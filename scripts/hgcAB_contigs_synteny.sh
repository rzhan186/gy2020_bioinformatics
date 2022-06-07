# running anvi-export locus with anvio development branch

module load CCEnv
module load StdEnv/2020
module load python/3.8
module load prodigal/2.6.3
module load hmmer/3.2.1
module load diamond
source ~/anvio-7.1-dev/bin/activate

export PYTHONPATH=$PYTHONPATH:$SCRATCH/anvio/ 
export PATH="/scratch/c/careg421/ruizhang/anvio/bin:$PATH"
export PATH="/scratch/c/careg421/ruizhang/anvio/sandbox:$PATH"

contigdb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_contigs_db
output=/scratch/c/careg421/ruizhang/guiyang/anvio/export-locus

list='hx1a hx1b hx2a hx2b hx3a hx3b gx1a gx1b gx2a gx2b gx3a gx3b sk1a sk1b sk2a sk2b sk3a sk3b'

for site in $list
do
anvi-export-locus \
--contigs-db $contigdb/${site}_contigs_1000.db \
--output-dir $output/hgcA_$site \
--output-file-prefix hgcA_$site \
--num-genes 5,5 \
--hmm-sources anvio_custom_hmm_hgcA \
--use-hmm \
--search-term HgcA \
--overwrite-output-destinations
done

### export files to visualize in gggenes 

for site in $list
do
cd $output/hgcA_$site
for file in *.db
do
anvi-export-functions \
-c $output/hgcA_$site/$file \
-o $output/locus-records/${file}-function.txt

anvi-export-gene-calls \
-c $output/hgcA_$site/$file \
-o $output/locus-records/${file}-gene-calls.txt \
--gene-caller prodigal
done
done


# add an extra column stating the file name
# then merge the file name column with the gene caller id name to form an unique column
mkdir $output/locus-records-mod

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