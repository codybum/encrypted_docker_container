FROM ubuntu:14.04
RUN apt-get -y install cryptsetup
COPY create_crypt.sh /mnt/create_crypt.sh 
