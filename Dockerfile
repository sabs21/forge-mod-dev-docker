FROM ubuntu:latest
ARG MC_VERSION
ARG FORGE_VERSION
ARG REPO
RUN apt-get update \
    && apt-get install -y wget \
    && wget -P /usr/local "https://download.oracle.com/java/17/archive/jdk-17.0.9_linux-x64_bin.deb" \
    && dpkg -i /usr/local/jdk-17.0.9_linux-x64_bin.deb \
    && apt-get install -f -y \
    && rm /usr/local/jdk-17.0.9_linux-x64_bin.deb \
    && apt-get install -y git \
    && apt-get install -y openssh-client
RUN --mount=type=ssh if test -n "$REPO" ; then \
    mkdir -p -m 0400 ~/.ssh \
    && ssh-keyscan github.com >> ~/.ssh/known_hosts \
    && git clone $REPO /usr/local/proj/ ;\
    else \
    mkdir /usr/local/proj \
    && apt-get install -y unzip \
    && wget -P /usr/local/proj "https://maven.minecraftforge.net/net/minecraftforge/forge/$MC_VERSION-$FORGE_VERSION/forge-$MC_VERSION-$FORGE_VERSION-mdk.zip" \
    && unzip /usr/local/proj/forge-$MC_VERSION-$FORGE_VERSION-mdk.zip -d /usr/local/proj \
    && rm /usr/local/proj/forge-$MC_VERSION-$FORGE_VERSION-mdk.zip ; \
    fi
WORKDIR /usr/local/proj
RUN if test -f ./gradlew ; then \
    ./gradlew build ;\
    fi
# Keep container running (for use in VSCode)
CMD [ "tail", "-f", "/dev/null" ]