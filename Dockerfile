# Use an official Java runtime as a parent image
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the local code to the container
COPY . /app/

# Install Maven
RUN apt-get update && apt-get install -y maven && apt-get clean

# Build the application using Maven
RUN mvn clean package

# Expose the port the app will run on
EXPOSE 8080

# Run the Spring Boot application
CMD ["java", "-jar", "target/HFMP-0.0.1-SNAPSHOT.jar"]
