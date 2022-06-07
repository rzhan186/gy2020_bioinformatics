# export gene coverage data in profile db

#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 2:0:0   
#SBATCH -J=anvi-export-gene-coverage-and-detection.sh
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

contigs_db=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_contigs_db
profiledb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_profile_db/20210912
output=/scratch/c/careg421/ruizhang/guiyang/anvio/gene-coverage

sites='hx1a hx2a hx3a hx1b hx2b hx3b gx1a gx2a gx3a gx1b gx2b gx3b sk1a sk2a sk3a sk1b sk2b sk3b'

for site in $sites
do
anvi-export-gene-coverage-and-detection \
-c $contigs_db/${site}_contigs_1000.db \
-p $profiledb/${site}_${site}_profile/PROFILE.db \
-O $output/${site}
done


# Now we extract coverage of each identified the specified gene caller
coverage=/scratch/c/careg421/ruizhang/guiyang/anvio/gene-coverage
output=/scratch/c/careg421/ruizhang/guiyang/anvio/custom_gene_coverage

# only the following genes were detected in the contigs db

genes='mtrA cymA omcF omcS'
sites='hx1a hx2a hx3a hx1b hx2b hx3b gx1a gx2a gx3a gx1b gx2b gx3b sk1a sk2a sk3a sk1b sk2b sk3b'

for gene in $genes
do
for site in $sites
do
# Extract headers 
grep -e ">" $output/${site}_${gene}_seqs.txt > $output/${site}_${gene}_headers.txt

# Select the fifth column
cut -f 5 -d '|' $output/${site}_${gene}_headers.txt | cut -f 2 -d ':' > $output/${site}_${gene}_gene_caller_id.txt

# extract the coverage value of each gene caller ID
while read p
do
awk '$1 == '$p'' $coverage/${site}-GENE-COVERAGES.txt >> $output/${site}_${gene}_coverage.txt
done <$output/${site}_${gene}_gene_caller_id.txt

# calculate the sum of coverage for each site
echo ${site} >> $output/${site}_${gene}_total_coverage.txt
awk '{ sum += $2 } END { print sum }' $output/${site}_${gene}_coverage.txt >> $output/${site}_${gene}_total_coverage.txt

# combine results for all sites
paste $output/*_${gene}_total_coverage.txt > $output/${gene}_all_coverage.txt
echo $gene >> $output/${gene}_all_coverage.txt
done
done

cat $output/*_all_coverage.txt > $output/all_coverage.txt