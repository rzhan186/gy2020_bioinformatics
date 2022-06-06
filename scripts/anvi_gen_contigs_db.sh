# create anvio contigs db

#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 20:0:0   
#SBATCH -J=contigs_db.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=END 
#SBATCH --output=%x-%j.out

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

contigs_dir=/scratch/c/careg421/ruizhang/guiyang/megahit_output
contigdb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_contigs_db
cog=/scratch/c/careg421/ruizhang/guiyang/anvio/ncbi-cogs/COG20

list='hx1a hx1b hx2a hx2b hx3a hx3b gx1a gx1b gx2a gx2b gx3a gx3b sk1a sk1b sk2a sk2b sk3a sk3b'

cd /scratch/c/careg421/ruizhang

for site in $list
do
anvi-gen-contigs-database -f $contigs_dir/fastp_${site}/contigs-anvio-fixed-1000-rename.fa -o $contigdb/${site}_contigs_1000.db -n '20211223 Guiyang 2020'
done


# anvio setup NCBI COGs
module load CCEnv
module load StdEnv/2020 gcc/9.3.0
module load python/3.8
module load prodigal/2.6.3
module load hmmer/3.2.1
module load diamond
module load blast+/2.12.0
source ~/anvio-dev/bin/activate

cog=/scratch/c/careg421/ruizhang/guiyang/anvio/ncbi-cogs
anvi-setup-ncbi-cogs \
--cog-data-dir $cog