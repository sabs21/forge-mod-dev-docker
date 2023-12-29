FROM ubuntu:latest
ARG MC_VERSION
ARG FORGE_VERSION
ARG REPO
ENV HOME /usr/local/proj

RUN apt-get update
RUN apt-get install -y wget \
    && wget -P /usr/local "https://download.oracle.com/java/17/archive/jdk-17.0.9_linux-x64_bin.deb" \
    && dpkg -i /usr/local/jdk-17.0.9_linux-x64_bin.deb \
    && apt-get install -f -y \
    && rm /usr/local/jdk-17.0.9_linux-x64_bin.deb
RUN mkdir $HOME \
    && apt-get install -y unzip \
    && wget -P $HOME "https://maven.minecraftforge.net/net/minecraftforge/forge/$MC_VERSION-$FORGE_VERSION/forge-$MC_VERSION-$FORGE_VERSION-mdk.zip" \
    && unzip $HOME/forge-$MC_VERSION-$FORGE_VERSION-mdk.zip -d $HOME \
    && rm $HOME/forge-$MC_VERSION-$FORGE_VERSION-mdk.zip ;
WORKDIR $HOME
# Keep container running (for use in VSCode)
CMD [ "tail", "-f", "/dev/null" ]