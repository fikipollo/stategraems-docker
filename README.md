STATegra EMS Docker Image
===================
The [STATegra EMS](https://github.com/fikipollo/stategraems) [Docker](http://www.docker.io) Image is an easy distributable full-fledged STATegra EMS installation.

STATegra EMS is an *Experiment Management System* (EMS) for omics experiments that supports different types of sequencing-based assays, proteomics and metabolomics data.
STATegra EMS was developed as part of the [STATegra Project](http://www.stategra.eu), which has received funding from the European Union’s FP7 research and innovation programme.

# Build the image <a name="install" />
The docker image for STATegra EMS can be found in the [docker hub](https://hub.docker.com/r/fikipollo/stategraems/). However, you can rebuild is manually by running **docker build**.

```sh
sudo docker build -t stategraems .
```
Note that the current working directory must contain the Dockerfile file.

# Running the STATegra EMS <a name="run" />
The recommended way for running your STATegra EMS docker is using the provided **docker-compose** script that resolves the dependencies and make easier to customize your instance. Alternatively you can run the docker manually. In both cases the first time that you access to your STATegra EMS instance the system will be auto-installed. You can easily customize the installation by changing some system variables, you can find the list of available variables in the next section.

## Using the docker-compose file
Launching your STATegra EMS docker is really easy using docker-compose. Just download the *docker-compose.yml* file and customize the content according to your needs. There are few settings that should be change in the file, follow the instructions in the file to configure your container.
To launch the container, type:
```sh
sudo docker-compose up
```
Using the *-d* flag you can launch the containers in background.

In case you do not have the Container stored locally, docker will download it for you.

# Install the image <a name="install" />
You can run manually your containers using the following commands:

```sh
sudo docker run --name stategraems-mysql -v /your/data/location/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=yoursecretpass -d mysql
sudo docker run --name stategraems-tomcat -e MYSQL_ROOT_PASSWORD=yoursecretpass --link stategraems-mysql -v /your/data/location:/data -p 8080:8080 -d fikipollo/stategraems
```

In case you do not have the Container stored locally, docker will download it for you.

A short description of the parameters would be:
- `docker run` will run the container for you.

- `-p 8080:8080` will make the port 8080 (inside of the container) available on port 8080 on your host.
    Inside the container an Tomcat Webserver is running on port 8080 and that port can be bound to a local port on your host computer.
    With this parameter you can access to the STATegraEMS instance via `http://localhost:8080` immediately after executing the command above.

- `fikipollo/stategraems` is the Image name, which can be found in the [docker hub](https://hub.docker.com/r/fikipollo/stategraems/).

- `-d` will start the docker container in daemon mode.

- `-e VARIABLE_NAME=VALUE` changes the default value for a system variable.
The STATegra EMS docker accepts the following variables that modify the **INSTALLATION** of the system in the docker.
Note that all the values are optional but the **MYSQL_ROOT_PASSWORD** which must be the same password for the MySQL container.

- **EMS_ADMIN_USER**, the email for the admin account (default value is *emsadminuser@email.com*).
- **EMS_ADMIN_PASSWORD**, the password for the admin account (default value is *admin*).
- **MYSQL_ROOT_USER**, the root user for the MySQL instance (default value is *root*).
- **MYSQL_ROOT_PASSWORD**, the password for the MySQL root user (**mandatory**).
- **MYSQL_DATABASE_NAME**, the name for the MySQL database (default value is *STATegraDB*).
- **MYSQL_HOST**, the name for the MySQL container (default value is *stategraems-mysql*).
- **MYSQL_EMS_USER**, the name for the MySQL user that will be used for administrate the databases (default value is *emsuser*).
- **MYSQL_EMS_PASS**, the password for the MySQL user (default value is autogenerated).

For an interactive session, you can execute :

```sh
sudo docker exec -it stategraems-tomcat bash
```
