FROM debian:jessie

# Install & update base system
#RUN sed 's/main$/main universe/' -i /etc/apt/sources.list
#RUN apt-get update && apt-get install -y software-properties-common
#RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN apt-get upgrade -y

# Install git and maven
RUN apt-get install -y git wget python-dev
RUN apt-get install -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils
RUN apt-get install -y libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev

ENV NODE_VERSION v4.2
ENV BITCORE_VERSION master

# Install Node.js
RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.30.2/install.sh | bash
RUN . ~/.bashrc && nvm install $NODE_VERSION &&  nvm alias default v4.2
RUN . ~/.bashrc && npm install -g node-gyp

# Clone bitcore
RUN git clone https://github.com/bitpay/bitcore-node.git bitcore
RUN cd bitcore && git checkout $BITCORE_VERSION

# Build bitcore
RUN . ~/.bashrc && cd bitcore && npm install
RUN . ~/.bashrc && cd bitcore/bin && ./build

RUN ln -s /.bitcore /root/.bitcore
# Compile BOP using Maven
#RUN cd /bop-trezor-server/sources && mvn -Djavax.net.ssl.trustStore=/netlock.truststore package
#RUN cp /bop-trezor-server/sources/bop-trezor-server/target/bop-trezor-server-$BOP_VERSION-shaded.jar /bop-trezor-server/

CMD . ~/.bashrc && cd /bitcore/bin && ./bitcore-node start >> /logs/bitcore.log
