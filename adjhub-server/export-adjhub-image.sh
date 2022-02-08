#Build adjhub image.
docker build -t lean-images/adjhub-pulse-new-tomcat-jdk:v4.2.144 .
#Export adjhub image as tar.
docker save -o adjhub-pulse4.2.150.tar lean-images/adjhub-pulse:v4.2.150
