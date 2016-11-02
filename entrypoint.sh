#! /bin/bash
set -x
if [ -z $SSH_PORT ]; then
  export  SSH_PORT=2221
fi

port_line=`grep "Port " /etc/ssh/sshd_config`
sed -i "s/$port_line/Port $SSH_PORT/g" /etc/ssh/sshd_config
sed -i "35s/.*/    StrictHostKeyChecking no/g" /etc/ssh/ssh_config
service ssh start

ssh-keygen -t rsa -q -P '' -f /root/.ssh/id_rsa
cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

$HADOOP_HOME/etc/hadoop/hadoop-env.sh
echo "Y" | $HADOOP_HOME/bin/hdfs namenode -format
$HADOOP_HOME/sbin/start-dfs.sh

# https://github.com/sequenceiq/hadoop-docker/blob/master/bootstrap.sh#L21-L27
if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
