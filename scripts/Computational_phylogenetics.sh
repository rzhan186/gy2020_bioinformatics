#####################################################
####### hgcA phylogenetic clustering analyses #######
#####################################################

# first create a MSA of the full length hgcA sequence using MAFFT plus the outgroup
# add the outgropu sequence to file hgcA_caphelix_TMHMM.faa to create hgcA_caphelix_TMHMM_outgroup.faa

'
>paralog_Candidatus_Omnitrophica_bacterium_CG1_02_41_171/1-99
KEGIYEINNPGDSPVLVTTNFSLTYFIVSGEIVPAWLLVQEAEGLSVMTAWAADKFVAETIAPFVKVKHKKLIIPGYAAQ-ISGELEEIIGPREASHIPA
>paralog_Thermosulfurimonas_dismutans/1-99
QEGIYPINGPDNSPVLITCNFALTYFIVSGEIVPSWLLIKDTEGLSVLTAWAAGKFGADTIAEFVKVKHRKLVIPGYLAS-IKGELEDIIGPREASSLPA'

module load StdEnv/2020
module load mafft

file=/scratch/ruizhang/hgcA_phylogeny/phyml
mafft --auto $file/hgcA_caphelix_TMHMM_outgroup.faa > $file/hgcA_caphelix_TMHMM_outgroup_msa.faa

# trim the MSA using trimal
module load StdEnv/2020
module load trimal
 
trimal \
-in $file/hgcA_caphelix_TMHMM_outgroup_msa.faa \
-out $file/hgcA_caphelix_TMHMM_outgroup_msa_trimal_gappyout.fasta \
-gappyout

# run PhyML
# convert the fasta file to phylip format
hgcA_caphelix_TMHMM_outgroup_msa_trimal_gappyout.fasta > hgcA_caphelix_TMHMM_outgroup_msa_trimal_gappyout.phy

# set seed to 10 different prime numbers 
95257
26113
77513
10333
90067
34283
46399
85627
29423
95783

# move the phylip into each subfolder
list='1 2 3 4 5 6 7 8 9 10'
for i in $list
do
cp hgcA_caphelix_TMHMM_outgroup_msa_trimal_gappyout.phy run_$i
done

#!/bin/bash
#SBATCH -c 4         
#SBATCH --mem=10G                    
#SBATCH -t 2-12:0:0                         
#SBATCH -J=run1_phyml_hgcA_aa_run1_outgroup.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=BEGIN 
#SBATCH --mail-type=END 

module load StdEnv/2020 
module load gcc/9.3.0 openmpi/4.0.3
module load phyml #version:3.3.20190321

file=/scratch/ruizhang/hgcA_phylogeny/phyml/run_1

phyml \
-i $file/hgcA_caphelix_TMHMM_outgroup_msa_trimal_gappyout.phy \
-q -d aa -b 100 -m LG -f e -c 4 -a e --r_seed 95257 \
--no_memory_check

#!/bin/bash
#SBATCH -c 4         
#SBATCH --mem=10G                    
#SBATCH -t 2-12:0:0                         
#SBATCH -J=run2_phyml_hgcA_aa_run2_outgroup.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=BEGIN 
#SBATCH --mail-type=END 

module load StdEnv/2020 
module load gcc/9.3.0 openmpi/4.0.3
module load phyml #version:3.3.20190321

file=/scratch/ruizhang/hgcA_phylogeny/phyml/run_2

phyml \
-i $file/hgcA_caphelix_TMHMM_outgroup_msa_trimal_gappyout.phy \
-q -d aa -b 100 -m LG -f e -c 4 -a e --r_seed 26113 \
--no_memory_check

#!/bin/bash
#SBATCH -c 4         
#SBATCH --mem=10G                    
#SBATCH -t 2-12:0:0                         
#SBATCH -J=run3_phyml_hgcA_aa_run3_outgroup.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=BEGIN 
#SBATCH --mail-type=END 

module load StdEnv/2020 
module load gcc/9.3.0 openmpi/4.0.3
module load phyml #version:3.3.20190321

file=/scratch/ruizhang/hgcA_phylogeny/phyml/run_3

phyml \
-i $file/hgcA_caphelix_TMHMM_outgroup_msa_trimal_gappyout.phy \
-q -d aa -b 100 -m LG -f e -c 4 -a e --r_seed 77513 \
--no_memory_check

#!/bin/bash
#SBATCH -c 4         
#SBATCH --mem=10G                    
#SBATCH -t 2-12:0:0                         
#SBATCH -J=run4_phyml_hgcA_aa_run4_outgroup.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=BEGIN 
#SBATCH --mail-type=END 

module load StdEnv/2020 
module load gcc/9.3.0 openmpi/4.0.3
module load phyml #version:3.3.20190321

file=/scratch/ruizhang/hgcA_phylogeny/phyml/run_4

phyml \
-i $file/hgcA_caphelix_TMHMM_outgroup_msa_trimal_gappyout.phy \
-q -d aa -b 100 -m LG -f e -c 4 -a e --r_seed 10333 \
--no_memory_check

#!/bin/bash
#SBATCH -c 4         
#SBATCH --mem=10G                    
#SBATCH -t 2-12:0:0                         
#SBATCH -J=run5_phyml_hgcA_aa_run5_outgroup.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=BEGIN 
#SBATCH --mail-type=END 

