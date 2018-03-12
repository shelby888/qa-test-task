# README

## Getting started with docker

Requirements:

* docker 1.8+
* docker-compose 1.5+

To build image:

```
docker-compose build
```

To finish setup the project:

```
docker-compose run --rm web bash -c "bundle install && yarn && rake db:create db:migrate"
```

To start project:
```
docker-compose up
```

Or you can start a bash console and run the server manually:

```
docker-compose run --rm --service-ports web /bin/bash
```

Run specs
```
docker-compose run --rm web bash -c "bundle exec rake spec"
```

## Chrome debugging

Connect to localhost:5900 with vnc client.

When you are prompted for the password it is secret
