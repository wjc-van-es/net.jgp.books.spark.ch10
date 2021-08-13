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

# start netcat in a new terminal with options -l (listen) -k (multiple connections) on port 9999
# then you may enter any text to be sent to the server (localhost)
# trying to close netcat with Ctrl+D Enter (which is equivalent to sending an EOF) Does not work in this example
# Ctrl+C, however does, (closing the entire gnome-terminal in the process)
# We checked this in another terminal with
# $ top -c -p $(pgrep -d',' -f 'nc -lk 9999')
gnome-terminal -- bash -c 'nc -lk 9999 && bash'
sleep 2
gnome-terminal -- bash -c 'JAVA_HOME=/home/willem/App/Java/jdk-11.0.5 mvn exec:exec@lab300 && bash'
