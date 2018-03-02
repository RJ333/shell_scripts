#!bin/bash
for contig in contig_list_phn
do
	grep -F contig -A1 prokka_all_fasta_singleline.txt | sed '/^--$/d' >> loop_test.txt
done