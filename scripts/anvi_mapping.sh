#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 24:0:0   
#SBATCH -J=bwa_contigs1000_hxa.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=END 
#SBATCH --output=%x-%j.out

module load bwa
module load samtools

# index the reference genome (in this case, the assemblies) - This step is already done earlier
# for site in $list
# do
# mkdir $OUTPUT/${site}
# bwa index -p $OUTPUT/${site}/${site}_index -a bwtsw $INPUT/fastp_${site}/contigs-anvio-fixed-1000-rename.fa
# done

# map reads from all samples within the same site onto each individual assembly
 
INPUT=/scratch/c/careg421/ruizhang/guiyang/megahit_output
OUTPUT=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_mapping/20210906/
READS=/scratch/c/careg421/ruizhang/guiyang/trimmed_reads
mapping_output=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_mapping/20220128/
 
list1='hx1a hx2a hx3a'
list2='hx1a hx1b hx2a hx2b hx3a hx3b'

for site in $list1
do
	for reads_site in $list2
	do
		# map reads onto the indexed assembly. BWA doesn't output .bam fiesl by default, use samtools to get .bam files, which will be used later during the binning process. 
		bwa mem -t 80 \
		$OUTPUT/${site}/${site}_index \
		$READS/LC_${reads_site}_fastp.R1.fq.gz \
		$READS/LC_${reads_site}_fastp.R2.fq.gz | samtools view -bS - > $mapping_output/${site}/${site}_${reads_site}_raw.bam --threads 80
	
		# get mapping stats and store in a txt file
		echo ${site}_${reads_site} >> $mapping_output/${site}_mapping_stats.txt 
		samtools flagstat $mapping_output/${site}/${site}_${reads_site}_raw.bam --threads 80 >> $mapping_output/${site}_mapping_stats.txt 
	done
done

# anvi initialize bams
cd $SCRATCH

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

OUTPUT=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_mapping/20210906/

for site in $list1
do
	for reads_site in $list2
	do
		anvi-init-bam $mapping_output/${site}/${site}_${reads_site}_raw.bam -o $mapping_output/${site}/${site}_${reads_site}_fixed.bam -T 80
	done
done





#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 24:0:0   
#SBATCH -J=bwa_contigs1000_hxb.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=END 
#SBATCH --output=%x-%j.out

module load bwa
module load samtools

# index the reference genome (in this case, the assemblies) - This step is already done earlier
# for site in $list
# do
# mkdir $OUTPUT/${site}
# bwa index -p $OUTPUT/${site}/${site}_index -a bwtsw $INPUT/fastp_${site}/contigs-anvio-fixed-1000-rename.fa
# done

# map reads from all samples within the same site onto each individual assembly
 
INPUT=/scratch/c/careg421/ruizhang/guiyang/megahit_output
OUTPUT=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_mapping/20210906/
READS=/scratch/c/careg421/ruizhang/guiyang/trimmed_reads
mapping_output=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_mapping/20220128/
 
list1='hx1b hx2b hx3b'
list2='hx1a hx1b hx2a hx2b hx3a hx3b'

for site in $list1
do
	for reads_site in $list2
	do
		# map reads onto the indexed assembly. BWA doesn't output .bam fiesl by default, use samtools to get .bam files, which will be used later during the binning process. 
		bwa mem -t 80 \
		$OUTPUT/${site}/${site}_index \
		$READS/LC_${reads_site}_fastp.R1.fq.gz \
		$READS/LC_${reads_site}_fastp.R2.fq.gz | samtools view -bS - > $mapping_output/${site}/${site}_${reads_site}_raw.bam --threads 80
	
		# get mapping stats and store in a txt file
		echo ${site}_${reads_site} >> $mapping_output/${site}_mapping_stats.txt 
		samtools flagstat $mapping_output/${site}/${site}_${reads_site}_raw.bam --threads 80 >> $mapping_output/${site}_mapping_stats.txt 
	done
done

# anvi initialize bams
cd $SCRATCH

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

OUTPUT=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_mapping/20210906/

for site in $list1
do
	for reads_site in $list2
	do
		anvi-init-bam $mapping_output/${site}/${site}_${reads_site}_raw.bam -o $mapping_output/${site}/${site}_${reads_site}_fixed.bam -T 80
	done
