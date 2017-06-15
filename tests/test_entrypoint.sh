#! /bin/bash

# test change hdfs blocksize script
function change_blocksize() {
    echo "before changing, hdfs-site.xml is"
    cat hdfs-site.xml

    # set hdfs blocksize in hdfs-site.xml
    if [ -z $HDFSBLOCK ];then
        export HDFSBLOCK=16m
    fi
    sed "21s@.*@      <value>${HDFSBLOCK}</value>@" -i hdfs-site.xml

    echo "after changing, hdfs-site.xml is"
    cat hdfs-site.xml
}

change_blocksize