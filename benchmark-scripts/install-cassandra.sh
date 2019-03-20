#!/bin/bash
source benchmark-scripts/general-helper.sh
mount_procfs;
mount_fs;
enable_network;

apt install curl gnupg
apt-key adv --keyserver pool.sks-keyservers.net --recv-key A278B781FE4B2BDA
curl https://www.apache.org/dist/cassandra/KEYS | apt-key add -
apt-key adv --keyserver pool.sks-keyservers.net --recv-key A278B781FE4B2BDA
apt update
apt install cassandra -y

