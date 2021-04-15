
__author__ = "Mira Sohn"
__copyright__ = "Copyright 2021, Mira Sohn"
__email__ = "tonton07@gmail.com"



# This workflow is designed to download fastq files from SRA database. 
# It's possible to perform manually as well (see https://github.com/Mira0507/using_SRA)



#################################### Defined by users #################################
configfile: "config/config_paired1.yaml"    # Sets path to the config file
#######################################################################################

shell.prefix('set -euo pipefail; ')
shell.executable('/bin/bash')

rule all: 
    input: 
        expand("fastq/{out}.fastq.gz", out=config['OUTPUT_LIST'])

rule get_fastq:
    """
    This rule downloads SRA and converts to FASTQ files
    """
    output:
        expand("fastq/{out}.fastq.gz", out=config['OUTPUT_LIST'])
    params:
        dic=config['SAMPLE'],
        reads=config['END'],
        sra=config['SRA']
    run:
        shell("set +o pipefail; "
              "fastq-dump --split-files {params.sra} --gzip")    # Without assigning the output directory (e.g. -O fastq)
        for key, value in params.dic.items(): 
              for read in params.reads: 
                  shell("set +o pipefail; " 
                        "mv {key}_{read}.fastq.gz fastq/{value}_{read}.fastq.gz") 
