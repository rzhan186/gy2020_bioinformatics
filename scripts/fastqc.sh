#!/bin/bash
#SBATCH -c 12          
#SBATCH --mem=48G                    
#SBATCH -t 1-0:0:0                         
#SBATCH -J=fastqc_rice
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=BEGIN 
#SBATCH --mail-type=END 
#SBATCH --output=%x-%j.out
	
module load fastqc/0.11.9
INPUT=/home/ruizhang/scratch/zzhan186/guiyang/lcbio_rawdata
OUTPUT=/home/ruizhang/scratch/zzhan186/guiyang/fastqc_report/lc-bio

list="hx1a hx1b hx2a hx2b hx3a hx3b gx1a gx1b gx2a gx2b gx3a gx3b sk1a sk2a sk2a sk2b sk3a sk3b"

for site in $list
do
	fastqc $INPUT/${site}_R1.fastq.gz $INPUT/${site}_R2.fastq.gz --outdir=$OUTPUT -t 12
done