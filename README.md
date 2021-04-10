## Getting FASTQ files from NCBI SRA database using Snakemake 

### This workflow demonstrates an example of reproducible and automated workflow getting FASTQ files (single-ended) from SRA database


#### 1. Conda Environment 

- Reference: [Conda doc](https://docs.conda.io/projects/conda/en/latest/index.html), [lcdb-wf doc](https://lcdb.github.io/lcdb-wf)



```yml
name: snakemake_sra
channels:
  - conda-forge
  - bioconda
  - defaults
dependencies:
  - _libgcc_mutex=0.1=conda_forge
  - _openmp_mutex=4.5=1_gnu
  - aiohttp=3.7.4=py38h497a2fe_0
  - amply=0.1.4=py_0
  - appdirs=1.4.4=pyh9f0ad1d_0
  - async-timeout=3.0.1=py_1000
  - atk-1.0=2.36.0=h3371d22_4
  - attrs=20.3.0=pyhd3deb0d_0
  - azure-common=1.1.27=pyhd8ed1ab_0
  - azure-core=1.12.0=pyhd8ed1ab_0
  - azure-storage-blob=12.8.0=pyhd8ed1ab_0
  - blinker=1.4=py_1
  - boto=2.49.0=py_0
  - boto3=1.17.49=pyhd8ed1ab_0
  - botocore=1.20.49=pyhd8ed1ab_0
  - brotlipy=0.7.0=py38h497a2fe_1001
  - c-ares=1.17.1=h7f98852_1
  - ca-certificates=2020.12.5=ha878542_0
  - cachetools=4.2.1=pyhd8ed1ab_0
  - cairo=1.16.0=h6cf1ce9_1008
  - certifi=2020.12.5=py38h578d9bd_1
  - cffi=1.14.5=py38ha65f79e_0
  - chardet=4.0.0=py38h578d9bd_1
  - coincbc=2.10.5=hcee13e7_1
  - configargparse=1.4=pyhd8ed1ab_0
  - cryptography=3.4.7=py38ha5dfef3_0
  - curl=7.76.0=h979ede3_0
  - datrie=0.8.2=py38h1e0a361_1
  - docutils=0.17=py38h578d9bd_0
  - expat=2.3.0=h9c3ff4c_0
  - filelock=3.0.12=pyh9f0ad1d_0
  - font-ttf-dejavu-sans-mono=2.37=hab24e00_0
  - font-ttf-inconsolata=2.001=hab24e00_0
  - font-ttf-source-code-pro=2.030=hab24e00_0
  - font-ttf-ubuntu=0.83=hab24e00_0
  - fontconfig=2.13.1=hba837de_1004
  - fonts-conda-ecosystem=1=0
  - fonts-conda-forge=1=0
  - freetype=2.10.4=h0708190_1
  - fribidi=1.0.10=h36c2ea0_0
  - gdk-pixbuf=2.42.6=h04a7f16_0
  - gettext=0.19.8.1=h0b5b191_1005
  - giflib=5.2.1=h36c2ea0_2
  - gitdb=4.0.7=pyhd8ed1ab_0
  - gitpython=3.1.14=pyhd8ed1ab_0
  - google-api-core=1.26.2=pyhd8ed1ab_0
  - google-auth=1.28.0=pyh44b312d_0
  - google-cloud-core=1.5.0=pyhd3deb0d_0
  - google-cloud-storage=1.35.1=pyh44b312d_0
  - google-crc32c=1.1.2=py38h8838a9a_0
  - google-resumable-media=1.2.0=pyhd3deb0d_0
  - googleapis-common-protos=1.53.0=py38h578d9bd_0
  - graphite2=1.3.13=h58526e2_1001
  - graphviz=2.47.0=he056042_1
  - grpcio=1.37.0=py38hdd6454d_0
  - gtk2=2.24.33=hab0c2f8_0
  - gts=0.7.6=h64030ff_2
  - harfbuzz=2.8.0=h83ec7ef_1
  - hdf5=1.10.5=nompi_h5b725eb_1114
  - icu=68.1=h58526e2_0
  - idna=2.10=pyh9f0ad1d_0
  - importlib-metadata=3.10.0=py38h578d9bd_0
  - importlib_metadata=3.10.0=hd8ed1ab_0
  - ipython_genutils=0.2.0=py_1
  - isodate=0.6.0=py_1
  - jmespath=0.10.0=pyh9f0ad1d_0
  - jpeg=9d=h36c2ea0_0
  - jsonschema=3.2.0=py38h32f6830_1
  - jupyter_core=4.7.1=py38h578d9bd_0
  - krb5=1.17.2=h926e7f8_0
  - ld_impl_linux-64=2.35.1=hea4e1c9_2
  - libblas=3.9.0=8_openblas
  - libcblas=3.9.0=8_openblas
  - libcrc32c=1.1.1=he1b5a44_2
  - libcurl=7.76.0=hc4aaa36_0
  - libedit=3.1.20191231=he28a2e2_2
  - libev=4.33=h516909a_1
  - libffi=3.3=h58526e2_2
  - libgcc-ng=9.3.0=h2828fa1_18
  - libgd=2.3.2=h78a0170_0
  - libgfortran-ng=9.3.0=hff62375_18
  - libgfortran5=9.3.0=hff62375_18
  - libglib=2.68.1=h3e27bee_0
  - libgomp=9.3.0=h2828fa1_18
  - libiconv=1.16=h516909a_0
  - liblapack=3.9.0=8_openblas
  - libnghttp2=1.43.0=h812cca2_0
  - libopenblas=0.3.12=pthreads_h4812303_1
  - libpng=1.6.37=h21135ba_2
  - libprotobuf=3.15.7=h780b84a_0
  - librsvg=2.50.3=hfa39831_1
  - libssh2=1.9.0=ha56f1ee_6
  - libstdcxx-ng=9.3.0=h6de172a_18
  - libtiff=4.2.0=hdc55705_0
  - libtool=2.4.6=h58526e2_1007
  - libuuid=2.32.1=h7f98852_1000
  - libwebp=1.2.0=h3452ae3_0
  - libwebp-base=1.2.0=h7f98852_2
  - libxcb=1.13=h7f98852_1003
  - libxml2=2.9.10=h72842e0_3
  - lz4-c=1.9.3=h9c3ff4c_0
  - msrest=0.6.21=pyh44b312d_0
  - multidict=5.1.0=py38h497a2fe_1
  - nbformat=5.1.3=pyhd8ed1ab_0
  - ncbi-ngs-sdk=2.11.0=hff44eed_0
  - ncurses=6.2=h58526e2_4
  - oauthlib=3.0.1=py_0
  - openssl=1.1.1k=h7f98852_0
  - ossuuid=1.6.2=hf484d3e_1000
  - packaging=20.9=pyh44b312d_0
  - pango=1.42.4=h69149e4_5
  - pcre=8.44=he1b5a44_0
  - perl=5.26.2=h36c2ea0_1008
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
  - perl-mime-base64=3.15=pl526_1
  - perl-parent=0.236=pl526_1
  - perl-uri=1.76=pl526_0
  - perl-xml-libxml=2.0132=pl526h7ec2d77_1
  - perl-xml-namespacesupport=1.12=pl526_0
  - perl-xml-sax=1.02=pl526_0
  - perl-xml-sax-base=1.09=pl526_0
  - perl-xsloader=0.24=pl526_0
  - pip=21.0.1=pyhd8ed1ab_0
  - pixman=0.40.0=h36c2ea0_0
  - protobuf=3.15.7=py38h709712a_0
  - psutil=5.8.0=py38h497a2fe_1
  - pthread-stubs=0.4=h36c2ea0_1001
  - pulp=2.4=py38h578d9bd_0
  - pyasn1=0.4.8=py_0
  - pyasn1-modules=0.2.7=py_0
  - pycparser=2.20=pyh9f0ad1d_2
  - pyjwt=2.0.1=pyhd8ed1ab_1
  - pyopenssl=20.0.1=pyhd8ed1ab_0
  - pyparsing=2.4.7=pyh9f0ad1d_0
  - pyrsistent=0.17.3=py38h497a2fe_2
  - pysocks=1.7.1=py38h578d9bd_3
  - python=3.8.8=hffdb5ce_0_cpython
  - python-dateutil=2.8.1=py_0
  - python_abi=3.8=1_cp38
  - pytz=2021.1=pyhd8ed1ab_0
  - pyyaml=5.4.1=py38h497a2fe_0
  - ratelimiter=1.2.0=py38h32f6830_1001
  - readline=8.0=he28a2e2_2
  - requests=2.25.1=pyhd3deb0d_0
  - requests-oauthlib=1.3.0=pyh9f0ad1d_0
  - rsa=4.7.2=pyh44b312d_0
  - s3transfer=0.3.6=pyhd8ed1ab_0
  - setuptools=49.6.0=py38h578d9bd_3
  - six=1.15.0=pyh9f0ad1d_0
  - smart_open=5.0.0=pyhd8ed1ab_0
  - smmap=3.0.5=pyh44b312d_0
  - snakemake-minimal=6.1.1=pyhdfd78af_0
  - sqlite=3.35.4=h74cdb3f_0
  - sra-tools=2.10.9=pl526haddd2b5_0
  - tk=8.6.10=hed695b0_1
  - toposort=1.6=pyhd8ed1ab_0
  - traitlets=5.0.5=py_0
  - typing-extensions=3.7.4.3=0
  - typing_extensions=3.7.4.3=py_0
  - urllib3=1.26.4=pyhd8ed1ab_0
  - wheel=0.36.2=pyhd3deb0d_0
  - wrapt=1.12.1=py38h497a2fe_3
  - xorg-kbproto=1.0.7=h7f98852_1002
  - xorg-libice=1.0.10=h7f98852_0
  - xorg-libsm=1.2.3=hd9c2040_1000
  - xorg-libx11=1.7.0=h7f98852_0
  - xorg-libxau=1.0.9=h7f98852_0
  - xorg-libxdmcp=1.1.3=h7f98852_0
  - xorg-libxext=1.3.4=h7f98852_1
  - xorg-libxrender=0.9.10=h7f98852_1003
  - xorg-renderproto=0.11.1=h7f98852_1002
  - xorg-xextproto=7.3.0=h7f98852_1002
  - xorg-xproto=7.0.31=h7f98852_1007
  - xz=5.2.5=h516909a_1
  - yaml=0.2.5=h516909a_0
  - yarl=1.5.1=py38h1e0a361_0
  - zipp=3.4.1=pyhd8ed1ab_0
  - zlib=1.2.11=h516909a_1010
  - zstd=1.4.9=ha95c52a_0
prefix: /home/mira/miniconda3/envs/snakemake_sra

```

#### 2. Snakemake 

- Reference: [Snakemake doc](https://snakemake.readthedocs.io/en/stable)

- **Snakefile**

```Snakefile


__author__ = "Mira Sohn"
__copyright__ = "Copyright 2021, Mira Sohn"
__email__ = "tonton07@gmail.com"



# This workflow is designed to download fastq files from SRA database. 
# It's possible to perform manually as well (see https://github.com/Mira0507/using_SRA)

#################################### Defined by users #################################
configfile: "config/config.yaml"    # Sets path to the config file
#######################################################################################

rule all: 
    input: 
        expand("fastq/{name}.fastq.gz", name=config["NAME"])

rule get_sra: 
    """
    This rule downloads SRA files
    """
    output: 
        temp("fastq/{sample}/{sample}.sra")
    shell:
        "prefetch {wildcards.sample} -O fastq"




rule get_fastq: 
    """
    This rule converts SRA to FASTQ files
    """
    input:
       "fastq/{sample}/{sample}.sra" 
    output: 
        temp("fastq/{sample}_1.fastq")
    shell:
        "fastq-dump --split-files fastq/{wildcards.sample}/{wildcards.sample}.sra -O fastq"
        

rule gzip_fastq:
    """
    This rule compresses FASTQ files using gzip
    """
    input: 
        expand("fastq/{sample}_1.fastq", sample=config["SAMPLE"])
    output: 
        "fastq/{name}.fastq.gz"
    message:
        "Gzipping in progress"
    shell:
        "gzip -cv {input} > {output}"





```

- **config.yaml**


```yaml

SAMPLE:
  - 'SRR8757088'
  - 'SRR8757084'

NAME:
  - 'rep1'
  - 'rep2'
  

```



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
#!bin/bash

# Either -j or --cores assignes the number of cores
snakemake -j 8

```
