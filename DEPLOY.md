# Setup

The deployment script will 
- ensure the podman secret imich_db_password exsts,
- create all necessary folders,
- replace variables in the files (via `envsubst`) and
- put the files in the search path for quadlets.

```shell
. ./immich/deploy.sh
```

Then start the pod via

```shell
systemctl --user start immich-pod
```

You can check if all containers are up via

```shell
systemctl --user list-units | grep immich
```

## Enable Machine Learning

You need to change the machine learning URL in the admin settings to http://localhost:3003 in order for it to work. See [README.md](README.md).


## Start at boot

You need to tell the server to spin up your user systemd instance at boot:

```shell
loginctl enable-linger
```

To ensure the service starts on boot, you need to enable it:

```shell
systemctl --user enable immich-pod
```