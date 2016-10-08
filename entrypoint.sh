#! /bin/bash
set -x
if [ -z $SSH_PORT ]; then
  export  SSH_PORT=2221
fi
# change sshd config (mainly default port)
#function chnageSSHPort() {
#  port_line=`sudo grep "Port " /etc/ssh/sshd_config`
#  sed -i "s/$port_line/Port $SSH_PORT/g" /etc/ssh/sshd_config
#  service ssh start
#}

# set ssh passwordless
#function setSSHPasswordless() {
#  ssh-keygen -t rsa -q -P '' -f /home/hadoop/.ssh/id_rsa
#  cp /home/hadoop/.ssh/id_rsa.pub /home/hadoop/.ssh/authorized_keys
#  chmod 600 /home/hadoop/.ssh/authorized_keys
#}

# init hadoop
#function initHadoop() {
#  $HADOOP_HOME/etc/hadoop/hadoop-env.sh
  # format namenode
#  echo "Y" | $HADOOP_HOME/bin/hdfs namenode -format
#}
# start datanode

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
