#!/bin/bash

#PBS -W group_list=bhurwitz
#PBS -q standard
#PBS -l select=1:ncpus=28:mem=168gb
#PBS -l walltime=12:00:00
#PBS -M aponsero@email.arizona.edu
#PBS -m bea

CONTIG_DIR="/rsgrps/bhurwitz/alise/my_data/Nostoc_project/Lichen_metagenomes/assemblies/test_assemblers/run_test1_spades/spades_12_S13_R1_QC.fq"
CONTIG="$CONTIG_DIR/contigs.fasta"
P1="/rsgrps/bhurwitz/alise/my_data/Nostoc_project/Lichen_metagenomes/fastQC/QC_sequences/S13_R1_QC.fq"
P2="/rsgrps/bhurwitz/alise/my_data/Nostoc_project/Lichen_metagenomes/fastQC/QC_sequences/S13_R2_QC.fq"
OUT_DIR="$CONTIG_DIR/map_reads"
mkdir $OUT_DIR
MAP_FILE="$OUT_DIR/aln.sam.gz"
COV_FILE="$OUT_DIR/cov.txt"

#Align reads with bbwrap.sh
cd /rsgrps/bhurwitz/alise/tools/bbmap

./bbwrap.sh ref=$CONTIG in=$P1 in2=$P2 out=$MAP_FILE kfilter=22 subfilter=15 maxindel=80

#Output per contig coverage to cov.txt with pileup.sh

./pileup.sh in=$MAP_FILE out=$COV_FILE
cd /rsgrps/bhurwitz/alise/tools/samtools-1.2
UNMAP_SE="$OUT_DIR/unmapped.se.fq"
UNMAP_PE="$OUT_DIR/unmapped.pe.fq"
UNMAP_SE_FA="$OUT_DIR/unmapped.se.fa"
UNMAP_PE_FA="$OUT_DIR/unmapped.pe.fa"

#Extract unmapped reads (SE to unmapped.se.fq and PE to unmapped.pe.fq)
./samtools view -u -f4 $MAP_FILE | ./samtools bam2fq -s $UNMAP_SE - > $UNMAP_PE

sed -n '1~4s/^@/>/p;2~4p' $UNMAP_SE > $UNMAP_SE_FA
sed -n '1~4s/^@/>/p;2~4p' $UNMAP_PE > $UNMAP_PE_FA
