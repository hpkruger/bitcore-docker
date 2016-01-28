#!/bin/bash

docker stop -t 1 `cat bitcore.cid`
rm -f bitcore.cid
