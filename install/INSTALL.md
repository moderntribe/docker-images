# Mac 

## Prerequisites

* 2010 or newer Mac
* OS X 10.10.3 or later
* Uninstall VirtualBox if you have version 4.3.30 or earlier

## Install Docker for Mac

[Download and install Docker for Mac](https://docs.docker.com/docker-for-mac/)

You'll probably want to give the Docker VM additional
resources. Click on the toolbar icon and set the number
of CPUs and memory to a number you're comfortable with
(I use 3 CPUs and 8 GB memory).

## Create data volume containers

Sometimes you want containers that contain persistent data.
For these, you will use a data volume. We're going to set one
up for storing mysql databases.

```
docker volume create --name mysqldata
```

## Build images (temporary)

Once we start pushing images to DockerHub, this won't be
necessary. But for the near term, we have to build our
custom images locally before we can use them.

```
cd build
docker build -t moderntribe/php:7.0-fpm php/7.0-fpm
```

## Create a loopback IP address

It's difficult to communicate from within a running container
back to your host machine. To facilitate that communication
for dev purposes (e.g., for running xdebug), we set up a
loopback IP address that the containers will be able to access.

From the root directory of this repo, run:

```
./install/loopback-ip-setup.sh
```

After it runs, you can see that your new alias is configured correctly:

```
ifconfig lo0
```

You should see 10.254.254.254 in the list.

## Install dnsmasq (optional)

dnsmasq is a utility that runs a local DNS server. You can use
it to route requests for a top-level domain like `.tribe` back
to your local system without editing your `hosts` file.

```
brew install dnsmasq
cd $(brew --prefix)
mkdir -p etc
touch etc/dnsmasq.conf
```

Edit the file `etc/dnsmasq.conf`. You'll want the following settings,
but you can add additional settings to your liking.

```
domain-needed

# repeat the address line as needed for other domains
address=/.tribe/10.254.254.254

listen-address=127.0.0.1
listen-address=10.254.254.254
```

Tell OS X to use dnsmasq for resolving the above configured domains.

```
sudo mkdir /etc/resolver
sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/tribe'
```

And finally launch the service:

```
sudo brew services restart dnsmasq
```
