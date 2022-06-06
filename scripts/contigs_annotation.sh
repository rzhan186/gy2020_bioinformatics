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

# run NCBI cogs on contigs db

#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 20:0:0   
#SBATCH -J=anvi-cog-all.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=BEGIN 
#SBATCH --mail-type=END 
#SBATCH --output=%x-%j.out

module load CCEnv
module load StdEnv/2020 gcc/9.3.0
module load python/3.8
module load prodigal/2.6.3
module load hmmer/3.2.1
module load diamond
module load blast+/2.12.0
source ~/anvio-dev/bin/activate

contigdb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_contigs_db
cog=/scratch/c/careg421/ruizhang/guiyang/anvio/ncbi-cogs

list='hx1a hx1b hx2a hx2b hx3a hx3b gx1a gx1b gx2a gx2b gx3a gx3b sk1a sk1b sk2a sk2b sk3a sk3b'

for site in $list
do
anvi-run-ncbi-cogs -c $contigdb/${site}_contigs_1000.db -T 80 \
--cog-data-dir $cog
done

	
# anvio setup pfam database 

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

pfam_db=/scratch/c/careg421/ruizhang/guiyang/anvio/pfam_db
mkdir $pfam_db

anvi-setup-pfams --pfam-data-dir $pfam_db

# anvio run pfam 

#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 24:0:0   
#SBATCH -J=anvi-run-pfam.sh
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

cd $SCRATCH

pfam_db=/scratch/c/careg421/ruizhang/guiyang/anvio/pfam_db
contigs_db=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_contigs_db

list='hx1a hx2a hx3a hx1b hx2b hx3b gx1a gx2a gx3a gx1b gx2b gx3b sk1a sk2a sk3a sk1b sk2b sk3b'

for site in $list
do
anvi-run-pfams \
-c $contigs_db/${site}_contigs_1000.db \
--pfam-data-dir $pfam_db \
--num-threads 40
done



# run hgcAB hmm

list='hx1a hx2a hx3a hx1b hx2b hx3b gx1a gx2a gx3a gx1b gx2b gx3b sk1a sk2a sk3a sk1b sk2b sk3b'

for site in $list
do
anvi-run-hmms \
-c $contigs_db/${site}_contigs_1000.db \
-H $hmm/anvio_custom_hmm_hgcA \
--num-thread 80
done

for site in $list
do
anvi-run-hmms \
-c $contigs_db/${site}_contigs_1000.db \
-H $hmm/anvio_custom_hmm_hgcB \
--num-thread 80
done
