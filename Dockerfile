FROM ubuntu:latest
RUN apt-get update \
    && apt-get install -y wget \
    && apt-get install -y unzip \
    && mkdir /usr/local/proj \
    && mkdir /usr/local/proj/mods \
    && wget -P /usr/local/proj "https://maven.minecraftforge.net/net/minecraftforge/forge/1.19.2-43.2.23/forge-1.19.2-43.2.23-mdk.zip" \
    && unzip /usr/local/proj/forge-1.19.2-43.2.23-mdk.zip -d /usr/local/proj \
    && rm /usr/local/proj/forge-1.19.2-43.2.23-mdk.zip \
    && wget -P /usr/local "https://download.oracle.com/java/17/archive/jdk-17.0.9_linux-x64_bin.deb" \
    && dpkg -i /usr/local/jdk-17.0.9_linux-x64_bin.deb \
    && apt-get install -f -y \
    && rm /usr/local/jdk-17.0.9_linux-x64_bin.deb

WORKDIR /usr/local/proj
RUN ./gradlew build
# Keep container running (for use in VSCode)
CMD [ "tail", "-f", "/dev/null" ]