FROM ubuntu:bionic

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install wget \
                    libstdc++6:i386 \
                    libgcc1:i386 \
                    libcurl4-gnutls-dev:i386 -y

RUN mkdir /steamcmd
WORKDIR /steamcmd
RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
RUN tar -xvzf steamcmd_linux.tar.gz && rm steamcmd_linux.tar.gz
