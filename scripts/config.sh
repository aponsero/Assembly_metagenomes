export CWD=$PWD
# where programs are
export SPADES=""
export SKESA=""
export MEGAHIT=""
# where the dataset to prepare is
export DATASET_DIR=""
export FILE_LIST_R1=""
export FILE_LIST_R2=""
export ASSEMBLER="" # SKESA, Spades or Megahit
export RESULT_DIR="" #provide the path of a non-existing folder
#place to store the scripts
export SCRIPT_DIR="$PWD/scripts"
export WORKER_DIR="$SCRIPT_DIR/workers" 
# User informations
export QUEUE="standard"
export GROUP=""
export MAIL_USER=""
export MAIL_TYPE="bea"

#
# --------------------------------------------------
function init_dir {
    for dir in $*; do
        if [ -d "$dir" ]; then
            rm -rf $dir/*
        else
            mkdir -p "$dir"
        fi
    done
}

# --------------------------------------------------
function lc() {
    wc -l $1 | cut -d ' ' -f 1
}
