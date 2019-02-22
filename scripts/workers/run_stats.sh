#!/bin/bash

#PBS -W group_list=bhurwitz
#PBS -q standard
#PBS -l select=1:ncpus=28:mem=168gb
#PBS -l walltime=12:00:00
#PBS -M aponsero@email.arizona.edu
#PBS -m bea

module load perl
source my_project/bin/activate

cd /rsgrps/bhurwitz/alise/my_data/Nostoc_project/Pipelines/Assembly_metagenomes/scripts/workers

LIST="/rsgrps/bhurwitz/alise/my_data/Nostoc_project/Lichen_metagenomes/fastQC/QC_sequences/list.txt"
RUN="/rsgrps/bhurwitz/alise/my_data/Nostoc_project/Pipelines/Assembly_metagenomes/scripts/workers/stats.pl"

while read CDS; do
  perl $RUN $CDS
done <$LIST


#CDS="/rsgrps/bhurwitz/alise/my_data/Nostoc_project/Lichen_metagenomes/assemblies/test_assemblers/run_test1_spades/spades_12_S13_R1_QC.fq/scaffolds.fasta"

#perl stats.pl $CDS

