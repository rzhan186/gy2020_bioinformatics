# installation 

# v1.6.12
cd $PROJECT/software
wget https://github.com/AstrobioMike/GToTree/archive/refs/tags/v1.7.06.tar.gz
tar -xzvf v1.7.06.tar.gz

# Add the bin to your PATH
cd GToTree-1.7.06/bin # make sure you are in this bin directory
echo "export PATH=\"$(pwd):\$PATH\"" >> ~/.bash_profile
	
# Add path to included HMM files
cd ../hmm_sets/ # from where we were above
echo "export GToTree_HMM_dir=\"$(pwd)/\"" >> ~/.bash_profile
	
# install muscle 
cd $SCRATCH
wget http://www.drive5.com/muscle/downloads3.8.31/muscle3.8.31_i86linux64.tar.gz
tar -xvzf muscle3.8.31_i86linux64.tar.gz
mv muscle3.8.31_i86linux64 muscle
	

# run 
module load CCEnv
module load python/3.8
module load taxonkit
module load prodigal/2.6.3
module load hmmer/3.2.1
module load muscle/3.8.1551
module load trimal
module load fasttree

source /project/def-careg421/ruizhang/software/anvio-7.1/bin/activate

export PATH="/project/def-careg421/ruizhang/software/GToTree-1.7.06/bin:$PATH"
export GToTree_HMM_dir="/project/def-careg421/ruizhang/software/GToTree-1.7.06/hmm_sets"
export GTDB_dir="/project/def-careg421/ruizhang/2020_guiyang/GToTree/GTDB_dir"

# download only representative genomes from GTDB (this is very useful for covering diversity without having a ton of clcosely related genomes )

# first get the number of taxons 
gtt-get-accessions-from-GTDB \
-t all \
--get-taxon-counts \
--GTDB-representatives-only \
--store-GTDB-metadata-in-current-working-dir

gtt-get-accessions-from-GTDB \
-t Bacteria \
--get-taxon-counts \
--GTDB-representatives-only \
--store-GTDB-metadata-in-current-working-dir

# download the GTDB accessions
gtt-get-accessions-from-GTDB \
-t all \
--GTDB-representatives-only

# Subsetting the GTDB accessions further (get one representative genome of each Order when making a tree spanning an entire Domain)

	# randomly choosing 1 representative per Order, lowered to 1.5k genomes from ~300k genomes
cd /project/def-careg421/ruizhang/2020_guiyang/GToTree

gtt-subset-GTDB-accessions \
-i GTDB_dirGTDB-arc-and-bac-metadata.tsv \
--get-Order-representatives-only


gtt-get-accessions-from-GTDB \
-t "Staphylococcaceae" \
--GTDB-representatives-only



# build the tree with GToTree (using representative (species clusters) genomes from GTDB), the reference tree has about 60K genomes

#!/bin/bash
#SBATCH -c 32          
#SBATCH --mem=125G                  
#SBATCH -t 1-0:0:0 
#SBATCH -J=gy2020_GToTree_MAGs.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=BEGIN 
#SBATCH --mail-type=END 
#SBATCH --output=%x-%j.out
#SBATCH --account=def-careg421

module load CCEnv
module load python/3.8
module load taxonkit
module load prodigal/2.6.3
module load hmmer/3.2.1
module load muscle/3.8.1551
module load trimal
module load fasttree

source /project/def-careg421/ruizhang/software/anvio-7.1/bin/activate

export PATH="/project/def-careg421/ruizhang/software/GToTree-1.7.06/bin:$PATH"
export GToTree_HMM_dir="/project/def-careg421/ruizhang/software/GToTree-1.7.06/hmm_sets"
export GTDB_dir="/project/def-careg421/ruizhang/2020_guiyang/GToTree/GTDB_dir"

cd /project/def-careg421/ruizhang/2020_guiyang/GToTree/GTDB_MAGs_tree

GToTree \
-f /project/def-careg421/ruizhang/2020_guiyang/GToTree/2020_guiyang_final_MAGs-fasta-files.txt \
-a /project/def-careg421/ruizhang/2020_guiyang/GToTree/GTDB_dir/GTDB-arc-and-bac-refseq-rep-accessions_uniq.txt \
-H Bacteria_and_Archaea -D -j 32



# build the tree with GToTree (using representative (species clusters) genomes from GTDB), the reference tree has about 60K genomes

#!/bin/bash
#SBATCH -c 32          
#SBATCH --mem=125G                  
#SBATCH -t 5:0:0 
#SBATCH -J=gy2020_GToTree_MAGs3.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=BEGIN 
#SBATCH --mail-type=END 
#SBATCH --output=%x-%j.out
#SBATCH --account=def-careg421

