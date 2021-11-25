#!/bin/bash

docker run -itd --name T1 alpine
docker network create -d bridge --subnet 10.0.10.0/24 bridge1

docker run -itd --name T2 -p 80:80 -p 10.0.10.0:8000:80 nginx
docker network connect bridge1 T2

docker run -itd --name D1 --net bridge1 --ip 10.0.10.254 --network-alias host1 alpine

docker network create -d bridge --subnet 10.0.12.0/24 bridge2

docker run -itd --name D2 -p 10.0.10.0:8080:80 --network-alias apa1 -p 10.0.12.0:8081:80 httpd
docker network connect --alias apa2 bridge2 D2

docker run -itd --name S1 --net bridge2 --network-alias host2 ubuntu
