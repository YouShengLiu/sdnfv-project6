#!/bin/bash
H1_SUB_NET="${1:-18}"
H2_SUB_NET="${2:-19}"

echo "H1 sub net: $H1_SUB_NET"
echo "H2 sub net: $H2_SUB_NET"

docker exec h1 ip route del default
docker exec h1 ip route add default via 172.$H1_SUB_NET.0.2

echo "Show host 1 route"
docker exec h1 route

docker exec h2 ip route del default
docker exec h2 ip route add default via 172.$H2_SUB_NET.0.2

echo "Show host 2 route"
docker exec h2 route