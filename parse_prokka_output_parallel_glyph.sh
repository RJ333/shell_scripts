#!/usr/bin/bash

# tmux 		# session will stay logged in
# tmux a 	# regain tmux session, must be logged in to the login node (ssh milou2)
# ctrl+b, c # new tab in tmux session for jobinfo etc
# ctrl+b, n # next
# ctrl+b, p # previous




BASE_DIR=/data/Rene/
SAMTOOLS_BIN=/data/jwerner/tools/samtools-1.7/samtools # path on bio-49
OUTPUT_DIR=/data/Rene/glyph/prokka   
SAMPLE_PATH=${BASE_DIR}/"$1"
SAMPLE_FOLDER="A1"
BED_DIR=${OUTPUT_DIR}/bed
RESULTS_DIR=${OUTPUT_DIR}/results
TMP_DIR=${OUTPUT_DIR}/tmp
mkdir -p $BED_DIR
mkdir -p $RESULTS_DIR
mkdir -p $TMP_DIR


# cd ${SAMPLE_PATH}/output_IMP/Analysis/annotation
# echo "$SAMPLE_PATH was found"
# echo "Sample is $SAMPLE_FOLDER"
# # for loops not recommended to read lines from file, set IFS= for while loop, if you have e.g. spaces per line
# # last entry in list must end with newline, otherwise it will no be considered as entry
# cat /data/Rene/test_products2.txt | while read PRODUCT_NAME_NO_SPACES 
# do
  # PRODUCT_NAME=`echo ${PRODUCT_NAME_NO_SPACES} | tr "@" " "`
  # BED_FILENAME=${BED_DIR}/intersect_${PRODUCT_NAME_NO_SPACES}_${SAMPLE_FOLDER}.bed
	
  # grep "$PRODUCT_NAME" annotation.filt.gff > ${TMP_DIR}/${PRODUCT_NAME_NO_SPACES}_${SAMPLE_FOLDER}_tmp.gff
	
  # cat ${TMP_DIR}/${PRODUCT_NAME_NO_SPACES}_${SAMPLE_FOLDER}_tmp.gff | \
    # awk -F '\t|;' '{for(i=9;i<=NF;i++){if($i~/^product=/){column=$i}} print $1,$4,$5,$5-$4,column}' > ${BED_FILENAME}

	# $SAMTOOLS_BIN view -L ${BED_FILENAME} ../../Assembly/mg.reads.sorted.bam | grep -v -P "^\@" | cut -f 1,3 | sort |\
	  # uniq | cut -f 2  | sort | uniq -c | perl -ane '$_=~/^\s+(\d+) (.+)$/;chomp($2); print "$2\t$1\n"; '\
	  # > ${RESULTS_DIR}/mg.reads.per.gene_${PRODUCT_NAME_NO_SPACES}_${SAMPLE_FOLDER}.tsv &
	  # ## TODO (WARNING): currently all processes are forked at the same time. this needs to be resolved. limit to a certain number of processes.

	# rm ${TMP_DIR}/${PRODUCT_NAME_NO_SPACES}_${SAMPLE_FOLDER}_tmp.gff
# done
# cd ../../../..

### TODO: to map product name back to genes: all lower case, unify white spaces, dashes and  !!  


#rmdir -p ${OUTPUT_DIR}/tmp

#cd ${SAMPLE_PATH}/${SAMPLE_FOLDER}/output_IMP/Analysis/annotation
#echo $SAMPLE_PATH
#echo $SAMPLE_FOLDER

#SAMPLE_FOLDER="$1"
	# PRODUCT_NAME_NO_SPACES="1%2C2-epoxyphenylacetyl-CoA@isomerase"
	# PRODUCT_NAME=`echo ${PRODUCT_NAME_NO_SPACES} | tr "@" " "`
	# BED_FILENAME=${BED_DIR}/intersect_${PRODUCT_NAME_NO_SPACES}_${SAMPLE_FOLDER}.bed

	# grep "$PRODUCT_NAME" annotation.filt.gff > ${TMP_DIR}/${PRODUCT_NAME_NO_SPACES}_${SAMPLE_FOLDER}_tmp.gff

	# cat ${TMP_DIR}/${PRODUCT_NAME_NO_SPACES}_${SAMPLE_FOLDER}_tmp.gff | awk -F '\t|;' '{for(i=9;i<=NF;i++){if($i~/^product=/){column=$i}} print $1,$4,$5,$5-$4,column}' > ${BED_FILENAME}

	# $SAMTOOLS_BIN view -L ${BED_FILENAME} ../../Assembly/mg.reads.sorted.bam | grep -v -P "^\@" | cut -f 1,3 | sort |\
	  # uniq | cut -f 2  | sort | uniq -c | perl -ane '$_=~/^\s+(\d+) (.+)$/;chomp($2); print "$2\t$1\n"; '\
	  # > ${RESULTS_DIR}/mg.reads.per.gene_${PRODUCT_NAME_NO_SPACES}_${SAMPLE_FOLDER}.tsv
	  # #TODO (WARNING): currently all processes are forked at the same time. this needs to be resolved. limit to a certain number of processes.

	# rm ${TMP_DIR}/${PRODUCT_NAME_NO_SPACES}_${SAMPLE_FOLDER}_tmp.gff

sam_parallel() {
	SAMPLE="$1"
	cd $OUTPUT_DIR
	PRODUCT_NAME_NO_SPACES="$2"
	BED_FILENAME=${BED_DIR}/intersect_${PRODUCT_NAME_NO_SPACES}_${SAMPLE_FOLDER}.bed

	grep "$PRODUCT_NAME_NO_SPACES" ${SAMPLE}_prokka_modified.tsv > ${TMP_DIR}/${PRODUCT_NAME_NO_SPACES}_${SAMPLE}_tmp.gff

	cat ${TMP_DIR}/${PRODUCT_NAME_NO_SPACES}_${SAMPLE}_tmp.gff | \
	awk -F '\t|;' '{for(i=9;i<=NF;i++){if($i~/^product=/){column=$i}} print $1,$4,$5,$5-$4,column}' > ${BED_FILENAME}

	$SAMTOOLS_BIN view -L ${BED_FILENAME} /data/jwerner/glyphosate/IMP/$SAMPLE/output_IMP/Assembly/mg.reads.sorted.bam | grep -v -P "^\@" | cut -f 1,3 | sort |\
	  uniq | cut -f 2  | sort | uniq -c | perl -ane '$_=~/^\s+(\d+) (.+)$/;chomp($2); print "$2\t$1\n"; '\
	  > ${RESULTS_DIR}/mg.reads.per.gene_${PRODUCT_NAME_NO_SPACES}_${SAMPLE}.tsv

	rm ${TMP_DIR}/${PRODUCT_NAME_NO_SPACES}_${SAMPLE}_tmp.gff
}


export -f sam_parallel
# These variables are defined outside the function and must be exported to be visible
export BED_DIR
export TMP_DIR
export OUTPUT_DIR
export RESULTS_DIR
export SAMTOOLS_BIN

parallel -j 44 sam_parallel ::: A1 A2 A3 A4 A5 A6 A7 B8 B9 B10 :::: /data/Rene/unique_products_greater_1_all_samples_new.tsv
