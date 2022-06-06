#!/bin/bash
#SBATCH -c 12         
#SBATCH --mem=48G                         
#SBATCH -t 5-0:0:0                         
#SBATCH -J=fastqc_multiqc_all
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=BEGIN 
#SBATCH --mail-type=END 
#SBATCH --output=%x-%j.out

#fastqc
module load fastqc/0.11.9
INPUT=/home/ruizhang/scratch/zzhan186/guiyang/fastp_results/lc-bio/filtered_sequence
OUTPUT=/home/ruizhang/scratch/zzhan186/guiyang/fastqc_report/lc-bio/lc_fastp

list="hx1a hx1b hx2a hx2b hx3a hx3b gx1a gx1b gx2a gx2b gx3a gx3b sk1a sk2a sk2a sk2b sk3a sk3b"

for site in $list
do
	fastqc $INPUT/LC_${site}_fastp.R1.fq.gz $INPUT/LC_${site}_fastp.R2.fq.gz --outdir=$OUTPUT -t 12
done

#multiqc

INPUT=/home/ruizhang/scratch/zzhan186/guiyang/fastqc_report/lc-bio/lc_fastp
OUTPUT=/home/ruizhang/scratch/zzhan186/guiyang/multiqc

singularity exec -B /home/ruizhang -B /project -B /scratch multiqc-1.9.sif \
multiqc $INPUT \
-o $OUTPUT \
-n LC_fastp_all_fastqc_multiqc_report.html