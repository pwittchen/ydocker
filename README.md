ydocker
=======

get, build, initialize and run SAP Hybris Commerce Suite inside Docker container

read [a blog post about dockerizing Hybris](http://blog.wittchen.biz.pl/dockerizing-hybris/)

![ydocker logo](ydocker.png)

Contents
--------
- [Usage](#usage)
- [Installing Docker](#installing-docker)
  - [Ubuntu](#ubuntu)
  - [Mac OS X](#mac-os-x)
- [Resolving problems with Docker](#resolving-problems-with-docker)
- [Server endpoints](#server-endpoints)
- [Platform build version](#platform-build-version)
- [Remarks](#remarks)
- [Testing](#testing)
- [References](#references)
  - [General links](#general-links)
  - [Similar projects](#similar-projects)
- [License](#license)

Usage
-----

If you haven't installed Docker yet, go to the section about [installing Docker](#installing-docker) first.

You can use helper shell script called `ydocker.sh` with the following parameters:

```
-b    building Docker container
-r    running Hybris Server in Docker container
-c    running Docker container with CLI
-i    showing info about Docker container
-d    deleting Docker container
-h    showing help
```

Inside `ydocker.conf` file you can view or customize the following parameters:
- Docker image name
- Commerce Suite version (set `latest` to keep your software fresh - you can also set specific version like `6.2`)
- Artifact type (`snapshot` or `release`)
- Recipe
- Host port
- Container port

Please remember that you need to have your own SAP e-mail and password
in order to be able to download SAP Hybris Commerce Suite from Hybris repository inside Docker container.

Installing Docker
-----------------

If you haven't installed Docker yet, follow instructions below.

### Ubuntu

If you are using Ubuntu Linux and want to install Docker, follow official instructions for [Installation on Ubuntu](https://docs.docker.com/engine/installation/linux/ubuntulinux/) from the Docker website.

### Mac OS X

If you are using Mac OS X and want to install Docker, get [**Docker for Mac**](https://docs.docker.com/docker-for-mac/) from the official Docker website.

Resolving problems with Docker
------------------------------

When you get the following message: `cannot connect to docker daemon`:
- Make sure that Docker daemon is running by typing: `sudo service docker status`
- If Docker daemon is stopped, type: `sudo service docker start`
- Type `sudo` before **every** Docker command (works on Ubuntu Linux)

When you get the following message: `port is already allocated`:
- Restart Docker daemon by typing: `sudo service docker restart` and run container again (works on Ubuntu Linux)

When you have problems with Docker on Mac OS X:
- [Install Docker Toolbox](https://getcarina.com/docs/tutorials/docker-install-mac/) and open Docker Quickstart Terminal with **default** system terminal
- On Mac OS X in Docker Quickstart Terminal docker commands **should not have sudo keywords** in the beginning. That's why `ydocker.sh` shell script contains a lot of "if" statements for Linux and OS X, which is subject of improvement in the future.
- Check if size of the disk of VM is big enough
- Optionally, you can create VM with Ubuntu via VirtualBox and build container there. Remember about proper disk size.

Server endpoints
----------------
- Hybris Administration Console (HAC): `https://localhost:9002/`
- Backoffice: `https://localhost:9002/backoffice`
- B2C accelerator: `https://localhost:9002/yacceleratorstorefront/en/?site=apparel-uk&clear=true`

Platform build version
----------------------

To get information about build and version of the platform inside created container, use the following commands:

```
./ydocker -c
cat /home/sap-hybris-commerce-suite/hybris/bin/platform/build.number
```

Remarks
-------

This repository does not contain any source code or libraries of SAP Hybris Commerce Suite.
It just downloads them, if you provide valid credentials to the shell script.
You should have such credentials if you're company employee or partner.
You'll need a lot of space on disk (probably about 12 GB, but I think 15 GB is safe number), because Commerce Suite is huge project. Size of built container is 6.8 GB.
Moreover, **it's not official company's repository**.
It's just proof of concept and may be not fully functional and stable.

Testing
-------

Currently it was tested on Ubuntu Linux 14.04 LTS and works fine.

I had problems with building container on Mac OS X with Docker Toolbox. It stucked during initialization at:

```
[java] INFO  [main] [MccManager] importing resource /impex/mcc_links_id.impex
 [java] INFO  [main] (0000002N-ImpEx-Import) [ImpExImportJob] Starting ImpEx cronjob "ImpEx-Import"
 [java] INFO  [main] (0000002N-ImpEx-Import) [Importer] Finished 1 pass in 0d 00h:00m:00s:235ms - processed: 20, no lines dumped (last pass 0)
 [java] INFO  [main] [Initialization] Localizing types ...
 [java] INFO  [main] [TypeLocalization] 1 thread will be used to localize type system.
```

and couldn't go further.

References
----------

### General links
- https://github.com/pwittchen/learning-docker
- https://github.com/wsargent/docker-cheat-sheet
- http://blog.wittchen.biz.pl/dockerizing-hybris/

### Similar projects
- https://github.com/stefanleh/hybris-base-image
- https://github.com/stefanleh/hybris-mysql
- https://github.com/stefanleh/hybris-datahub-mysql
- https://github.com/debianmaster/docker-hybris
- https://github.com/prelegalwonder/hybris-docker
- https://github.com/mlong168/hybris-docker

License
-------

    Copyright 2016 Piotr Wittchen

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
