########################################################Repeat-masking of the genome

#!/bin/bash

#SBATCH -J Nobt_repeatmodeler            # Job name
#SBATCH -o Nobt_repeatmodeler.%j.out       # Specify stdout output file (%j expands to jobId)
#SBATCH -p bigmem                   # Queue name 'smp' or 'parallel' on Mogon II
#SBATCH -n 1                     # Total number of tasks, here explicitly 1
#SBATCH -c 20                    # Total number of cores for the single task
#SBATCH --mem 280G                # The default is 300M memory per job. You'll likely have to adapt this to your needs
#SBATCH -t 48:00:00              # Run time (hh:mm:ss)

#SBATCH -A m2_jgu-evoltroph     # Specify allocation to charge against

#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=achakrab@uni-mainz.de

## Load all necessary modules if needed
module load bio/RepeatModeler/2.0.2a-foss-2020b
BuildDatabase -name Nobt_repeatdb -engine ncbi NO_genome.fasta
RepeatModeler -database Nobt_repeatdb -engine ncbi -pa 20 -LTRStruct
RepeatMasker -pa 20 -xsmall -gff -lib consensi_classified.fasta NO_genome.fasta

########################################################Running BRAKER3 (Using Illumina short read RNA-Seq data and protein evidences)

#!/bin/bash

#SBATCH -J Nobt_Illumina_BRAKER3            # Job name
#SBATCH -o Nobt_Illumina_BRAKER3.%j.out       # Specify stdout output file (%j expands to jobId)
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
export AUGUSTUS_CONFIG_PATH=/lustre/project/m2_jgu-evoltroph/achakrab/NO_genome/03_BRAKER_analysis/AUGUSTUS_CONFIG/config
braker.pl --genome=/lustre/project/m2_jgu-evoltroph/achakrab/NO_genome/02_Assembly_files/NO_genome_masked.fasta --species=obtusifolia --softmasking --threads 20 --rnaseq_sets_ids=NO --rnaseq_sets_dir=/lustre/project/m2_jgu-evoltroph/achakrab/NO_genome/04_RNAseq_files/filtered_files --prot_seq=/lustre/project/m2_jgu-evoltroph/achakrab/NA_genome/05_protein_files/Selected_Solanaceae_species_cat.fasta --workingdir=/lustre/project/m2_jgu-evoltroph/achakrab/NO_genome/03_BRAKER_analysis/NO_BRAKER3_Run1 --AUGUSTUS_CONFIG_PATH=$AUGUSTUS_CONFIG_PATH --PYTHON3_PATH=$PYTHON3_PATH --PROTHINT_PATH=/lustre/project/m2_jgu-evoltroph/achakrab/SOFTWARES/ProtHint-2.6.0/bin --GENEMARK_PATH=/lustre/project/m2_jgu-evoltroph/achakrab/SOFTWARES/gmetp_linux_64/bin

########################################################Running BRAKER3 (Using Iso-seq transcriptome data and protein evidences)

##############Minimap2 alignment
#!/bin/bash

#SBATCH -J NO_minimap            # Job name
#SBATCH -o NO_minimap.%j.out       # Specify stdout output file (%j expands to jobId)
#SBATCH -p bigmem                   # Queue name 'smp' or 'parallel' on Mogon II
#SBATCH -n 1                     # Total number of tasks, here explicitly 1
#SBATCH -c 20                    # Total number of cores for the single task
#SBATCH --mem 280G                # The default is 300M memory per job. You'll likely have to adapt this to your needs
#SBATCH -t 24:00:00              # Run time (hh:mm:ss)

#SBATCH -A m2_jgu-evoltroph     # Specify allocation to charge against

#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=achakrab@uni-mainz.de

## Load all necessary modules if needed
module load bio/minimap2/2.24-GCCcore-11.2.0
module load bio/SAMtools/1.17-GCC-12.2.0
minimap2 -t 20 -ax splice:hq -uf NO_genome_masked.fasta NO_ccs.fastq > NO_isoseq.sam
samtools view -bS --threads 20 NO_isoseq.sam -o NO_isoseq.bam

##############BRAKER3 run
#!/bin/bash

