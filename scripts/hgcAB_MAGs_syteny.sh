# annotate the contigs db
module load CCEnv
module load StdEnv/2020
module load python/3.8
module load prodigal/2.6.3
module load hmmer/3.2.1
module load diamond

source ~/anvio-7.1-dev/bin/activate

export PYTHONPATH=$PYTHONPATH:$SCRATCH/anvio-dev-apr2022/anvio/ 
export PATH="/scratch/c/careg421/ruizhang/anvio-dev-apr2022/anvio/bin:$PATH"
export PATH="/scratch/c/careg421/ruizhang/anvio-dev-apr2022/anvio/sandbox:$PATH"

contigdb=/scratch/c/careg421/ruizhang/methylator_review/contigs_db
output=/scratch/c/careg421/ruizhang/guiyang/anvio/export-locus/methylators
hmm=/scratch/c/careg421/ruizhang/guiyang/anvio/anvio_custom_hmm

# setup db
#COG
cog=/scratch/c/careg421/ruizhang/guiyang/anvio/ncbi-cogs
anvi-setup-ncbi-cogs \
--cog-data-dir $cog

#PFAM
pfam_db=/scratch/c/careg421/ruizhang/guiyang/anvio/pfam_db
anvi-setup-pfams \
--pfam-data-dir $pfam_db


######### 
# Note
# replace the "confirmed_methylators.txt" with other lists to run a separate list of methylator genomes

# annotate contigs 
# COG
cog=/scratch/c/careg421/ruizhang/guiyang/anvio/ncbi-cogs
while read i
do
anvi-run-ncbi-cogs \
-c $contigdb/$i \
-T 80 \
--cog-data-dir $cog
done <$output/confirmed_methylators.txt

#PFAM
pfam_db=/scratch/c/careg421/ruizhang/guiyang/anvio/pfam_db
while read i
do
anvi-run-pfams \
-c $contigdb/$i \
--pfam-data-dir $pfam_db \
--num-threads 80
done <$output/confirmed_methylators.txt

#KEGG 
kegg_db=/scratch/c/careg421/ruizhang/guiyang/anvio/KEGG_db

while read i
do
anvi-run-kegg-kofams \
-c $contigdb/$i \
--kegg-data-dir $kegg_db \
-T 80 \
--just-do-it
done <$output/confirmed_methylators.txt

#hgcAB HMMs
hmm=/scratch/c/careg421/ruizhang/guiyang/anvio/anvi_custom_hmm
contigdb=/scratch/c/careg421/ruizhang/methylator_review/contigs_db

while read i
do
anvi-run-hmms \
-c $contigdb/$i \
-H $hmm/anvio_custom_hmm_hgcA \
--num-thread 80
done <$output/confirmed_methylators.txt

while read i
do
anvi-run-hmms \
-c $contigdb/$i \
-H $hmm/anvio_custom_hmm_hgcB \
--num-thread 80
done <$output/confirmed_methylators.txt



# determine hgcAB gene neighorhood
module load CCEnv
module load StdEnv/2020
module load python/3.8
module load prodigal/2.6.3
module load hmmer/3.2.1
module load diamond

source ~/anvio-7.1-dev/bin/activate

export PYTHONPATH=$PYTHONPATH:$SCRATCH/anvio-dev-apr2022/anvio/ 
export PATH="/scratch/c/careg421/ruizhang/anvio-dev-apr2022/anvio/bin:$PATH"
export PATH="/scratch/c/careg421/ruizhang/anvio-dev-apr2022/anvio/sandbox:$PATH"


# 5,5
contigdb=/scratch/c/careg421/ruizhang/methylator_review/contigs_db
output=/scratch/c/careg421/ruizhang/guiyang/anvio/export-locus/methylators

while IFS=$'\t' read -r f1 f2
do
mkdir $output/$f2
done <$output/confirmed_methylators_mod.txt

while IFS=$'\t' read -r f1 f2
do
anvi-export-locus \
--contigs-db $contigdb/$f1 \
--output-dir $output/$f2 \
--output-file-prefix $f2 \
--num-genes 5,5 \
--hmm-sources anvio_custom_hmm_hgcA \
--use-hmm \
--search-term HgcA \
--overwrite-output-destinations
done < $output/confirmed_methylators_mod.txt


### export files to visualize in gggenes 

while IFS=$'\t' read -r f1 f2
do
anvi-export-functions \
-c $output/$f2/${f2}_0001.db \
-o $output/locus-records/${f2}-function.txt

anvi-export-gene-calls \
-c $output/$f2/${f2}_0001.db \
-o $output/locus-records/${f2}-gene-calls.txt \
--gene-caller prodigal

done < $output/confirmed_methylators_mod.txt


# add an extra column stating the file name
# then merge the file name column with the gene caller id name to form an unique column

cd $output/locus-records

for file in *function.txt
do
awk -v env_var="$file" '{ print env_var"\t" $0}' $file > $output/locus-records-mod/$file
done

for file in *gene-calls.txt
do
awk -v env_var="$file" '{ print env_var"\t" $0}' $file > $output/locus-records-mod/$file
done

cd $output/locus-records-mod
cat $output/locus-records-mod/*-function.txt > $output/locus-records-mod/hgcA_concatenated-function.txt
cat $output/locus-records-mod/*-gene-calls.txt > $output/locus-records-mod/hgcA_concatenated-gene-calls.txt