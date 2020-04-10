FROM debian:bullseye
LABEL maintainer="cslev <cslev@gmx.com>, HimanshuSinghGH <heman.sam@gmail.com>"

#packages needed for compilation
ENV DEPS  net-tools\
          wget \
          libssl-dev \
          tcpdump \
          cmake \
          make \
          gcc \
          g++ \
          libpcap-dev \
          flex \
          bison \
          zlib1g-dev \
          python3 \
          python-dev \
          swig \
          libmaxminddb-dev \
          sendmail

COPY source /zeek
WORKDIR /zeek
SHELL ["/bin/bash", "-c"]
RUN apt-get update && \
    apt-get install -y --no-install-recommends $DEPS && \
    tar -xzf zeek-3.1.1.tar.gz && \
    cd zeek-3.1.1/ && \
    ./configure && \
    make -j2 && \
    make install && \
    cd /zeek && \
    apt-get autoremove --purge -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    cp bashrc_template /root/.bashrc && \
    source /root/.bashrc

ENTRYPOINT ["bash"]
