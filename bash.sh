#!/bin/bash

docker run -t --cidfile=bitcore.cid \
        -v $(pwd)/data:/.bitcore \
        -p 3001:3001 \
        -i bitcore /bin/bash

rm bitcore.cid
