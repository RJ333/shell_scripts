
scp rene@milou.uppmax.uu.se:/proj/b2010008/nobackup/projects/rene_roundup/metag_glyph_workflow/mapping/bowtie2/default/meta-sensitive_coassembly_10K/samples/*.sorted.removeduplicates.bam .

scp rene@milou.uppmax.uu.se:/proj/b2010008/nobackup/projects/rene_roundup/metag_glyph_workflow/mapping/bowtie2/default/meta-sensitive_coassembly_10K/samples/*.sorted.removeduplicates.bam.bai .

scp ./46-RNA-AT3-3T2_R2_clipped.fastq.bz2 rene@milou.uppmax.uu.se:/proj/b2014214/nobackup/christin/h2o2_metatrans/clipped/

scp ./47* rene@milou.uppmax.uu.se:/proj/b2014214/nobackup/christin/h2o2_metatrans/clipped/
scp ./48* rene@milou.uppmax.uu.se:/proj/b2014214/nobackup/christin/h2o2_metatrans/clipped/
scp ./49* rene@milou.uppmax.uu.se:/proj/b2014214/nobackup/christin/h2o2_metatrans/clipped/
scp ./5* rene@milou.uppmax.uu.se:/proj/b2014214/nobackup/christin/h2o2_metatrans/clipped/


samtools index A1.sorted.removeduplicates.bam #didn't work in a loop (says it was unsorted bam file)
