#!/bin/bash
sudo apt-get update
sudo apt-get install -y curl
sudo curl -ssl https://get.docker.com | sh
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker