#!/bin/bash
for i in {1..7}; do
mkdir ./kallisto/sampleA${i}
scp rene@milou.uppmax.uu.se:/proj/b2010008/nobackup/projects/rene_roundup/metag_glyph_workflow/quantification/kallisto/quant/meta-sensitive_coassembly_10K/samples/A${i}/abundance.tsv.gz ./kallisto/sampleA${i};
done

#!/bin/bash
for i in {8..10}; do
mkdir ./kallisto/sampleB${i}
scp rene@milou.uppmax.uu.se:/proj/b2010008/nobackup/projects/rene_roundup/metag_glyph_workflow/quantification/kallisto/quant/meta-sensitive_coassembly_10K/samples/B${i}/abundance.tsv.gz ./kallisto/sampleB${i};
done