module load StdEnv/2020 
module load gcc/9.3.0 openmpi/4.0.3
module load phyml #version:3.3.20190321

file=/scratch/ruizhang/hgcA_phylogeny/phyml/run_5

phyml \
-i $file/hgcA_caphelix_TMHMM_outgroup_msa_trimal_gappyout.phy \
-q -d aa -b 100 -m LG -f e -c 4 -a e --r_seed 90067 \
--no_memory_check

#!/bin/bash
#SBATCH -c 4         
#SBATCH --mem=10G                    
#SBATCH -t 2-12:0:0                         
#SBATCH -J=run6_phyml_hgcA_aa_run6_outgroup.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=BEGIN 
#SBATCH --mail-type=END 

module load StdEnv/2020 
module load gcc/9.3.0 openmpi/4.0.3
module load phyml #version:3.3.20190321

file=/scratch/ruizhang/hgcA_phylogeny/phyml/run_6

phyml \
-i $file/hgcA_caphelix_TMHMM_outgroup_msa_trimal_gappyout.phy \
-q -d aa -b 100 -m LG -f e -c 4 -a e --r_seed 34283 \
--no_memory_check

#!/bin/bash
#SBATCH -c 4         
#SBATCH --mem=10G                    
#SBATCH -t 2-12:0:0                         
#SBATCH -J=run7_phyml_hgcA_aa_run7_outgroup.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=BEGIN 
#SBATCH --mail-type=END 

module load StdEnv/2020 
module load gcc/9.3.0 openmpi/4.0.3
module load phyml #version:3.3.20190321

file=/scratch/ruizhang/hgcA_phylogeny/phyml/run_7

phyml \
-i $file/hgcA_caphelix_TMHMM_outgroup_msa_trimal_gappyout.phy \
-q -d aa -b 100 -m LG -f e -c 4 -a e --r_seed 46399 \
--no_memory_check

#!/bin/bash
#SBATCH -c 4         
#SBATCH --mem=10G                    
#SBATCH -t 2-12:0:0                         
#SBATCH -J=run8_phyml_hgcA_aa_run8_outgroup.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=BEGIN 
#SBATCH --mail-type=END 

module load StdEnv/2020 
module load gcc/9.3.0 openmpi/4.0.3
module load phyml #version:3.3.20190321

file=/scratch/ruizhang/hgcA_phylogeny/phyml/run_8

phyml \
-i $file/hgcA_caphelix_TMHMM_outgroup_msa_trimal_gappyout.phy \
-q -d aa -b 100 -m LG -f e -c 4 -a e --r_seed 85627 \
--no_memory_check

#!/bin/bash
#SBATCH -c 4         
#SBATCH --mem=10G                    
#SBATCH -t 2-12:0:0                         
#SBATCH -J=run9_phyml_hgcA_aa_run9_outgroup.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=BEGIN 
#SBATCH --mail-type=END 

module load StdEnv/2020 
module load gcc/9.3.0 openmpi/4.0.3
module load phyml #version:3.3.20190321

file=/scratch/ruizhang/hgcA_phylogeny/phyml/run_9

phyml \
-i $file/hgcA_caphelix_TMHMM_outgroup_msa_trimal_gappyout.phy \
-q -d aa -b 100 -m LG -f e -c 4 -a e --r_seed 29423 \
--no_memory_check

#!/bin/bash
#SBATCH -c 4         
#SBATCH --mem=10G                    
#SBATCH -t 2-12:0:0                         
#SBATCH -J=run10_phyml_hgcA_aa_run10_outgroup.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=BEGIN 
#SBATCH --mail-type=END 

module load StdEnv/2020 
module load gcc/9.3.0 openmpi/4.0.3
module load phyml #version:3.3.20190321

file=/scratch/ruizhang/hgcA_phylogeny/phyml/run_10

phyml \
-i $file/hgcA_caphelix_TMHMM_outgroup_msa_trimal_gappyout.phy \
-q -d aa -b 100 -m LG -f e -c 4 -a e --r_seed 95783 \
--no_memory_check

# combine the resulting trees 
file=/scratch/ruizhang/hgcA_phylogeny/phyml
cat $file/run_*/hgcA_caphelix_TMHMM_outgroup_msa_trimal_gappyout.phy_phyml_boot_trees.txt > $file/combined_hgcA_tree_outgroup_phyML.txt


# remove the outgroup sequence
library(ape)
library(phangorn)

all_tr <- read.tree("combined_hgcA_tree_outgroup_phyML.txt") 
outgrp <- all_tr[[1]]$tip.label[grep("paralog_", all_tr[[1]]$tip.label)]

for(i in 1:length(all_tr)){
	all_tr[[i]] <- drop.tip(all_tr[[i]], outgrp)
}

write.tree(all_tr, "combined_hgcA_tree_outgroup_phyML_noOutgrp.trees")

# in
dat <- read.tree("combined_hgcA_tree_outgroup_phyML_noOutgrp.trees")

# resolve the (unexisting) multifurcations?
is.binary(dat)
dat2 <- multi2di(dat)

# get rid of node support values
# and small brlen
eps <- 1e-4
for(i in 1:length(dat2)){
	dat2[[i]]$node.label <- NULL
	if(sum(dat2[[i]]$edge.length < eps) > 0){
		pos <- which(dat2[[i]]$edge.length < eps)
		if(length(pos) > 0){
			dat2[[i]]$edge.length[pos] <- eps
		}
	}
}

