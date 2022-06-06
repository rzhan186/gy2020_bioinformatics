# Run GTDB-tk on the 50%/10% MAGs
# download GTDB release 207_V2
# Run CheckM and GTDB-tk on 50% MAGs with the latest release of GTDB-tk, 207_v2

module load CCEnv
module load StdEnv/2020
module load python/3.8.2

virtualenv gtdbtk.2.1
source ~/gtdbtk.2.1/bin/activate
pip install --no-index --upgrade pip
pip install --upgrade gtdbtk #upgrade to gtdbtk.2.1

#!/bin/bash
#SBATCH --nodes 1
#SBATCH -t 10:0:0   
#SBATCH -J=gtdb-tk-release207v2.sh
#SBATCH --mail-user=zzhan186@uottawa.ca
#SBATCH --mail-type=END 
#SBATCH --output=%x-%j.out

module load CCEnv
module load StdEnv/2020
module load prodigal/2.6.3
module load hmmer/3.2.1
module load fastani/1.32
module load pplacer/1.1
module load fasttree

export GTDBTK_DATA_PATH=/scratch/c/careg421/ruizhang/release207_v2
export PATH=/scratch/c/careg421/ruizhang/Mash-2.3:$PATH
source ~/gtdbtk.2.1/bin/activate

collection='20220217_dastool_anvio_refined_230_release_v2'
mkdir -p /scratch/c/careg421/ruizhang/guiyang/gtdb-tk/${collection}/identify_rs207_v2/
mkdir -p /scratch/c/careg421/ruizhang/guiyang/gtdb-tk/${collection}/align_rs207_v2/
mkdir -p /scratch/c/careg421/ruizhang/guiyang/gtdb-tk/${collection}/classify_rs207_v2/

genome=/scratch/c/careg421/ruizhang/guiyang/anvio/20220217_refined_bins_50
input=/scratch/c/careg421/ruizhang/guiyang/gtdb-tk/${collection}

gtdbtk identify \
--genome_dir $genome \
--out_dir $input/identify_rs207_v2 \
--extension fa --cpus 80

gtdbtk align \
--identify_dir $input/identify_rs207_v2 \
--out_dir $input/align_rs207_v2 --cpus 80

gtdbtk classify \
--genome_dir $genome \
--align_dir $input/align_rs207_v2 \
--out_dir $input/classify_rs207_v2 -x fa \
--scratch_dir $BBUFFER \
--cpus 80 \
--pplacer_cpus 1

