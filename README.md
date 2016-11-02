# Standalone HDFS mode on docker
[![Docker Pulls](https://img.shields.io/docker/pulls/dockerq/docker-hdfs.svg?maxAge=2592000)]()

## Introduction
- base image: ubuntu16.04 64 bit
- java: openjdk-8-jre
- default JAVA_HOME:/usr/lib/jvm/java-8-openjdk-amd64

## Usage
### quick start
  ```
  docker run -d --net host --name hdfs dockerq/docker-hdfs
  ```
Then browser [localhost:50070](http://localhost:50070) to see HDFS WebUI

### volumn data directory to host
The default directory of `datanode` and `namenode` is `/hdfsdata`.So you can volumn it in onder to backing up data.
  ```
  docker run -d --name --net host -v host_data_path:/hdfsdata dockerq/docker-hdfs
  ```

### change sshd binding port
If your container's network mode is `host` and your host runs **SSHD** too,you should change your container's sshd binding port using environment `SSH_PORT`.
  ```
  docker run -d --net host -e SSH_PORT=2222 --name hdfs dockerq/docker-hdfs
  ```

## Troubleshooting
### hdfs sshd not working.
You should check the config for sshd. Config file lies in `/etc/ssh/sshd_config`. More details click
[ssh config on Ubuntu](https://help.ubuntu.com/community/SSH/OpenSSH/Configuring?highlight=%28%28SSH%29%29)

## Summary
This image aims to exploring HDFS and setuping standalone HDFS quickly.I do not suggest you use it in production environment.
