FROM debian:testing
ENV DEBIAN_FRONTEND noninteractive

MAINTAINER Richard Lincoln, r.w.lincoln@gmail.com

RUN apt-get update
RUN apt-get install -y libc6-i386 lib32stdc++6 bzip2 wget python python-dev unzip git curl python-pip

RUN git config --global user.email "r.w.lincoln@gmail.com"
RUN git config --global user.name "Richard Lincoln"

# NaCl SDK
RUN wget --no-verbose http://storage.googleapis.com/nativeclient-mirror/nacl/nacl_sdk/nacl_sdk.zip
RUN unzip nacl_sdk.zip
RUN ./nacl_sdk/naclsdk install pepper_40
ENV NACL_SDK_ROOT /nacl_sdk/pepper_40

# NaCl Ports
#RUN git clone https://chromium.googlesource.com/external/naclports.git
#ENV PATH /naclports/bin:$PATH


RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
ENV PATH /depot_tools:$PATH

RUN mkdir /naclports
WORKDIR /naclports
RUN gclient config --name=src https://chromium.googlesource.com/external/naclports.git
RUN gclient sync
WORKDIR /naclports/src
RUN git checkout -b pepper_40 origin/pepper_40
ENV PATH /naclports/src/bin:$PATH

EXPOSE 5103

#RUN naclports --toolchain=pnacl --arch=pnacl -v install bzip2
