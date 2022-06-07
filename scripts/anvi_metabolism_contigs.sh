# anvi-setup-kegg-kofams (anvio v7.1)

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

dir=/scratch/c/careg421/ruizhang/guiyang/anvio/KEGG_db/
anvi-setup-kegg-kofams --kegg-data-dir $dir --download-from-kegg #get the most up to date version of KEGG


# during this process, anvio reported 

	# WARNING
	# ===============================================
	# Please note that while anvi'o was building your databases, she found 1382 KOfam
	# entries that did not have any threshold to remove weak hits. We have removed
	# those HMM profiles from the final database. You can find them under the
	# directory '/scratch/c/careg421/ruizhang/guiyang/anvio/KEGG_db/orphan_data'.



# anvi-run-kegg-kofam

#!/bin/bash
#SBATCH --nodes 2
#SBATCH -t 15:0:0   
#SBATCH -J=anvi-run-kegg-kofams-HX.sh
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

kegg_db=/scratch/c/careg421/ruizhang/guiyang/anvio/KEGG_db
contigs_db=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_contigs_db
list='hx1a hx1b hx2a hx2b hx3a hx3b'

for site in $list
do
anvi-run-kegg-kofams -c $contigs_db/${site}_contigs_1000.db --kegg-data-dir $kegg_db -T 160 --just-do-it
done

#!/bin/bash
#SBATCH --nodes 2
#SBATCH -t 15:0:0   
#SBATCH -J=anvi-run-kegg-kofams-GX.sh
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

kegg_db=/scratch/c/careg421/ruizhang/guiyang/anvio/KEGG_db
contigs_db=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_contigs_db
list='gx1a gx1b gx2a gx2b gx3a gx3b'

for site in $list
do
anvi-run-kegg-kofams -c $contigs_db/${site}_contigs_1000.db --kegg-data-dir $kegg_db -T 160 --just-do-it
done



#!/bin/bash
#SBATCH --nodes 2
#SBATCH -t 15:0:0   
#SBATCH -J=anvi-run-kegg-kofams-SK.sh
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

kegg_db=/scratch/c/careg421/ruizhang/guiyang/anvio/KEGG_db
contigs_db=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_contigs_db
list='sk1a sk1b sk2a sk2b sk3a sk3b'

for site in $list
do
anvi-run-kegg-kofams -c $contigs_db/${site}_contigs_1000.db --kegg-data-dir $kegg_db -T 160 --just-do-it
done


# anvi-estimate-metabolism

#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 2:0:0   
#SBATCH -J=anvi-estimate-metabolism.sh
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

contigdb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_contigs_db
profiledb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_profile_db/20210912
output=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_anvi_estimate_metabolism
kegg_db=/scratch/c/careg421/ruizhang/guiyang/anvio/KEGG_db
mkdir $output

list='hx1a hx1b hx2a hx3a hx2b hx3b gx1a gx2a gx3a gx1b gx2b gx3b sk1a sk2a sk3a sk1b sk2b sk3b'

for site in $list
do
# mode: kofam_hits 
anvi-estimate-metabolism \
-c $contigdb/${site}_contigs_1000.db \
-p $profiledb/${site}_${site}_profile/PROFILE.db \
--output-file-prefix $output/20220109_${site} \
--kegg-data-dir $kegg_db \
--kegg-output-modes kofam_hits \
--add-coverage
done




# Now combine the kofam_hits file from all sites 
output=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_anvi_estimate_metabolism
list='hx1a hx2a hx3a hx1b hx2b hx3b gx1a gx2a gx3a gx1b gx2b gx3b sk1a sk2a sk3a sk1b sk2b sk3b'

for site in $list
do
# The goal of the following code is the first remove the space character in the file, to make sure each header can be aligned properly with their content.
# then calculate the sum of the coverage of the same KO and create another file 
sed "s| |_|g" $output/20220109_${site}_kofam_hits.txt | awk '{a[$3]+=$8}END{for(i in a) print i,a[i]}' > $output/20220109_${site}_ko_coverage.txt
# add header 
sed -i "1i A-Sample ${site}" $output/20220109_${site}_ko_coverage.txt  # add A-sample and $site as the headers for the first and second column
done


# get the unique names of the KO in all sites. The reason why we do that is that for example site1 might only contain K01,k02, site2 might only contain K01 and K03. We want to extract a list of KOs from all sites such that we have K01,K02 and K03. 

# 1. combine ko records and their names from all sites
list='hx1a hx2a hx3a hx1b hx2b hx3b gx1a gx2a gx3a gx1b gx2b gx3b sk1a sk2a sk3a sk1b sk2b sk3b'

for file in $list
do
sed "s| |_|g" $output/20220109_${site}_kofam_hits.txt | awk '{print $3 " " $7}' | sort | uniq >> full_ko_list.txt
done

# 2. sort and find the unique values in the ko list
sort full_ko_list.txt | uniq > uniq_ko_list.txt
wc -l uniq_ko_list.txt # 6295 records, thus 6295 KOs in all sites. 


# https://unix.stackexchange.com/questions/638521/merge-multiple-files-by-first-column
# https://unix.stackexchange.com/questions/113898/how-to-merge-two-files-based-on-the-matching-of-two-columns
# using the join command to first join two coverage tables

join -e0 -a1 -j 1 -o auto <(sort -k1 uniq_ko_list.txt) <(sort -k1 20220109_hx1a_ko_coverage.txt) > join.tmp

# then join the rest of the tables
for file in 20220109_*_ko_coverage.txt
do
join -e0 -a1 -j 1 -o auto <(sort -k1 join.tmp) <(sort -k1 $file) > join.tmp.1
yes | mv join.tmp.1 join.tmp
done


# Next, check a few cell to make sure the results are accurate
# divide coverage by the total coverage of the ribosomal marker gene determined by anvi-run-scg-taxonomy to noramlize the data, as suggested by meren