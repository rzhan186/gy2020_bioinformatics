#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 24:0:0   
#SBATCH -J=concoct-hx.sh   # each sample takes roughly 4 hours
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=END 
#SBATCH --output=%x-%j.out

CONTIG=/scratch/c/careg421/ruizhang/guiyang/megahit_output
OUTPUT=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_binning/concoct
MAPPING=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_mapping/20220128

list='hx1a hx1b hx2a hx2b hx3a hx3b'

cd $SCRATCH

for site in $list
do

cd $SCRATCH

# cut contigs into 1kb
singularity exec -B /scratch/c/careg421/ruizhang concoct-v1.1.0.sif \
cut_up_fasta.py $CONTIG/fastp_${site}/contigs-anvio-fixed-1000-rename.fa -c 1000 -o 0 --merge_last -b $OUTPUT/${site}/${site}_contigs_1000.bed > $OUTPUT/${site}/${site}_contigs_1000.fa

# generate table with coverage depth info per sample and subcontig, BAM files have to be indexed and sorted. 
singularity exec --no-home -B /scratch/c/careg421/ruizhang concoct-v1.1.0.sif \
concoct_coverage_table.py $OUTPUT/${site}/${site}_contigs_1000.bed $MAPPING/${site}/${site}_*_fixed.bam > $OUTPUT/${site}/${site}_concoct_coverage_table.tsv

# run concoct:
singularity exec --no-home -B /scratch/c/careg421/ruizhang concoct-v1.1.0.sif \
concoct --composition_file $OUTPUT/${site}/${site}_contigs_1000.fa --coverage_file $OUTPUT/${site}/${site}_concoct_coverage_table.tsv -b $OUTPUT/${site}/ -t 40

# merge subcontig clustering into original contig clustering:
singularity exec --no-home -B /scratch/c/careg421/ruizhang concoct-v1.1.0.sif \
merge_cutup_clustering.py $OUTPUT/${site}/clustering_gt1000.csv > $OUTPUT/${site}/clustering_merged.csv

# extract bins as individual FASTA
singularity exec --no-home -B /scratch/c/careg421/ruizhang concoct-v1.1.0.sif \
extract_fasta_bins.py $CONTIG/fastp_${site}/contigs-anvio-fixed-1000-rename.fa $OUTPUT/${site}/clustering_merged.csv --output_path $OUTPUT/${site}/bins/

# rename bins 
cd $OUTPUT/${site}/bins/
for f in *
do
mv -- "$f" "concoct_${site}_bin_$f"
done
done

#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 24:0:0   
#SBATCH -J=concoct-gx.sh   # each sample takes roughly 4 hours
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=END 
#SBATCH --output=%x-%j.out

CONTIG=/scratch/c/careg421/ruizhang/guiyang/megahit_output
OUTPUT=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_binning/concoct
MAPPING=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_mapping/20220128

list='gx1a gx1b gx2a gx2b gx3a gx3b'

cd $SCRATCH

for site in $list
do

cd $SCRATCH

# cut contigs into 1kb
singularity exec -B /scratch/c/careg421/ruizhang concoct-v1.1.0.sif \
cut_up_fasta.py $CONTIG/fastp_${site}/contigs-anvio-fixed-1000-rename.fa -c 1000 -o 0 --merge_last -b $OUTPUT/${site}/${site}_contigs_1000.bed > $OUTPUT/${site}/${site}_contigs_1000.fa

# generate table with coverage depth info per sample and subcontig, BAM files have to be indexed and sorted. 
singularity exec --no-home -B /scratch/c/careg421/ruizhang concoct-v1.1.0.sif \
concoct_coverage_table.py $OUTPUT/${site}/${site}_contigs_1000.bed $MAPPING/${site}/${site}_*_fixed.bam > $OUTPUT/${site}/${site}_concoct_coverage_table.tsv

# run concoct:
singularity exec --no-home -B /scratch/c/careg421/ruizhang concoct-v1.1.0.sif \
concoct --composition_file $OUTPUT/${site}/${site}_contigs_1000.fa --coverage_file $OUTPUT/${site}/${site}_concoct_coverage_table.tsv -b $OUTPUT/${site}/ -t 40

# merge subcontig clustering into original contig clustering:
singularity exec --no-home -B /scratch/c/careg421/ruizhang concoct-v1.1.0.sif \
merge_cutup_clustering.py $OUTPUT/${site}/clustering_gt1000.csv > $OUTPUT/${site}/clustering_merged.csv

# extract bins as individual FASTA
singularity exec --no-home -B /scratch/c/careg421/ruizhang concoct-v1.1.0.sif \
extract_fasta_bins.py $CONTIG/fastp_${site}/contigs-anvio-fixed-1000-rename.fa $OUTPUT/${site}/clustering_merged.csv --output_path $OUTPUT/${site}/bins/

# rename bins 
cd $OUTPUT/${site}/bins/
for f in *
do
mv -- "$f" "concoct_${site}_bin_$f"
done
done

#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 24:0:0   
#SBATCH -J=concoct-sk.sh   # each sample takes roughly 4 hours
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=END 
#SBATCH --output=%x-%j.out

CONTIG=/scratch/c/careg421/ruizhang/guiyang/megahit_output
OUTPUT=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_binning/concoct
MAPPING=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_mapping/20220128

list='sk1a sk1b sk2a sk2b sk3a sk3b'

cd $SCRATCH

for site in $list
do

cd $SCRATCH

# cut contigs into 1kb
singularity exec -B /scratch/c/careg421/ruizhang concoct-v1.1.0.sif \
cut_up_fasta.py $CONTIG/fastp_${site}/contigs-anvio-fixed-1000-rename.fa -c 1000 -o 0 --merge_last -b $OUTPUT/${site}/${site}_contigs_1000.bed > $OUTPUT/${site}/${site}_contigs_1000.fa

# generate table with coverage depth info per sample and subcontig, BAM files have to be indexed and sorted. 
singularity exec --no-home -B /scratch/c/careg421/ruizhang concoct-v1.1.0.sif \
concoct_coverage_table.py $OUTPUT/${site}/${site}_contigs_1000.bed $MAPPING/${site}/${site}_*_fixed.bam > $OUTPUT/${site}/${site}_concoct_coverage_table.tsv

# run concoct:
singularity exec --no-home -B /scratch/c/careg421/ruizhang concoct-v1.1.0.sif \
concoct --composition_file $OUTPUT/${site}/${site}_contigs_1000.fa --coverage_file $OUTPUT/${site}/${site}_concoct_coverage_table.tsv -b $OUTPUT/${site}/ -t 40

# merge subcontig clustering into original contig clustering:
singularity exec --no-home -B /scratch/c/careg421/ruizhang concoct-v1.1.0.sif \
merge_cutup_clustering.py $OUTPUT/${site}/clustering_gt1000.csv > $OUTPUT/${site}/clustering_merged.csv

# extract bins as individual FASTA
singularity exec --no-home -B /scratch/c/careg421/ruizhang concoct-v1.1.0.sif \
extract_fasta_bins.py $CONTIG/fastp_${site}/contigs-anvio-fixed-1000-rename.fa $OUTPUT/${site}/clustering_merged.csv --output_path $OUTPUT/${site}/bins/

# rename bins 
cd $OUTPUT/${site}/bins/
for f in *
do
mv -- "$f" "concoct_${site}_bin_$f"
done
done