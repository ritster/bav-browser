#!/usr/bin/env bash
# Process GenBank nucleotide and amino acid sequences for segments 1, 2, 9, and 12
# across 13 BAV or BAV-like viral strains

# Combine individual nucleotide fasta files into one for subsequent MSA
awk '/^>/ || NF' data/non-programmatic/seg1/nucleotide/*.fna > data/msa_seg1_nucleotide.fna
awk '/^>/ || NF' data/non-programmatic/seg2/nucleotide/*.fna > data/msa_seg2_nucleotide.fna
awk '/^>/ || NF' data/non-programmatic/seg9/nucleotide/*.fna > data/msa_seg9_nucleotide.fna
awk '/^>/ || NF' data/non-programmatic/seg12/nucleotide/*.fna > data/msa_seg12_nucleotide.fna

# Combine individual nucleotide fasta files into one for subsequent MSA
awk '/^>/ || NF' data/non-programmatic/seg1/protein/*.faa > data/msa_seg1_protein.faa
awk '/^>/ || NF' data/non-programmatic/seg2/protein/*.faa > data/msa_seg2_protein.faa
awk '/^>/ || NF' data/non-programmatic/seg9/protein/*.faa > data/msa_seg9_protein.faa
awk '/^>/ || NF' data/non-programmatic/seg12/protein/*.faa > data/msa_seg12_protein.faa
