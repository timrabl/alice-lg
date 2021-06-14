# alice-lg ( docker reworked ) #
Your friendly loo.. Your docker based lookingglass.
This repo is based on the original repository: [alice-lg](https://github.com/alice-lg/alice-lg.git).

## What is this ? ##
This is a modified or better called reworked image of the original one.
The orignal image is using multi staging too, but with larger images and more multi staging.
So this repository is more lightweight ( i hope ) and builds faster ( fast is something else, round about 5 min ).
This docker image simply builds the executable in a previous build image and drops the artifact to a secound scratch alpine image.
This secound image simply runs the executable.
Yes, thats it... nothing more.

## example.conf ##
The provided `example.conf` file is cloned 1:1 from the source repository.
You can find the orignal file [here](https://github.com/alice-lg/alice-lg/blob/master/etc/alice-lg/alice.example.conf).

## docker-compose.example.conf ##
This is a simple example docker-compose file, which **have to be adopted**, to run this image.
```yaml
version: '3.1'
services:
  alice-lg:
    image: timrabl/alice-lg:latest
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./example.conf:/etc/alice-lg/alice.conf

```
See the [docekr compose docs](https://docs.docker.com/compose/) for more information.
