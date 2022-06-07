# Here we'd like to get the taxonomic information of those contigs containing hgcAB and the TA-gene, see if the truely belong to Archaea. 

# https://merenlab.org/2016/06/18/importing-taxonomy/

# step 1. Get sequencees for gene calls in the contigs database

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
output=/scratch/c/careg421/ruizhang/guiyang/anvio/contigs-gene-call-sequences
mkdir $output

list='hx1a hx1b hx2a hx2b hx3a hx3b gx1a gx1b gx2a gx2b gx3a gx3b sk1a sk1b sk2a sk2b sk3a sk3b'
for site in $list
do
anvi-get-sequences-for-gene-calls \
-c $contigdb/${site}_contigs_1000.db \
-o $output/${site}-gene-call.fa
done

# step2. install Kaiju 
module load CCEnv
module load StdEnv/2020
cd $SCRATCH
git clone https://github.com/bioinformatics-centre/kaiju.git
cd kaiju/src
make

# add kaiju to PATH
export PATH="/scratch/c/careg421/ruizhang/kaiju/bin:$PATH" # niagara
export PATH="/home/ruizhang/scratch/kaiju/bin:$PATH" # cedar

# download Refseq from the kaiju web service
https://kaiju.binf.ku.dk/server
mkdir $SCRATCH/kaijudb_web
cd $SCRATCH/kaijudb_web
wget https://kaiju.binf.ku.dk/database/kaiju_db_refseq_2022-03-23.tgz # refseq 20220323 (24G)

# step3. classification 
output=/scratch/c/careg421/ruizhang/guiyang/anvio/contigs-gene-call-sequences
export PATH="/scratch/c/careg421/ruizhang/kaiju/bin:$PATH"
list='hx1a hx1b hx2a hx2b hx3a hx3b gx1a gx1b gx2a gx2b gx3a gx3b sk1a sk1b sk2a sk2b sk3a sk3b'

for site in $list
do
kaiju -t $SCRATCH/kaijudb_web/nodes.dmp \
      -f $SCRATCH/kaijudb_web/kaiju_db_refseq.fmi \
      -i $output/${site}-gene-call.fa \
      -o $output/${site}-gene-call-refseq.out \
      -z 80 \
      -v
done

for site in $list
do
kaiju-addTaxonNames \
-t $SCRATCH/kaijudb_web/nodes.dmp \
-n $SCRATCH/kaijudb_web/names.dmp \
-i $output/${site}-gene-call-refseq.out \
-o $output/${site}-gene-call-refseq.names \
-r superkingdom,phylum,order,class,family,genus,species
done


# step4. import taxonomy into contigs db
contigdb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_contigs_db
output=/scratch/c/careg421/ruizhang/guiyang/anvio/contigs-gene-call-sequences
list='hx1a hx1b hx2a hx2b hx3a hx3b gx1a gx1b gx2a gx2b gx3a gx3b sk1a sk1b sk2a sk2b sk3a sk3b'

for site in $list
do
anvi-import-taxonomy-for-genes \
-i $output/${site}-gene-call-refseq.names \
-c $contigdb/${site}_contigs_1000.db \
-p kaiju \
--just-do-it
done

# anvi-export-splits-taxonomy
output=/scratch/c/careg421/ruizhang/guiyang/anvio/contigs-taxonomy

for site in $list
do
anvi-export-splits-taxonomy \
-c $contigdb/${site}_contigs_1000.db \
-o $output/${site}_contigs_taxonomy.txt
done

# combine the output files
cd $output 
cat *_contigs_taxonomy.txt > combined.txt

# now the the list of contigs, then search the combined the files for the target contigs number then output the results

while read line
do
grep $line combined.txt >> hgcA_contigs_taxonomy.txt
done < hgcA_contigs.txt
