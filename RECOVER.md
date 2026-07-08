
# Recover from Borg Backup

Execute the `deploy.sh` script. Then extract the contents from the borg backup library folder to the library folder on the server. Afterwards start the immich service. Now recover the database via:

```shell
podman exec -i systemd-immich-database psql --username=postgres < "immich/library/backups/database-cli/immich-database.sql"
```

After the database restore, restart the service. Within the Immich Webconsole, set the machine Learning URL. Then start the job for meta data creation (will be lost for videos). Then the jobs for thumbnails and finally video transcoding.