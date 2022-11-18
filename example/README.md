1. docker build -t host -f host.Dockerfile .
2. docker pull opencord/quagga
3. bash create_container.sh
4. bash create_network.sh
5. bash config_host_gateway.sh
6. bash setup_routers.sh
7. docker restart R1 R2