FROM library/tomcat:8-jre8

ADD server.xml /usr/local/tomcat/conf

COPY target/X2K_dev-*.war webapps/X2K_dev.war

RUN apt-get update && apt-get install -y libtcnative-1 && apt-get clean