# Copyright (c) 2020, jalbiero, all rights reserved.
#
# The MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.


################################################################################
FROM ubuntu:18.04 as EosBuild
ARG deps_dir=.

RUN apt-get update && \ 
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        autoconf \
        automake \
        autotools-dev \
        bzip2 \
        clang \
        cmake \
        curl \
        doxygen \
        git \
        gnupg \
        graphviz \
        libbz2-dev \
        libcurl4-gnutls-dev \
        libgmp3-dev \
        libicu-dev \
        libssl-dev \
        libtool \
        libusb-1.0-0-dev \
        llvm-7-dev \
        lsb-release \
        make \
        patch \
        pkg-config \
        python2.7 \
        python2.7-dev \
        python3 \
        python3-dev \
        ruby \
        sudo \
        zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

COPY ${deps_dir}/eos /usr/local/src/eos
WORKDIR /usr/local/src/eos
    
RUN ./scripts/eosio_build.sh -i /usr/local/eos && \
    build/unittests/unit_test --show_progress && \
    ./scripts/eosio_install.sh

################################################################################
FROM ubuntu:18.04
ARG deps_dir=.
ARG cdt_file

# EOS (installation and some test dependencies)
COPY --from=EosBuild /usr/local/eos /usr/local/eos

COPY --from=EosBuild /usr/local/src/eos/build/unittests/contracts \
                     /usr/local/src/eos/build/unittests/contracts
                     
COPY --from=EosBuild /usr/local/src/eos/build/unittests/snapshots \
                     /usr/local/src/eos/build/unittests/snapshots

# CDT
WORKDIR /tmp/eos-install
COPY ${deps_dir}/${cdt_file} ./
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install ./${cdt_file}

# Extra deps (native compiler among others)
RUN apt-get update && \ 
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        clang-7 clang-tools-7 libclang-common-7-dev libclang-7-dev libclang1-7 \
        git \
        libgmp3-dev \
        libssl-dev \
        lldb-7 \
        llvm-7-dev \
        make \
        cmake \
        mc \
        vim \
        zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/clang   clang   /usr/bin/clang-7   30 && \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-7 30 && \
    update-alternatives --install /usr/bin/lldb    lldb    /usr/bin/lldb-7    30

# Lots of differents variables pointing to the same locations due
# to backward compatibility across several versions
ENV EOSIO_ROOT=/usr/local/eos
ENV EOSIO_INSTALL_DIR="${EOSIO_ROOT}"
ENV EOSIO_INSTALL_PREFIX="${EOSIO_ROOT}"
ENV EOS_HOME="${EOSIO_ROOT}"
ENV BOOST_ROOT="${EOSIO_ROOT}/src/boost_1_71_0" 
ENV LD_LIBRARY_PATH="${BOOST_ROOT}/lib:${LD_LIBRARY_PATH}"
ENV PATH="${EOSIO_ROOT}/bin:${PATH}"
ENV CC=clang
ENV CXX=clang++
ENV CTEST_OUTPUT_ON_FAILURE=1
ENV EOSIO_CONTRACTS="/usr/local/src/eos/build/unittests/contracts"


WORKDIR /

