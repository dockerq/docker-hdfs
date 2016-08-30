# hadoop standalone mode docker image
[![Docker Pulls](https://img.shields.io/docker/pulls/dockerq/docker-hdfs.svg?maxAge=2592000)]()

## intro
- base image: ubuntu14.04 64 bit
- java: openjdk-7-jre
- default JAVA_HOME:/usr/lib/jvm/java-7-openjdk-amd64

## note
If you run this image in you host and in container net node is **host**. And you host run sshd on port 22.
You should promise you container sshd run in different port such as 2212.

## usage
- download image
```
docker pull dockerq/docker-hdfs or
docker pull daocloud.io/adolphlwq/docker-hdfs:master-4dfe551  (in China will be more faster)
```
- change hdfs config
  - hadoop home is `/usr/local/hadoop-2.6.4`
  - core-site.xml and hdfs-site.xml
- set passwordless
```
# generate ssh key
ssh-keygen -t rsa -P ''
# copy pub key
cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
# test
ssh localhost
ssh username
```
- format hdfs namenode
```
cd path/to/hadoop
. etc/hadoop/hadoop-env.sh
./bin/hdfs namenode -format
```
- start hdfs on pseudo mode
```
cd path/to/hadoop
./sbin/start-dfs.sh
```
- run hdfs pseudo mode using docker-compose
```
install docker-compese ##refer (https://docs.docker.com/compose/install/)
#chanfe some config in hdfs-compose.yml
docker-compose -f hdfs-compose.yml up -d
```

## optional operations
### volumn datanode dir
The datanode and namenode is `/hdfsdata` default.So you can volumn it for data backing up.
```
docker run -d --name --net host -v host_data_path:/hdfsdata dockerq/docker-hdfs
```

### change sshd listen port
If your container network mode is `host` and you HOST is just run SSHD,you should change the sshd listen port in your container.

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

## troubleshooting
### hdfs sshd not working.
You should check the config for sshd. Config file lies in `/etc/ssh/sshd_config`
[ssh config on Ubuntu](https://help.ubuntu.com/community/SSH/OpenSSH/Configuring?highlight=%28%28SSH%29%29)
