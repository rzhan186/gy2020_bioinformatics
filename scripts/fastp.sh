#!/bin/bash
#SBATCH -c 20          
#SBATCH --mem=80G                  
#SBATCH -t 5-0:0:0                         
#SBATCH -J=fastp_all
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=BEGIN 
#SBATCH --mail-type=END 
#SBATCH --output=%x-%j.out

export PATH="/home/ruizhang/scratch/:$PATH"

INPUT=/home/ruizhang/scratch/zzhan186/guiyang/fastp_results/lc-bio/filtered_sequence
OUTPUT=/home/ruizhang/scratch/zzhan186/guiyang/fastqc_report/lc-bio/lc_fastp

list="hx1a hx1b hx2a hx2b hx3a hx3b gx1a gx1b gx2a gx2b gx3a gx3b sk1a sk2a sk2a sk2b sk3a sk3b"

for site in $list
do
	fastp \
	-i $INPUT/${site}_R1.fastq.gz \
	-I $INPUT/${site}_R2.fastq.gz \
	--unpaired1 $OUTPUT/filtered_sequence/LC_${site}_fastP_unpaired_combined.fq.gz \
	--unpaired2 $OUTPUT/filtered_sequence/LC_${site}_fastP_unpaired_combined.fq.gz \
	-o $OUTPUT/filtered_sequence/LC_{site}_fastp.R1.fq.gz \
	-O $OUTPUT/filtered_sequence/LC_{site}_fastp.R2.fq.gz \
	-h $OUTPUT/reports/fastp_lc_{site}.html \
	-j $OUTPUT/reports/fastp_lc_{site}.json \
	--adapter_sequence AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
	--adapter_sequence_r2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT \
	-g 
done