FROM debian:stable
ENV DEBIAN_FRONTEND noninteractive

MAINTAINER Richard Lincoln, r.w.lincoln@gmail.com

RUN apt-get update
RUN apt-get install -y libc6-i386 bzip2 wget python unzip git

# NaCl SDK
RUN wget --no-verbose http://storage.googleapis.com/nativeclient-mirror/nacl/nacl_sdk/nacl_sdk.zip
RUN unzip nacl_sdk.zip
RUN ./nacl_sdk/naclsdk install pepper_40
ENV NACL_SDK_ROOT /nacl_sdk/pepper_40

# NaCl Ports
#RUN mkdir naclports && cd naclports
RUN git clone https://chromium.googlesource.com/external/naclports.git
ENV PATH /naclports/bin:$PATH
RUN ./bin/naclports --toolchain=pnacl --arch=pnacl -v install zlib



#RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
#ENV PATH `pwd`/depot_tools:"$PATH"
#RUN mkdir naclports && cd naclports
#RUN gclient config --name=src  https://chromium.googlesource.com/external/naclports.git
#RUN gclient sync
#ENV PATH `pwd`/src/bin:"$PATH"
