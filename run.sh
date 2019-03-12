#!/bin/sh
set -u
#
# Checking args
#

source scripts/config.sh

if [[ ! -d "$DATASET_DIR" ]]; then
    echo "$DATASET_DIR does not exist. Please provide the path to the folder to process Job terminated."
    exit 1
fi

if [[ ! -f "$FILE_LIST_R1" ]]; then
  echo "$FILE_LIST_R1 does not exist. Please provide the list of files to process. Job terminated."
  exit 1
fi

if [[ ! -f "$FILE_LIST_R2" ]]; then
  echo "$FILE_LIST_R2 does not exist. Please provide the list of files to process. Job terminated."
  exit 1
fi

#
# Job submission
#

PREV_JOB_ID=""
ARGS="-q $QUEUE -W group_list=$GROUP -M $MAIL_USER -m $MAIL_TYPE"

#
## 01-run assemblies
#

PROG="01-run-assemblies"
export STDERR_DIR="$SCRIPT_DIR/err/$PROG"
export STDOUT_DIR="$SCRIPT_DIR/out/$PROG"

init_dir "$STDERR_DIR" "$STDOUT_DIR"

export NUM_FILE=$(wc -l < "$FILE_LIST_R1")

if [ "$ASSEMBLER" == "IDBA" ]; then
    echo "launching $SCRIPT_DIR/run_idba.sh "


    JOB_ID=`qsub $ARGS -v DATASET_DIR,FILE_LIST_R1,FILE_LIST_R2,IDBA,RESULT_DIR,STDERR_DIR,STDOUT_DIR -N run_idba -e "$STDERR_DIR" -o "$STDOUT_DIR" -J 1-$NUM_FILE $SCRIPT_DIR/run_idba.sh`

    if [ "${JOB_ID}x" != "x" ]; then
         echo Job: \"$JOB_ID\"
         PREV_JOB_ID=$JOB_ID  
    else
         echo Problem submitting job. Job terminated
    fi
    
    echo "job successfully submited"

elif [ "$ASSEMBLER" == "Spades" ]; then
    echo "launching $SCRIPT_DIR/run_spades.sh "


    JOB_ID=`qsub $ARGS -v DATASET_DIR,FILE_LIST_R1,FILE_LIST_R2,SPADES,RESULT_DIR,STDERR_DIR,STDOUT_DIR -N run_spades -e "$STDERR_DIR" -o "$STDOUT_DIR" -J 1-$NUM_FILE $SCRIPT_DIR/run_spades.sh`

    if [ "${JOB_ID}x" != "x" ]; then
         echo Job: \"$JOB_ID\"
         PREV_JOB_ID=$JOB_ID
    else
         echo Problem submitting job. Job terminated
    fi

    echo "job successfully submited"

elif [ "$ASSEMBLER" == "Megahit" ]; then
    echo "launching $SCRIPT_DIR/run_Megahit.sh "

    JOB_ID=`qsub $ARGS -v DATASET_DIR,FILE_LIST_R1,FILE_LIST_R2,MEGAHIT,RESULT_DIR,STDERR_DIR,STDOUT_DIR -N run_mega -e "$STDERR_DIR" -o "$STDOUT_DIR" -J 1-$NUM_FILE $SCRIPT_DIR/run_megahit.sh`

    if [ "${JOB_ID}x" != "x" ]; then
         echo Job: \"$JOB_ID\"
         PREV_JOB_ID=$JOB_ID
    else
         echo Problem submitting job. Job terminated
    fi

    echo "job successfully submited"

elif [ "$ASSEMBLER" == "SKESA" ]; then
    echo "launching $SCRIPT_DIR/run_SKESA.sh "

    JOB_ID=`qsub $ARGS -v DATASET_DIR,FILE_LIST_R1,FILE_LIST_R2,SKESA,RESULT_DIR,STDERR_DIR,STDOUT_DIR -N run_mega -e "$STDERR_DIR" -o "$STDOUT_DIR" -J 1-$NUM_FILE $SCRIPT_DIR/run_SKESA.sh`

    if [ "${JOB_ID}x" != "x" ]; then
         echo Job: \"$JOB_ID\"
         PREV_JOB_ID=$JOB_ID
    else
         echo Problem submitting job. Job terminated
    fi

    echo "job successfully submited"

else
    echo "Assembler unknown, please choose between SKESA, Spades and Megahit"
    exit 1


fi




