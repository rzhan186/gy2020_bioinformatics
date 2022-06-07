# cluster similar sequences using cd-hit, using a threshold of 99%.
module load CCEnv
module load cd-hit

cd $SCRATCH/guiyang/cd-hit

cd-hit \
-i contigs_hgcA_hx.fasta \
-o cdhit_contigs_hgcA_hx.fasta \
-c 0.99

cd-hit \
-i contigs_hgcA_gx.fasta \
-o cdhit_contigs_hgcA_gx.fasta \
-c 0.99

cd-hit \
-i contigs_hgcA_sk.fasta \
-o l \
-c 0.99

# combine the files 
cat cdhit*fasta > cdhit_contigs_hgcA_combined.fasta

# perform MSA to remove sequences without the cap-helix domain
module load mafft

mafft --auto $SCRATCH/guiyang/cd-hit/cdhit_contigs_hgcA_combined.fasta > $SCRATCH/guiyang/cd-hit/mafft_cdhit_contigs_hgcA_combined.fasta

# construct a maximum likelihood phylogenetic tree


####################### trim sequences ##############################

# trim sequence - trimal(v1.4)
# http://trimal.cgenomics.org/getting_started_with_trimal_v1.2

module load CCEnv
module load StdEnv/2020
module load trimal 

trimal \
-in $SCRATCH/guiyang/cd-hit/mafft_cdhit_contigs_hgcA_combined.fasta \
-out $SCRATCH/guiyang/cd-hit/trimal_mafft_cdhit_contigs_hgcA_combined.fasta \
-htmlout $SCRATCH/guiyang/cd-hit/trimal_mafft_cdhit_contigs_hgcA_combined.fasta.html \
-automated1

####################### construct a protein tree ##############################

#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 3:0:0                       
#SBATCH -J=hgcA_contigs1000_gionfriddo_tree_AA.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=BEGIN 
#SBATCH --mail-type=END 
#SBATCH --output=%x-%j.out

iqtree_output=/scratch/c/careg421/ruizhang/guiyang/iqtree2

export PATH="/scratch/c/careg421/ruizhang/iqtree-2.1.3-Linux/bin:$PATH"
iqtree2 -s $SCRATCH/guiyang/cd-hit/trimal_mafft_cdhit_contigs_hgcA_combined.fasta -B 1000 -T AUTO --prefix $iqtree_output/iqtree2_trimal_mafft_cdhit_contigs_hgcA_combined_auto --seqtype AA



