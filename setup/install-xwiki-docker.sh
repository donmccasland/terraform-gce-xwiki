#!/usr/bin/bash
sudo apt-get update
sudo apt install -y docker.io
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
