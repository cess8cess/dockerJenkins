
# Pull base image
# ---------------
FROM jenkins/jenkins:jdk11

# Author
# ------
MAINTAINER Onur Ince <onurince48@icloud.com>

# Build the container
# -------------------

USER root

# install wget
RUN apt-get install -y wget

# get maven 3.2.2
RUN wget --no-verbose -O /tmp/apache-maven-3.6.0-bin.tar.gz https://www-us.apache.org/dist/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz

# verify checksum
# RUN echo "fae9c12b570c3ba18116a4e26ea524b29f7279c17cbaadc3326ca72927368924d9131d11b9e851b8dc9162228b6fdea955446be41207a5cfc61283dd8a561d2f  apache-maven-3.6.0-bin.tar.gz" | md5sum -c

# install maven
RUN tar xzf /tmp/apache-maven-3.6.0-bin.tar.gz -C /opt/
RUN ln -s /opt/apache-maven-3.6.0 /opt/maven
RUN ln -s /opt/maven/bin/mvn /usr/local/bin
RUN rm -f /tmp/apache-maven-3.6.0-bin.tar.gz
ENV MAVEN_HOME /opt/maven

RUN chown -R jenkins:jenkins /opt/maven

# install git (MH: Git should be preinstalled in the original Jenkins docker image prep)
# RUN apt-get install -y git

# remove download archive files
RUN apt-get clean

USER jenkins
