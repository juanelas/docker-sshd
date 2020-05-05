# docker-sshd

## Usage

Clone this repo, build and run
```sh
$ git clone https://github.com/juanelas/docker-sshd.git
$ cd docker-sshd
$ docker build -t sshd .
$ docker run --name sshd -p 8022:22/tcp sshd
```

The container use volumes to persist sshd keys and users'data. If you stop the container, you can start it again and everything will continue as it was.

```sh
$ docker start sshd
```

To create a user with username `pancho` and password `hello1234`:
```sh
$ docker exec sshd adduser.sh pancho hello1234
```

To delete user `pancho`:
```sh
$ docker exec sshd deluser.sh pancho
```

## docker-compose

An example `docker-compose.yml` listening on port 22/tcp:

```yaml
version: '3.1'

services:
  sshd:
    build: .
    container_name: sshd
    ports:
      - 22:22/tcp
    volumes:
      - home:/home
      - sshd:/opt/sshd
    restart: always

volumes:
    home:
    sshd:
```