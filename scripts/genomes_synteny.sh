#!/usr/bin/env bash
# Process JKT-6423, BAV-Ch, and KDV-JKT-7075 Pairwise Alignment Information, and add data to JBrowse

# Compare JKT-6423 (BAV reference genome) and BAV-Ch (BAV alternate genome)
minimap2 -c data/JKT-6423-Genome.fa data/BAV-Ch-Genome.fa > data/synteny_JKT-6423_vs_BAV-Ch.paf
jbrowse add-track data/synteny_JKT-6423_vs_BAV-Ch.paf --assemblyNames BAV-Ch,JKT-6423 --load copy --out $APACHE_ROOT/jbrowse2

# NOTE: these viruses are too different for paf alignment (empty files) and synteny view
# Compare JKT-6423 (BAV reference genome) and KDV-JKT-7075 (KDV reference genome)
#minimap2 -c data/JKT-6423-Genome.fa data/KDV-JKT-7075-Genome.fa > data/synteny_JKT-6423_vs_KDV-JKT-7075.paf
#jbrowse add-track data/synteny_JKT-6423_vs_KDV-JKT-7075.paf --assemblyNames KDV-JKT-7075,JKT-6423 --load copy --out $APACHE_ROOT/jbrowse2
# Compare BAV-Ch (BAV alternate genome) and KDV-JKT-7075 (KDV reference genome)
#minimap2 -c data/BAV-Ch-Genome.fa data/KDV-JKT-7075-Genome.fa > data/synteny_BAV-Ch_vs_KDV-JKT-7075.paf
#jbrowse add-track data/synteny_BAV-Ch_vs_KDV-JKT-7075.paf --assemblyNames KDV-JKT-7075,BAV-Ch --load copy --out $APACHE_ROOT/jbrowse2
