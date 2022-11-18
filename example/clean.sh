#!/bin/bash
echo "Stop h1 h2 R1 R2"
docker stop h1 h2 R1 R2

echo "Remove h1 h2 R1 R2"
docker rm h1 h2 R1 R2

echo "Remove "
docker network rm R1h1br R2h2br R1R2br