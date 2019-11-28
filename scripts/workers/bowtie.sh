#!/bin/bash

#PBS -W group_list=bhurwitz
#PBS -q standard
#PBS -l select=1:ncpus=28:mem=168gb
#PBS -l walltime=48:00:00
#PBS -M aponsero@email.arizona.edu
#PBS -m bea

source activate anvio

BOWTIE="/rsgrps/bhurwitz/alise/tools/bowtie2-2.3.3.1-linux-x86_64"
LIST_CONTIGS="/rsgrps/bhurwitz/alise/my_data/Nostoc_project/Lichen_metagenomes/assemblies/results/run_test1_megahit/list2.txt"
MAPPING_DIR="/rsgrps/bhurwitz/alise/my_data/Nostoc_project/Lichen_metagenomes/assemblies/mappings/run_test1_megahit"
cd $MAPPING_DIR
####we need to build an index for our contigs

#while read CONTIG; do
#    NAME=$(basename $(dirname $CONTIG))
#    BASE=${NAME%???}
#    echo $BASE
#    $BOWTIE/bowtie2-build $CONTIG $BASE
#done <$LIST_CONTIGS

####get an indexed BAM file for one of your samples

while read CONTIG; do
    NAME=$(basename $(dirname $CONTIG))
    BASE=${NAME%???}
    SAMPLE="$(cut -d'_' -f3 <<<"$BASE")"
    echo $SAMPLE
    R1="/rsgrps/bhurwitz/alise/my_data/Nostoc_project/Lichen_metagenomes/fastQC/QC_sequences/${SAMPLE}_R1_QC.fq"
    R2="/rsgrps/bhurwitz/alise/my_data/Nostoc_project/Lichen_metagenomes/fastQC/QC_sequences/${SAMPLE}_R2_QC.fq"
    MAPP_SAM="$MAPPING_DIR/${SAMPLE}_QC.sam"
    MAP_BAM_RAW="$MAPPING_DIR/${SAMPLE}_QC-RAW.bam"
    $BOWTIE/bowtie2 -x $BASE -1 $R1 -2 $R2 -S $MAPP_SAM | samtools view -bSF4 - > $MAP_BAM_RAW
 
    #samtools view -S -b $MAPP > $MAP_BAM_RAW
    MAP_BAM="$MAPPING_DIR/${SAMPLE}_QC.bam"
    #anvi-init-bam $MAP_BAM_RAW -o $MAP_BAM
done <$LIST_CONTIGS

