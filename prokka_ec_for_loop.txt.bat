#!/bin/bash
for i in {0..6}; do
grep "eC_number=" ./megahit_coassembly.${i}/PROKKA.gff | cut -f9 | cut -f1,2 -d ';'| sed 's/ID=//g'| sed 's/;eC_number=/\t/g' >> PROKKA.ec;
done