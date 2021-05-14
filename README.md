## Getting FASTQ files from NCBI SRA database using Snakemake 

### This workflow demonstrates an example of reproducible and automated workflow getting FASTQ files from SRA database


#### 1. Conda Environment 

- Reference: [Conda doc](https://docs.conda.io/projects/conda/en/latest/index.html), [lcdb-wf doc](https://lcdb.github.io/lcdb-wf), [sra-tools](https://github.com/ncbi/sra-tools), [Snakemake Installation Guide](https://snakemake.readthedocs.io/en/stable/getting_started/installation.html)

- Recipe: [config/conda_env.yml](https://github.com/Mira0507/snakemake_sra/blob/master/config/conda_env.yml)




#### 2. Snakemake 

- Reference: [Snakemake doc](https://snakemake.readthedocs.io/en/stable)

- Snakefile: [Snakefile](https://github.com/Mira0507/snakemake_sra/blob/master/Snakefile)


```


__author__ = "Mira Sohn"
__copyright__ = "Copyright 2021, Mira Sohn"
__email__ = "tonton07@gmail.com"



# This workflow is designed to download fastq files from SRA database. 
# It's possible to perform manually as well (see https://github.com/Mira0507/using_SRA)
#################################### Defined by users #################################
configfile: "config/config_paired1.yaml"    # Sets path to the config file
#######################################################################################


rule all: 
    input:
        expand("fastq/{sample}_{end}.fastq.gz", sample=list(config['SAMPLE'].keys()), end=config['END'])

rule get_fastq:   
    """
    This rule downloads SRA and converts to FASTQ files
    """
    output:
        expand("fastq/{{sample}}_{end}.fastq.gz", end=config['END'])
    params:
        dic=config['SAMPLE']
    run:
        sra=params.dic[wildcards.sample]
        shell("fastq-dump --split-files {sra} --gzip -X 100000")   # -X is for testing
        for i in range(len(output)):
            i += 1
            shell("mv {sra}_{i}.fastq.gz fastq/{wildcards.sample}_{i}.fastq.gz")

```

- Config files:      
    a. [config/config_paired.yaml (paired-end testing 1)](https://github.com/Mira0507/snakemake_sra/blob/master/config/config_paired.yaml)     
    b. [config/config_paired1.yaml (paired-end testing 2)](https://github.com/Mira0507/snakemake_sra/blob/master/config/config_paired1.yaml)    
    c. [config/config_single.yaml (single-end testing)](https://github.com/Mira0507/snakemake_sra/blob/master/config/config_single.yaml)





#### 3. Running the Snakemake workflow

- Reference: [Snakemake Command Line Arguments](https://snakemake.readthedocs.io/en/stable/executing/cli.html)

- **Dry run**


```bash
#!/bin/bash

snakemake -n

```


- **DAG visualization** 


```bash
#!/bin/bash


# The dot commend requires graphviz (downloadable via conda)
snakemake --dag | dot -Tpdf > dag.pdf


```


- **Run**


```bash
#!/bin/bash

# Either -j or --cores assignes the number of cores
snakemake -j 8

```