is.binary(dat2)

# out
write.nexus(dat2, file = "combined_hgcA_tree_outgroup_phyML_noOutgrp_noNode.nex", translate = T)

# sed
sed -i 's/TREE \* UNTITLED/tree STATE_1011000/g' combined_hgcA_tree_outgroup_phyML_noOutgrp_noNode.nex

# modify the file to fit BaTS (e.g. example.trees)
combined_hgcA_tree_outgroup_phyML_noOutgrp_noNode.nex > combined_hgcA_tree_outgroup_phyML_noOutgrp_noNode_BaTs.nex

# run BaTS 

#!/bin/bash
#SBATCH -c 4         
#SBATCH --mem=10G                    
#SBATCH -t 5:0:0                         
#SBATCH -J=220806_BaTS_beta_build2.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=BEGIN 
#SBATCH --mail-type=END 

module load java/14.0.2

cd /scratch/ruizhang/befi-bats-gui-0.9/BaTS_beta_build2/
file=/scratch/ruizhang/hgcA_phylogeny/phyml

java -jar BaTS_beta_build2.jar single $file/combined_hgcA_tree_outgroup_phyML_noOutgrp_noNode_BaTs.nex 988 3 > $file/20220806_hgcA_BaTS.out



#########################################################
### merA, rpoB, glnA phylogenetic clustering analyses ###
#########################################################

## sequence extraction

# identifying merA sequences from the metagenomic assembly

# extracting merA using HMM

module load StdEnv/2020 gcc/9.3.0 openmpi/4.0.3
module load mafft-mpi/7.471 
module load hmmer/3.3.2
module load seqtk/1.3

merA=/project/def-careg421/ruizhang/software/anvio-7.1/hmm/Christakis_reduced_merA/merA.hmm

cd $SCRATCH

list="hx1a hx1b hx2a hx2b hx3a hx3b gx1a gx1b gx2a gx2b gx3a gx3b sk1a sk1b sk2a sk2b sk3a sk3b"

for INPUT in $list
do
hmmsearch -E 1e-100 -o ${INPUT}_tmp/${INPUT}_merA.txt --tblout ${INPUT}_outputs/${INPUT}_merA_hmmer.out $merA $SCRATCH/prodigal_gy20/gy20_${INPUT}_proteins.faa

grep -v '^#' ${INPUT}_outputs/${INPUT}_merA_hmmer.out | awk {'{print $1}'} | sort > ${INPUT}_tmp/${INPUT}_merA_geneid.txt

seqtk subseq $SCRATCH/prodigal_gy20/gy20_${INPUT}_proteins.faa ${INPUT}_tmp/${INPUT}_merA_geneid.txt | awk {'{gsub(/*$/,""); print}'} > ${INPUT}_tmp/${INPUT}_merA_proteins.faa
done

