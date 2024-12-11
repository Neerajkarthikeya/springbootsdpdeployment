# Use an official openjdk image to build the application
FROM openjdk:17-jdk-slim

# Install Maven
RUN apt-get update && apt-get install -y maven

# Set the working directory in the container
WORKDIR /app

# Copy the pom.xml and the source code into the container
COPY pom.xml /app
COPY src /app/src

# Package the Spring Boot application with Maven
RUN mvn clean package

# Expose the port on which the app will run
EXPOSE 8080

# Run the JAR file (replace with your actual JAR file name)
CMD ["java", "-jar", "target/HFMP-0.0.1-SNAPSHOT.jar"]
