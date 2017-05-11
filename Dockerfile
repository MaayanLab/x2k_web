FROM library/tomcat:8-jre8

COPY target/X2K-*.war webapps/X2K.war

RUN apt-get update && apt-get install -y libtcnative-1 && apt-get clean