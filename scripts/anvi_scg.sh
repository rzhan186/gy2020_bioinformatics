# download the latest database #update to GTDB rs202
anvi-setup-scg-taxonomy \
--scgs-taxonomy-data-dir $scg_db --reset

# re-run anvio scg taxonomy

#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 3:0:0   
#SBATCH -J=anvi-run-hmm.sh
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
scg_db=/scratch/c/careg421/ruizhang/guiyang/anvio/scg_db

list='hx1a hx2a hx3a hx1b hx2b hx3b gx1a gx2a gx3a gx1b gx2b gx3b sk1a sk2a sk3a sk1b sk2b sk3b'

for site in $list
do
anvi-run-hmms -c $contigs_db/${site}_contigs_1000.db --num-thread 80
done

#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 3:0:0   
#SBATCH -J=anvi-run-scg-taxonomy.sh
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
scg_db=/scratch/c/careg421/ruizhang/guiyang/anvio/scg_db

list='hx1a hx2a hx3a hx1b hx2b hx3b gx1a gx2a gx3a gx1b gx2b gx3b sk1a sk2a sk3a sk1b sk2b sk3b'

for site in $list
do
anvi-run-scg-taxonomy \
-c $contigs_db/${site}_contigs_1000.db \
--scgs-taxonomy-data-dir $scg_db -T 80
done


# report scg frequencies
output=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_estimate_scg_taxonomy # long format

anvi-estimate-scg-taxonomy \
--metagenomes $output/anvi_taxonomy_metadata.txt \
--output-file-prefix $output/test \
--report-scg-frequencies $output/rs202_report_scg_frequencies \
--metagenome-mode

# Now because the most frequent scg across all samples is the ribosomal_S11, therefore the coverage of this particular scg will be reporeted using the following code. The coverage will be used to normalize the abundance (i.e., coverage) of KOs determined using anvi-estimate-metabolism. However, we are not sure if S11 is the most appropriate scg to use, and I wonder using other scgs would change the normalization results of the KOs. Here I will also test a few other scgs and see if the normalize results are relatively consistent across scg. 

# long format
cd $SCRATCH
output=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_estimate_scg_taxonomy

anvi-estimate-scg-taxonomy \
--metagenomes $output/anvi_taxonomy_metadata.txt \
--output-file-prefix $output/rs202-anvi-estimate-scg-taxonomy-long-format \
--compute-scg-coverages \
--metagenome-mode \
-T 40

# matrix format
anvi-estimate-scg-taxonomy \
--metagenomes $output/anvi_taxonomy_metadata.txt \
--output-file-prefix $output/rs202-anvi-estimate-scg-taxonomy \
--metagenome-mode \
--matrix-format \
-T 40

# matrix format - on domain
anvi-estimate-scg-taxonomy \
--metagenomes $output/copy2.txt  \
--output-file-prefix $output/rs202-anvi-estimate-scg-taxonomy \
--metagenome-mode \
--matrix-format \
--taxonomic-level t_domain \
-T 40


# test Ribosomal_L16 (second most abundant)
anvi-estimate-scg-taxonomy \
--metagenomes $output/anvi_taxonomy_metadata.txt \
--scg-name-for-metagenome-mode Ribosomal_L16 \
--output-file-prefix $output/Ribosomal_L16 \
--metagenome-mode \
--matrix-format \
-T 40

# test Ribosomal_S7 (thrid most abundant)
anvi-estimate-scg-taxonomy \
--metagenomes $output/anvi_taxonomy_metadata.txt \
--scg-name-for-metagenome-mode Ribosomal_S7 \
--output-file-prefix $output/Ribosomal_S7 \
--metagenome-mode \
--matrix-format \
-T 40

# test Ribosomal_L17 (a less abundant scg)
anvi-estimate-scg-taxonomy \
--metagenomes $output/anvi_taxonomy_metadata.txt \
--scg-name-for-metagenome-mode Ribosomal_L17 \
--output-file-prefix $output/Ribosomal_L17 \
--metagenome-mode \
--matrix-format \
-T 40

# test the other scgs

list='Ribosomal_S3_C Ribosomal_S2 Ribosomal_S9 Ribosomal_L1 Ribosomal_L22 Ribosomal_L20'

for scg in $list
do
	anvi-estimate-scg-taxonomy \
	--metagenomes $output/anvi_taxonomy_metadata.txt \
	--scg-name-for-metagenome-mode $scg \
	--output-file-prefix $output/$scg \
	--metagenome-mode \
	--matrix-format \
	-T 40
done