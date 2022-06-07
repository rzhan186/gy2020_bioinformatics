# here we want to obtain the coverage of each hgcA sequences from the contigs, we don't perform dereplication here, because we want to know the taxonomic distribution of hgcA acorss samples. performing dereplication would skew the data. 

# get hgcA sequences from contigs

module load CCEnv
module load StdEnv/2020 gcc/9.3.0
module load python/3.8
module load prodigal/2.6.3
module load hmmer/3.2.1
module load diamond
module load blast+/2.12.0
module load mcl
module load r

source ~/anvio-dev/bin/activate

list='hx1a hx1b hx2a hx2b hx3a hx3b gx1a gx1b gx2a gx2b gx3a gx3b sk1a sk1b sk2a sk2b sk3a sk3b'

contigdb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_contigs_db

for site in $list
do
anvi-get-sequences-for-hmm-hits \
-c $contigdb/${site}_contigs_1000.db \
--hmm-source anvio_custom_hmm_hgcA \
-o $SCRATCH/guiyang/anvio/hmm/contigs_hgcA_${site}_aa \
--get-aa-sequences
done

cat $SCRATCH/guiyang/anvio/hmm/contigs_hgcA_*_aa > $SCRATCH/guiyang/anvio/hmm/contigs_hgcA_all_aa.txt

# perform MSA of the sequences, remove those without the cap-helix motif.
module load mafft

mafft --auto $SCRATCH/guiyang/anvio/hmm/contigs_hgcA_all_aa.txt > $SCRATCH/guiyang/anvio/hmm/msa_contigs_hgcA_all_aa.fasta


scp ruizhang@niagara.computecanada.ca:/scratch/c/careg421/ruizhang/guiyang/anvio/hmm/msa_contigs_hgcA_all_aa.fasta /Users/ruizhang/Desktop

scp /Users/ruizhang/Desktop/msa_contigs_hgcA_all_aa_mod.fasta ruizhang@niagara.computecanada.ca:/scratch/c/careg421/ruizhang/guiyang/anvio/hmm/

scp ruizhang@niagara.computecanada.ca:/scratch/c/careg421/ruizhang/guiyang/anvio/hmm/contigs_hgcA_all_aa.txt /Users/ruizhang/Desktop

# import the sequences into TMHMM, remove sequences without at least 4 transmembrane domains
 



# get the coverage of the genes 
output=/scratch/c/careg421/ruizhang/guiyang/anvio/hgcA_gene_call_coverage

# first, copy the site_name + gene caller id into a separate file (file.txt)
# e.g. 
gx1a	13737
gx1a	33085
gx1a	172280

list='hx1a hx1b hx2a hx2b hx3a hx3b gx1a gx1b gx2a gx2b gx3a gx3b sk1a sk1b sk2a sk2b sk3a sk3b'

for site in $list
do
grep ${site} $output/file.txt > $output/${site}_tmp.txt # create separate files for each sampe
awk '{print $2}' $output/${site}_tmp.txt > ${site}_hgcA_caller_id.txt # retain only the second column, which are the gene caller IDs
yes | rm $output/${site}_tmp.txt
done

# export coverages of the gene caller IDs
 
profiledb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_profile_db/20220128
contigdb=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_contigs_db

for site in $list
do
anvi-export-gene-coverage-and-detection \
-c $contigdb/${site}_contigs_1000.db \
-p $profiledb/${site}_${site}_profile/PROFILE.db \
--genes-of-interest $output/${site}_hgcA_caller_id.txt \
-O $output/${site}_hgcA_coverage
done

cat $output/*_hgcA_coverage-GENE-COVERAGES.txt > $output/all_hgcA_coverage-GENE-COVERAGES.txt

output=/scratch/c/careg421/ruizhang/guiyang/anvio/hgcA_gene_call_coverage
scp ruizhang@niagara.computecanada.ca:$output/all_hgcA_coverage-GENE-COVERAGES.txt /Users/ruizhang/Desktop


# create a fasta file for the taxonomic identification
contigs_hgcA_all_aa_final.fasta

scp /Users/ruizhang/Desktop/contigs_hgcA_all_aa_final.fasta ruizhang@niagara.computecanada.ca:/scratch/c/careg421/ruizhang/guiyang/anvio/hgcA_gene_call_coverage/

output=/scratch/c/careg421/ruizhang/guiyang/anvio/hgcA_gene_call_coverage

module load mafft

mafft --auto $output/contigs_hgcA_all_aa_final.fasta > $output/msa_contigs_hgcA_all_aa_final.fasta


# now determine the taxonomy of each HMM hit using Gionfriddo Hg-Db


# make an alignment of the sequences
# the resulting file is the .sto file in the OUTPUT directory

module load hmmer

HMM=/scratch/c/careg421/ruizhang/gionfriddo_hgcAB_2021Db/Hg-MATE-Db.v1.ISOCELMAG_HgcA_full.refpkg
OUTPUT=/scratch/c/careg421/ruizhang/guiyang/hmmer/goinfriddo

hmmalign \
-o $OUTPUT/20220309_hgcA_hmm_1E-50_alignment.sto \
--mapali $HMM/Hg-MATE-Db.v1.ISOCELMAG_HgcA_full.stockholm $HMM/Hg-MATE-Db.v1.ISOCELMAG_HgcA_full.hmm $output/msa_contigs_hgcA_all_aa_final.fasta  

# place query sequences onto a reference tree using pplacer(v1.1.alpha19)
module load CCEnv
module load StdEnv/2020
module load pplacer 

refpkg=/scratch/c/careg421/ruizhang/gionfriddo_hgcAB_2021Db
INPUT=/scratch/c/careg421/ruizhang/guiyang/hmmer/goinfriddo
OUTPUT=/scratch/c/careg421/ruizhang/guiyang/pplacer

pplacer \
--keep-at-most 1 \
--max-pend 1 \
-p -c $refpkg/Hg-MATE-Db.v1.ISOCELMAG_HgcA_full.refpkg $INPUT/20220309_hgcA_hmm_1E-50_alignment.sto \
-o $OUTPUT/20220309_hgcA_1E-50_hmm_alignment.jplace


rppr prep_db \
--sqlite $OUTPUT/20220309_hgcA_1E-50_classify_output \
-c $refpkg/Hg-MATE-Db.v1.ISOCELMAG_HgcA_full.refpkg

#Assign taxonomy to query sequences 
guppy classify \
-c $refpkg/Hg-MATE-Db.v1.ISOCELMAG_HgcA_full.refpkg \
--pp --sqlite $OUTPUT/20220309_hgcA_1E-50_classify_output $OUTPUT/20220309_hgcA_1E-50_hmm_alignment.jplace

#write classifications to a csv file
guppy to_csv \
--point-mass \
--pp -o $OUTPUT/20220309_hgcA_1E-50_classifications.csv $OUTPUT/20220309_hgcA_1E-50_hmm_alignment.jplace

#produce a visualization showing placements of query sequences on reference tree
guppy tog \
--pp -o $OUTPUT/20220309_hgcA_1E-50_classifications_on_tree.nwk $OUTPUT/20220309_hgcA_1E-50_hmm_alignment.jplace