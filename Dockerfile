FROM  maven:3.6.3-jdk-8

ARG LODE_EXTERNAL_URL
ARG WEBVOWL_EXTERNAL_URL
ARG USE_HTTPS

WORKDIR /opt/LODE

COPY . .

RUN echo "externalURL=${LODE_EXTERNAL_URL}\nwebvowl=${WEBVOWL_EXTERNAL_URL}\nuseHTTPs=${USE_HTTPS}" > /opt/LODE/src/main/webapp/config.properties

EXPOSE 8080

ENTRYPOINT ["mvn", "clean", "jetty:run"]
