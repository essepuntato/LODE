FROM  maven:3.6.3-jdk-8 as build

ARG LODE_EXTERNAL_URL=true
ARG WEBVOWL_EXTERNAL_URL=true
ARG USE_HTTPS=false

WORKDIR /opt/LODE

COPY . .
RUN echo "externalURL=${LODE_EXTERNAL_URL}\nwebvowl=${WEBVOWL_EXTERNAL_URL}\nuseHTTPs=${USE_HTTPS}" > /opt/LODE/src/main/webapp/config.properties
RUN mvn clean package

FROM jetty
COPY --from=build /opt/LODE/target/LODE-1.3-SNAPSHOT.war /var/lib/jetty/webapps/lode.war

EXPOSE 80
