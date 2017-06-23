# Use openjdk 8 as a base image
FROM openjdk:8u131-jre

# Set Label
LABEL maintainer "kylinsoong.1214@gmail.com"

# Set the working directory to /app
WORKDIR /app

# Copy the runable jar into the container at /app
ADD target/vdb-datafederation-swarm.jar /app

# Make port 31000 available to the world outside this container
EXPOSE 31000

# Run  when the container launches
CMD ["java", "-jar", "vdb-datafederation-swarm.jar"]
