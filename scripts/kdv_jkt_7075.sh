#!/usr/bin/env bash
# Retrieve and process NCBI assembly data for KDV-JKT-7075, and add data to JBrowse

# Handle sed version mismatch error
vers="$(sed --version < /dev/null 2>&1 | grep -q GNU && echo gnu || echo bsd)"
case "$vers" in
    gnu) SED='sed -i' ;;
    *) SED="sed -i ''"
esac

# Set default value for APACHE_ROOT if it's not already set (will only work for MacOS Silicon)
: "${APACHE_ROOT:='/opt/homebrew/var/www'}"

# Download and Unzip NCBI Data
./datasets download genome accession GCF_000851685.1 --include gff3,rna,cds,protein,genome,seq-report
unzip ncbi_dataset.zip -d tmp
rm -rf ncbi_dataset.zip

# Process Genome FASTA for JBrowse
sed -E 's/^>NC_[^ ]+ .*segment ([0-9]+),.*/>seg\1/' "tmp/ncbi_dataset/data/GCF_000851685.1/GCF_000851685.1_ViralMultiSegProj14858_genomic.fna" > "tmp/KDV-JKT-7075-Genome.fa"
seqkit sort -lr tmp/KDV-JKT-7075-Genome.fa -o data/KDV-JKT-7075-Genome.fa
samtools faidx data/KDV-JKT-7075-Genome.fa
jbrowse add-assembly data/KDV-JKT-7075-Genome.fa --name "KDV-JKT-7075" --out $APACHE_ROOT/jbrowse2 --load copy

# Process GFF Annotations for JBrowse
declare -A map=(
    ["NC_004209.1"]="seg7"
    ["NC_004206.1"]="seg10"
    ["NC_004205.1"]="seg11"
    ["NC_004210.1"]="seg1"
    ["NC_004199.1"]="seg12"
    ["NC_004212.1"]="seg2"
    ["NC_004213.1"]="seg3"
    ["NC_004214.1"]="seg4"
    ["NC_004215.1"]="seg5"
    ["NC_004216.1"]="seg6"
    ["NC_004208.1"]="seg8"
    ["NC_004207.1"]="seg9"
)
cp tmp/ncbi_dataset/data/GCF_000851685.1/genomic.gff data/KDV-JKT-7075-Annotations.gff
for key in "${!map[@]}"; do
    $SED "s/$key/${map[$key]}/g" "data/KDV-JKT-7075-Annotations.gff"
done
cp data/KDV-JKT-7075-Annotations.gff tmp2.gff #TODO: remove
jbrowse sort-gff data/KDV-JKT-7075-Annotations.gff
bgzip data/KDV-JKT-7075-Annotations.gff
tabix data/KDV-JKT-7075-Annotations.gff.gz
jbrowse add-track data/KDV-JKT-7075-Annotations.gff.gz -a "KDV-JKT-7075" --out $APACHE_ROOT/jbrowse2 --load copy

## Allow Searching by Genes in JBrowse
jbrowse text-index --out $APACHE_ROOT/jbrowse2

## Cleanup
rm -rf tmp/
