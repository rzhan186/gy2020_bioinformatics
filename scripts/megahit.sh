#!/bin/bash   
#SBATCH -c 40 
#SBATCH --nodes 1
#SBATCH -t 1-0:0:0         
#SBATCH -J=megahit_all
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=BEGIN 
#SBATCH --mail-type=END 
#SBATCH --output=%x-%j.out

export PATH="/scratch/c/careg421/ruizhang/MEGAHIT-1.2.9-Linux-x86_64-static/bin/:$PATH"
INPUT=/scratch/c/careg421/ruizhang/guiyang/trimmed_reads
OUTPUT=/scratch/c/careg421/ruizhang/guiyang/megahit_output

list="hx1a hx1b hx2a hx2b hx3a hx3b gx1a gx1b gx2a gx2b gx3a gx3b sk1a sk2a sk2a sk2b sk3a sk3b"

for site in $list
do
	megahit \
	-1 $INPUT/LC_${site}_fastp.R1.fq.gz \
	-2 $INPUT/LC_${site}_fastp.R2.fq.gz \
	-o $OUTPUT/${site} \
	--no-mercy \
	--kmin-1pass \
	--presets meta-large \
	-t 40
done