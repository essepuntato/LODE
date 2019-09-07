FROM openjdk:8

RUN apt-get update && apt-get -y install maven git

WORKDIR /lode

EXPOSE 8080 8443

ENTRYPOINT ["mvn", "jetty:run"]
