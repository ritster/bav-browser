#!/usr/bin/env bash
# Retrieve and process NCBI assembly data for JKT-6423, and add data to JBrowse

# Handle sed version mismatch error
vers="$(sed --version < /dev/null 2>&1 | grep -q GNU && echo gnu || echo bsd)"
case "$vers" in
    gnu) SED='sed -i' ;;
    *) SED="sed -i ''"
esac

# Set default value for APACHE_ROOT if it's not already set (will only work for MacOS Silicon)
: "${APACHE_ROOT:='/opt/homebrew/var/www'}"

# Download and Unzip NCBI Data
./datasets download genome accession GCF_000858185.1 --include gff3,rna,cds,protein,genome,seq-report
unzip ncbi_dataset.zip -d tmp
rm -rf ncbi_dataset.zip

# Process Genome FASTA for JBrowse
sed -E 's/^>NC_[^ ]+ .*segment ([0-9]+),.*/>seg\1/' "tmp/ncbi_dataset/data/GCF_000858185.1/GCF_000858185.1_ViralMultiSegProj15178_genomic.fna" > "data/JKT-6423-Genome.fa"
samtools faidx data/JKT-6423-Genome.fa
jbrowse add-assembly data/JKT-6423-Genome.fa --out $APACHE_ROOT/jbrowse2 --load copy

# Process GFF Annotations for JBrowse
declare -A map=(
    ["NC_004211.1"]="seg1"
    ["NC_004217.1"]="seg2"
    ["NC_004218.1"]="seg3"
    ["NC_004219.1"]="seg4"
    ["NC_004220.1"]="seg5"
    ["NC_004221.1"]="seg6"
    ["NC_004204.1"]="seg7"
    ["NC_004203.1"]="seg8"
    ["NC_004202.1"]="seg9"
    ["NC_004201.1"]="seg10"
    ["NC_004200.1"]="seg11"
    ["NC_004198.1"]="seg12"
)
cp tmp/ncbi_dataset/data/GCF_000858185.1/genomic.gff data/JKT-6423-Annotations.gff
for key in "${!map[@]}"; do
    $SED "s/$key/${map[$key]}/g" "data/JKT-6423-Annotations.gff"
done
cp data/JKT-6423-Annotations.gff tmp0.gff #TODO: remove
jbrowse sort-gff data/JKT-6423-Annotations.gff
bgzip data/JKT-6423-Annotations.gff
tabix data/JKT-6423-Annotations.gff.gz
jbrowse add-track data/JKT-6423-Annotations.gff.gz -a "JKT-6423-Genome" --out $APACHE_ROOT/jbrowse2 --load copy

# Allow Searching by Genes in JBrowse
jbrowse text-index --out $APACHE_ROOT/jbrowse2

# Cleanup
rm -rf tmp/
