# Docker short tips

## Changing root dir

- Stop `docker.service` and `docker.socket`: `sudo systemctl stop service_name`
- Create a new dir to receive the docker files: `mkdir path_to/new_docker_dir`
  - Copy the files there: `sudo rsync -aqxP /var/lib/docker path_to/new_docker_dir`
- Create the config file for the new docker root:
  - `touch /etc/docker/daemon.json`
  - Paste the following content:
  ```json
  {
    "data-root": "path_to/new_docker_dir"
  }
  ```
  - Save and quit
- Restart the docker daemons: `sudo systemctl start docker.socket (and then docker.service)`
- Check the status with `sudo systemctl status docker`
- Check if the new docker dir has been set: `sudo docker info | grep "Docker Root Dir"`
- Remove the old docker folder: `sudo rm -rf /var/lib/docker/`
