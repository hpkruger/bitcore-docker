#!/bin/bash

docker run -t --cidfile=bitcore.cid \
	-v $(pwd)/data:/.bitcore \
       	-v $(pwd)/logs:/logs \
        -p 3001:3001 \
	-d bitcore
