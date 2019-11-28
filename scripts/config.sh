export CWD=$PWD
# where programs are
export SPADES="/rsgrps/bhurwitz/alise/tools/SPAdes-3.13.0-Linux/bin"
export SKESA="/rsgrps/bhurwitz/alise/tools"
export IDBA="/rsgrps/bhurwitz/alise/tools/idba"
export MEGAHIT="/rsgrps/bhurwitz/alise/tools/megahit"
# where the dataset to prepare is
export DATASET_DIR=""
export FILE_LIST_R1=""
export FILE_LIST_R2=""
export ASSEMBLER="Megahit" # SKESA, IDBA, Spades or Megahit
export RESULT_DIR=""
# Note: provide the path of an existing folder
#place to store the scripts
export SCRIPT_DIR="$PWD/scripts"
export WORKER_DIR="$SCRIPT_DIR/workers" 
# User informations
export QUEUE="windfall"
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
