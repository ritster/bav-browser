#!/usr/bin/env bash
# Retrieve and process NCBI assembly data for BAV-Ch, and add data to JBrowse

# Handle sed version mismatch error
vers="$(sed --version < /dev/null 2>&1 | grep -q GNU && echo gnu || echo bsd)"
case "$vers" in
    gnu) SED=(sed -i) ;;
    *) SED=(sed -i '')
esac

# Set default value for APACHE_ROOT if it's not already set (will only work for MacOS Silicon)
: "${APACHE_ROOT:='/opt/homebrew/var/www'}"

# Download and Unzip NCBI Data
./datasets download genome accession GCA_023156985.1 --include gff3,rna,cds,protein,genome,seq-report
unzip ncbi_dataset.zip -d tmp
rm -rf ncbi_dataset.zip

# Process Genome FASTA for JBrowse
sed -E 's/^>([^ ]+).*segment ([0-9]+).*$/>seg\2/' "tmp/ncbi_dataset/data/GCA_023156985.1/GCA_023156985.1_ASM2315698v1_genomic.fna" > "data/BAV-Ch-Genome.fa"
samtools faidx data/BAV-Ch-Genome.fa
jbrowse add-assembly data/BAV-Ch-Genome.fa --name "BAV-Ch" --out $APACHE_ROOT/jbrowse2 --load copy

# Retrieve Individual Segment Records
declare -a segment_records=("AF168005.1" "AF134526.1" "AY549307.1" "AY549308.1" "AY549309.1" "AF168006.1" "AF052035.1" "AF052034.1" "AF052033.1" "AF052032.1" "AF052031.1" "AF052030.1")
mkdir -p tmp1
for item in "${segment_records[@]}"; do
  wget -O "tmp1/BAV-Ch-${item}.gff" "https://www.ncbi.nlm.nih.gov/sviewer/viewer.cgi?db=nuccore&report=gff3&id=${item}"
done

# Assemble Segment Records into One GFF File
seen_header=0
for item in "${segment_records[@]}"; do
  if [ $seen_header -eq 0 ]; then
    cat "tmp1/BAV-Ch-${item}.gff" > "data/BAV-Ch-Annotations.gff"
    seen_header=1
  else
    tail -n +4 "tmp1/BAV-Ch-${item}.gff" >> "data/BAV-Ch-Annotations.gff"
  fi
done
# Remove Spaces
"${SED[@]}" '/^$/d' "data/BAV-Ch-Annotations.gff"

# Process GFF Annotations for JBrowse
declare -A map=(
    ["AF168005.1"]="seg1"
    ["AF134526.1"]="seg2"
    ["AY549307.1"]="seg3"
    ["AY549308.1"]="seg4"
    ["AY549309.1"]="seg5"
    ["AF168006.1"]="seg6"
    ["AF052035.1"]="seg7"
    ["AF052034.1"]="seg8"
    ["AF052033.1"]="seg9"
    ["AF052032.1"]="seg10"
    ["AF052031.1"]="seg11"
    ["AF052030.1"]="seg12"
)
for key in "${!map[@]}"; do
    "${SED[@]}" "s/$key/${map[$key]}/g" "data/BAV-Ch-Annotations.gff"
done
cp data/BAV-Ch-Annotations.gff tmp1.gff #TODO: remove
jbrowse sort-gff data/BAV-Ch-Annotations.gff
bgzip data/BAV-Ch-Annotations.gff
tabix data/BAV-Ch-Annotations.gff.gz
jbrowse add-track data/BAV-Ch-Annotations.gff.gz -a "BAV-Ch" --out $APACHE_ROOT/jbrowse2 --load copy

# Allow Searching by Genes in JBrowse
jbrowse text-index --out $APACHE_ROOT/jbrowse2

# Cleanup
rm -rf tmp/
rm -rf tmp1/
