#!/usr/bin/env bash
###############################################################################################
# This script runs mvn clean install and then starts
# net.jgp.books.spark.ch10.x.utils.streaming.app.RecordsInFilesGeneratorApp and
# net.jgp.books.spark.ch10.lab200_read_stream.ReadLinesFromFileStreamApp from lab200
# each in their own terminal
###############################################################################################
echo "Make sure the current dir contains this projects pom.xml file"
pwd
# setting the JAVA_HOME explicitly before every mvn command as the default Java installation is an JRE (1.8.0 version)
JAVA_HOME=/home/willem/App/Java/jdk-11.0.5 mvn clean install -e
gnome-terminal -- bash -c 'JAVA_HOME=/home/willem/App/Java/jdk-11.0.5 mvn exec:java@generate-records-in-files && bash'
gnome-terminal -- bash -c 'JAVA_HOME=/home/willem/App/Java/jdk-11.0.5 mvn exec:exec@lab210 && bash'
