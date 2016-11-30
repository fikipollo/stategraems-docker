STATegra EMS Docker Image
===================
The [STATegra EMS](https://github.com/fikipollo/stategraems) [Docker](http://www.docker.io) Image is an easy distributable full-fledged STATegra EMS installation.
STATegraEMS is an Experiment Management System (EMS) for omics experiments that supports different types of sequencing-based assays, proteomics and metabolomics data. 
stategraems was developed as part of the [STATegra Project](http://www.stategra.eu), which has received funding from the European Union’s FP7 research and innovation programme.

# Build the image <a name="install" />
The docker image for STATegra EMS can be found in the [docker hub](https://hub.docker.com/r/fikipollo/stategraems/). However, you can rebuild is manually by running **docker build**.

```sh
sudo docker build -t stategraems .
```
Note that the current working directory must contain the Dockerfile file. 

# Install the image <a name="install" />

First you need to install docker. Please follow the [instructions](https://docs.docker.com/installation/) from the Docker project.

After the successful installation, all you need to do is:

```sh
sudo docker run --name stategraems-mysql -v /your/data/location/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=yoursecretpass -d mysql
sudo docker run --name stategraems-tomcat --link stategraems-mysql -v /your/data/location/data:/data -p 8080:8080 -d fikipollo/stategraems
```

In case you do not have the Container stored locally, docker will download it for you.

A short description of the parameters would be:
- `docker run` will run the container for you.

- `-p 8080:8080` will make the port 8080 (inside of the container) available on port 8080 on your host.
    Inside the container an Tomcat Webserver is running on port 8080 and that port can be bound to a local port on your host computer. 
    With this parameter you can access to the STATegraEMS instance via `http://localhost:8080` immediately after executing the command above. 

- `fikipollo/stategraems` is the Image name, which can be found in the [docker hub](https://hub.docker.com/r/fikipollo/stategraems/).

- `-d` will start the docker container in daemon mode.

For an interactive session, you can execute :

```sh
sudo docker exec -it stategraems-tomcat bash
```


# First configuration for stategraems <a name="configure" />
The first time that you access to your stategraems instance you will need to configure some of the main settings.
By default stategraems will work with the local mysql server (localhost) for this dockerized version, change the Database host to stategraems-mysql.
This and other options can be customized through the web application.


