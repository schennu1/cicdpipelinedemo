FROM maven:3.6-jdk-11-slim as BUILD
COPY . /src
WORKDIR /src
RUN mvn install -DskipTests
FROM registry.access.redhat.com/openjdk/openjdk-11-rhel7
EXPOSE 8080
WORKDIR /app
ARG JAR=spring-petclinic-2.2.0.BUILD-SNAPSHOT.jar

COPY --from=BUILD /src/target/$JAR /app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
