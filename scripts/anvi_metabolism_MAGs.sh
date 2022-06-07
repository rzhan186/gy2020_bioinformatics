#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 3:0:0   
#SBATCH -J=guiyang_updated_kegg.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=END 
#SBATCH --output=%x-%j.out

module load CCEnv
module load StdEnv/2020 gcc/9.3.0
module load python/3.8
module load prodigal/2.6.3
module load hmmer/3.2.1
module load diamond
module load blast+/2.12.0
module load mcl
module load r

source ~/anvio-7.1-dev/bin/activate

export PYTHONPATH=$PYTHONPATH:$SCRATCH/anvio-dev-apr2022/anvio/ 
export PATH="/scratch/c/careg421/ruizhang/anvio-dev-apr2022/anvio/bin:$PATH"
export PATH="/scratch/c/careg421/ruizhang/anvio-dev-apr2022/anvio/sandbox:$PATH"

kegg_db=/scratch/c/careg421/ruizhang/guiyang/anvio/KEGG_db
contigs_dir=/scratch/c/careg421/ruizhang/methylator_review/ncbi-genomes-2022-03-16
contigdb=/scratch/c/careg421/ruizhang/methylator_review/contigs_db

cd /scratch/c/careg421/ruizhang/guiyang/anvio/20220429_anvi-estimate-metabolism

# matrix format
anvi-estimate-metabolism \
-i $SCRATCH/guiyang/anvio/20220228_final_refined_internal_genomes.txt \
--kegg-data-dir $kegg_db \
-O 20220504_all_MAGs \
--matrix-format \
--include-metadata

# module steps format
anvi-estimate-metabolism \
-i $SCRATCH/guiyang/anvio/20220228_final_refined_internal_genomes.txt \
--kegg-data-dir $kegg_db \
-O 20220504_all_MAGs \
--output-modes module_steps 