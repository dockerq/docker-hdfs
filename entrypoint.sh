#! /bin/bash
set -e

if [ -z $SSH_PORT ]; then
  SSH_PORT = 2221
fi

# change sshd config (mainly default port)
function chnageSSHPort() {
  port_line=`sudo grep "Port " /etc/ssh/sshd_config`
  sed -i "s/$port_line/Port $SSH_PORT/g" /etc/ssh/sshd_config
  service ssh start
}

# set ssh passwordless
function setSSHPasswordless() {
  ssh-keygen -t rsa -q -P '' -f /home/hadoop/.ssh/id_rsa
  cp /home/hadoop/.ssh/id_rsa.pub /home/hadoop/.ssh/authorized_keys
  sudo chmod 600 /home/hadoop/.ssh/authorized_keys
}

# init hadoop
function initHadoop() {
  $HADOOP_HOME/etc/hadoop/hadoop-env.sh
  # format namenode
  echo "Y" | $HADOOP_HOME/bin/hdfs namenode -format
}

# start datanode
chnageSSHPort()
setSSHPasswordless()
initHadoop()
$HADOOP_HOME/sbin/start-dfs.sh
echo "start hdfs success!"
