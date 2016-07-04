#!/bin/bash

docker run -t --cidfile=bitcore.cid \
        -v $(pwd)/data:/.bitcore \
        -p 3001:3001 \
        -i bitcore /bin/bash

read -p "Store changed data to image? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # do dangerous stuff
    docker commit `cat bitcore.cid` bitcore
fi

rm bitcore.cid
