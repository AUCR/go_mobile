FROM golang:1.14

WORKDIR /go/src/drone

RUN apt-get update \
  && apt-get install openjdk-11-jdk unzip -y \
  && wget https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz \
  && tar -zxvf openjdk-11.0.2_linux-x64_bin.tar.gz \
  && rm openjdk-11.0.2_linux-x64_bin.tar.gz \
  && wget https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip \
  && mkdir Android \
  && mkdir Android/cmdline-tools \
  && unzip commandlinetools-linux-6609375_latest.zip \
  && mv tools Android/cmdline-tools \
  && rm commandlinetools-linux-6609375_latest.zip \
  && cd Android \
  && wget https://dl.google.com/android/repository/android-ndk-r21d-linux-x86_64.zip \
  && unzip android-ndk-r21d-linux-x86_64.zip \
  && rm android-ndk-r21d-linux-x86_64.zip \
  && mv android-ndk-r21d ndk-bundle \
  && apt-get purge unzip -y
ENV JAVA_HOME=/go/src/drone/openjdk-11.0.2_linux-x64_bin
ENV ANDROID_HOME=/go/src/drone/Android
RUN go get golang.org/x/mobile/cmd/gomobile \
  && gomobile init


