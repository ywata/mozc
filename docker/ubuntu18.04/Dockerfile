# Copyright 2017-2018 coooooooozy
# All rights reserved.
# http://docs.docker.jp/engine/userguide/eng-image/dockerfile_best-practice.html

FROM ubuntu:18.04

RUN apt-get -y update \
 && apt-get -y upgrade

## Generate locale
ARG lang="ja_JP.UTF-8"
RUN apt-get update  -y \
 && apt-get install -y --no-install-recommends \
    language-pack-ja \
    language-pack-ja-base
RUN locale-gen en_US.UTF-8 \
 && locale-gen ja_JP.UTF-8 \
 && locale-gen $LANG
RUN /usr/sbin/update-locale LANG=$LANG

## Common packages for linux
RUN apt-get update  -y \
 && apt-get install -y --no-install-recommends \
    apt-transport-https \
    apt-utils \
    bzip2 \
    clang \
    curl \
    fonts-noto-cjk \
    git \
    libboost-all-dev \
    make \
    nano \
    ninja-build \
    nkf \
    pkg-config \
    python \
    rsync \
    ruby \
    software-properties-common \
    unzip \
    wget

## Packages for linux desktop
RUN apt-get update  -y \
 && apt-get install -y --no-install-recommends \
    libglib2.0-dev \
    libgtk2.0-dev \
    libibus-1.0-dev \
    libxcb-xfixes0-dev \
    qtbase5-dev

## Packages for Android
RUN apt-get update  -y \
 && apt-get install -y --no-install-recommends \
    lib32z1 \
    lib32ncurses5 \
    lib32stdc++6 \
    libc6-i386 \
    libjsr305-java zip \
    openjdk-8-jdk \
    openjdk-8-jre-headless

## Android Studio
## https://developer.android.com/studio/
RUN add-apt-repository ppa:maarten-fonville/android-studio -y \
 && apt-get update  -y \
 && apt-get install -y --no-install-recommends \
    android-studio
ENV PATH $PATH:/opt/android-studio/bin

## Visual Source Code
RUN curl https://packages.microsoft.com/keys/microsoft.asc \
    | gpg --dearmor \
    > /tmp/microsoft.gpg
RUN install -o root -g root -m 644 \
    /tmp/microsoft.gpg \
    /etc/apt/trusted.gpg.d/
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" \
    > /etc/apt/sources.list.d/vscode.list
RUN apt-get update  -y  \
 && apt-get install -y --no-install-recommends \
    code

## Finalize software.
RUN apt-get -y update \
 && apt-get -y upgrade \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Setup build user
ENV HOME /home/builder
ARG uid=0
ARG gid=0
RUN groupadd -g ${gid} craft
RUN useradd -u ${uid} --create-home \
    --shell /bin/bash \
    --base-dir /home builder \
    -G craft

USER root

# Ignore root
RUN usermod -L root

## Setup develop environment
USER builder

WORKDIR /home/builder
RUN mkdir -p /home/builder
VOLUME  homevolume:/home/builder
RUN mkdir -p /home/builder/workshop
VOLUME  workvolume:/home/builder/workshop
ENV HOME /home/builder

## Android SDK/NDK
## Install sdkmanager and tools
## https://developer.android.com/studio/index.html?hl=en#downloads
## https://developer.android.com/studio/command-line/sdkmanager.html

RUN mkdir -p /home/builder/Android/Sdk/ndk-bundle
ENV ANDROID_HOME /home/builder/Android/Sdk
ENV ANDROID_NDK_HOME ${ANDROID_HOME}/ndk-bundle
ENV PATH $PATH:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/build-tools/29.0.2:${ANDROID_NDK_HOME}

RUN wget  -O sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip \
 && unzip -o -d $ANDROID_HOME sdk.zip \
 && rm sdk.zip
RUN mkdir -p $ANDROID_HOME/licenses \
 && echo 8933bad161af4178b1185d1a37fbf41ea5269c55 >  $ANDROID_HOME/licenses/android-sdk-license \
 && echo d56f5187479451eabf01fb78af6dfcb131a6481e >> $ANDROID_HOME/licenses/android-sdk-license
RUN mkdir -p ~/.android
RUN touch ~/.android/repositories.cfg
RUN echo y | sdkmanager --verbose "platform-tools"
RUN echo y | sdkmanager --verbose "ndk-bundle"
RUN echo y | sdkmanager --verbose "extras;android;m2repository"
RUN echo y | sdkmanager --verbose "extras;google;google_play_services"
RUN echo y | sdkmanager --verbose "extras;google;m2repository"
RUN echo y | sdkmanager --verbose "cmake;3.10.2.4988404"
RUN echo y | sdkmanager --verbose "lldb;3.1"
RUN echo y | sdkmanager --verbose "patcher;v4"
RUN echo y | sdkmanager --verbose "emulator"
RUN echo y | sdkmanager --verbose "docs"
RUN echo y | sdkmanager --verbose "platforms;android-29"
RUN echo y | sdkmanager --verbose "build-tools;29.0.2"
RUN echo y | sdkmanager --verbose "sources;android-29"
RUN echo y | sdkmanager --update

## Visual Studio Code
## Install Extensions
RUN code --install-extension ms-vscode.cpptools
RUN code --install-extension twxs.cmake
RUN code --install-extension vector-of-bool.cmake-tools
RUN code --install-extension mhutchie.git-graph
RUN code --install-extension donjayamanne.githistory
RUN code --install-extension ms-ceintl.vscode-language-pack-ja
RUN code --install-extension webfreak.debug
RUN code --install-extension donjayamanne.python-extension-pack
RUN code --install-extension ms-azuretools.vscode-docker


WORKDIR /home/builder/workshop

## Clone Kurage source with submodules
RUN if [ -z "`ls $DIR`" ]; then \
        git clone \
            https://github.com/TinyFort/Kurage.git \
            . \
            -b master \
            --single-branch \
            --recursive \
            ; \
    fi

RUN code --add /home/builder/workshop

CMD bash
