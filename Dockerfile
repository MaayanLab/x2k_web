FROM node as builder

RUN set -x \
  && apt-get update -y \
  && apt-get install -y unzip curl openjdk-11-jdk

RUN \
  cd /usr/local && \
  curl -L https://services.gradle.org/distributions/gradle-8.0-bin.zip -o gradle-8.0-bin.zip && \
  unzip gradle-8.0-bin.zip && \
  rm gradle-8.0-bin.zip

ENV GRADLE_HOME=/usr/local/gradle-8.0
ENV PATH=$PATH:$GRADLE_HOME/bin JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

WORKDIR /work

ADD . .
RUN gradle war

FROM library/tomcat:8.5-jre9

COPY --from=builder /work/build/libs/work.war webapps/X2K.war
