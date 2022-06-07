# guiyang2020 bioinformatic pipeline
 
### Acquiring raw sequence data

```sh
Raw sequences are submitted to the NCBI SRA under the following accession number

SRR15313073
SRR15313072
SRR15313070
SRR15313069
SRR15313071
SRR15313068
```
### Sequencing data QA/QC
Examining trimmed reads using fastqc (v0.21.0) then make a summary report using multiqc (v1.9) <br>
[fastqc](https://github.com/rzhan186/gy2020_bioinformatics/blob/master/scripts/fastqc.sh) [Cedar] <br/>
[multiqc](https://github.com/rzhan186/gy2020_bioinformatics/blob/master/scripts/multiqc.sh) [Cedar]

### Assembling trimmed reads using MEGAHIT(v1.2.9)
[megahit.sh](hhttps://github.com/rzhan186/gy2020_bioinformatics/blob/master/scripts/megahit.sh) [Niagara]

### Processing assembled contigs using Anvi'o

*a little note of the Anvi'o pipeline*

Anvio can build contigs DB from both single assemblies and co-assemblies (assemblies produced from by combining mulitple samples together, as opposed to single assembly which was produced using only a single sample). There are 3 approaches one can adopt when having multiple samples (to make the pipeline clear, here we will assume that we only have 6 samples to work with, which are hx1a, hx1b, hx2a, hx2b, hx3a, hx3b),

Approach 1: single assemblies, single mapping
1. generat contigs DB for each of the 6 samples, producing a total of 6 contigs DB.
2. map trimmed reads from each sample (e.g. R1 and R2) onto themselves to produce 6 .bam files.
3. sort and index the 6 .bam files
4. construct single-profile DB for each sample, a total of 6 profile DB. 
5. skip anvi-merge, since there is nothing to merge. 
6. import bins produced from each sample into the single-profile DB for manual curation with anvi-refine and the interactive interface. 

Approach 2: single assemblies, multiple mapping
1. edit the header of the contigs to include the sample names.
2. generate contigs DB for each of the 6 samples, producing a total of 6 contigs DB.
3. map trimmed reads (i.e. R1 and R2) from all samples onto the assembly file of each sample individually to produce 36 .bam files. For example, you will map R1/R2 from hx1a, hx1b, hx2a, hx2b, hx3a, hx3b onto the assembly file of hx1a, then you repeat this process for hx1b, and so on. (This was implemented and recommended by Meren in his "Walbachia tutorial" <https://merenlab.org/data/wolbachia-plasmid/>, to fully take advantage of the differential-coverage-based method of the binning softwares).
4. sort and index the 36 .bam files
5. construct single-profile DB for each sample, producing a total of 36 profile DB. 
6. perform anvi-merge to merge single-profile DB from each sample, producing a total of 6 merged profile DB.
7. import bins produced from each sample into the merged profile DB for manuel curation with anvi-refine and the interactive interface. 

Approach 3: co-assemblies
1. assemble all 6 six samples together using MEAGHIT (this is called a co-assembly), producing 1 final.contigs.fa file. 
2. generate contigs DB for this contig file, producing a total of 1 contigs DB.
3. map trimmed reads from all samples onto this single assembly, producing a total of 6 .bam files. 
4. sort and index the 6 .bam files
5. construct single-profile DB for each sample, producing a total of 6 profile DB. 
6. perform anvi-merge to merge the 6 single-profile DB from each sample, producing a total of 1 merged profile DB.
7. import DAStool bins from each sample into the merged profile DB for manuel curation with anvi-refine and the interactive interface.

I have chosen to adopt apporach 2, but it seems there is no consensus in the field as to which one is the best, the other options could perform better or worse depending on the samples you have, the only way to find out which option is the best is to try them all (if you have the passion), and compare the results.

#### Reformating headers of the contigs

The reason why we need to reformat the headers of the contigs is to make them compatible with Anvi'o, and only retain contigs with a length greater than 1000 bases. We change the headers from something like **>k127_5028584 flag=1 multi=1.0000_len=305** to **>c_000000000148** using the `anvi-script-reformat-fasta` function, basically removing the spaces in the names and renumbering the contigs. Then we furthur modify the header names by attaching site names to which the headers belong, so that the header names are changed to \**>c_000000000148_hx1a**

[anvi-refomat-contigs](https://github.com/rzhan186/gy2020_bioinformatics/blob/master/scripts/anvi_refomat_contigs.sh) [Niagara]


#### Creating Anvi'o contigs databases for each sample 

Here I created contigs database by reserving all contigs over 1000 bases.

[anvi-gen-contigs-db](https://github.com/rzhan186/gy2020_bioinformatics/blob/master/scripts/anvi_gen_contigs_db.sh) [Niagara]

#### Creating Anvi'o profile databases for each sample 

Here, we generate BAM files (mapping) using BWA(v0.7.17) and samtools(v1.12). As mentioned ealier, the purpose is to map each reads file from every sample of the same site onto each individual single assemblies of the same site, to guide the differential coverage based binning method later on.

[mapping](https://github.com/rzhan186/gy2020_bioinformatics/blob/master/scripts/anvi_mapping.sh) [Niagara]

Constructing profile database <br>
[anvi-profile-db](https://github.com/rzhan186/gy2020_bioinformatics/blob/master/scripts/anvi_profile_db.sh) [Niagara]

(Optional) [anvi-merge](https://github.com/rzhan186/gy2020_bioinformatics/blob/master/scripts/anvi_merge.sh) [Niagara] This step is not required if you don't plan to bin your contigs using anvio. 

#### Annotating the contigs databases with COG, pfam and the custom HMM from the Hg-MATE db. 
[contigs_annotation](https://github.com/rzhan186/gy2020_bioinformatics/blob/master/scripts/contigs_annotation.sh) [Niagara]



#### SCG abundance in contigs databases
[anvi_scg](https://github.com/rzhan186/gy2020_bioinformatics/blob/master/scripts/anvi_scg.sh) [Niagara]

#### Functional annotation of the contigs using the KEGG kofam database 
In this step, we will estimate the metabolic potential of our samples by applying hmmsearch using profile HMMs implemented in KEGG's kofam database on the contigs in our contigs db.

[anvi_metabolism](https://github.com/rzhan186/gy2020_bioinformatics/blob/master/scripts/anvi_metabolism_contigs.sh) [Niagara]

The resulting files contain information about KO hits on each individual contig, their gene ID as well as the coverage of each KO on the contigs. Since the files are too large, they won't be stored in this repo. The following table shows an example of the format of the output tables. 

| unique_id | genome_name         | ko     | gene_caller_id | contig              | modules_with_ko             | ko_definition         | sk3b_sk3b_profile_DB_coverage | sk3b_sk3b_profile_DB_detection |
|-----------|---------------------|--------|----------------|---------------------|-----------------------------|-----------------------|-------------------------------|--------------------------------|
| 1         | Guiyang 2020 sikeng | K01689 | 394240         | c_000003239302_sk3b | M00001,M00002,M00003,M00346 | enolase [EC:4.2.1.11] | 12.857463524130191            | 0.9753086419753086             |
| 2         | Guiyang 2020 sikeng | K01689 | 115716         | c_000000922903_sk3b | M00001,M00002,M00003,M00346 | enolase [EC:4.2.1.11] | 15.105919003115265            | 1.0                            |
| 3         | Guiyang 2020 sikeng | K01689 | 187911         | c_000001509472_sk3b | M00001,M00002,M00003,M00346 | enolase [EC:4.2.1.11] | 7.460992907801418             | 1.0                            |
| 4         | Guiyang 2020 sikeng | K01689 | 177675         | c_000001424072_sk3b | M00001,M00002,M00003,M00346 | enolase [EC:4.2.1.11] | 15.81375358166189             | 1.0                            |
| 5         | Guiyang 2020 sikeng | K01689 | 440331         | c_000003632225_sk3b | M00001,M00002,M00003,M00346 | enolase [EC:4.2.1.11] | 8.493798449612402             | 1.0                            |
| 6         | Guiyang 2020 sikeng | K01689 | 241678         | c_000001957446_sk3b | M00001,M00002,M00003,M00346 | enolase [EC:4.2.1.11] | 9.707246376811595             | 1.0                            |
| 7         | Guiyang 2020 sikeng | K01689 | 208910         | c_000001683148_sk3b | M00001,M00002,M00003,M00346 | enolase [EC:4.2.1.11] | 6.127868852459017             | 1.0                            |
| 8         | Guiyang 2020 sikeng | K01689 | 577552         | c_000004839097_sk3b | M00001,M00002,M00003,M00346 | enolase [EC:4.2.1.11] | 6.698630136986301             | 1.0                            |

Next, I pulled out the `ko`, `ko_definition` and the coverage column from all samples and concatenated them. Then the coverage values from each sample were then normalized using the total single copy gene coverage of that sample, times 10, as suggested by Meren in his Slack Channel: \

"Rui:
Hello everyone, I’d like to compare the abundance of some KOfam hits across samples using anvi-estimate-metabolism, I produced results using the kofam-hits mode along with the coverage of each hit. I am wondering if it would make sense to sum the coverage of the same KOfam despite they are from different contigs (or summing the coverage of the same KOfam with different gene caller IDs), then do this for many samples and compare results? My concern is that if the same reads are recruited multiple times on different contigs, then this comparison would not make much sense, any insights? Thank you!

meren:
_Hey @Rui, there is absolutely no proper way of doing this, because despite our wishful thinking, metagenomes can’t offer any accurate quantitative estimates. But perhaps you can approach to a relatively less incorrect estimate by adding up coverage values for a single KOfam in a single sample and then dividing by the total coverage of all single-copy core genes of a single class in the same sample (i.e., Ribosomal L16 or something — which you can also get from anvi’o). If you do this to every single sample independently, the ratio between the two would be somewhat useful (and much more useful than normalizing those values based on total number of reads, etc).
My 2 cents._"

For example, if the coverage of K00001 in sample hx1a is 100, and the total scg coverage in hx1a is 1000, then the normalized coverage value of K00001 in hx1a would be 100/1000 * 10 = 1. 


#### Obtaining hgcAB sequences from contigs databases
Becuase there are genes not included in KOFAM, such as the hgcAB, if we were to determine the abundance of those genes, we'd have add our own hmm files into anvio and do some addition coding. I implemented additional hmm files, files and codes are shown below: 

[custom hmm files](https://github.com/rzhan186/gy2020_bioinformatics/blob/master/data/anvio_custom_hmm) 

[anvi custom hmm](https://github.com/rzhan186/gy2020_bioinformatics/blob/master/scripts/anvi_custom_hmm.sh)

Exporting coverage info of the genes identified through the custom HMMs <br>
[gene coverage](https://github.com/rzhan186/gy2020_bioinformatics/blob/master/scripts/gene_coverage.sh)

#### Contigs level hgcA analysis
the purpose of this step is the determine the taxonomic classification of each hgcA sequence recovered from the contigs database. <br>
[hgcA analyses](https://github.com/rzhan186/gy2020_bioinformatics/blob/master/scripts/hgcA_analyses.sh)

hgcA phylogenetic tree <br>
[hgcA phylogenetic tree](https://github.com/rzhan186/gy2020_bioinformatics/blob/master/scripts/hgcA_phylogenetic_tree.sh) 

hgcAB synteny analysis <br>
[hgcA contigs synteny](https://github.com/rzhan186/gy2020_bioinformatics/blob/master/scripts/hgcAB_contigs_synteny.sh) 

Taxonomic classification of the contigs containing hgcAB <br>
[hgcA contigs taxonomy](https://github.com/rzhan186/gy2020_bioinformatics/blob/master/scripts/hgcAB_contigs_taxonomy.sh) 


### Binning (outside of Anvi'o)
The purpose of this step is to bin the contigs using three binners, then combine and select the best set of bins using a DASToool. 
#### metabat2
[metabat2.sh](https://github.com/rzhan186/gy2020_bioinformatics/blob/master/scripts/metabat2.sh) [Niagara]

export contig coverages for binning outside of anvio <br>
[anvi-export-coverage](https://github.com/rzhan186/gy2020_bioinformatics/blob/master/scripts/anvi-export-splits-and-coverages.sh)  [Niagara]

#### maxbin2
[maxbin2.sh](https://github.com/rzhan186/gy2020_bioinformatics/blob/master/scripts/maxbin2.sh) [Niagara]

#### concoct
[concoct.sh](https://github.com/rzhan186/gy2020_bioinformatics/blob/master/scripts/concoct.sh) [Niagara]

#### DAS Tool
[dastool.sh](https://github.com/rzhan186/gy2020_bioinformatics/blob/master/scripts/dastool.sh) [Niagara]

#### Anvi'o manual refinement
[anvi-refine](https://github.com/rzhan186/gy2020_bioinformatics/blob/master/scripts/anvi_refine.sh) [Niagara]

### Taxonomic classificaiton of the MAGs
[GTDB-tk](https://github.com/rzhan186/gy2020_bioinformatics/blob/master/scripts/gtdbtk-MAGs.sh) [Niagara]

### Metabolic analyses of the MAGs
[MAGs metabolism](https://github.com/rzhan186/gy2020_bioinformatics/blob/master/scripts/anvi_metabolism_MAGs.sh) [Niagara]

### hgcAB synteny analysis of confirmed Hg methylators
First downloading the genomes of the confirmed methylator from NCBI based on their NCBI accessions, and create Anvi'o contigs databases of the genomes. 

[hgcAB MAGs synteny](https://github.com/rzhan186/gy2020_bioinformatics/blob/master/scripts/hgcAB_MAGs_syteny.sh) [Niagara]