cat *_tmp/*_merA_proteins.faa > $PROJECT/2020_guiyang/phylogenetic_clustering/gy20_merA_proteins.faa

# 
awk '/^>/ {printf("%s%s\t",(N>0?"\n":""),$0);N++;next;} {printf("%s",$0);} END {printf("\n");}' $PROJECT/2020_guiyang/phylogenetic_clustering/gy20_merA_proteins.faa |\
awk -F '\t' '{if(index($2,"CC")!=0) printf("%s\n%s\n",$1,$2);}' > $PROJECT/2020_guiyang/phylogenetic_clustering/gy20_merA_filtered_proteins.faa

# merge the proteins with the reference MerA 
cd $PROJECT/2020_guiyang/phylogenetic_clustering
cat gy20_merA_filtered_proteins.faa MerA_RC607.fasta > gy20_merA_filtered_proteins_ref.faa

# transfer the sequence file to local

# merA includiong criteria
"Specifically, homologs were screened for the presence of the 

	vicinal cysteine pair at the carboxy terminus (aligned positions 628 and 629; numbering in reference to MerA from Bacillus cereus RC607 [BAB62433.1; Wang et al., 1989; Gupta et al., 1999] and for the 
	
	conserved cysteine pair at positions 207 and 212 in the redox active site, 
	tyrosine at position 264 (Rennex et al., 1993), and 
	tyrosine at position 605 for bacterial MerA and 
	phenylalanine at position 605 for archaeal MerA (Simbahan et al., 2005)."

"https://www.ncbi.nlm.nih.gov/protein/AAA83977.1?report=fasta"


# rpoB phylogenetic clustering analysis

#!/bin/bash
#SBATCH -c 4         
#SBATCH --mem=20G                  
#SBATCH -t 4:0:0                         
#SBATCH -J=gy20_rpoB_HMM.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=ALL 
#SBATCH --output=%x-%j.out
#SBATCH --account=def-careg421
 
module load StdEnv/2020 gcc/9.3.0 openmpi/4.0.3
module load mafft-mpi/7.471 
module load hmmer/3.3.2
module load seqtk/1.3

cd $SCRATCH

list="hx1a hx1b hx2a hx2b hx3a hx3b gx1a gx1b gx2a gx2b gx3a gx3b sk1a sk1b sk2a sk2b sk3a sk3b"

for INPUT in $list
do
# rpoB Bacteria (DNA directed RNA-polymerase subunitB)
rpoB_bac=/project/def-careg421/ruizhang/software/anvio-7.1/hmm/TIGR02013.hmm

hmmsearch -T 801.2 -o ${INPUT}_tmp/${INPUT}_rpoB_bac.txt --tblout ${INPUT}_outputs/${INPUT}_rpoB_bac_hmmer.out $rpoB_bac $SCRATCH/prodigal_gy20/gy20_${INPUT}_proteins.faa

grep -v '^#' ${INPUT}_outputs/${INPUT}_rpoB_bac_hmmer.out | awk {'{print $1}'} | sort > ${INPUT}_tmp/${INPUT}_rpoB_bac_geneid.txt

seqtk subseq $SCRATCH/prodigal_gy20/gy20_${INPUT}_proteins.faa ${INPUT}_tmp/${INPUT}_rpoB_bac_geneid.txt | awk {'{gsub(/*$/,""); print}'} > ${INPUT}_tmp/${INPUT}_rpoB_bac_proteins.faa


# rpoB Archaea
rpoB_arc=/project/def-careg421/ruizhang/software/anvio-7.1/hmm/TIGR03670.hmm

hmmsearch -T 811.0 -o ${INPUT}_tmp/${INPUT}_rpoB_arc.txt --tblout ${INPUT}_outputs/${INPUT}_rpoB_arc_hmmer.out $rpoB_arc $SCRATCH/prodigal_gy20/gy20_${INPUT}_proteins.faa

grep -v '^#' ${INPUT}_outputs/${INPUT}_rpoB_arc_hmmer.out | awk {'{print $1}'} | sort > ${INPUT}_tmp/${INPUT}_rpoB_arc_geneid.txt

seqtk subseq $SCRATCH/prodigal_gy20/gy20_${INPUT}_proteins.faa ${INPUT}_tmp/${INPUT}_rpoB_arc_geneid.txt | awk {'{gsub(/*$/,""); print}'} > ${INPUT}_tmp/${INPUT}_rpoB_arc_proteins.faa

# merge bac and arc rpoB
cat ${INPUT}_tmp/${INPUT}_rpoB_bac_proteins.faa ${INPUT}_tmp/${INPUT}_rpoB_arc_proteins.faa > ${INPUT}_tmp/${INPUT}_rpoB_all_proteins.faa
done

ls *_tmp/*_rpoB_all_proteins.faa
cat *_tmp/*_rpoB_all_proteins.faa > $PROJECT/2020_guiyang/phylogenetic_clustering/gy20_rpoB_all_proteins.faa



#!/bin/bash
#SBATCH -c 4         
#SBATCH --mem=20G                  
#SBATCH -t 3:0:0                         
#SBATCH -J=gy20_glnA_HMM.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=ALL 
#SBATCH --output=%x-%j.out
#SBATCH --account=def-careg421
 
module load StdEnv/2020 gcc/9.3.0 openmpi/4.0.3
module load mafft-mpi/7.471 
module load hmmer/3.3.2
module load seqtk/1.3

cd $SCRATCH

list="hx1a hx1b hx2a hx2b hx3a hx3b gx1a gx1b gx2a gx2b gx3a gx3b sk1a sk1b sk2a sk2b sk3a sk3b"

for INPUT in $list
do
# glnA (type I glutamate--ammonia ligase)
glnA=/project/def-careg421/ruizhang/software/anvio-7.1/hmm/TIGR00653.hmm

hmmsearch -T 429.1 -o ${INPUT}_tmp/${INPUT}_glnA.txt --tblout ${INPUT}_outputs/${INPUT}_glnA_hmmer.out $glnA $SCRATCH/prodigal_gy20/gy20_${INPUT}_proteins.faa

grep -v '^#' ${INPUT}_outputs/${INPUT}_glnA_hmmer.out | awk {'{print $1}'} | sort > ${INPUT}_tmp/${INPUT}_glnA_geneid.txt

seqtk subseq $SCRATCH/prodigal_gy20/gy20_${INPUT}_proteins.faa ${INPUT}_tmp/${INPUT}_glnA_geneid.txt | awk {'{gsub(/*$/,""); print}'} > ${INPUT}_tmp/${INPUT}_glnA_proteins.faa
done

# merge bac and arc rpoB
ls *_tmp/*_glnA_proteins.faa
cat *_tmp/*_glnA_proteins.faa > $PROJECT/2020_guiyang/phylogenetic_clustering/gy20_glnA_proteins.faa


## Phylogenetic clustering analysis

### rpoB 

# upload the unaligned .faa file to https://ngphylogeny.fr/workflows/wkmake/39018910bfb506f3 to get PHYLIP format alignment
	
		# another fasta to phylip converter
		# http://phylogeny.lirmm.fr/phylo_cgi/data_converter.cgi
		
cc_file=/project/def-careg421/ruizhang/2020_guiyang/phylogenetic_clustering/gy20_rpoB_all_proteins.faa
local_file=/Users/ruizhang/Desktop/
scp ruizhang@cedar.computecanada.ca:$cc_file $local_file

# upload file to server
# the server can also build PhyML tree, compare results later
95257: ngphylogeny.fr/workspace/history/3742273588981d88
26113: ngphylogeny.fr/workspace/history/61a3d6bf65060cd5
77513: ngphylogeny.fr/workspace/history/8d4bfbd74f13defe
10333: ngphylogeny.fr/workspace/history/0d279021b2657769
90067: ngphylogeny.fr/workspace/history/6def441a19586bf1
34283: ngphylogeny.fr/workspace/history/4e631fc72c1e6b56
46399: ngphylogeny.fr/workspace/history/319012b70c6d6d2b
85627: ngphylogeny.fr/workspace/history/b319166f217db8ac
29423: ngphylogeny.fr/workspace/history/d0de6a43a92b0387
95783: ngphylogeny.fr/workspace/history/10abaa3c54cb586b
"# FAILED :/"


## multiple sequence alignment
module load StdEnv/2020
module load trimal
module load mafft
module load emboss
module load r/4.2.2

file=$PROJECT/2020_guiyang/phylogenetic_clustering/

mafft --auto $file/gy20_rpoB_all_proteins.faa > $file/gy20_rpoB_all_proteins.msa

# 
trimal \
-in $file/gy20_rpoB_all_proteins.msa \
-out $file/gy20_rpoB_all_proteins_trimal.phylip \
-automated1 \
-phylip_paml	
	

# Used the following trimmed sequence for alignment
trimal \
-in $file/gy20_rpoB_all_proteins.msa \
-out $file/gy20_rpoB_all_proteins_trimal.phylip \
-automated1 \
-phylip_paml \
-resoverlap 0.75 \
-seqoverlap 75


# for merA and rpoB, because there are too many sequences for PhyML to handle, here we implemented an alternative approach.
# create boostrapped alignment
# then input the bootstrapped alignment into fasttree to build bootstrapped trees. 

# seqboot 
# get bootstrapped multiple sequence alignment
module load phylip/3.698
seqboot
# input file
/project/def-careg421/ruizhang/2020_guiyang/phylogenetic_clustering/gy20_merA_proteins_trimal.phylip

/project/def-careg421/ruizhang/2020_guiyang/phylogenetic_clustering/gy20_merA_proteins_trimal_T1.phylip

/project/def-careg421/ruizhang/2020_guiyang/phylogenetic_clustering/gy20_merA_proteins_trimal_T1_10.phylip

# type I, to change "Input sequences interleaved" to No. 
# random number seed

# set seed to 10 different prime numbers 
95257 # mv outfile merA_seqtoot_run1.phylip
26113 # mv outfile merA_seqtoot_run2.phylip
77513 # mv outfile merA_seqtoot_run3.phylip
10333 # mv outfile merA_seqtoot_run4.phylip
90067 # mv outfile merA_seqtoot_run5.phylip
34283 # mv outfile merA_seqtoot_run6.phylip
46399 # mv outfile merA_seqtoot_run7.phylip
85627 # mv outfile merA_seqtoot_run8.phylip
29423 # mv outfile merA_seqtoot_run9.phylip
95783 # mv outfile merA_seqtoot_run10.phylip

# seqboot produces phylip files in interleaved format, which fasttree can't handle. Converting interleaved files to sequential files. 


# load fasttree
module load fasttree/2.1.11
cd $SCRATCH/seqboot
FastTree merA_seqtoot_run1.phylip > merA_seqtoot_run1.tree
FastTree -n 100 outfile > outfile.tree

#### 

# seqboot was used to generate boostrapped alignemnt 100 bootstrapped alignemt were individually analyzed with fasttree (-n 100), which were then fed into BaTS. 

# task to do 
# convert the header line of msa file to be 10-character-long unique names, with site names at the beginning. e.g. hx75849, gx83932 .. etc.
# create phylip format trimmed file with trimal

awk 'FNR==NR { id[$1]=$2; next } { split($1,a,":"); if (a[1] in id) $1=id[a[1]]; print }' merA_msa_header_names.txt gy20_merA_proteins_trimal_T1.phylip > gy20_merA_proteins_trimal_T1_10.phylip
sed -i 's/ /    /g' gy20_merA_proteins_trimal_T1_10.phylip



# convert msa to phylip format using trimal, make sure it is the -phylip_m10 format
trimal \
-in $file/gy20_merA_filtered_proteins.msa \
-out $file/gy20_merA_proteins_trimal_T2.phylip \
-automated1 \
-phylip_m10 \
-resoverlap 0.75 \
-seqoverlap 75

# move the resulting phylip locally, copy the header lines to a Mac "Numbers" page, then  create unique names of each header in excel. Copy the column from excel to numbers. Then from numbers to the text file.
=RANDBETWEEN(10000,99999) # generate random numbers in excel
# move the header-edited file back to cedar

# run seqboot, indicate interleaved format

# run fasttree. 

# seqtool
gy20_merA_proteins_trimal_T2.phylip
FastTree -n 100 outfile3 > outfile3.tree # worked!!! 

mv outfile3.tree gy20_merA_proteins_run1.tree


# convert to nexus
R
library(phangorn)

# in
dat <- read.tree("gy20_merA_proteins_run1.tree")
# out
write.nexus(dat, file = "gy20_merA_proteins_run1.nex", translate = T)
q()

sed -i 's/TREE \* UNTITLED = \[\&U\]/tree STATE_1011000 = \[\&R\]/g' gy20_merA_proteins_run1.nex

sed -i 's/END/End/g' gy20_merA_proteins_run1.nex

# edit the header lines manually
cc_file=/project/def-careg421/ruizhang/2020_guiyang/phylogenetic_clustering/gy20_merA_proteins_run1.nex
local_file=/Users/ruizhang/Desktop/
scp ruizhang@cedar.computecanada.ca:$cc_file $local_file

cc_file=/project/def-careg421/ruizhang/2020_guiyang/phylogenetic_clustering
local_file=/Users/ruizhang/Desktop/gy20_merA_proteins_run1.nex
scp $local_file ruizhang@cedar.computecanada.ca:$cc_file

# BaTS

cd /project/def-careg421/ruizhang/software/befi-bats-gui-0.9/BaTS_beta_build2
java -jar BaTS_beta_build2.jar single /project/def-careg421/ruizhang/2020_guiyang/phylogenetic_clustering/gy20_merA_proteins_run1.nex 1 3

java -jar BaTS_beta_build2.jar single example.trees 10 3

java -jar befi-BaTS_0-2.jar single /project/def-careg421/ruizhang/2020_guiyang/phylogenetic_clustering/gy20_merA_proteins_run1.nex 10 3




####### modify the tree
module load r
R

library(phangorn)

# in
dat <- read.tree("gy20_merA_proteins_run1.tree")

# resolve the (unexisting) multifurcations?
is.binary(dat)
dat2 <- multi2di(dat)

# get rid of node support values
# and small brlen
eps <- 1e-4
for(i in 1:length(dat2)){
	dat2[[i]]$node.label <- NULL
	if(sum(dat2[[i]]$edge.length < eps) > 0){
		pos <- which(dat2[[i]]$edge.length < eps)
		if(length(pos) > 0){
			dat2[[i]]$edge.length[pos] <- eps
		}
	}
}

is.binary(dat2)

# out
write.nexus(dat2, file = "gy20_merA_proteins_run1.nexus", translate = T)

# 
sed -i 's/TREE \* UNTITLED = \[\&U\]/tree STATE_1011000 = \[\&R\]/g' gy20_merA_proteins_run1.nexus

sed -i 's/TREE \* UNTITLED/tree STATE_1011000/g' gy20_merA_proteins_run1.nexus

sed -i 's/END/End/g' gy20_merA_proteins_run1.nexus

# 
cc_file=/project/def-careg421/ruizhang/2020_guiyang/phylogenetic_clustering/gy20_merA_proteins_run1.nexus
local_file=/Users/ruizhang/Desktop/
scp ruizhang@cedar.computecanada.ca:$cc_file $local_file

cc_file=/project/def-careg421/ruizhang/2020_guiyang/phylogenetic_clustering
local_file=/Users/ruizhang/Desktop/gy20_merA_proteins_run1.nexus
scp $local_file ruizhang@cedar.computecanada.ca:$cc_file


# BaTS
cd /project/def-careg421/ruizhang/software/befi-bats-gui-0.9/BaTS_beta_build2
java -jar BaTS_beta_build2.jar single /project/def-careg421/ruizhang/2020_guiyang/phylogenetic_clustering/gy20_merA_proteins_run1.nexus 10 3



# seqboot metdho 
# rpoB 

## multiple sequence alignment
module load StdEnv/2020
module load trimal
module load mafft
module load r/4.2.2

# Used the following trimmed sequence for alignment
file=$PROJECT/2020_guiyang/phylogenetic_clustering/

trimal \
-in $file/gy20_rpoB_all_proteins.msa \
-out $file/gy20_rpoB_all_proteins_trimal.phylip \
-automated1 \
-phylip_m10 \
-resoverlap 0.75 \
-seqoverlap 75

# edit the header lines manually
# e.g. 
"gx1a_unfix --> gx51770"

cc_file=/project/def-careg421/ruizhang/2020_guiyang/phylogenetic_clustering/gy20_rpoB_all_proteins_trimal.phylip
local_file=/Users/ruizhang/Desktop/
scp ruizhang@cedar.computecanada.ca:$cc_file $local_file

cc_file=/project/def-careg421/ruizhang/2020_guiyang/phylogenetic_clustering
local_file=/Users/ruizhang/Desktop/gy20_rpoB_all_proteins_trimal.phylip
scp $local_file ruizhang@cedar.computecanada.ca:$cc_file

# seqboot 
# get bootstrapped multiple sequence alignment
cd $SCRATCH/seqboot
module load phylip/3.698
seqboot
# input file
/project/def-careg421/ruizhang/2020_guiyang/phylogenetic_clustering/gy20_rpoB_all_proteins_trimal.phylip

# random number seed

# set seed to 10 different prime numbers 
95257 # outfile1
26113 # outfile2
77513 # outfile3
10333 # outfile4
90067 # outfile5
34283 # outfile6
46399 # outfile7
85627 # outfile8
29423 # outfile9
95783 # outfile10

list='1 2 3 4 5 6 7 8 9 10'
gene='rpoB'

for i in $list
do
mv outfile${i} ${gene}_seqboot_run${i}.phylip
done

cat ${gene}_seqboot_run*.phylip > ${gene}_seqboot_combined.phylip
mv ${gene}_seqboot_combined.phylip $PROJECT/2020_guiyang/phylogenetic_clustering/

# run fasttree

#!/bin/bash
#SBATCH -c 8         
#SBATCH --mem=40G                  
#SBATCH -t 3-00:0:0                 
#SBATCH -J=fasttree_rpoB.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=ALL 
#SBATCH --output=%x-%j.out
#SBATCH --account=def-careg421

cd /project/def-careg421/ruizhang/2020_guiyang/phylogenetic_clustering/
gene='rpoB'
FastTree -n 1000 ${gene}_seqboot_combined.phylip > ${gene}_seqboot_combined.tree

### convert tree to nexus format
cd /project/def-careg421/ruizhang/2020_guiyang/phylogenetic_clustering/
R
library(phangorn)

# in
dat <- read.tree("rpoB_seqboot_combined.tree")

# resolve the (unexisting) multifurcations?
is.binary(dat) # could be all FALSE at this point
dat2 <- multi2di(dat)

# get rid of node support values
# and small brlen
eps <- 1e-4
for(i in 1:length(dat2)){
	dat2[[i]]$node.label <- NULL
	if(sum(dat2[[i]]$edge.length < eps) > 0){
		pos <- which(dat2[[i]]$edge.length < eps)
		if(length(pos) > 0){
			dat2[[i]]$edge.length[pos] <- eps
		}
	}
}

is.binary(dat2) # make sure they are all TRUE

# out
write.nexus(dat2, file = "rpoB_seqboot_combined.nexus", translate = T)

sed -i 's/TREE \* UNTITLED = \[\&U\]/tree STATE_1011000 = \[\&R\]/g' rpoB_seqboot_combined.nexus

sed -i 's/TREE \* UNTITLED/tree STATE_1011000/g' rpoB_seqboot_combined.nexus

sed -i 's/END/End/g' rpoB_seqboot_combined.nexus

# fix the nexus format so they look identical as in the example.trees
cc_file=/project/def-careg421/ruizhang/2020_guiyang/phylogenetic_clustering/gy20_merA_proteins_run1.nexus
local_file=/Users/ruizhang/Desktop/
scp ruizhang@cedar.computecanada.ca:$cc_file $local_file

cc_file=/project/def-careg421/ruizhang/2020_guiyang/phylogenetic_clustering
local_file=/Users/ruizhang/Desktop/gy20_merA_proteins_run1.nexus
scp $local_file ruizhang@cedar.computecanada.ca:$cc_file


# BaTS
cd /project/def-careg421/ruizhang/software/befi-bats-gui-0.9/BaTS_beta_build2
java -jar BaTS_beta_build2.jar single /project/def-careg421/ruizhang/2020_guiyang/phylogenetic_clustering/gy20_merA_proteins_run1.nexus 10 3


# glnA

file=$PROJECT/2020_guiyang/phylogenetic_clustering/

trimal \
-in $file/gy20_glnA_proteins.msa \
-out $file/gy20_glnA_proteins_trimal.phylip \
-automated1 \
-phylip_m10 \
-resoverlap 0.75 \
-seqoverlap 75

# edit the header lines manually 
# e.g. 
"gx1a_unfix --> gx51770" # excel formula =RANDBETWEEN(10000000,99999999)

cc_file=/project/def-careg421/ruizhang/2020_guiyang/phylogenetic_clustering/gy20_glnA_proteins_trimal.phylip
local_file=/Users/ruizhang/Desktop/
scp ruizhang@cedar.computecanada.ca:$cc_file $local_file

cc_file=/project/def-careg421/ruizhang/2020_guiyang/phylogenetic_clustering
local_file=/Users/ruizhang/Desktop/gy20_glnA_proteins_trimal.phylip
scp $local_file ruizhang@cedar.computecanada.ca:$cc_file

# seqboot 
# get bootstrapped multiple sequence alignment
cd $SCRATCH/seqboot
module load phylip/3.698
seqboot
# input file
/project/def-careg421/ruizhang/2020_guiyang/phylogenetic_clustering/gy20_glnA_proteins_trimal.phylip

# random number seed

# set seed to 10 different prime numbers 
95257 # outfile1
26113 # outfile2
77513 # outfile3
10333 # outfile4
90067 # outfile5
34283 # outfile6
46399 # outfile7
85627 # outfile8
29423 # outfile9
95783 # outfile10

list='1 2 3 4 5 6 7 8 9 10'
gene='glnA'

for i in $list
do
mv outfile${i} ${gene}_seqboot_run${i}.phylip
done

cat ${gene}_seqboot_run*.phylip > ${gene}_seqboot_combined.phylip
cp ${gene}_seqboot_combined.phylip $PROJECT/2020_guiyang/phylogenetic_clustering/

# run fasttree

#!/bin/bash
#SBATCH -c 8         
#SBATCH --mem=40G                  
#SBATCH -t 12:0:0                 
#SBATCH -J=fasttree_glnA.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=ALL 
#SBATCH --output=%x-%j.out
#SBATCH --account=def-careg421

module load fasttree/2.1.11

cd /project/def-careg421/ruizhang/2020_guiyang/phylogenetic_clustering/
gene='glnA'
FastTree -n 1000 ${gene}_seqboot_combined.phylip > ${gene}_seqboot_combined.tree

# run fasttree individually

#!/bin/bash
#SBATCH -c 10         
#SBATCH --mem=40G                  
#SBATCH -t 1-0:0:0                         
#SBATCH -J=fasttree_rpoB_array.sh
#SBATCH --array=0-10                     
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=ALL 
#SBATCH --output=%x-%j.out
#SBATCH --account=def-careg421

module load fasttree/2.1.11

cd ~
names=($(cat numbers.txt))
echo ${names[${SLURM_ARRAY_TASK_ID}]}

gene='rpoB'
FastTree -n 100 $SCRATCH/seqboot/${gene}_seqboot_run${names[${SLURM_ARRAY_TASK_ID}]}.phylip > $SCRATCH/fasttree/${gene}_seqboot_run${names[${SLURM_ARRAY_TASK_ID}]}.tree


#!/bin/bash
#SBATCH -c 10         
#SBATCH --mem=40G                  
#SBATCH -t 1-0:0:0                         
#SBATCH -J=fasttree_glnA_array.sh
#SBATCH --array=0-10                     
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=ALL 
#SBATCH --output=%x-%j.out
#SBATCH --account=def-careg421

module load fasttree/2.1.11

cd ~
names=($(cat numbers.txt))
echo ${names[${SLURM_ARRAY_TASK_ID}]}

gene='glnA'
FastTree -n 100 $SCRATCH/seqboot/${gene}_seqboot_run${names[${SLURM_ARRAY_TASK_ID}]}.phylip > $SCRATCH/fasttree/${gene}_seqboot_run${names[${SLURM_ARRAY_TASK_ID}]}.tree


# merge trees
cd $SCRATCH/fasttree/
cat glnA* > glnA_seqboot_combined.tree
cat rpoB* > rpoB_seqboot_combined.tree 


### convert tree to nexus format
cd $SCRATCH/fasttree/
R
library(phangorn)

# rpoB 
dat <- read.tree("rpoB_seqboot_combined.tree")

# resolve the (unexisting) multifurcations?
is.binary(dat) # could be all FALSE at this point
dat2 <- multi2di(dat)

# get rid of node support values
# and small brlen
eps <- 1e-4
for(i in 1:length(dat2)){
	dat2[[i]]$node.label <- NULL
	if(sum(dat2[[i]]$edge.length < eps) > 0){
		pos <- which(dat2[[i]]$edge.length < eps)
		if(length(pos) > 0){
			dat2[[i]]$edge.length[pos] <- eps
		}
	}
}

is.binary(dat2) # make sure they are all TRUE

# out
write.nexus(dat2, file = "rpoB_seqboot_combined.nexus", translate = T)


# glnA
dat <- read.tree("glnA_seqboot_combined.tree")

# resolve the (unexisting) multifurcations?
is.binary(dat) # could be all FALSE at this point
dat2 <- multi2di(dat)

# get rid of node support values
# and small brlen
eps <- 1e-4
for(i in 1:length(dat2)){
	dat2[[i]]$node.label <- NULL
	if(sum(dat2[[i]]$edge.length < eps) > 0){
		pos <- which(dat2[[i]]$edge.length < eps)
		if(length(pos) > 0){
			dat2[[i]]$edge.length[pos] <- eps
		}
	}
}

is.binary(dat2) # make sure they are all TRUE

# out
write.nexus(dat2, file = "glnA_seqboot_combined.nexus", translate = T)

q()

# 
sed -i 's/TREE \* UNTITLED/tree STATE_1011000/g' rpoB_seqboot_combined.nexus
sed -i 's/END/End/g' rpoB_seqboot_combined.nexus
sed -i 's/\ttree/tree/g' rpoB_seqboot_combined.nexus


sed -i 's/TREE \* UNTITLED/tree STATE_1011000/g' glnA_seqboot_combined.nexus
sed -i 's/END/End/g' glnA_seqboot_combined.nexus
sed -i 's/\ttree/tree/g' glnA_seqboot_combined.nexus


# extract header line
head -n 800 rpoB_seqboot_combined.nexus > rpoB_seqs.txt
head -n 3000 glnA_seqboot_combined.nexus > glnA_seqs.txt


# fix the nexus format so they look identical as in the example.trees
cc_file=/scratch/ruizhang/fasttree/rpoB_seqs.txt
local_file=/Users/ruizhang/Desktop/
scp ruizhang@cedar.computecanada.ca:$cc_file $local_file

cc_file=/scratch/ruizhang/fasttree/glnA_seqs.txt
local_file=/Users/ruizhang/Desktop/
scp ruizhang@cedar.computecanada.ca:$cc_file $local_file

# edit the headerlines manually, to the same as example.trees


# BaTS

#!/bin/bash
#SBATCH -c 32         
#SBATCH --mem=125G                  
#SBATCH -t 1-0:0:0              # took 2 hours             
#SBATCH -J=BaTS-rpoB.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=ALL 
#SBATCH --output=%x-%j.out
#SBATCH --account=def-careg421

module load StdEnv/2020
module load java/17.0.2

cd /project/def-careg421/ruizhang/software/befi-bats-gui-0.9/BaTS_beta_build2
java -jar BaTS_beta_build2.jar single /scratch/ruizhang/fasttree/rpoB_seqboot_combined.nexus 988 3


# BaTS
#!/bin/bash
#SBATCH -c 32         
#SBATCH --mem=125G                  
#SBATCH -t 1-0:0:0            # took 13 hours             
#SBATCH -J=BaTS-glnA.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=ALL 
#SBATCH --output=%x-%j.out
#SBATCH --account=def-careg421

module load StdEnv/2020
module load java/17.0.2

cd /project/def-careg421/ruizhang/software/befi-bats-gui-0.9/BaTS_beta_build2
java -jar BaTS_beta_build2.jar single /scratch/ruizhang/fasttree/glnA_seqboot_combined.nexus 988 3


# see file below for results
/project/def-careg421/ruizhang/2020_guiyang/phylogenetic_clustering/BaTS-glnA.txt
/project/def-careg421/ruizhang/2020_guiyang/phylogenetic_clustering/BaTS-rpoB.txt