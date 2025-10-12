#!/bin/bash

#SBATCH -J NA_BRAKER3            # Job name
#SBATCH -o NA_BRAKER3.%j.out       # Specify stdout output file (%j expands to jobId)
#SBATCH -p bigmem                   # Queue name 'smp' or 'parallel' on Mogon II
#SBATCH -n 1                     # Total number of tasks, here explicitly 1
#SBATCH -c 20                    # Total number of cores for the single task
#SBATCH --mem 280G                # The default is 300M memory per job. You'll likely have to adapt this to your needs
#SBATCH -t 48:00:00              # Run time (hh:mm:ss)

#SBATCH -A m2_jgu-evoltroph     # Specify allocation to charge against

#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=achakrab@uni-mainz.de

## Load all necessary modules if needed
module unload SciPy-bundle
module unload Python
export GM_KEY=~/.gm_key
source /lustre/project/m2_jgu-evoltroph/achakrab/SOFTWARES/ALL_SOFTWARES_anaconda3/bin/activate
conda activate BRAKER3_env
export PYTHON3_PATH=/lustre/project/m2_jgu-evoltroph/achakrab/SOFTWARES/ALL_SOFTWARES_anaconda3/envs/BRAKER3_env/bin
export PYTHONPATH=/lustre/project/m2_jgu-evoltroph/achakrab/SOFTWARES/ALL_SOFTWARES_anaconda3/envs/BRAKER3_env/lib/python3.9/site-packages:$PYTHONPATH
export PATH=/lustre/project/m2_jgu-evoltroph/achakrab/SOFTWARES/ALL_SOFTWARES_anaconda3/envs/BRAKER3_env/bin:$PATH
export AUGUSTUS_CONFIG_PATH=/lustre/project/m2_jgu-evoltroph/achakrab/NA_genome/03_BRAKER_analysis/AUGUSTUS_CONFIG/config
braker.pl --genome=/lustre/project/m2_jgu-evoltroph/achakrab/NA_genome/02_Assembly_files/NA_genome_masked.fasta --useexisting --species=coyote_tobacco --softmasking --threads 20 --rnaseq_sets_ids=NA --rnaseq_sets_dir=/lustre/project/m2_jgu-evoltroph/achakrab/NA_genome/04_RNAseq_files/filtered_files --prot_seq=/lustre/project/m2_jgu-evoltroph/achakrab/NA_genome/05_protein_files/Selected_Solanaceae_species_cat.fasta --workingdir=/lustre/project/m2_jgu-evoltroph/achakrab/NA_genome/03_BRAKER_analysis/NA_BRAKER3_output --AUGUSTUS_CONFIG_PATH=$AUGUSTUS
_CONFIG_PATH --PYTHON3_PATH=$PYTHON3_PATH --PROTHINT_PATH=/lustre/project/m2_jgu-evoltroph/achakrab/SOFTWARES/ProtHint-2.6.0/bin --GENEMARK_PATH=/lustre/project/m2_jgu-evoltroph/achakrab/SOFTWARES/gmetp_linux_64/bin
