#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 10:0:0   
#SBATCH -J=anvi_merged_db_hx.sh    # take half an hour
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
 
export MPLCONFIGDIR=/scratch/c/careg421/ruizhang/MPLCONFIGDIR 
 
export PYTHONPATH=$PYTHONPATH:$SCRATCH/github/anvio-7.1/ 
export PATH="/scratch/c/careg421/ruizhang/github/anvio-7.1/bin:$PATH"
export PATH="/scratch/c/careg421/ruizhang/github/anvio-7.1/sandbox:$PATH"

contigdb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_contigs_db
profiledb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_profile_db/20220128
merged_db=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_merged_db

list='hx1a hx1b hx2a hx2b hx3a hx3b'

for site in $list
do
	anvi-merge \
	$profiledb/${site}*profile/PROFILE.db \
	-o $merged_db/${site}_MERGED_DB \
	-c $contigdb/${site}_contigs_1000.db \
	--enforce-hierarchical-clustering -W
done



#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 10:0:0   
#SBATCH -J=anvi_merged_db_gx.sh
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
 
export MPLCONFIGDIR=/scratch/c/careg421/ruizhang/MPLCONFIGDIR 
 
export PYTHONPATH=$PYTHONPATH:$SCRATCH/github/anvio-7.1/ 
export PATH="/scratch/c/careg421/ruizhang/github/anvio-7.1/bin:$PATH"
export PATH="/scratch/c/careg421/ruizhang/github/anvio-7.1/sandbox:$PATH"

contigdb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_contigs_db
profiledb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_profile_db/20220128
merged_db=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_merged_db

list='gx1a gx1b gx2a gx2b gx3a gx3b'

for site in $list
do
	anvi-merge \
	$profiledb/${site}*profile/PROFILE.db \
	-o $merged_db/${site}_MERGED_DB \
	-c $contigdb/${site}_contigs_1000.db \
	--enforce-hierarchical-clustering -W
done



#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 10:0:0   
#SBATCH -J=anvi_merged_db_sk.sh
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
 
export MPLCONFIGDIR=/scratch/c/careg421/ruizhang/MPLCONFIGDIR 
 
export PYTHONPATH=$PYTHONPATH:$SCRATCH/github/anvio-7.1/ 
export PATH="/scratch/c/careg421/ruizhang/github/anvio-7.1/bin:$PATH"
export PATH="/scratch/c/careg421/ruizhang/github/anvio-7.1/sandbox:$PATH"

contigdb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_contigs_db
profiledb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_profile_db/20220128
merged_db=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_merged_db

list='sk1a sk1b sk2a sk2b sk3a sk3b'

for site in $list
do
	anvi-merge \
	$profiledb/${site}*profile/PROFILE.db \
	-o $merged_db/${site}_MERGED_DB \
	-c $contigdb/${site}_contigs_1000.db \
	--enforce-hierarchical-clustering -W
done
