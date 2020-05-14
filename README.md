# docker-sshd

## Usage

For the data to persist, you need named volumes or bind mounts for `/opt/sshd`, where the OpenSSH server keys are stored, and `/home`, where the created users and their homes are kept. You should also forward a port in you host to port 22 in your container. An example run command forwarding port 8022/tcp in your host would be:

```sh
$ docker run --name sshd -p 8022:22/tcp -v sshd:/opt/sshd -v home:/home juanelas:sshd
```

When the container is running, assuming you named it `sshd`, you can create a user with username `pancho` and password `hello1234` with:

```sh
$ docker exec sshd adduser.sh pancho hello1234
```

To delete user `pancho`:
```sh
$ docker exec sshd deluser.sh pancho
```

## docker-compose

An example `docker-compose.yml` listening on port 8022/tcp:

```yaml
version: '3.4'

services:
  sshd:
    image: "juanelas:sshd"
    container_name: sshd
    ports:
      - 8022:22/tcp
    volumes:
      - home:/home
      - sshd:/opt/sshd
    restart: always

volumes:
    home:
    sshd:
```