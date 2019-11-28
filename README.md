# Assembly_metagenomes
Pipeline for metagenomic assemblies (Megahit, Spades or Skesa) parralelized on HPC (PBS scheduler)

## Requirements

### Megahit
This pipeline requires to download and install [Megahit](https://github.com/voutcn/megahit) on the HPC. 
### Spades
This pipeline requires to download and install [Spades](https://github.com/ablab/spades) on the HPC. 
### Skesa
This pipeline requires to download and install [Skesa](https://github.com/ncbi/SKESA) on the HPC. 
### IDBA
This pipeline requires to download and install [IDBA](https://github.com/loneknightpy/idba) on the HPC.


## Quick start

### Edit scripts/config.sh file

please modify the

  - SPADES= path to the bin directory of SPADES
  - SKESA= path to the bin directory of SPADES
  - IDBA= path to the bin directory of SPADES
  - MEGAHIT= path to the bin directory of SPADES
  - DATASET_DIR=path to the directory containing the files to process
  - FILE_LIST_R1= list of the forward pair to process
  - FILE_LIST_R2= list of the reverse pair to process
  - ASSEMBLER= choose between "SKESA", "IDBA", "Spades" or "Megahit"
  - RESULT_DIR= Note: the user needs to provide the path of an existing folder
  - MAIL_USER = indicate here your arizona.edu email
  - GROUP = indicate here your group affiliation

You can also modify

  - MAIL_TYPE = change the mail type option. By default set to "bea".
  - QUEUE = change the submission queue. By default set to "standard".
  
  ### Run pipeline
  
  Run 
  ```bash
  ./submit.sh
  ```
  This command will place one job in queue.
