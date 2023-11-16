FROM ubuntu:latest
RUN apt-get update \
    && apt-get install -y wget \
    && apt-get install -y unzip \
    && mkdir /usr/local/proj \
    && wget -P /usr/local/proj "https://maven.minecraftforge.net/net/minecraftforge/forge/$MC_VERSION-$FORGE_VERSION/forge-$MC_VERSION-$FORGE_VERSION-mdk.zip" \
    && unzip /usr/local/proj/forge-$MC_VERSION-$FORGE_VERSION-mdk.zip -d /usr/local/proj \
    && rm /usr/local/proj/forge-$MC_VERSION-$FORGE_VERSION-mdk.zip \
    && wget -P /usr/local "https://download.oracle.com/java/17/archive/jdk-17.0.9_linux-x64_bin.deb" \
    && dpkg -i /usr/local/jdk-17.0.9_linux-x64_bin.deb \
    && apt-get install -f -y \
    && rm /usr/local/jdk-17.0.9_linux-x64_bin.deb

WORKDIR /usr/local/proj
RUN ./gradlew build
# Keep container running (for use in VSCode)
CMD [ "tail", "-f", "/dev/null" ]