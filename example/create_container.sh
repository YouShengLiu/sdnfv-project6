#!/bin/bash
docker run --privileged --cap-add NET_ADMIN \
    --cap-add NET_BROADCAST -d -it \
    --name h1 host
    
docker run --privileged --cap-add NET_ADMIN \
    --cap-add NET_BROADCAST -d -it \
    --name h2 host
    
docker run --privileged --cap-add NET_ADMIN \
    --cap-add NET_BROADCAST -d -it \
    --name R1 opencord/quagga
    
docker run --privileged --cap-add NET_ADMIN \
    --cap-add NET_BROADCAST -d -it \
    --name R2 opencord/quagga