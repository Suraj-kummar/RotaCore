# Stage 1: Build the application
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
# Build the WAR file, skipping tests to speed up deployment
RUN mvn clean package -DskipTests

# Stage 2: Run the application on Tomcat
FROM tomcat:9.0-jdk17-temurin
# Remove default Tomcat apps to keep it clean
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the built WAR file from the build stage to Tomcat's webapps directory
# Renaming to ROOT.war ensures it runs at the root context (e.g., mysite.com/ instead of mysite.com/Rota-Core)
COPY --from=build /app/target/Rota-Core.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
