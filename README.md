RNAcmap
===============

A docker image containing the fully configured RNAcmap predictor:

SYSTEM REQUIREMENTS
====
Hardware Requirments:
----
RNAcmap predictor requires only a standard computer with around 32 GB RAM to support the in-memory operations for RNAs sequence length less than 500.

Software Requirments:
----

Please install docker engine and download NCBI's nt database from the links shown belows:

* [Docker](https://docs.docker.com/engine/installation/)
* [NCBI's nucleotide database](ftp://ftp.ncbi.nlm.nih.gov/blast/db/FASTA/nt.gz)

Please unzip the downloaded nt database. Make sure you have enough space on system as it of size around 270 GBs

After docker installation and nt database downlaod, RNAcmap is good to run.

Usage
-------------------

To run RNAcmap, you need provide path to the input sequence file and nt database to the Docker container. Therefore, you have to mount the file system of your computer (the host) in the Docker container (the guest). For prediction, please run the following command by replacing 'path\_to\_directory\_with\_input\_sequence\_file' with absolute path to directory contains input sequence fasta file and 'path\_to\_directory\_with\_nt\_database\_file' with absolute path to directory contains nt database file in the following command:

```
docker run --rm -ti -v path_to_directory_with_input_sequence_file/:/mnt -v path_to_directory_with_nt_database_file/:/nt_database jaswindersingh2/RNAcmap RNAcmap mnt/sequences.fasta RNAfold GREMLIN
```

Above command saves predicted secondary structure files (.ct, .bpseq, .prob etc) in the 'outputs' folder within the directory 'path\_to\_directory\_with\_input\_sequence\_file'.

Usage Example
------------------

If you setup file system on your computer as follows:

```
home # cd ~/
|
|___user_name # mkdir RNAcmap_data && cd RNAcmap
    |
    |___RNAcmap_data # mkdir inputs database outputs
       |
       |___inputs # copy your input sequence file (say seq.fasta) in this directory 
           |
           |___seq.fasta # must in the fasta format with *.fasta extension.
           |.......
       | 
       |___database # copy the nt database file name nt (don't rename) in this directory
           |
           |___nt 
       |
       |___outputs

```

then, the following command can be used for the prediction with only replacing 'user_name' with actual user on the system:

```
docker run --rm -ti -v /home/user_name/RNAcmap_data/database/:/nt_database -v /home/user_name/rnacmap_data/inputs/:/mnt jaswindersingh2/rnacmap:v1 RNAcmap mnt/seq.fasta RNAfold GRMLIN
```
