FROM library/tomcat:8-jre8

COPY build/libs/X2K*.war webapps/X2K.war

RUN apt-get update && apt-get install -y libtcnative-1 vim && apt-get clean