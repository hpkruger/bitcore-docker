FROM node:4.1.2
# Add our user and group first to make sure their IDs get assigned consistently
RUN groupadd -r app && useradd -r -g app app

# Apt Get Dependenceies
RUN apt-get update
RUN apt-get install -y libzmq3-dev build-essential mongodb libkrb5-dev git

# Set User
ENV user app
ENV INSIGHT_NETWORK testnet
COPY . /home/$user/
WORKDIR /home/$user

RUN chown $user --recursive .
RUN chown $user --recursive /home/$user/
RUN ls -lah /home/app/

# Install NPM Dependenceies
RUN . ~/.bashrc && npm install --unsafe-perm -g bitcore bitcore-node yarn

# Set Ports
EXPOSE 3001
EXPOSE 8333
EXPOSE 6667

# Build bitcore
RUN . ~/.bashrc && bitcore-node create -d /bitcore/ --testnet coinzen
WORKDIR coinzen

# Install services
RUN git clone https://github.com/timwhite47/cz-bitcore.git
RUN bitcore-node install insight-api
RUN bitcore-node install ./cz-bitcore

CMD bitcore-node start
