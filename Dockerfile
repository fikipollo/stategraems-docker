############################################################
# Dockerfile to build Galaxy container images
# Based on tomcat
############################################################

# Set the base image to official Tomcat
FROM tomcat

# File Author / Maintainer
MAINTAINER Rafael Hernandez <rafahd87@gmail.com>

################## BEGIN INSTALLATION ######################
#Install mysql client for connecting to the mysql component
RUN apt-get update && apt-get install -y mysql-client  \
    && https://github.com/fikipollo/stategraems/archive/feature/angular.zip -O /tmp/ems.zip \
    && mkdir /tmp/ems/ \
    && unzip /tmp/ems.zip -d /tmp/ems/ \
    && cp /tmp/ems/*/dist/stategraems.war /usr/local/tomcat/webapps/  \
    && sleep 10 \
    && rm -r /usr/local/tomcat/webapps/ROOT \
    && ln -s /usr/local/tomcat/webapps/stategraems /usr/local/tomcat/webapps/ROOT 

##################### INSTALLATION END #####################

# Expose port 8080 (tomcat)
EXPOSE :80

# Mark folders as imported from the host.
VOLUME ["/data/"]

