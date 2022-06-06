#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 12:0:0   
#SBATCH -J=anvi-export-coverage-hx.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=END 
#SBATCH --output=%x-%j.out

module load CCEnv
module load StdEnv/2020 gcc/9.3.0
module load python/3.8
module load prodigal/2.6.3
module load hmmer/3.2.1
module load diamond
module load metabat/2.14
module load maxbin/2.2.7

source ~/anvio-dev/bin/activate
 #appending to PYTHONPATH instead of overwriting it completely
 
export MPLCONFIGDIR=/scratch/c/careg421/ruizhang/MPLCONFIGDIR 
 
export PYTHONPATH=$PYTHONPATH:$SCRATCH/github/anvio-7.1/ 
export PATH="/scratch/c/careg421/ruizhang/github/anvio-7.1/bin:$PATH"
export PATH="/scratch/c/careg421/ruizhang/github/anvio-7.1/sandbox:$PATH"
export PATH="/scratch/c/careg421/ruizhang/DAS_Tool-1.1.3:$PATH"

contigdb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_contigs_db
profiledb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_profile_db/20220128
merged_db=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_merged_db
output=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_anvi-export-gene-coverage

list='hx1a hx1b hx2a hx2b hx3a hx3b'

for site in $list
do
anvi-export-splits-and-coverages \
-p $merged_db/${site}_MERGED_DB/PROFILE.db \
-c $contigdb/${site}_contigs_1000.db \
-o $output \
-O ${site}-coverages \
--report-contigs
done



#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 12:0:0   
#SBATCH -J=anvi-export-coverage-gx.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=END 
#SBATCH --output=%x-%j.out

module load CCEnv
module load StdEnv/2020 gcc/9.3.0
module load python/3.8
module load prodigal/2.6.3
module load hmmer/3.2.1
module load diamond
module load metabat/2.14
module load maxbin/2.2.7

source ~/anvio-dev/bin/activate
 #appending to PYTHONPATH instead of overwriting it completely
 
export MPLCONFIGDIR=/scratch/c/careg421/ruizhang/MPLCONFIGDIR 
 
export PYTHONPATH=$PYTHONPATH:$SCRATCH/github/anvio-7.1/ 
export PATH="/scratch/c/careg421/ruizhang/github/anvio-7.1/bin:$PATH"
export PATH="/scratch/c/careg421/ruizhang/github/anvio-7.1/sandbox:$PATH"
export PATH="/scratch/c/careg421/ruizhang/DAS_Tool-1.1.3:$PATH"

contigdb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_contigs_db
profiledb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_profile_db/20220128
merged_db=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_merged_db
output=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_anvi-export-gene-coverage

list='gx1a gx1b gx2a gx2b gx3a gx3b'

for site in $list
do
anvi-export-splits-and-coverages \
-p $merged_db/${site}_MERGED_DB/PROFILE.db \
-c $contigdb/${site}_contigs_1000.db \
-o $output \
-O ${site}-coverages \
--report-contigs
done
  

#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 12:0:0   
#SBATCH -J=anvi-export-coverage-sk.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=END 
#SBATCH --output=%x-%j.out

module load CCEnv
module load StdEnv/2020 gcc/9.3.0
module load python/3.8
module load prodigal/2.6.3
module load hmmer/3.2.1
module load diamond
module load metabat/2.14
module load maxbin/2.2.7

source ~/anvio-dev/bin/activate
 #appending to PYTHONPATH instead of overwriting it completely
 
export MPLCONFIGDIR=/scratch/c/careg421/ruizhang/MPLCONFIGDIR 
 
export PYTHONPATH=$PYTHONPATH:$SCRATCH/github/anvio-7.1/ 
export PATH="/scratch/c/careg421/ruizhang/github/anvio-7.1/bin:$PATH"
export PATH="/scratch/c/careg421/ruizhang/github/anvio-7.1/sandbox:$PATH"
export PATH="/scratch/c/careg421/ruizhang/DAS_Tool-1.1.3:$PATH"

contigdb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_contigs_db
profiledb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_profile_db/20220128
merged_db=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_merged_db
output=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_anvi-export-gene-coverage

list='sk1a sk1b sk2a sk2b sk3a sk3b'

for site in $list
do
anvi-export-splits-and-coverages \
-p $merged_db/${site}_MERGED_DB/PROFILE.db \
-c $contigdb/${site}_contigs_1000.db \
-o $output \
-O ${site}-coverages \
--report-contigs
done


# remove the header line of the coverage file produced by anvi-export-splits-and-coverages, and transform the file into long format. 
output=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_anvi-export-gene-coverage
list='hx1a hx1b hx2a hx2b hx3a hx3b gx1a gx1b gx2a gx2b gx3a gx3b sk1a sk1b sk2a sk2b sk3a sk3b'

for site in $list
do
tail -n +2 $output/${site}-coverages-COVs.txt > $output/${site}-coverages-COVs-1.txt
cut -f 1,2 $output/${site}-coverages-COVs-1.txt > $output/tmp-${site}-1.txt
cut -f 1,3 $output/${site}-coverages-COVs-1.txt > $output/tmp-${site}-2.txt
cut -f 1,4 $output/${site}-coverages-COVs-1.txt > $output/tmp-${site}-3.txt
cut -f 1,5 $output/${site}-coverages-COVs-1.txt > $output/tmp-${site}-4.txt
cut -f 1,6 $output/${site}-coverages-COVs-1.txt > $output/tmp-${site}-5.txt
cut -f 1,7 $output/${site}-coverages-COVs-1.txt > $output/tmp-${site}-6.txt
cat $output/tmp-${site}*.txt > $output/${site}_merged.txt
yes | rm $output/tmp-${site}-*.txt
done