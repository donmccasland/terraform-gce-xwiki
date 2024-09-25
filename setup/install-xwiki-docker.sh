#!/usr/bin/bash
sudo apt-get update
sudo apt install -y docker.io
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
docker remove mysql-xwiki
docker run --net=xwiki-nw --name mysql-xwiki -v /home/ubuntu/mysql:/var/lib/mysql -v /home/ubuntu/mysql-init:/docker-entrypoint-initdb.d -e MYSQL_ROOT_PASSWORD=xwiki -e MYSQL_USER=xwiki -e MYSQL_PASSWORD=xwiki -e MYSQL_DATABASE=xwiki -d mysql:9.0 --character-set-server=utf8mb4 --collation-server=utf8mb4_bin --explicit-defaults-for-timestamp=1
docker remove xwiki
docker run --net=xwiki-nw --name xwiki -p 8080:8080 -v /home/ubuntu/xwiki:/usr/local/xwiki -e DB_USER=xwiki -e DB_PASSWORD=xwiki -e DB_DATABASE=xwiki -e DB_HOST=mysql-xwiki xwiki:stable-mysql-tomcat
