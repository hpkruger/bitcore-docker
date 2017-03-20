FROM node:4.1.2
# Add our user and group first to make sure their IDs get assigned consistently
RUN groupadd -r app && useradd -r -g app app

# Apt Get
RUN apt-get update
RUN apt-get install -y libzmq3-dev build-essential mongodb libkrb5-dev

# Set User
ENV user app
ENV INSIGHT_NETWORK testnet
COPY . /home/$user/
WORKDIR /home/$user
RUN chown $user --recursive .
RUN chown $user --recursive /home/$user/
RUN ls -lah /home/app/
RUN . ~/.bashrc && npm install --unsafe-perm -g bitcore

EXPOSE 3001
EXPOSE 8333
EXPOSE 6667

# Build bitcore
RUN . ~/.bashrc && bitcore create -d /bitcore/ --testnet coinzen
WORKDIR coinzen
COPY bitcore-node.json /home/$user/bitcore-node.json
CMD bitcored
