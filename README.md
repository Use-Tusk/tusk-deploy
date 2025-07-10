![Tusk Logo](./img/tusk_logo.svg)

Welcome! This repo will help you with deploying Tusk.

# Getting started

Note: Currently our install script is tailored for **Ubuntu**.
Simply clone this repo, run `./install.sh` and follow the prompts.
However, it is also get started on other distros as long as you
have installed docker and docker compose.

To get started, log into your machine and run the following:
```
git clone https://github.com/Use-Tusk/tusk-deploy.git
cd tusk-deploy
./install.sh
```
You should have been provided with our docker registry key. Enter it when asked.
After the script finishes, please log out and log back in for the user group
changes to take effect. This is important, otherwise you might face permission
issues later on.

Finally, after logging back in you can run
```
docker compose up -d
```
in the folder cloned above to start the service.

# Updating

Run the following in the cloned folder:
```
docker compose pull
docker compose up -d
```
