### Getting FASTQ files from NCBI SRA database using Snakemake 

#### 1. Conda Environment 

- Reference: [Conda doc](https://docs.conda.io/projects/conda/en/latest/index.html), [lcdb-wf doc](https://lcdb.github.io/lcdb-wf)
- This conda environment was established by the NIH/NICHD Bioinformatics Scientific Programming Core (PI: Dr. Ryan Dale) 


```yml

bedtools>=2.29.2
biopython>=1.76
bowtie>=1.2.3
bowtie2>=2.3.5.1
cutadapt>=2.10
deeptools>=3.4.3
fastq-screen>=0.14.0
fastqc>=0.11.9
font-ttf-dejavu-sans-mono>=2.37
gat>=1.3.6
gffread>=0.11.7
gffutils>=0.10.1
hisat2>=2.2.0
intervalstats>=1.01
ipython>=7.13.0
multiqc>=1.8
pandas>=1.0.3
pandoc>=2.9.2.1
picard>=2.22.3
preseq>=2.0.3
pybedtools>=0.8.1
pyfaidx>=0.5.8
pysam>=0.15.4
pytest>=5.4.1
pytest-xdist>=1.31.0
rseqc>=3.0.1
salmon>=1.2.1
samtools>=1.9
seaborn>=0.10.0
snakemake-minimal
sra-tools>=2.10.7
star>=2.7.3a
subread>=2.0.0
trackhub>=0.2.4
ucsc-bedgraphtobigwig>=377
ucsc-bedsort>=377
ucsc-bedtobigbed>=377
ucsc-bigwigmerge>=377
ucsc-fetchchromsizes>=377
ucsc-genepredtobed>=377
ucsc-gtftogenepred>=377
ucsc-liftover>=377
ucsc-oligomatch>=377
ucsc-twobittofa>=377
ucsc-wigtobigwig>=377

```

#### 2. Snakemake 

- Reference: [Snakemake doc](https://snakemake.readthedocs.io/en/stable)

- **Without a configfile**


```Snakefile



__author__ = "Mira Sohn"
__copyright__ = "Copyright 2021, Mira Sohn"
__email__ = "tonton07@gmail.com"



######################## Defined by users #########################
SAMPLE=["SRR12626034", "SRR12626035"]
NAME=["A", "B"]
###################################################################

DONE="etc/done.txt"
DELETED="etc/deleted.txt"


rule all: 
    input:
        DELETED

rule export_sratoolkit: 
    """
    This workflow uses pre-installed SRAtoolkit. Installation is needed, 
    otherise.
    """
    log: 
        "snakemake_logs/log_export_sratoolkit.log"
    benchmark: 
        "snakemake_logs/bcm_export_sratoolkit.tsv" 
    output: 
        "etc/location_sratoolkit.txt" 
    shell:
        "export PATH=$PATH:~/lcdb-wf/myproj/env/bin | "
        "which fastq-dump > {output}" 

rule get_sra: 
    """
    This rule downloads SRA files
    """
    log:
        "snakemake_logs/log_get_sra.log"
    benchmark:
        "snakemake_logs/bcm_get_sra.tsv"
    input: 
        "etc/location_sratoolkit.txt"
    output: 
        touch(DONE)
    run: 
        for x in SAMPLE:
           shell("prefetch {x} > {log}") 

rule get_fastq: 
    """
    This rule converts SRA to FASTQ files
    """
    input:
       "etc/done.txt" 
    output: 
        expand("fastq/{sample}_1.fastq", sample=SAMPLE)
    run:
        for x in SAMPLE:
            shell("fastq-dump --split-files {x}/{x}.sra --outdir fastq")

rule gzip_fastq:
    """
    This rule compresses FASTQ files using gzip
    """
    input: 
        expand("fastq/{sample}_1.fastq", sample=SAMPLE)    
    output: 
        expand("fastq/{sample}_1.fastq.gz", sample=SAMPLE) 
    shell:
        "gzip {input}"

rule name_fastq:
    """
    This rule renames fastq.gz files from the SRR to Sample names
    """
    input: 
        expand("fastq/{sample}_1.fastq.gz", sample=SAMPLE) 
    output: 
        expand("fastq/{name}.fastq.gz", name=NAME)
    run:
        for i in range(len(NAME)):
            FROM=SAMPLE[i]
            TO=NAME[i]
            shell("mv fastq/{FROM}_1.fastq.gz fastq/{TO}.fastq.gz")

rule clean_rsa: 
    """
    This rule deletes the raw SRA files 
    """
    input: 
        expand("fastq/{name}.fastq.gz", name=NAME)
    output: 
        touch(DELETED)
    run:
        for x in SAMPLE:
            shell("rm {x}/*.sra")
            shell("rm -d {x}")


```


- ** With a configfile** 


```Snakefile





```


#### 3. Running the Snakemake workflow

- Reference: [Snakemake Command line Arguments](https://snakemake.readthedocs.io/en/stable/executing/cli.html)

- **Dry run**


```bash
#!/bin/bash

snakemake -n

```


- **DAG visualization** 


```bash
#!/bin/bash

snakemake --dag | dot -Tpdf > dag.pdf

```


- **Run**


```bash
#!bin/bash

# -j or --cores assignes the number of cores
snakemake -j 8

```
