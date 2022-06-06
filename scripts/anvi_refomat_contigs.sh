#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 5:0:0   
#SBATCH -J=reformat_contigs.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=END 
#SBATCH --output=%x-%j.out

# activate anvio development version 
module load CCEnv
module load StdEnv/2020
module load python/3.8
module load prodigal/2.6.3
module load hmmer/3.2.1
module load diamond

source ~/anvio-dev/bin/activate
 #appending to PYTHONPATH instead of overwriting it completely
export PYTHONPATH=$PYTHONPATH:$SCRATCH/github/anvio-7.1/ 
export PATH="/scratch/c/careg421/ruizhang/github/anvio-7.1/bin:$PATH"
export PATH="/scratch/c/careg421/ruizhang/github/anvio-7.1/sandbox:$PATH"

cd $SCRATCH

file=/scratch/c/careg421/ruizhang/guiyang/megahit_output/
list='hx1a hx1b hx2a hx2b hx3a hx3b gx1a gx1b gx2a gx2b gx3a gx3b sk1a sk1b sk2a sk2b sk3a sk3b'

for site in $list
do
	anvi-script-reformat-fasta \
	$file/fastp_${site}/final.contigs.fa \
	-o $file/fastp_${site}/contigs-anvio-fixed-1000.fa \
	-l 1000 --simplify-names
done

for site in $list
do
	sed 's/>.*/&_'${site}'/' $file/fastp_${site}/contigs-anvio-fixed-1000.fa > $file/fastp_${site}/contigs-anvio-fixed-1000-rename.fa
done