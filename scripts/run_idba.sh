#!/bin/bash

#PBS -W group_list=bhurwitz
#PBS -q standard
#PBS -l select=1:ncpus=30:mem=1260gb:pcmem=42gb 
#PBS -l walltime=24:00:00
#PBS -M aponsero@email.arizona.edu
#PBS -m bea


HOST=`hostname`
LOG="$STDOUT_DIR/${HOST}.log"
ERRORLOG="$STDERR_DIR/${HOST}.log"

if [ ! -f "$LOG" ] ; then
    touch "$LOG"
fi
echo "Started `date`">>"$LOG"
echo "Host `hostname`">>"$LOG"


R1=`head -n +${PBS_ARRAY_INDEX} $FILE_LIST_R1 | tail -n 1`
R2=`head -n +${PBS_ARRAY_INDEX} $FILE_LIST_R2 | tail -n 1`
P1="$DATASET_DIR/$R1"
P2="$DATASET_DIR/$R2"
I="$DATASET_DIR/$R1_interleaved.fa"

OUT_DIR="$RESULT_DIR/idba_${PBS_ARRAY_INDEX}_$R1"
mkdir $OUT_DIR

cd $IDBA

bin/fq2fa --merge --filter $P1 $P2 $I

bin/idba_ud -o $OUT_DIR -r $I

echo "Finished `date`">>"$LOG"

