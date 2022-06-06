# anvio import collection 

#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 3:0:0   
#SBATCH -J=anvi-import-collection.sh
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

bins=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_binning/dastool/20220207
contigdb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_contigs_db
profiledb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_profile_db/20220128
merged_db=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_merged_db

list='hx1a hx1b hx2a hx2b hx3a hx3b gx1a gx1b gx2a gx2b gx3a gx3b sk1a sk1b sk2a sk2b sk3a sk3b'

for site in $list
do
anvi-import-collection \
$bins/$site/t1_DASTool_scaffolds2bin.txt \
-p $merged_db/${site}_MERGED_DB/PROFILE.db \
-c $contigdb/${site}_contigs_1000.db \
-C ${site}_Dastool_bins \
--contigs-mode
done

# summarize bins

#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 2:0:0   
#SBATCH -J=anvi-summarize.sh
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

# summarize bins
bins=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_binning/dastool/20220207
contigdb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_contigs_db
profiledb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_profile_db/20220128
merged_db=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_merged_db
output=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_anvi_summarize
list='hx1a hx1b hx2a hx2b hx3a hx3b gx1a gx1b gx2a gx2b gx3a gx3b sk1a sk1b sk2a sk2b sk3a sk3b'

for site in $list
do
anvi-summarize \
-c $contigdb/${site}_contigs_1000.db \
-p $merged_db/${site}_MERGED_DB/PROFILE.db \
--collection-name ${site}_Dastool_bins \
--output-dir $output/$site
done



# Check the summarize output file (bins_summary). anvi-refine MAGs, only include bins with completeness > 50%, redundancy < 10%. 
bins=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_binning/dastool/20220207
contigdb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_contigs_db
profiledb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_profile_db/20220128
merged_db=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_merged_db
output=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_anvi_summarize

site='gx1a' # change this one by one
bin='maxbin2_gx1a_bin112' # change this parameter (bin) one by one
anvi-refine \
-c $contigdb/${site}_contigs_1000.db \
-p $merged_db/${site}_MERGED_DB/PROFILE.db \
-C ${site}_Dastool_bins \
-b ${bin} 

# once all bins from a site has been refined
# generate summary file of the newly refined bins
yes | rm -R /scratch/c/careg421/ruizhang/guiyang/anvio/option2_anvi_summarize/$site

anvi-summarize \
-c $contigdb/${site}_contigs_1000.db \
-p $merged_db/${site}_MERGED_DB/PROFILE.db \
--collection-name ${site}_Dastool_bins \
--output-dir $output/$site

# After the bins are refined in one export collections. This step is to export the bins that have been refined and make a new collection by including the refined bins only. 
anvi-export-collection \
-C ${site}_Dastool_bins \
-p $merged_db/${site}_MERGED_DB/PROFILE.db \
-O $SCRATCH/${site}_refined_collection

# retain lines that only include the keyword "refined"
grep 'refined' $SCRATCH/${site}_refined_collection.txt > $SCRATCH/${site}_refined.txt

# import the filtered collection back into the profile DB with a new collection name
anvi-import-collection \
$SCRATCH/${site}_refined.txt \
-p $merged_db/${site}_MERGED_DB/PROFILE.db \
-c $contigdb/${site}_contigs_1000.db \
-C ${site}_refined

# then export the refined bins as Fasta files into a dedeicated location
input=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_anvi_summarize
output=/scratch/c/careg421/ruizhang/guiyang/anvio/20220207_refined_bins

cp $input/$site/bin_by_bin/refined*/*.fa $output


# summarize refined MAGS 

#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 2:0:0   
#SBATCH -J=anvi-summarize-refined.sh
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

bins=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_binning/dastool/20220207
contigdb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_contigs_db
profiledb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_profile_db/20220128
merged_db=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_merged_db
output=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_anvi_summarize
list='hx1a hx1b hx2a hx2b hx3a hx3b gx1a gx1b gx2a gx2b gx3a gx3b sk1a sk1b sk2a sk2b sk3a sk3b'

for site in $list
do
anvi-summarize \
-c $contigdb/${site}_contigs_1000.db \
-p $merged_db/${site}_MERGED_DB/PROFILE.db \
--collection-name ${site}_refined \
--output-dir $output/${site}_refine_summary
done