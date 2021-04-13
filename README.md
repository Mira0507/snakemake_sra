## Getting FASTQ files from NCBI SRA database using Snakemake 

### This workflow demonstrates an example of reproducible and automated workflow getting FASTQ files from SRA database


#### 1. Conda Environment 

- Reference: [Conda doc](https://docs.conda.io/projects/conda/en/latest/index.html), [lcdb-wf doc](https://lcdb.github.io/lcdb-wf), [sra-tools](https://github.com/ncbi/sra-tools), [Snakemake Installation Guide](https://snakemake.readthedocs.io/en/stable/getting_started/installation.html)

- Recipe: [config/conda_env.yml](https://github.com/Mira0507/snakemake_sra/blob/master/config/conda_env.yml)





#### 2. Snakemake 

- Reference: [Snakemake doc](https://snakemake.readthedocs.io/en/stable)

- Snakefile: [Snakefile](https://github.com/Mira0507/snakemake_sra/blob/master/Snakefile)

- Config files: [config/config_paired.yaml (for paired end reads)](https://github.com/Mira0507/snakemake_sra/blob/master/config/config_paired.yaml), [config/config_single.yaml (for single end reads)](https://github.com/Mira0507/snakemake_sra/blob/master/config/config_single.yaml)





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
