SPOT-RNA
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
* [NCBI's nucleotide database](ftp://ftp.ncbi.nlm.nih.gov/blast/db/FASTA/nt.gz) (unzip the downloaded file; size = 270 GBs)

After docker installation and nt database downlaod, RNAcmap is good to run.

Usage
-------------------

To run RNAcmap, you need provide path to the input sequence file and nt database to the Docker container. Therefore, you have to mount the file system of your computer (the host) in the Docker container (the guest). For prediction, please run the following command by replacing 'path\_to\_directory\_with\_input\_sequence\_file' with absolute path to directory contains input sequence fasta file and 'path\_to\_directory\_with\_nt\_database\_file' with absolute path to directory contains nt database file in the following command:

```
docker run --rm -ti -v path\_to\_directory\_with\_input\_sequence\_file/:/mnt -v path\_to\_directory\_with\_nt\_database\_file/:/nt\_database jaswindersingh2/RNAcmap RNAcmap mnt/sequences.fasta RNAfold GREMLIN
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
        |   |
        |   |___seq.fasta # must in the fasta format with *.fasta extension.
        |
		|___database # copy the nt database file name nt (don't rename) in this directory
		|	|
		|	|___nt 
		|
		|___outputs
```

then, the following command can be used for the prediction with only replacing 'user_name' with actual user on the system:

```
docker run --rm -ti -v /home/user\_name/RNAcmap\_data/database/:/nt\_database -v /home/user\_name/rnacmap\_data/inputs/:/mnt jaswindersingh2/rnacmap:v1 RNAcmap mnt/seq.fasta RNAfold GRMLIN
```
