### First Stage of docker build ###
###################################
#Taking tomcat base image to copy over as setup.
FROM tomcat:9.0-jdk8-openjdk-slim AS tomcat-build

#Removes any prior contents in tomcat.
RUN rm -rf /usr/local/tomcat/webapps/*

#Copying custom settings for https
COPY /target/server.xml /usr/local/tomcat/conf/
#Add jks key for https
COPY /target/leandevpulse.jks /usr/local/tomcat/conf/leandevpulse.jks

#Add adjhub war to tomcat webapps folder.
COPY /target/adjhub-pulse-4.2.176.war /usr/local/tomcat/webapps/ROOT.war

#Change access permission to tomcat directories to be accessed by non-root users.
RUN chmod -R g=u /usr/local/tomcat

### Second Stage of docker build ###
####################################
FROM openjdk:8u212-jre-alpine3.9

#Installing bash to load properties with "." as env variables.
RUN apk add --no-cache --upgrade

# Add Maintainer Info.
MAINTAINER Gentian Licenji <glicenji@leanindustries.com>

#Setting working directory to root.(This is also the default directory where dockerFile commands run)
WORKDIR /

#Make port 8080 available to the world outside this container.
EXPOSE 8080

#Copies the whole tomcat setup to the new image.
#Sets owner for the directory copied to non-root user.
COPY --from=tomcat-build --chown=0:0 /usr/local/tomcat /usr/local/tomcat

# Create a restricted user as part of the root group.
# Root group has less privilages than root user!
# Random UIDs (part of root group) will execute the image on openshift.
RUN adduser -D -G root -g "Limited User" app-user
USER app-user

#Executes.
CMD ["/usr/local/tomcat/bin/catalina.sh","run"]
