#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 12:0:0                       
#SBATCH -J=metabat2-all.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=BEGIN 
#SBATCH --mail-type=END 
#SBATCH --output=%x-%j.out

module load CCEnv
module load StdEnv/2020

cd $SCRATCH

CONTIG=/scratch/c/careg421/ruizhang/guiyang/megahit_output
MAPPING=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_mapping/20220128
OUTPUT=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_binning/metabat2

list='hx1a hx1b hx2a hx2b hx3a hx3b gx1a gx1b gx2a gx2b gx3a gx3b sk1a sk1b sk2a sk2b sk3a sk3b'

for site in $list
do
	# BAM to TXT conversion
	singularity exec -B /scratch/c/careg421/ruizhang metabat2-v2-15-2.sif \
	jgi_summarize_bam_contig_depths --outputDepth $OUTPUT/${site}/${site}_metabat2_depth.txt $MAPPING/${site}/${site}_*_fixed.bam
done

for site in $list
do
	singularity exec -B /scratch/c/careg421/ruizhang metabat2-v2-15-2.sif \
	metabat2 -i $CONTIG/fastp_${site}/contigs-anvio-fixed-1000-rename.fa \
	-a $OUTPUT/${site}/${site}_metabat2_depth.txt \
	-o $OUTPUT/${site}/bins/metabat2_${site}_bin_ \
	-m 1500 \
	-t 80
done

