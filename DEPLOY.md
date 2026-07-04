# Setup

The deployment script will 
- ensure the podman secret imich_db_password exsts,
- create all necessary folders,
- replace variables in the files (via `envsubst`) and
- put the files in the search path for quadlets.

```shell
. ./deploy.sh
```

Then start the pod via

```shell
systemctl --user start immich-pod
```

You can check if all containers are up via

```shell
systemctl --user list-units | grep immich
```