############################################################
# Dockerfile to build STATegra EMS container images
# Based on tomcat
############################################################

# Set the base image to official Tomcat
FROM tomcat

# File Author / Maintainer
MAINTAINER Rafa Hernandez <https://github.com/fikipollo>

################## BEGIN INSTALLATION ######################
# Install MySQL client for connecting to the MySQL component
RUN apt-get update && apt-get install -y mysql-client
# Download the last image of STATegra EMS
RUN wget https://raw.githubusercontent.com/fikipollo/stategraems/release/last/dist/stategraems.war -O /tmp/stategraems.war
# Install the image and set up the system
RUN cp /tmp/stategraems.war /usr/local/tomcat/webapps/ \
    && rm /tmp/stategraems.war \
    && sleep 10 \
    && rm -r /usr/local/tomcat/webapps/ROOT \
    && ln -s /usr/local/tomcat/webapps/stategraems /usr/local/tomcat/webapps/ROOT  \
    && echo "export is_docker=true" >>  /usr/local/tomcat/bin/setenv.sh \
    && chmod +x /usr/local/tomcat/bin/setenv.sh

##################### INSTALLATION END #####################

# Expose port 8080 (tomcat)
EXPOSE :80

# Mark folders as imported from the host.
VOLUME ["/data/"]
