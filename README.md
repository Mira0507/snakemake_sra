## Getting FASTQ files from NCBI SRA database using Snakemake 

### This workflow demonstrates an example of reproducible and automated workflow getting FASTQ files (single-ended) from SRA database


#### 1. Conda Environment 

- Reference: [Conda doc](https://docs.conda.io/projects/conda/en/latest/index.html), [lcdb-wf doc](https://lcdb.github.io/lcdb-wf)
- I used an env established by the NIH/NICHD Bioinformatics Scientific Programming Core (PI: Dr. Ryan Dale) 


```yml

name: /home/mira/lcdb-wf/myproj/env
channels:
  - conda-forge
  - bioconda
  - defaults
dependencies:
  - _libgcc_mutex=0.1=conda_forge
  - _openmp_mutex=4.5=1_gnu
  - _r-mutex=1.0.1=anacondar_1
  - alsa-lib=1.2.3=h516909a_0
  - amply=0.1.4=py_0
  - apipkg=1.5=py_0
  - appdirs=1.4.4=pyh9f0ad1d_0
  - argcomplete=1.12.1=pyh9f0ad1d_0
  - argh=0.26.2=pyh9f0ad1d_1002
  - attrs=20.2.0=pyh9f0ad1d_0
  - backcall=0.2.0=pyh9f0ad1d_0
  - backports=1.0=py_2
  - backports.functools_lru_cache=1.6.1=py_0
  - bedtools=2.29.2=hc088bd4_0
  - binutils_impl_linux-64=2.35=h18a2f87_9
  - binutils_linux-64=2.35=hc3fd857_29
  - biopython=1.78=py38h1e0a361_1
  - bowtie=1.3.0=py38hed8969a_1
  - bowtie2=2.4.2=py38h1c8e9b9_0
  - brotlipy=0.7.0=py38h8df0ef7_1001
  - bwidget=1.9.14=0
  - bx-python=0.8.9=py38hb90e610_2
  - bzip2=1.0.8=h516909a_3
  - c-ares=1.16.1=h516909a_3
  - ca-certificates=2020.6.20=hecda079_0
  - cairo=1.16.0=hcf35c78_1003
  - certifi=2020.6.20=py38h924ce5b_2
  - cffi=1.14.3=py38h1bdcb99_1
  - chardet=3.0.4=py38h924ce5b_1008
  - click=7.1.2=pyh9f0ad1d_0
  - coincbc=2.10.5=hab63836_1
  - coloredlogs=14.0=py38h32f6830_2
  - colormath=3.0.0=py_2
  - configargparse=1.2.3=pyh9f0ad1d_0
  - cryptography=3.1.1=py38hb23e4d4_1
  - curl=7.71.1=he644dc0_8
  - cutadapt=2.10=py38h0213d0e_1
  - cycler=0.10.0=py_2
  - datrie=0.8.2=py38h1e0a361_1
  - decorator=4.4.2=py_0
  - deeptools=3.5.0=py_0
  - deeptoolsintervals=0.1.9=py38h0213d0e_2
  - dnaio=0.4.2=py38h0213d0e_1
  - docutils=0.16=py38h924ce5b_2
  - execnet=1.7.1=py_0
  - expat=2.2.9=he1b5a44_2
  - fastq-screen=0.14.0=pl526_0
  - fastqc=0.11.9=0
  - font-ttf-dejavu-sans-mono=2.37=hab24e00_0
  - fontconfig=2.13.1=h86ecdb6_1001
  - freetype=2.10.4=he06d7ca_0
  - fribidi=1.0.10=h516909a_0
  - future=0.18.2=py38h32f6830_2
  - gat=1.3.6=py38h197edbe_2
  - gcc_impl_linux-64=7.5.0=hd9e1a51_17
  - gcc_linux-64=7.5.0=he2a3fca_29
  - gettext=0.19.8.1=hf34092f_1004
  - gffread=0.12.1=h8b12597_0
  - gffutils=0.10.1=pyh864c0ab_1
  - gfortran_impl_linux-64=7.5.0=hfca37b7_17
  - gfortran_linux-64=7.5.0=ha081f1e_29
  - giflib=5.2.1=h516909a_2
  - gitdb=4.0.5=py_0
  - gitpython=3.1.9=py_0
  - glib=2.66.2=he1b5a44_0
  - graphite2=1.3.13=he1b5a44_1001
  - gsl=2.6=h294904e_0
  - gxx_impl_linux-64=7.5.0=h7ea4de1_17
  - gxx_linux-64=7.5.0=h547f3ba_29
  - harfbuzz=2.4.0=h9f30f68_3
  - hdf5=1.10.5=nompi_h54c07f9_1110
  - hisat2=2.2.1=he1b5a44_2
  - htslib=1.11=hd3b49d5_0
  - humanfriendly=8.2=py38h32f6830_1
  - icu=64.2=he1b5a44_1
  - idna=2.10=pyh9f0ad1d_0
  - importlib-metadata=2.0.0=py_1
  - importlib_metadata=2.0.0=1
  - iniconfig=1.1.0=pyh9f0ad1d_0
  - intervalstats=1.01=0
  - ipython=7.18.1=py38h1cdfbd6_1
  - ipython_genutils=0.2.0=py_1
  - jedi=0.17.2=py38h32f6830_1
  - jemalloc=5.2.1=he1b5a44_4
  - jinja2=2.11.2=pyh9f0ad1d_0
  - jpeg=9d=h516909a_0
  - jsonschema=3.2.0=py_2
  - jupyter_core=4.6.3=py38h32f6830_2
  - kernel-headers_linux-64=2.6.32=h77966d4_13
  - kiwisolver=1.2.0=py38hbf85e49_1
  - krb5=1.17.1=hfafb76e_3
  - lcms2=2.11=hbd6801e_0
  - ld_impl_linux-64=2.35=h769bd43_9
  - libblas=3.8.0=17_openblas
  - libcblas=3.8.0=17_openblas
  - libcurl=7.71.1=hcdd3856_8
  - libdeflate=1.6=h516909a_0
  - libedit=3.1.20191231=he28a2e2_2
  - libev=4.33=h516909a_1
  - libffi=3.2.1=he1b5a44_1007
  - libgcc-devel_linux-64=7.5.0=h42c25f5_17
  - libgcc-ng=9.3.0=h5dbcf3e_17
  - libgd=2.2.5=h307a58e_1007
  - libgfortran-ng=7.5.0=hae1eefd_17
  - libgfortran4=7.5.0=hae1eefd_17
  - libglib=2.66.2=h0dae87d_0
  - libgomp=9.3.0=h5dbcf3e_17
  - libiconv=1.16=h516909a_0
  - liblapack=3.8.0=17_openblas
  - libnghttp2=1.41.0=h8cfc5f6_2
  - libopenblas=0.3.10=pthreads_hb3c22a3_5
  - libpng=1.6.37=hed695b0_2
  - libssh2=1.9.0=hab1572f_5
  - libstdcxx-devel_linux-64=7.5.0=h4084dd6_17
  - libstdcxx-ng=9.3.0=h2ae2ef3_17
  - libtiff=4.1.0=hc3755c2_3
  - libuuid=2.32.1=h14c3975_1000
  - libwebp=1.0.2=h56121f0_5
  - libxcb=1.13=h14c3975_1002
  - libxml2=2.9.10=hee79883_0
  - lz4-c=1.9.2=he1b5a44_3
  - lzo=2.10=h516909a_1000
  - lzstring=1.0.4=py_1001
  - make=4.3=hd18ef5c_1
  - markdown=3.3.2=pyh9f0ad1d_0
  - markupsafe=1.1.1=py38h8df0ef7_2
  - matplotlib=3.3.2=0
  - matplotlib-base=3.3.2=py38h4d1ce4f_1
  - more-itertools=8.5.0=py_0
  - multiqc=1.9=py_1
  - mysql-connector-c=6.1.11=h6eb9d5d_1007
  - nbformat=5.0.8=py_0
  - ncbi-ngs-sdk=2.10.4=h3e72335_1
  - ncurses=6.2=he1b5a44_2
  - networkx=2.5=py_0
  - numpy=1.19.2=py38hf89b668_1
  - olefile=0.46=pyh9f0ad1d_1
  - openblas=0.3.10=pthreads_h43bd3aa_5
  - openjdk=11.0.8=hacce0ff_0
  - openssl=1.1.1h=h516909a_0
  - ossuuid=1.6.2=hf484d3e_1000
  - packaging=20.4=pyh9f0ad1d_0
  - pandas=1.1.3=py38hddd6c8b_2
  - pandoc=2.11.0.2=hd18ef5c_0
  - pango=1.42.4=h7062337_4
  - parso=0.7.1=pyh9f0ad1d_0
  - patsy=0.5.1=py_0
  - pcre=8.44=he1b5a44_0
  - pcre2=10.35=h2f06484_0
  - perl=5.26.2=h516909a_1006
  - perl-app-cpanminus=1.7044=pl526_1
  - perl-business-isbn=3.004=pl526_0
  - perl-business-isbn-data=20140910.003=pl526_0
  - perl-carp=1.38=pl526_3
  - perl-constant=1.33=pl526_1
  - perl-data-dumper=2.173=pl526_0
  - perl-encode=2.88=pl526_1
  - perl-exporter=5.72=pl526_1
  - perl-extutils-makemaker=7.36=pl526_1
  - perl-file-path=2.16=pl526_0
  - perl-file-temp=0.2304=pl526_2
  - perl-gd=2.71=pl526he860b03_0
  - perl-gdgraph=1.54=pl526_0
  - perl-gdtextutil=0.86=pl526h14c3975_5
  - perl-mime-base64=3.15=pl526_1
  - perl-parent=0.236=pl526_1
  - perl-uri=1.76=pl526_0
  - perl-xml-libxml=2.0132=pl526h7ec2d77_1
  - perl-xml-namespacesupport=1.12=pl526_0
  - perl-xml-sax=1.02=pl526_0
  - perl-xml-sax-base=1.09=pl526_0
  - perl-xsloader=0.24=pl526_0
  - pexpect=4.8.0=pyh9f0ad1d_2
  - picard=2.23.8=0
  - pickleshare=0.7.5=py_1003
  - pigz=2.3.4=hed695b0_1
  - pillow=8.0.0=py38h9776b28_0
  - pip=20.2.4=py_0
  - pixman=0.38.0=h516909a_1003
  - plotly=4.11.0=pyh9f0ad1d_0
  - pluggy=0.13.1=py38h32f6830_3
  - preseq=2.0.3=hc216eb9_5
  - prompt-toolkit=3.0.8=py_0
  - psutil=5.7.2=py38h8df0ef7_1
  - pthread-stubs=0.4=h14c3975_1001
  - ptyprocess=0.6.0=py_1001
  - pulp=2.3=py38h32f6830_2
  - py=1.9.0=pyh9f0ad1d_0
  - py2bit=0.3.0=py38h0213d0e_4
  - pybedtools=0.8.1=py38h1c8e9b9_2
  - pybigwig=0.3.17=py38h55f8d50_2
  - pycparser=2.20=pyh9f0ad1d_2
  - pyfaidx=0.5.9.1=pyh864c0ab_1
  - pygments=2.7.1=py_0
  - pyopenssl=19.1.0=py_1
  - pyparsing=2.4.7=pyh9f0ad1d_0
  - pyrsistent=0.17.3=py38h1e0a361_1
  - pysam=0.16.0.1=py38hbdc2ae9_1
  - pysocks=1.7.1=py38h924ce5b_2
  - pytest=6.1.1=py38h32f6830_1
  - pytest-forked=1.2.0=pyh9f0ad1d_0
  - pytest-xdist=2.1.0=py_0
  - python=3.8.6=h852b56e_0_cpython
  - python-dateutil=2.8.1=py_0
  - python-lzo=1.12=py38h47b17db_1001
  - python_abi=3.8=1_cp38
  - pytz=2020.1=pyh9f0ad1d_0
  - pyyaml=5.3.1=py38h8df0ef7_1
  - r-base=4.0.2=h95c6c4b_0
  - ratelimiter=1.2.0=py_1002
  - readline=8.0=he28a2e2_2
  - requests=2.24.0=pyh9f0ad1d_0
  - retrying=1.3.3=py_2
  - rseqc=4.0.0=py38h0213d0e_0
  - salmon=1.3.0=hf69c8f4_0
  - samtools=1.11=h6270b1f_0
  - scipy=1.5.2=py38h8c5af15_2
  - seaborn=0.11.0=0
  - seaborn-base=0.11.0=py_0
  - sed=4.8=hbfbb72e_0
  - setuptools=49.6.0=py38h924ce5b_2
  - simplejson=3.17.2=py38h1e0a361_1
  - six=1.15.0=pyh9f0ad1d_0
  - smmap=3.0.4=pyh9f0ad1d_0
  - snakemake-minimal=5.26.1=py_1
  - spectra=0.0.11=py_1
  - sqlite=3.33.0=h4cf870e_1
  - sra-tools=2.10.8=pl526haddd2b5_0
  - star=2.7.6a=0
  - statsmodels=0.12.0=py38hab2c0dc_1
  - subread=2.0.1=hed695b0_0
  - sysroot_linux-64=2.12=h77966d4_13
  - tbb=2020.2=hc9558a2_0
  - tk=8.6.10=hed695b0_1
  - tktable=2.10=h555a92e_3
  - toml=0.10.1=pyh9f0ad1d_0
  - toposort=1.5=py_3
  - tornado=6.0.4=py38h1e0a361_2
  - trackhub=0.2.4=pyh864c0ab_2
  - traitlets=5.0.5=py_0
  - ucsc-bedgraphtobigwig=377=h446ed27_1
  - ucsc-bedsort=377=h446ed27_2
  - ucsc-bedtobigbed=377=h446ed27_1
  - ucsc-bigwigmerge=377=h446ed27_1
  - ucsc-fetchchromsizes=377=h446ed27_1
  - ucsc-genepredtobed=377=h446ed27_3
  - ucsc-gtftogenepred=377=h446ed27_3
  - ucsc-liftover=377=h446ed27_2
  - ucsc-oligomatch=377=h446ed27_1
  - ucsc-twobittofa=377=h446ed27_2
  - ucsc-wigtobigwig=377=h446ed27_1
  - urllib3=1.25.11=py_0
  - wcwidth=0.2.5=pyh9f0ad1d_2
  - wheel=0.35.1=pyh9f0ad1d_0
  - wrapt=1.12.1=py38h1e0a361_1
  - xopen=0.9.0=py38h32f6830_1
  - xorg-fixesproto=5.0=h14c3975_1002
  - xorg-inputproto=2.3.2=h14c3975_1002
  - xorg-kbproto=1.0.7=h14c3975_1002
  - xorg-libice=1.0.10=h516909a_0
  - xorg-libsm=1.2.3=h84519dc_1000
  - xorg-libx11=1.6.12=h516909a_0
  - xorg-libxau=1.0.9=h14c3975_0
  - xorg-libxdmcp=1.1.3=h516909a_0
  - xorg-libxext=1.3.4=h516909a_0
  - xorg-libxfixes=5.0.3=h516909a_1004
  - xorg-libxi=1.7.10=h516909a_0
  - xorg-libxrender=0.9.10=h516909a_1002
  - xorg-libxtst=1.2.3=h516909a_1002
  - xorg-recordproto=1.14.2=h516909a_1002
  - xorg-renderproto=0.11.1=h14c3975_1002
  - xorg-xextproto=7.3.0=h14c3975_1002
  - xorg-xproto=7.0.31=h14c3975_1007
  - xz=5.2.5=h516909a_1
  - yaml=0.2.5=h516909a_0
  - zipp=3.3.1=py_0
  - zlib=1.2.11=h516909a_1010
  - zstd=1.4.5=h6597ccf_2
prefix: /home/mira/lcdb-wf/myproj/env
```

#### 2. Snakemake 

- Reference: [Snakemake doc](https://snakemake.readthedocs.io/en/stable)

- **Without a configfile**


```Snakefile


__author__ = "Mira Sohn"
__copyright__ = "Copyright 2021, Mira Sohn"
__email__ = "tonton07@gmail.com"



# This workflow is designed to download fastq files from SRA database. 
# It's possible to perform manually as well (see https://github.com/Mira0507/using_SRA)

#################################### Defined by users #################################
SAMPLE=["SRR12626034", "SRR12626035"]    # Sets SRA ID
NAME=["A", "B"]                          # Sets sample names corresponding to each SRA 
#######################################################################################

DONE="etc/done.txt"
DELETED="etc/deleted.txt"


rule all: 
    input:
        DELETED

rule export_sratoolkit: 
    """
    This workflow uses pre-installed SRAtoolkit. Installation is newly needed, 
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


- **With a configfile** 


```Snakefile



__author__ = "Mira Sohn"
__copyright__ = "Copyright 2021, Mira Sohn"
__email__ = "tonton07@gmail.com"



# This workflow is designed to download fastq files from SRA database. 
# It's possible to perform manually as well (see https://github.com/Mira0507/using_SRA)

#################################### Defined by users #################################
configfile:"config.yaml"    # Sets path to the config file
#######################################################################################

DONE="etc/done.txt"
DELETED="etc/deleted.txt"


rule all: 
    input:
        DELETED

rule export_sratoolkit: 
    """
    This workflow uses pre-installed SRAtoolkit. Installation is newly needed, 
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
        for x in config["SAMPLE"]:
           shell("prefetch {x} > {log}") 

rule get_fastq: 
    """
    This rule converts SRA to FASTQ files
    """
    input:
       "etc/done.txt" 
    output: 
        expand("fastq/{sample}_1.fastq", sample=config["SAMPLE"])
    run:
        for x in config["SAMPLE"]:
            shell("fastq-dump --split-files {x}/{x}.sra --outdir fastq")

rule gzip_fastq:
    """
    This rule compresses FASTQ files using gzip
    """
    input: 
        expand("fastq/{sample}_1.fastq", sample=config["SAMPLE"])    
    output: 
        expand("fastq/{sample}_1.fastq.gz", sample=config["SAMPLE"]) 
    shell:
        "gzip {input}"

rule name_fastq:
    """
    This rule renames fastq.gz files from the SRR to Sample names
    """
    input: 
        expand("fastq/{sample}_1.fastq.gz", sample=config["SAMPLE"]) 
    output: 
        expand("fastq/{name}.fastq.gz", name=config["NAME"])
    run:
        for i in range(len(config["NAME"])):
            FROM=config["SAMPLE"][i]
            TO=config["NAME"][i]
            shell("mv fastq/{FROM}_1.fastq.gz fastq/{TO}.fastq.gz")

rule clean_rsa: 
    """
    This rule deletes the raw SRA files 
    """
    input: 
        expand("fastq/{name}.fastq.gz", name=config["NAME"])
    output: 
        touch(DELETED)
    run:
        for x in config["SAMPLE"]:
            shell("rm {x}/*.sra")
            shell("rm -d {x}")


```

- config.yaml 


```yaml

SAMPLE:
  - 'SRR12626034'
  - 'SRR12626042'

NAME:
  - 'C'
  - 'D'

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


# The dot commend requires graphviz (downloadable via conda)
snakemake --dag | dot -Tpdf > dag.pdf

```


- **Run**


```bash
#!bin/bash

# Either -j or --cores assignes the number of cores
snakemake -j 8

```
