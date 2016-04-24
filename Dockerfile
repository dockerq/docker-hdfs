FROM ubuntu:16.04
MAINTAINER adolphlwq wlu@linkernetworks.com

RUN ln -f -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#install java
RUN apt update && \
    apt install -y ssh rsync openjdk-8-jre supervisor curl && \
    apt clean

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
    HADOOP_HOME=/usr/local/hadoop-2.6.4 \
    HADOOP_PREFIX=/usr/local/hadoop-2.6.4
ENV PATH=$JAVA_HOME/bin:$HADOOP_HOME/bin:$PATH \
    HD_URL="http://ftp.tc.edu.tw/pub/Apache/hadoop/common/hadoop-2.6.4/hadoop-2.6.4.tar.gz"

#install hadoop
RUN curl -fL $HD_URL | tar xzf - -C /usr/local && \
    useradd -m hadoop && \
    echo 'hadoop:hadoop' | chpasswd && \
    echo "hadoop ALL=(ALL) ALL" >> /etc/sudoers && \
    apt remove -y curl && \
    apt clean
#    chmod 755 -R /usr/local/hadoop-2.6.4 && \
#    sed -i '/^export HADOOP_CONF_DIR/ s:.*:export HADOOP_CONF_DIR=/usr/local/hadoop-2.6.4/etc/hadoop:' /usr/local/hadoop-2.6.4/etc/hadoop/hadoop-env.sh && \
#    echo 'export HADOOP_LOG_DIR' >> /usr/hadoop/etc/hadoop/hadoop-env.sh

ADD supervisord.conf /etc/
ADD files/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml
ADD files/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml
ADD files/config /root/.ssh/config
ADD files/hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadop-env.sh

RUN apt install -y vim && \
    echo y|ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && \
    echo y|ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    echo y|ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa && \
    cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys && \
    chmod 600 /root/.ssh/config

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
