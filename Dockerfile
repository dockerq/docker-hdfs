FROM ubuntu:16.04
MAINTAINER adolphlwq wlu@linkernetworks.com

RUN ln -f -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#install java
RUN apt update && \
    apt install -y ssh rsync openjdk-8-jre supervisor curl && \
    apt clean

ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk \
    HADOOP_HOME=/usr/local/hadoop-2.6.4 \
    HADOOP_PREFIX=/usr/local/hadoop-2.6.4
ENV PATH=$JAVA_HOME/bin:$PATH \
    HD_URL="http://ftp.tc.edu.tw/pub/Apache/hadoop/common/hadoop-2.6.4/hadoop-2.6.4.tar.gz"

#install hadoop
RUN curl -fL $HD_URL | tar xvf - -C /usr/local && \
    useradd -m hadoop && \
    echo 'hadoop:hadoop' | chpasswd && \
    echo "hadoop ALL=(ALL) ALL" >> /etc/sudoers && \
    apt remove curl
#    chmod 755 -R /usr/local/hadoop-2.6.4 && \
#    sed -i '/^export HADOOP_CONF_DIR/ s:.*:export HADOOP_CONF_DIR=/usr/local/hadoop-2.6.4/etc/hadoop:' /usr/local/hadoop-2.6.4/etc/hadoop/hadoop-env.sh && \
#    echo 'export HADOOP_LOG_DIR' >> /usr/hadoop/etc/hadoop/hadoop-env.sh

ADD supervisord.conf /etc/
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
