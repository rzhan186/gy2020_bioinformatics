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


# implement custom HMM files

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
hmm_db=/scratch/c/careg421/ruizhang/guiyang/anvio/anvio_custom_hmm

sites='hx1a hx2a hx3a hx1b hx2b hx3b gx1a gx2a gx3a gx1b gx2b gx3b sk1a sk2a sk3a sk1b sk2b sk3b'
genes='mtrA mtrB mtrC cymA omcF omcS omcZ' 

for gene in $genes 
do
for site in $sites
do
anvi-run-hmms \
-c $contigs_db/${site}_contigs_1000.db \
-H $hmm_db/anvio_custom_hmm_${gene} \
-T 40
done
done

# determine the gene caller ID of the genes identified by hmmscan
contigs_db=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_contigs_db
output=/scratch/c/careg421/ruizhang/guiyang/anvio/custom_gene_coverage

for gene in $genes 
do
for site in $sites
do
anvi-get-sequences-for-hmm-hits \
-c $contigs_db/${site}_contigs_1000.db \
--hmm-source anvio_custom_hmm_${gene} \
--get-aa-sequences \
-o $output/${site}_${gene}_seqs.txt
done
done