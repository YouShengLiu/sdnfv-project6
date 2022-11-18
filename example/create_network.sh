#!/bin/bash
docker network create R1h1br
docker network create R2h2br
docker network create R1R2br

docker network connect R1h1br R1
docker network connect R1h1br h1

docker network connect R2h2br R2
docker network connect R2h2br h2

docker network connect R1R2br R1
docker network connect R1R2br R2