FROM maven:3.6.3-jdk-11 AS build

WORKDIR /build
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src 
RUN mvn clean package -DskipTests

FROM amazoncorretto:11

WORKDIR /app 
COPY --from=build /build/target/database_service_project-0.0.4.jar .
EXPOSE 8080
CMD ["java", "-jar", "database_service_project-0.0.4.jar" ]