module load CCEnv
module load python/3.8
module load taxonkit
module load prodigal/2.6.3
module load hmmer/3.2.1
module load muscle/3.8.1551
module load trimal
module load fasttree

source /project/def-careg421/ruizhang/software/anvio-7.1/bin/activate

export PATH="/project/def-careg421/ruizhang/software/GToTree-1.7.06/bin:$PATH"
export GToTree_HMM_dir="/project/def-careg421/ruizhang/software/GToTree-1.7.06/hmm_sets"
export GTDB_dir="/project/def-careg421/ruizhang/2020_guiyang/GToTree/GTDB_dir"

cd /project/def-careg421/ruizhang/2020_guiyang/GToTree/GTDB_MAGs_tree_3

GToTree \
-f /project/def-careg421/ruizhang/2020_guiyang/GToTree/2020_guiyang_final_MAGs-fasta-files.txt \
-a /project/def-careg421/ruizhang/2020_guiyang/GToTree/GTDB_order_dir/subset-accessions.txt \
-o GToTree_output2 \
-H Universal_Hug_et_al -D -j 2 -n 8 -M 8


#!/bin/bash
#SBATCH -c 32          
#SBATCH --mem=125G                  
#SBATCH -t 4:0:0 
#SBATCH -J=gy2020_GToTree_MAGs4.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=BEGIN 
#SBATCH --mail-type=END 
#SBATCH --output=%x-%j.out
#SBATCH --account=def-careg421

module load StdEnv/2020
module load python/3.8
module load taxonkit
module load prodigal/2.6.3
module load hmmer/3.2.1
module load muscle/3.8.31
module load trimal
module load fasttree

source /project/def-careg421/ruizhang/software/anvio-7.1/bin/activate

export PATH="/project/def-careg421/ruizhang/software/GToTree-1.7.06/bin:$PATH"
export GToTree_HMM_dir="/project/def-careg421/ruizhang/software/GToTree-1.7.06/hmm_sets"
export GTDB_dir="/project/def-careg421/ruizhang/2020_guiyang/GToTree/GTDB_dir"

cd /project/def-careg421/ruizhang/2020_guiyang/GToTree/GTDB_MAGs_tree_3

# test
GToTree \
-f /project/def-careg421/ruizhang/2020_guiyang/GToTree/2020_guiyang_final_MAGs-fasta-files.txt \
-a /project/def-careg421/ruizhang/2020_guiyang/GToTree/GTDB-Staphylococcaceae-family-GTDB-rep-accs.txt \
-o GToTree_output4 \
-H Universal_Hug_et_al -D -j 2



-H Universal -t -D -j 4 -o GToTree-test-output -F



# install muscle 
cd /project/def-careg421/ruizhang/software
wget https://github.com/rcedgar/muscle/archive/refs/tags/5.1.0.tar.gz
tar -xvzf 5.1.0.tar.gz
cd /muscle-5.1.0/src
make

# rerun

#!/bin/bash
#SBATCH -c 32          
#SBATCH --mem=125G                  
#SBATCH -t 10:0:0 
#SBATCH -J=gy2020_GToTree_MAGs_new.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=BEGIN 
#SBATCH --mail-type=END 
#SBATCH --output=%x-%j.out
#SBATCH --account=def-careg421

module load StdEnv/2020
module load python/3.8
module load taxonkit
module load prodigal/2.6.3
module load hmmer/3.2.1
module load trimal
module load fasttree

source /project/def-careg421/ruizhang/software/anvio-7.1/bin/activate

export PATH="/project/def-careg421/ruizhang/software/GToTree-1.7.06/bin:$PATH"
export GToTree_HMM_dir="/project/def-careg421/ruizhang/software/GToTree-1.7.06/hmm_sets"
export GTDB_dir="/project/def-careg421/ruizhang/2020_guiyang/GToTree/GTDB_dir"
export PATH="/project/def-careg421/ruizhang/software/muscle-5.1.0/src/Linux:$PATH"

cd /project/def-careg421/ruizhang/2020_guiyang/GToTree/GTDB_MAGs_tree

GToTree \
-f /project/def-careg421/ruizhang/2020_guiyang/GToTree/2020_guiyang_final_MAGs-fasta-files.txt \
-a /project/def-careg421/ruizhang/2020_guiyang/GToTree/GTDB_order_dir/subset-accessions.txt \
-o GToTree_output2 \
-H Universal_Hug_et_al -D -j 2 -n 8 -M 8


###########################################
#### construct a phylogenomic tree ########
############################################

# download GTDB taxonomic information
https://data.gtdb.ecogenomic.org/releases/release207/207.0/bac120_taxonomy_r207.tsv
https://data.gtdb.ecogenomic.org/releases/release207/207.0/ar53_taxonomy_r207.tsv

# 

















