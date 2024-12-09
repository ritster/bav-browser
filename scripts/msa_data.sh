#!/usr/bin/env bash
# Process GenBank nucleotide and amino acid sequences for segments 1, 2, 9, and 12
# across 13 BAV or BAV-like viral strains

# Handle sed version mismatch error
vers="$(sed --version < /dev/null 2>&1 | grep -q GNU && echo gnu || echo bsd)"
case "$vers" in
    gnu) SED=(sed -i) ;;
    *) SED=(sed -i '')
esac

# seg1 sequence concatenation (fixed order, both nuc and amino separately)
file_arr=("KX884638" "MH521264" "KC954611" "OM953801" "AF168005" "MF124330" "EU265695" "EU265683" "NC_004211" "JX947843" "KR349187" "NC_004210" "AY317099")
out_file_nuc="data/msa_seg1_nucleotide.fna"
> "$out_file_nuc"
out_file_pro="data/msa_seg1_protein.faa"
> "$out_file_pro"
for file in "${file_arr[@]}"; do
  # Append each file's contents to the output
  awk '/^>/ || NF' "data/non-programmatic/seg1/nucleotide/$file.1.fna" >> "$out_file_nuc"
  awk '/^>/ || NF' "data/non-programmatic/seg1/protein/$file.1.faa" >> "$out_file_pro"
done
"${SED[@]}" 's/^>lcl|/>/' $out_file_nuc
"${SED[@]}" 's/^>lcl|/>/' $out_file_pro

# seg2 sequence concatenation (fixed order, both nuc and amino separately)
file_arr=("KX884639" "MH521265" "KC954612" "OM953802" "AF134528" "MF134894" "EU265696" "EU265684" "NC_004217" "KF790697" "KR349188" "NC_004212" "AY317100")
out_file_nuc="data/msa_seg2_nucleotide.fna"
> "$out_file_nuc"
out_file_pro="data/msa_seg2_protein.faa"
> "$out_file_pro"
for file in "${file_arr[@]}"; do
  # Append each file's contents to the output
  awk '/^>/ || NF' "data/non-programmatic/seg2/nucleotide/$file.1.fna" >> "$out_file_nuc"
  awk '/^>/ || NF' "data/non-programmatic/seg2/protein/$file.1.faa" >> "$out_file_pro"
done
"${SED[@]}" 's/^>lcl|/>/' $out_file_nuc
"${SED[@]}" 's/^>lcl|/>/' $out_file_pro

# seg9 sequence concatenation (fixed order, both nuc and amino separately)
file_arr=("KX884646" "MH521272" "KC954619" "OM953809" "AF052033" "MF141020" "EU312980" "EU265691" "NC_004202" "JX947848" "KR349195" "NC_004205" "AY317108")
out_file_nuc="data/msa_seg9_nucleotide.fna"
> "$out_file_nuc"
out_file_pro="data/msa_seg9_protein.faa"
> "$out_file_pro"
for file in "${file_arr[@]}"; do
  # Append each file's contents to the output
  awk '/^>/ || NF' "data/non-programmatic/seg9/nucleotide/$file.1.fna" >> "$out_file_nuc"
  awk '/^>/ || NF' "data/non-programmatic/seg9/protein/$file.1.faa" >> "$out_file_pro"
done
"${SED[@]}" 's/^>lcl|/>/' $out_file_nuc
"${SED[@]}" 's/^>lcl|/>/' $out_file_pro

# seg12 sequence concatenation (fixed order, both nuc and amino separately)
file_arr=("KX884648" "MH521275" "KC954622" "OM953812" "AF052030" "MF141023" "EU265705" "EU265694" "NC_004198" "JX947849" "KR349197" "NC_004208" "AY317109")
out_file_nuc="data/msa_seg12_nucleotide.fna"
> "$out_file_nuc"
out_file_pro="data/msa_seg12_protein.faa"
> "$out_file_pro"
for file in "${file_arr[@]}"; do
  # Append each file's contents to the output
  awk '/^>/ || NF' "data/non-programmatic/seg12/nucleotide/$file.1.fna" >> "$out_file_nuc"
  awk '/^>/ || NF' "data/non-programmatic/seg12/protein/$file.1.faa" >> "$out_file_pro"
done
"${SED[@]}" 's/^>lcl|/>/' $out_file_nuc
"${SED[@]}" 's/^>lcl|/>/' $out_file_pro
