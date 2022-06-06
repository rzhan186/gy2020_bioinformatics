#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 20:0:0   
#SBATCH -J=anvi_profile_db_contigs1000_hx.sh
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

cd $SCRATCH

bam=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_mapping/20220128
contigdb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_contigs_db
profiledb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_profile_db/20220128

mkdir $profiledb

list1='hx1a hx1b hx2a hx2b hx3a hx3b'
list2='hx1a hx1b hx2a hx2b hx3a hx3b'

for site in $list1
do
for reads_site in $list2
do
anvi-profile \
--min-contig-length 1000 \
-i $bam/${site}/${site}_${reads_site}_fixed.bam \
-c $contigdb/${site}_contigs_1000.db \
--output-dir $profiledb/${site}_${reads_site}_profile \
--num-threads 40 \
--sample-name ${site}_${reads_site}_profileDB \
--skip-hierarchical-clustering \
--write-buffer-size 10000
done
done



#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 20:0:0   
#SBATCH -J=anvi_profile_db_contigs1000_gx.sh
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

cd $SCRATCH

bam=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_mapping/20220128
contigdb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_contigs_db
profiledb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_profile_db/20220128

mkdir $profiledb

list1='gx1a gx1b gx2a gx2b gx3a gx3b'
list2='gx1a gx1b gx2a gx2b gx3a gx3b'

for site in $list1
do
for reads_site in $list2
do
anvi-profile \
--min-contig-length 1000 \
-i $bam/${site}/${site}_${reads_site}_fixed.bam \
-c $contigdb/${site}_contigs_1000.db \
--output-dir $profiledb/${site}_${reads_site}_profile \
--num-threads 40 \
--sample-name ${site}_${reads_site}_profileDB \
--skip-hierarchical-clustering \
--write-buffer-size 10000
done
done




#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 20:0:0   
#SBATCH -J=anvi_profile_db_contigs1000_sk.sh
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

cd $SCRATCH

bam=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_mapping/20220128
contigdb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_contigs_db
profiledb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_profile_db/20220128

mkdir $profiledb

list1='sk1a sk1b sk2a sk2b sk3a sk3b'
list2='sk1a sk1b sk2a sk2b sk3a sk3b'

for site in $list1
do
for reads_site in $list2
do
anvi-profile \
--min-contig-length 1000 \
-i $bam/${site}/${site}_${reads_site}_fixed.bam \
-c $contigdb/${site}_contigs_1000.db \
--output-dir $profiledb/${site}_${reads_site}_profile \
--num-threads 40 \
--sample-name ${site}_${reads_site}_profileDB \
--skip-hierarchical-clustering \
--write-buffer-size 10000
done
done