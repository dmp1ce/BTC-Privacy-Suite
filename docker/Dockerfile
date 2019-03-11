# Alpine build for tor + bitcoind + lnd

# Thank you to the following projects:
# https://github.com/enil/alpine-supervisord-docker
# https://github.com/ogarcia/docker-tor
# https://github.com/ruimarinho/docker-bitcoin-core
# https://github.com/comodal/lnd-docker

# Build stage for BerkeleyDB
FROM alpine as berkeleydb

RUN sed -i 's/http\:\/\/dl-cdn.alpinelinux.org/https\:\/\/alpine.global.ssl.fastly.net/g' /etc/apk/repositories
RUN apk --no-cache add autoconf
RUN apk --no-cache add automake
RUN apk --no-cache add build-base
RUN apk --no-cache add libressl

ENV BERKELEYDB_VERSION=db-4.8.30.NC
ENV BERKELEYDB_PREFIX=/opt/${BERKELEYDB_VERSION}

RUN wget https://download.oracle.com/berkeley-db/${BERKELEYDB_VERSION}.tar.gz
RUN tar -xzf *.tar.gz
RUN sed s/__atomic_compare_exchange/__atomic_compare_exchange_db/g -i ${BERKELEYDB_VERSION}/dbinc/atomic.h
RUN mkdir -p ${BERKELEYDB_PREFIX}

WORKDIR /${BERKELEYDB_VERSION}/build_unix

RUN ../dist/configure --enable-cxx --disable-shared --with-pic --prefix=${BERKELEYDB_PREFIX}
RUN make -j4
RUN make install
RUN rm -rf ${BERKELEYDB_PREFIX}/docs

# Build stage for Bitcoin Core
FROM alpine as bitcoin-core

COPY --from=berkeleydb /opt /opt

RUN sed -i 's/http\:\/\/dl-cdn.alpinelinux.org/https\:\/\/alpine.global.ssl.fastly.net/g' /etc/apk/repositories
RUN apk --no-cache add autoconf
RUN apk --no-cache add automake
RUN apk --no-cache add boost-dev
RUN apk --no-cache add build-base
RUN apk --no-cache add chrpath
RUN apk --no-cache add file
RUN apk --no-cache add gnupg
RUN apk --no-cache add libevent-dev
RUN apk --no-cache add libressl
RUN apk --no-cache add libressl-dev
RUN apk --no-cache add libtool
RUN apk --no-cache add linux-headers
RUN apk --no-cache add protobuf-dev
RUN apk --no-cache add zeromq-dev
RUN set -ex \
  && for key in \
    90C8019E36C2E964 \
  ; do \
    gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$key" || \
    gpg --batch --keyserver pgp.mit.edu --recv-keys "$key" || \
    gpg --batch --keyserver keyserver.pgp.com --recv-keys "$key" || \
    gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" || \
    gpg --batch --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" ; \
  done

ENV BITCOIN_VERSION=0.17.1
ENV BITCOIN_PREFIX=/opt/bitcoin-${BITCOIN_VERSION}

RUN wget https://bitcoin.org/bin/bitcoin-core-${BITCOIN_VERSION}/SHA256SUMS.asc
RUN wget https://bitcoin.org/bin/bitcoin-core-${BITCOIN_VERSION}/bitcoin-${BITCOIN_VERSION}.tar.gz
RUN gpg --verify SHA256SUMS.asc
RUN grep " bitcoin-${BITCOIN_VERSION}.tar.gz\$" SHA256SUMS.asc | sha256sum -c -
RUN tar -xzf *.tar.gz

WORKDIR /bitcoin-${BITCOIN_VERSION}

