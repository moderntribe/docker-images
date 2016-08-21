# Docker for Dev

## Installation

Follow the instructions in `install/INSTALL.md`.

## Run the global containers

We have two containers that will run globally, apart from any project.

1. mysql - you'll have one server that you can
 reference from all your projects
1. nginx proxy - all requests will go through this
 proxy, which maps domain names to running containers
 
Start these by running the start script:

```
./start.sh
```

Stop them by running the stop script:

```
./stop.sh
```

The first time you start it, it may take a while as it
downloads or builds the containers you need.

## Open a shell in a running container

Get the name of your container. E.g., "global_mysql_1". Then run:

```
docker exec -it YOUR_CONTAINER /bin/bash
```

Or shorten this by adding the following to your `.bash_profile`:

```
dbash()
{
  docker exec -i -t $1 /bin/bash
}
```

Then, to open a shell in a container:

```
dbash YOUR_CONTAINER
```

You'll find yourself using this on occasion to get a shell in
a running container to run WP CLI, for example.

## Connect to your mysql server

Using a tool like Sequel Pro, you can connect to your mysql
server much like you would with a locally hosted mysql. The
container's port 3306 is mapped to your local port 3306.

Host: 127.0.0.1
User: root
Password: password

In your WordPress config, change the host name to `mysql`.

## Connect to your memcached server

Each project will run its own memcached container. From
your WordPress config, set the host to `memcached:11211`.

To access it from your local system, find the port number
by checking `docker ps`. You might see a number like "32976".
Use that port to connect to the server. E.g.,

```
telnet 127.0.0.1 32976`
``