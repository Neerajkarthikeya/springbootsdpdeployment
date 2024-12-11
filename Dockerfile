# Use Maven base image with JDK
FROM maven:3.9.3-eclipse-temurin-17

# Set working directory
WORKDIR /app

# Copy all project files into the container
COPY . .

# Run Maven to build the project
RUN mvn clean package

# Expose the application port
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "target/HFMP-0.0.1-SNAPSHOT.jar"]
