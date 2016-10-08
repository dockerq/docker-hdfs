# Hadoop standalone mode on docker
[![Docker Pulls](https://img.shields.io/docker/pulls/dockerq/docker-hdfs.svg?maxAge=2592000)]()

## Introduction
- base image: ubuntu16.04 64 bit
- java: openjdk-8-jre
- default JAVA_HOME:/usr/lib/jvm/java-8-openjdk-amd64

## Usage
### basic usage:download and run
  ```
  docker run -d --net host --name hdfs dockerq/docker-hdfs
  ```

### volumn datanode dir
The datanode and namenode is `/hdfsdata` default.So you can volumn it for data backing up.
  ```
  docker run -d --name --net host -v host_data_path:/hdfsdata dockerq/docker-hdfs
  ```

### change sshd listen port
If your container network mode is `host` and your host runs SSHD too,you should change the sshd listen port in your container.

1. edit /etc/ssh/sshd_config
  ```
  Port 2221 (default is 22)
  ```
2. restart sshd
  ```
  service ssh restart
  ```
3. add ssh port to HADOOP_HOME/etc/hadoop/hadoop-env.sh
  ```
  export HADOOP_SSH_OPTS="-p 2221"
  ```

## Troubleshooting
### hdfs sshd not working.
You should check the config for sshd. Config file lies in `/etc/ssh/sshd_config`
[ssh config on Ubuntu](https://help.ubuntu.com/community/SSH/OpenSSH/Configuring?highlight=%28%28SSH%29%29)
