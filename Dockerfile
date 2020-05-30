FROM ubuntu:18.04
MAINTAINER Jaswinder Singh (jaswinder.singh3@griffithuni.edu.au)
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update && apt-get install -y build-essential wget virtualenv git python-minimal


RUN wget -c 'https://www.dropbox.com/s/byy719p07ct03gg/RNAcmap.tar.gz' && tar -xvzf RNAcmap.tar.gz && rm RNAcmap.tar.gz && mkdir nt_database
WORKDIR RNAcmap

RUN wget -c 'eddylab.org/infernal/infernal-1.1.3-linux-intel-gcc.tar.gz' && tar -xvzf infernal-*.tar.gz && rm infernal-*.tar.gz
RUN wget -c 'ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.10.0+-x64-linux.tar.gz' && tar -xvzf ncbi-blast-2.10.0+-x64-linux.tar.gz && rm ncbi-blast-2.10.0+-x64-linux.tar.gz

RUN wget -c 'https://www.tbi.univie.ac.at/RNA/download/sourcecode/2_4_x/ViennaRNA-2.4.14.tar.gz' && tar -zxvf ViennaRNA-2.4.14.tar.gz && rm ViennaRNA-2.4.14.tar.gz
RUN cd ViennaRNA-2.4.14 && ./configure --prefix=/RNAcmap/RNAfold && make && make install && cd /RNAcmap && rm -r ViennaRNA-2.4.14

RUN git clone https://github.com/jaswindersingh2/SPOT-RNA.git && cd SPOT-RNA && wget -c 'https://www.dropbox.com/s/dsrcf460nbjqpxa/SPOT-RNA-models.tar.gz' || wget -O SPOT-RNA-models.tar.gz 'https://app.nihaocloud.com/f/fbf3315a91d542c0bdc2/?dl=1' && tar -xvzf SPOT-RNA-models.tar.gz && rm SPOT-RNA-models.tar.gz && cd /RNAcmap

RUN virtualenv -p python3.6 venv3_rnacmap && source ./venv3_rnacmap/bin/activate &&  pip install tensorflow==1.14.0 && pip install -r requirements.txt && deactivate

RUN git clone 'https://github.com/sokrypton/GREMLIN_CPP' && cd GREMLIN_CPP && g++ -O3 -std=c++0x -o gremlin_cpp gremlin_cpp.cpp -fopenmp && cd /RNAcmap
RUN git clone 'https://github.com/debbiemarkslab/plmc' && cd plmc && make all-openmp && cd /RNAcmap

RUN virtualenv -p python2.7 venv2_rnacmap && source ./venv2_rnacmap/bin/activate &&  pip install numpy && deactivate

RUN chmod -R 777 RNAcmap && cp ./RNAcmap /usr/bin/ 
WORKDIR /

