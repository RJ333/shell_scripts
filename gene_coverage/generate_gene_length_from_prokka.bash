#!/bin/bash

#extract gene length from prokka annotation 

genename="phnM"

awk -F '\t|;' -v gene="$genename" ' $0 ~ gene {print $3-$2,$6}' 

awk -F '\t|;' ' $0 ~ "phnM" {print $1,$3-$2,$6}'  prokka_annotation.txt > gene_length_phnM


#extract contig length from contig_length and match with gene_length

awk 'NR==FNR{contig_id[$1]=$1}
	NR==FNR{next} {subst($0,3) | contig_id2[$1]?$1; contig_length[$1]=$4; }
	{if (contig_id==contig_id2) {print contig_id, contig_length}'
	gene_length_phnM.txt contig_lengths.txt