done



#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 24:0:0   
#SBATCH -J=bwa_contigs1000_gxa.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=END 
#SBATCH --output=%x-%j.out

module load bwa
module load samtools

# index the reference genome (in this case, the assemblies) - This step is already done earlier
# for site in $list
# do
# mkdir $OUTPUT/${site}
# bwa index -p $OUTPUT/${site}/${site}_index -a bwtsw $INPUT/fastp_${site}/contigs-anvio-fixed-1000-rename.fa
# done

# map reads from all samples within the same site onto each individual assembly
 
INPUT=/scratch/c/careg421/ruizhang/guiyang/megahit_output
OUTPUT=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_mapping/20210906/
READS=/scratch/c/careg421/ruizhang/guiyang/trimmed_reads
mapping_output=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_mapping/20220128/
 
list1='gx1a gx2a gx3a'
list2='gx1a gx1b gx2a gx2b gx3a gx3b'

for site in $list1
do
	for reads_site in $list2
	do
		# map reads onto the indexed assembly. BWA doesn't output .bam fiesl by default, use samtools to get .bam files, which will be used later during the binning process. 
		bwa mem -t 80 \
		$OUTPUT/${site}/${site}_index \
		$READS/LC_${reads_site}_fastp.R1.fq.gz \
		$READS/LC_${reads_site}_fastp.R2.fq.gz | samtools view -bS - > $mapping_output/${site}/${site}_${reads_site}_raw.bam --threads 80
	
		# get mapping stats and store in a txt file
		echo ${site}_${reads_site} >> $mapping_output/${site}_mapping_stats.txt 
		samtools flagstat $mapping_output/${site}/${site}_${reads_site}_raw.bam --threads 80 >> $mapping_output/${site}_mapping_stats.txt 
	done
done

# anvi initialize bams
cd $SCRATCH

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

OUTPUT=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_mapping/20210906/

for site in $list1
do
	for reads_site in $list2
	do
		anvi-init-bam $mapping_output/${site}/${site}_${reads_site}_raw.bam -o $mapping_output/${site}/${site}_${reads_site}_fixed.bam -T 80
	done
done


#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 24:0:0   
#SBATCH -J=bwa_contigs1000_gxb.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=END 
#SBATCH --output=%x-%j.out

module load bwa
module load samtools

# index the reference genome (in this case, the assemblies) - This step is already done earlier
# for site in $list
# do
# mkdir $OUTPUT/${site}
# bwa index -p $OUTPUT/${site}/${site}_index -a bwtsw $INPUT/fastp_${site}/contigs-anvio-fixed-1000-rename.fa
# done

# map reads from all samples within the same site onto each individual assembly
 
INPUT=/scratch/c/careg421/ruizhang/guiyang/megahit_output
OUTPUT=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_mapping/20210906/
READS=/scratch/c/careg421/ruizhang/guiyang/trimmed_reads
mapping_output=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_mapping/20220128/
 
list1='gx1b gx2b gx3b'
list2='gx1a gx1b gx2a gx2b gx3a gx3b'

for site in $list1
do
	for reads_site in $list2
	do
		# map reads onto the indexed assembly. BWA doesn't output .bam fiesl by default, use samtools to get .bam files, which will be used later during the binning process. 
		bwa mem -t 80 \
		$OUTPUT/${site}/${site}_index \
		$READS/LC_${reads_site}_fastp.R1.fq.gz \
		$READS/LC_${reads_site}_fastp.R2.fq.gz | samtools view -bS - > $mapping_output/${site}/${site}_${reads_site}_raw.bam --threads 80
	
		# get mapping stats and store in a txt file
		echo ${site}_${reads_site} >> $mapping_output/${site}_mapping_stats.txt 
		samtools flagstat $mapping_output/${site}/${site}_${reads_site}_raw.bam --threads 80 >> $mapping_output/${site}_mapping_stats.txt 
	done
done

# anvi initialize bams
cd $SCRATCH

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

OUTPUT=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_mapping/20210906/

for site in $list1
do
	for reads_site in $list2
	do
		anvi-init-bam $mapping_output/${site}/${site}_${reads_site}_raw.bam -o $mapping_output/${site}/${site}_${reads_site}_fixed.bam -T 80
	done
done


