
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

rule get_fastq:   # Creates fastq.gz files in fastq directory
    """
    This rule downloads SRA and converts to FASTQ files
    """
    output:
        expand("fastq/{{sample}}_{end}.fastq.gz", end=config['END'])
    params:
        dic=config['SAMPLE']
    run:
        sra=params.dic[wildcards.sample]
        shell("fastq-dump --split-files {sra} --gzip -X 100000")
        for i in range(len(output)):
            i += 1
            shell("mv {sra}_{i}.fastq.gz fastq/{wildcards.sample}_{i}.fastq.gz")



