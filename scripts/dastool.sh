#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 8:0:0   
#SBATCH -J=dastool-all.sh   # each sample takes roughly 4 hours
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=END 
#SBATCH --output=%x-%j.out

module load CCEnv
module load StdEnv/2020
module load gcc/9.3.0
module load r/4.0.2
module load prodigal/2.6.3
module load diamond
module load blast
module load blast+/2.11.0

export PATH="/scratch/c/careg421/ruizhang/:$PATH"
export PATH="/scratch/c/careg421/ruizhang/pullseq/src/:$PATH"
export PATH="/scratch/c/careg421/ruizhang/DAS_Tool-1.1.3/:$PATH"
export PATH="/scratch/c/careg421/ruizhang/DAS_Tool-1.1.3/src/:$PATH"

concoct=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_binning/concoct
maxbin2=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_binning/maxbin2/20220202
metabat2=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_binning/metabat2
output=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_binning/dastool/20220207
contigs=/scratch/c/careg421/ruizhang/guiyang/megahit_output
mkdir $output 

list='hx1a hx1b hx2a hx2b hx3a hx3b gx1a gx1b gx2a gx2b gx3a gx3b sk1a sk1b sk2a sk2b sk3a sk3b'
for site in $list
do
mkdir $output/$site
done

for site in $list
do
Fasta_to_Scaffolds2Bin.sh \
-i $metabat2/${site}/bins \
-e fa > $output/${site}/${site}_metabat2.scaffolds2bin.tsv

Fasta_to_Scaffolds2Bin.sh \
-i $maxbin2/${site} \
-e fasta > $output/${site}/${site}_maxbin2.scaffolds2bin.tsv

Fasta_to_Scaffolds2Bin.sh \
-i $concoct/${site}/bins \
-e fa > $output/${site}/${site}_concoct.scaffolds2bin.tsv

DAS_Tool -i $output/${site}/${site}_metabat2.scaffolds2bin.tsv,$output/${site}/${site}_maxbin2.scaffolds2bin.tsv,$output/${site}/${site}_concoct.scaffolds2bin.tsv \
-l metabat2,maxbin2,concoct \
-c $contigs/fastp_${site}/contigs-anvio-fixed-1000-rename.fa \
-o $output/${site}/t1 \
--write_bins 1 \
--write_bin_evals 1 \
--search_engine diamond \
-t 80
done


# remove all dots in the scaffolds2bin document 
output=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_binning/dastool/20220207
list='hx1a hx1b hx2a hx2b hx3a hx3b gx1a gx1b gx2a gx2b gx3a gx3b sk1a sk1b sk2a sk2b sk3a sk3b'
for site in $list
do
sed -i 's/\.//g' $output/$site/t1_DASTool_scaffolds2bin.txt
done