#SBATCH -J Nobt_Illumina_BRAKER3            # Job name
#SBATCH -o Nobt_Illumina_BRAKER3.%j.out       # Specify stdout output file (%j expands to jobId)
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
export AUGUSTUS_CONFIG_PATH=/lustre/project/m2_jgu-evoltroph/achakrab/NO_genome/03_BRAKER_analysis/AUGUSTUS_CONFIG/config
braker.pl --genome=/lustre/project/m2_jgu-evoltroph/achakrab/NO_genome/02_Assembly_files/NO_genome_masked.fasta --useexisting --species=obtusifolia --softmasking --threads 20 --bam=/lustre/project/m2_jgu-evoltroph/achakrab/NO_genome/04_RNAseq_files/Isoseq_minimap_mapping/NO_isoseq.bam --prot_seq=/lustre/project/m2_jgu-evoltroph/achakrab/NA_genome/05_protein_files/Selected_Solanaceae_species_cat.fasta --workingdir=/lustre/project/m2_jgu-evoltroph/achakrab/NO_genome/03_BRAKER_analysis/NO_BRAKER3_Run2 --AUGUSTUS_CONFIG_PATH=$AUGUSTUS_CONFIG_PATH --PYTHON3_PATH=$PYTHON3_PATH --PROTHINT_PATH=/lustre/project/m2_jgu-evoltroph/achakrab/SOFTWARES/ProtHint-2.6.0/bin --GENEMARK_PATH=/lustre/project/m2_jgu-evoltroph/achakrab/SOFTWARES/gmetp_linux_64/bin

########################################################Gene set merging using TSEBRA

#!/bin/bash

#SBATCH -J NO_tsebra            # Job name
#SBATCH -o NO_tsebra.%j.out       # Specify stdout output file (%j expands to jobId)
#SBATCH -p devel                   # Queue name 'smp' or 'parallel' on Mogon II
#SBATCH -n 1                     # Total number of tasks, here explicitly 1
#SBATCH -c 10                    # Total number of cores for the single task
#SBATCH --mem 60G                # The default is 300M memory per job. You'll likely have to adapt this to your needs
#SBATCH -t 00:30:00              # Run time (hh:mm:ss)

#SBATCH -A m2_jgu-evoltroph     # Specify allocation to charge against

#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=achakrab@uni-mainz.de

## Load all necessary modules if needed
/lustre/project/m2_jgu-evoltroph/achakrab/SOFTWARES/TSEBRA/bin/tsebra.py -g braker_run1.gtf,braker_run2.gtf -c /lustre/project/m2_jgu-evoltroph/achakrab/SOFTWARES/TSEBRA/config/long_reads.cfg -e hintsfile_run1.gff,hintsfile_run2.gff -o NO_merged_TSEBRA.gtf

########################################################Filtering using AGAT

#!/bin/bash

#SBATCH -J AGAT_NO            # Job name
#SBATCH -o AGAT_NO.%j.out       # Specify stdout output file (%j expands to jobId)
#SBATCH -p devel                   # Queue name 'smp' or 'parallel' on Mogon II
#SBATCH -n 1                     # Total number of tasks, here explicitly 1
#SBATCH -c 10                    # Total number of cores for the single task
#SBATCH --mem 80G                # The default is 300M memory per job. You'll likely have to adapt this to your needs
#SBATCH -t 00:30:00              # Run time (hh:mm:ss)

#SBATCH -A m2_jgu-evoltroph     # Specify allocation to charge against

#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=achakrab@uni-mainz.de

## Load all necessary modules if needed
module load bio/AGAT/1.1.0-GCC-11.2.0
agat_convert_sp_gxf2gxf.pl -g braker.gtf -o braker.gff
agat_sp_keep_longest_isoform.pl -gff braker.gff -o NO_braker_longest.gff
agat_sp_filter_gene_by_length.pl --gff NO_braker_longest.gff --size 99 --test ">" -o NO_braker_longest_100.gff

########################################################Extraction of CDS

#!/bin/bash

#SBATCH -J gffread            # Job name
#SBATCH -o gffread.%j.out       # Specify stdout output file (%j expands to jobId)
#SBATCH -p devel                   # Queue name 'smp' or 'parallel' on Mogon II
#SBATCH -n 1                     # Total number of tasks, here explicitly 1
#SBATCH -c 10                    # Total number of cores for the single task
#SBATCH --mem 80G                # The default is 300M memory per job. You'll likely have to adapt this to your needs
#SBATCH -t 00:30:00              # Run time (hh:mm:ss)

#SBATCH -A m2_jgu-evoltroph     # Specify allocation to charge against

#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=achakrab@uni-mainz.de

