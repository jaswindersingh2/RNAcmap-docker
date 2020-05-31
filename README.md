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

Please install docker engine for any given OS and distro as follows:

* Docker-Linux-Platforms: [Ubuntu](https://docs.docker.com/engine/install/ubuntu/), [Centos](https://docs.docker.com/engine/install/centos/), [Debian](https://docs.docker.com/engine/install/debian/), [Fedora](https://docs.docker.com/engine/install/fedora/)
* Docker-Mac[https://docs.docker.com/docker-for-mac/install/]
* Docker-Windows[https://docs.docker.com/docker-for-windows/install/]

In additions, need to download NCBI's nt database file from the links shown belows:

* [NCBI's nucleotide database](ftp://ftp.ncbi.nlm.nih.gov/blast/db/FASTA/)

Download the file 'nt.gz' from the link above and unzip without renaming it. Make sure, your system have enough space as it is of size around 270 GBs after unzip.

After docker installation and nt database downlaod, RNAcmap is good to run.

Installation Instructions
====
Docker can be easily installed for Windows and Mac OS by downloading and running '.exe' and '.dmg' file from the link mentioned above. For Linux, the following steps can used to install docker for Ubuntu Linux distro as follows:

```
sudo apt-get remove docker docker-engine docker.io containerd runc
```  

```
sudo apt-get update
```

```
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
```

```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

```
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```

```
sudo apt-get update
```

```
sudo apt-get install docker-ce docker-ce-cli containerd.io
```

```
sudo groupadd docker && sudo usermod -aG docker $USER
```

To brings changes into effect, you need to logout and then login to your system.

To verify the correct installation, you can run the following command:
```
docker run hello-world
```
The output of above should give message about correct installation.

To install docker for other Linux distro, please follows the steps mentioned in the links provided above.

Usage
-------------------

To run RNAcmap, you need provide path to the input sequence file and nt database to the Docker container. Therefore, you have to mount the file system of your computer (the host) in the Docker container (the guest). For prediction, please run the following command by replacing 'path\_to\_directory\_with\_input\_sequence\_file' with absolute path to directory contains input sequence fasta file and 'path\_to\_directory\_with\_nt\_database\_file' with absolute path to directory contains nt database file in the following command:

```
docker run --rm -ti -v path_to_directory_with_input_sequence_file/:/mnt -v path_to_directory_with_nt_database_file/:/nt_database jaswindersingh2/rnacmap RNAcmap mnt/sequences.fasta RNAfold GREMLIN
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
docker run --rm -ti -v /home/$USER/RNAcmap_data/database/:/nt_database -v /home/$USER/rnacmap_data/inputs/:/mnt jaswindersingh2/rnacmap:v1 RNAcmap mnt/seq.fasta RNAfold GRMLIN
```
