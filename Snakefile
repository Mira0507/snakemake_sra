
__author__ = "Mira Sohn"
__copyright__ = "Copyright 2021, Mira Sohn"
__email__ = "tonton07@gmail.com"



# This workflow is designed to download fastq files from SRA database. 
# It's possible to perform manually as well (see https://github.com/Mira0507/using_SRA)

#################################### Defined by users #################################
configfile: "config/config_paired.yaml"    # Sets path to the config file
#######################################################################################

shell.prefix('set -euo pipefail; source ~/.bashrc; ')
shell.executable('/bin/bash')

rule all: 
    input: 
        expand("fastq/{name}_{end}.fastq.gz", name=config["NAME"], end=config["END"])


rule get_fastq: 
    """
    This rule downloads SRA and converts to FASTQ files
    """
    output: 
       "fastq/{sample}_{end}.fastq.gz"
    shell:
        "fastq-dump --split-files {wildcards.sample} --gzip -O fastq"

rule rename: 
    """
    This rule renames fastq.gz files
    """
    input: 
        expand("fastq/{sample}_{end}.fastq.gz", sample=config["SAMPLE"], end=config["END"])
    output:
        expand("fastq/{name}_{end}.fastq.gz", name=config["NAME"], end=config["END"])
    run:
        for i in range(len(output)): 
            IN=input[i]
            OUT=output[i]
            shell("mv {IN} {OUT}")
        # The output files are stored in the fastq folder