#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 24:0:0   
#SBATCH -J=bwa_contigs1000_ska.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=END 
#SBATCH --output=%x-%j.out

module load bwa
module load samtools

# index the reference genome (in this case, the assemblies) - This step is already done earlier
# for site in $list
# do
# mkdir $OUTPUT/${site}
# bwa index -p $OUTPUT/${site}/${site}_index -a bwtsw $INPUT/fastp_${site}/contigs-anvio-fixed-1000-rename.fa
# done

# map reads from all samples within the same site onto each individual assembly
 
INPUT=/scratch/c/careg421/ruizhang/guiyang/megahit_output
OUTPUT=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_mapping/20210906/
READS=/scratch/c/careg421/ruizhang/guiyang/trimmed_reads
mapping_output=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_mapping/20220128/
 
list1='sk1a sk2a sk3a'
list2='sk1a sk1b sk2a sk2b sk3a sk3b'

for site in $list1
do
	for reads_site in $list2
	do
		# map reads onto the indexed assembly. BWA doesn't output .bam fiesl by default, use samtools to get .bam files, which will be used later during the binning process. 
		bwa mem -t 80 \
		$OUTPUT/${site}/${site}_index \
		$READS/LC_${reads_site}_fastp.R1.fq.gz \
		$READS/LC_${reads_site}_fastp.R2.fq.gz | samtools view -bS - > $mapping_output/${site}/${site}_${reads_site}_raw.bam --threads 80
	
		# get mapping stats and store in a txt file
		echo ${site}_${reads_site} >> $mapping_output/${site}_mapping_stats.txt 
		samtools flagstat $mapping_output/${site}/${site}_${reads_site}_raw.bam --threads 80 >> $mapping_output/${site}_mapping_stats.txt 
	done
done

# anvi initialize bams
cd $SCRATCH

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

OUTPUT=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_mapping/20210906/

for site in $list1
do
	for reads_site in $list2
	do
		anvi-init-bam $mapping_output/${site}/${site}_${reads_site}_raw.bam -o $mapping_output/${site}/${site}_${reads_site}_fixed.bam -T 80
	done
done



#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 24:0:0   
#SBATCH -J=bwa_contigs1000_skb.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=END 
#SBATCH --output=%x-%j.out

module load bwa
module load samtools

# index the reference genome (in this case, the assemblies) - This step is already done earlier
# for site in $list
# do
# mkdir $OUTPUT/${site}
# bwa index -p $OUTPUT/${site}/${site}_index -a bwtsw $INPUT/fastp_${site}/contigs-anvio-fixed-1000-rename.fa
# done

# map reads from all samples within the same site onto each individual assembly
 
INPUT=/scratch/c/careg421/ruizhang/guiyang/megahit_output
OUTPUT=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_mapping/20210906/
READS=/scratch/c/careg421/ruizhang/guiyang/trimmed_reads
mapping_output=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_mapping/20220128/
 
list1='sk1b sk2b sk3b'
list2='sk1a sk1b sk2a sk2b sk3a sk3b'

for site in $list1
do
	for reads_site in $list2
	do
		# map reads onto the indexed assembly. BWA doesn't output .bam fiesl by default, use samtools to get .bam files, which will be used later during the binning process. 
		bwa mem -t 80 \
		$OUTPUT/${site}/${site}_index \
		$READS/LC_${reads_site}_fastp.R1.fq.gz \
		$READS/LC_${reads_site}_fastp.R2.fq.gz | samtools view -bS - > $mapping_output/${site}/${site}_${reads_site}_raw.bam --threads 80
	
		# get mapping stats and store in a txt file
		echo ${site}_${reads_site} >> $mapping_output/${site}_mapping_stats.txt 
		samtools flagstat $mapping_output/${site}/${site}_${reads_site}_raw.bam --threads 80 >> $mapping_output/${site}_mapping_stats.txt 
	done
done

# anvi initialize bams
cd $SCRATCH

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

OUTPUT=/scratch/c/careg421/ruizhang/guiyang/anvio/option2_mapping/20210906/

for site in $list1
do
	for reads_site in $list2
	do
		anvi-init-bam $mapping_output/${site}/${site}_${reads_site}_raw.bam -o $mapping_output/${site}/${site}_${reads_site}_fixed.bam -T 80
	done
done