RUN sed -i '/AC_PREREQ/a\AR_FLAGS=cr' src/univalue/configure.ac
RUN sed -i '/AX_PROG_CC_FOR_BUILD/a\AR_FLAGS=cr' src/secp256k1/configure.ac
RUN sed -i s:sys/fcntl.h:fcntl.h: src/compat.h
RUN ./autogen.sh
RUN ./configure LDFLAGS=-L`ls -d /opt/db*`/lib/ CPPFLAGS=-I`ls -d /opt/db*`/include/ \
    --prefix=${BITCOIN_PREFIX} \
    --mandir=/usr/share/man \
    --disable-tests \
    --disable-bench \
    --disable-ccache \
    --with-gui=no \
    --with-utils \
    --with-libs \
    --with-daemon
RUN make -j4
RUN make install
RUN strip ${BITCOIN_PREFIX}/bin/bitcoin-cli
RUN strip ${BITCOIN_PREFIX}/bin/bitcoin-tx
RUN strip ${BITCOIN_PREFIX}/bin/bitcoind
RUN strip ${BITCOIN_PREFIX}/lib/libbitcoinconsensus.a
RUN strip ${BITCOIN_PREFIX}/lib/libbitcoinconsensus.so.0.0.0

# Build lnd
FROM golang:alpine as lnd_builder

ARG LND_RELEASE_TAG="v0.5.2-beta"

RUN set -x\
  && apk add --no-cache git build-base\
  && git clone -q --branch ${LND_RELEASE_TAG} --single-branch --depth 1\
     https://github.com/lightningnetwork/lnd\
     /go/src/github.com/lightningnetwork/lnd\
  && cd /go/src/github.com/lightningnetwork/lnd\
  && make\
  && make install

FROM alpine
MAINTAINER David Parrish <daveparrish@tutanota.com>

#ENV PYTHON_VERSION=2.7.12-r0
#ENV PY_PIP_VERSION=8.1.2-r0
#ENV SUPERVISOR_VERSION=3.3.1

ENV TOR_DATA=/var/lib/tor
ENV BITCOIN_DATA=/home/alice/.bitcoin
ENV BITCOIN_VERSION=0.17.1
ENV BITCOIN_PREFIX=/opt/bitcoin-${BITCOIN_VERSION}
ENV LOCAL_USER_ID=9001

COPY --from=lnd_builder /go/bin/lncli /usr/local/bin
COPY --from=lnd_builder /go/bin/lnd /usr/local/bin
COPY --from=bitcoin-core /opt /opt
COPY supervisord.conf /etc/supervisord.conf
COPY entrypoint.sh /root/entrypoint.sh
COPY lnd.conf /tmp/lnd.conf
COPY bitcoin.conf /tmp/bitcoin.conf
COPY torrc /tmp/torrc

# Install supervisord, tor
# mkdir logfiles directory
# Add bitcoin user
RUN apk -U --no-progress update && apk -U --no-progress upgrade && \
  apk -U --no-progress add -u python \
    py-pip \
    tor \
    boost \
    boost-program_options \
    libevent \
    libressl \
    libzmq \
    shadow && \
  pip install supervisor && \
  useradd -u 9999 --shell /bin/sh -m alice && \
  usermod -g alice tor && \
  mkdir -p\
    /home/alice/.bitcoin\
    /home/alice/.lnd/data /home/alice/.lnd/logs\
    /home/alice/.node/data /home/alice/.node/logs &&\
  ln -s /opt/bitcoin-0.17.1/bin/bitcoind /usr/local/bin &&\
  ln -s /opt/bitcoin-0.17.1/bin/bitcoin-cli /usr/local/bin &&\
  ln -s /opt/bitcoin-0.17.1/bin/bitcoin-tx /usr/local/bin

EXPOSE 9001 9050 8332 8333 18332 18333 18444 9735 18501 18502 10009 8080

VOLUME [ "/etc/tor", "/var/lib/tor", "/root/logfiles", "/home/alice/.bitcoin", "/home/alice/.lnd", "/home/alice/.node" ]

# Try to fix some permission
RUN mkdir -p /root/logfiles && chown -R alice: /root/logfiles

ENTRYPOINT [ "/root/entrypoint.sh" ]