## Load all necessary modules if needed
source /lustre/project/m2_jgu-evoltroph/achakrab/SOFTWARES/ALL_SOFTWARES_anaconda3/bin/activate
gffread NA_braker_longest_100.gff -g /lustre/project/m2_jgu-evoltroph/achakrab/NO_genome/02_Assembly_files/NO_genome.fasta -x Longest_isoforms_CDS.fasta

########################################################Run RepeatMasker on extracted CDS

#!/bin/bash

#SBATCH -J NO_RM            # Job name
#SBATCH -o NO_RM.%j.out       # Specify stdout output file (%j expands to jobId)
#SBATCH -p devel                   # Queue name 'smp' or 'parallel' on Mogon II
#SBATCH -n 1                     # Total number of tasks, here explicitly 1
#SBATCH -c 20                    # Total number of cores for the single task
#SBATCH --mem 80G                # The default is 300M memory per job. You'll likely have to adapt this to your needs
#SBATCH -t 02:00:00              # Run time (hh:mm:ss)

#SBATCH -A m2_jgu-evoltroph     # Specify allocation to charge against

#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=achakrab@uni-mainz.de

## Load all necessary modules if needed
module load bio/RepeatModeler/2.0.2a-foss-2020b
RepeatMasker -pa 20 -xsmall -gff -lib rep_lib.fasta Longest_isoforms_CDS.fasta

########################################################TE-based filtering to obtain final files

#!/bin/bash

#SBATCH -J NA_Filtering            # Job name
#SBATCH -o NA_Filtering.%j.out       # Specify stdout output file (%j expands to jobId)
#SBATCH -p devel                   # Queue name 'smp' or 'parallel' on Mogon II
#SBATCH -n 1                     # Total number of tasks, here explicitly 1
#SBATCH -c 10                    # Total number of cores for the single task
#SBATCH --mem 80G                # The default is 300M memory per job. You'll likely have to adapt this to your needs
#SBATCH -t 01:00:00              # Run time (hh:mm:ss)

#SBATCH -A m2_jgu-evoltroph     # Specify allocation to charge against

#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=achakrab@uni-mainz.de

## Load all necessary modules if needed
perl calc_TE_proportion.pl Longest_isoforms_CDS.gff Longest_isoforms_CDS.fasta > NO_TE_prop.out
awk '{if ($5 > 0.5) print $2}' NO_TE_prop.out > NO_gene_list.TE_gt_50perc.list
module load bio/AGAT/1.1.0-GCC-11.2.0
agat_sp_filter_feature_from_kill_list.pl --gff NO_braker_longest_100.gff --kill_list NO_gene_list.TE_gt_50perc.list -o NO_Braker_longest_100_TEfiltered.gff
source /lustre/project/m2_jgu-evoltroph/achakrab/SOFTWARES/ALL_SOFTWARES_anaconda3/bin/activate
gffread NO_Braker_longest_100_TEfiltered.gff -g /lustre/project/m2_jgu-evoltroph/achakrab/NO_genome/02_Assembly_files/NO_genome.fasta -x NO_CDS.fasta -y NO_aa.fasta

########################################################BUSCO evaluation

#!/bin/bash

#SBATCH -J busco_Nicotiana            # Job name
#SBATCH -o busco_Nicotiana.%j.out       # Specify stdout output file (%j expands to jobId)
#SBATCH -p smp                   # Queue name 'smp' or 'parallel' on Mogon II
#SBATCH -n 1                     # Total number of tasks, here explicitly 1
#SBATCH -c 20                    # Total number of cores for the single task
#SBATCH --mem 80G                # The default is 300M memory per job. You'll likely have to adapt this to your needs
#SBATCH -t 12:00:00              # Run time (hh:mm:ss)

#SBATCH -A m2_jgu-evoltroph     # Specify allocation to charge against

#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=achakrab@uni-mainz.de

## Load all necessary modules if needed
module load bio/BUSCO/5.4.3-foss-2021b
busco -f -m genome --offline --download_path /lustre/project/m2_jgu-evoltroph/achakrab/SOFTWARES/busco_downloads -i Nobt_genome.fasta -o Nobt_Solanales_genome -l solanales_odb10 -c 20
busco -f -m proteins --offline --download_path /lustre/project/m2_jgu-evoltroph/achakrab/SOFTWARES/busco_downloads -i Nobt_aa.fasta -o Nobt_Solanales_proteome -l solanales_odb10 -c 20
