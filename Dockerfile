FROM ubuntu:20.04
MAINTAINER "Sanjit Kr Das" "kr.sanjitdas@gmail.com"
RUN apt update
CMD "mkdir /opt/java/"
ENV JAVA_HOME /opt/java/jdk-17.0.5
ENV CATALINA_HOME /home/tomcat/apache-tomcat-9.0.70
ENV CATALINA_BASE /home/tomcat/apache-tomcat-9.0.70
ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/lib:$CATALINA_HOME/bin
WORKDIR /opt/java
ADD jdk-17_linux-x64_bin.tar.gz .
CMD "tar -xzf jdk-17_linux-x64_bin.tar.gz"
RUN ["bash","-c","update-alternatives --install /usr/bin/java java /opt/java/jdk-17.0.5/bin/java -1"]
RUN groupadd tomcat && useradd -g tomcat tomcat
ENV TOMCAT_HOME /home/tomcat
WORKDIR /home/tomcat/
ADD apache-tomcat-9.0.70.tar.gz .
CMD "tar -xzf apache-tomcat-9.0.70.tar.gz" 
WORKDIR /home/tomcat/apache-tomcat-9.0.70/bin/
EXPOSE 8080

ENTRYPOINT ["/home/tomcat/apache-tomcat-9.0.70/bin/catalina.sh","run"]
