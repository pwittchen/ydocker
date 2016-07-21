ydocker
=======

get, build, initialize and run SAP Hybris Commerce Suite inside Docker container

Contents
--------
- [Usage](#usage)
- [Server endpoints](#server-endpoints)
- [Resolving problems with Docker](#resolving-problems-with-docker)
- [Remarks](#remarks)
- [License](#license)

Usage
-----

You can use helper shell script called `ydocker.sh` with the following parameters:

```
-b    building Docker container
-r    running Hybris Server in Docker container
-c    running Docker container with CLI
-d    deleting Docker container
-h    showing help
```

Inside `ydocker.sh` file you can customize **version of the Commerce Suite** and **installation recipe**.

Default version is `6.1.0.0.12816` and default recipe is `b2c_acc`.

Please remember that you need to have your own SAP e-mail and password
in order to be able to download SAP Hybris Commerce Suite from Hybris repository inside Docker container.

Server endpoints
----------------
- Hybris Administration Console (HAC): `https://localhost:9002/`
- Backoffice: `https://localhost:9002/backoffice`
- B2C accelerator: `https://localhost:9002/yacceleratorstorefront/en/?site=apparel-uk&clear=true`

Resolving problems with Docker
------------------------------

When you get the following message: `cannot connect to docker daemon`:
- Make sure that Docker daemon is running by typing: `sudo service docker status`
- If Docker daemon is stopped, type: `sudo service docker start`
- Type `sudo` before **every** Docker command (works on Ubuntu Linux)

When you get the following message: `port is already allocated`:
- Restart Docker daemon by typing: `sudo service docker restart` and run container again

Remarks
-------

This repository does not contain any source code or libraries of SAP Hybris Commerce Suite.
It just downloads them, if you provide valid credentials to the shell script.
You should have such credentials if you're company employee or partner.
Moreover, **it's not official company's repository**.
It's just proof of concept and may be not fully functional and stable.

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
