export CWD=$PWD
# where programs are
export SPADES="/rsgrps/bhurwitz/alise/tools/SPAdes-3.13.0-Linux/bin"
export SKESA="/rsgrps/bhurwitz/alise/tools"
export IDBA="/rsgrps/bhurwitz/alise/tools/idba"
export MEGAHIT="/rsgrps/bhurwitz/alise/tools/megahit"
# where the dataset to prepare is
export DATASET_DIR="/rsgrps/bhurwitz/alise/my_data/Nostoc_project/Lichen_metagenomes/fastQC/QC_sequences"
export FILE_LIST_R1="/rsgrps/bhurwitz/alise/my_data/Nostoc_project/Lichen_metagenomes/fastQC/QC_sequences/paire1.list"
export FILE_LIST_R2="/rsgrps/bhurwitz/alise/my_data/Nostoc_project/Lichen_metagenomes/fastQC/QC_sequences/paire2.list"
export ASSEMBLER="SKESA" # SKESA, IDBA, Spades or Megahit
export RESULT_DIR="/rsgrps/bhurwitz/alise/my_data/Nostoc_project/Lichen_metagenomes/assemblies/test_assemblers/run_test1_SKESA" #provide the path of an existing folder
#place to store the scripts
export SCRIPT_DIR="$PWD/scripts"
export WORKER_DIR="$SCRIPT_DIR/workers" 
# User informations
export QUEUE="standard"
export GROUP="bhurwitz"
export MAIL_USER="aponsero@email.arizona.edu"
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
