# hadoop standalone mode docker image
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
- start hdfs on standalone mode
```
cd path/to/hadoop
./sbin/start-dfs.sh
```

## troubleshooting
### sshd not working.
You should check the config for sshd. Config file lies in `/etc/ssh/sshd_config`
[ssh config on Ubuntu](https://help.ubuntu.com/community/SSH/OpenSSH/Configuring?highlight=%28%28SSH%29%29)
