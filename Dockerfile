FROM ubuntu:14.04
MAINTAINER adolphlwq wlu@linkernetworks.com

RUN ln -f -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#install java
RUN apt-get update && \
    apt-get install -y openssh-server openssh-client rsync openjdk-7-jre supervisor curl vim && \
    apt-get clean

ENV JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64 \
    HADOOP_HOME=/usr/local/hadoop-2.6.4 \
    HADOOP_PREFIX=/usr/local/hadoop-2.6.4
ENV PATH=$JAVA_HOME/bin:$HADOOP_HOME/bin:$PATH \
    HD_URL="http://ftp.tc.edu.tw/pub/Apache/hadoop/common/hadoop-2.6.4/hadoop-2.6.4.tar.gz"

#install hadoop
RUN curl -fL $HD_URL | tar xzf - -C /usr/local && \
    echo 'root:root' | chpasswd  && \
    sed -i "28s/.*/PermitRootLogin yes/g" /etc/ssh/sshd_config && \
    useradd -m hadoop && \
    echo 'hadoop:hadoop' | chpasswd && \
    echo "hadoop ALL=(ALL) ALL" >> /etc/sudoers && \
    apt-get remove -y curl && \
    chown hadoop:hadoop -R $HADOOP_HOME

ADD supervisord.conf /etc/
ADD files/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml
ADD files/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml
#ADD files/config /root/.ssh/config
ADD files/hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadoop-env.sh

RUN chown hadoop:hadoop -R $HADOOP_HOME

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
