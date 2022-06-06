# maxbin2 would stop working occasionally for unknown reason. Jobs have to be submitted multiple times sometimes. 
# it is advised to submit the jobs independently for each site. 

#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 10:0:0   
#SBATCH -J=maxbin-sk3a.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=END 
#SBATCH --output=%x-%j.out

module load CCEnv
module load StdEnv/2020 
module load gcc/9.3.0
module load python/3.8
module load maxbin/2.2.7
module load fraggenescan
module load hmmer3
module load bowtie2

CONTIG=/scratch/c/careg421/ruizhang/guiyang/megahit_output
ABUND=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_anvi-export-gene-coverage
OUTPUT=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_binning/maxbin2/20220202
site='hx1a' # adjust this for each site

cd $OUTPUT/$site
yes | rm maxbin2*

cd $SCRATCH

singularity exec -B /scratch/c/careg421/ruizhang maxbin2-2.2.7.sif \
run_MaxBin.pl \
-contig $CONTIG/fastp_${site}/contigs-anvio-fixed-1000-rename.fa \
-abund $ABUND/${site}_merged.txt \
-out $OUTPUT/${site}/maxbin2_${site}_bin \
-min_contig_length 1000 \
-thread 40