FROM debian:jessie

# Install & update base system
RUN apt-get update
RUN apt-get upgrade -y

# Install git and maven
RUN apt-get install -y git wget python-dev
RUN apt-get install -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils
RUN apt-get install -y libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev

ENV NODE_VERSION v4.2
ENV BITCORE_REPO https://github.com/jpochyla/bitcore-node.git
ENV BITCORE_VERSION block-methods

# Install Node.js
RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.30.2/install.sh | bash
RUN . ~/.bashrc && nvm install $NODE_VERSION &&  nvm alias default v4.2
RUN . ~/.bashrc && npm install -g node-gyp

# Increase this to skip Docker cache
ENV BUILD_ATTEMPT 1

# Clone bitcore
RUN git clone $BITCORE_REPO bitcore
RUN cd bitcore && git checkout $BITCORE_VERSION

# Build bitcore
RUN . ~/.bashrc && cd bitcore && npm install
RUN . ~/.bashrc && cd bitcore/bin && ./build
RUN ln -s /.bitcore /root/.bitcore

CMD . ~/.bashrc && cd /bitcore/bin && ./bitcore-node start >> /logs/bitcore.log
