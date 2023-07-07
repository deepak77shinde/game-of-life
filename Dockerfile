FROM maven:3.5.4-jdk-8-alpine as maven
WORKDIR /src
COPY ./pom.xml ./pom.xml
COPY ./src ./src
RUN mvn dependency:go-offline -B
RUN mvn package
FROM openjdk:8u171-jre-alpine
COPY --from=maven target/game-of-life-*.jar ./game-of-life.jar
EXPOSE 80
CMD ["java", "-jar", "./game-of-life.jar"]
