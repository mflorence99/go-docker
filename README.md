# go-docker

Assume we'll use this repo as a real project, rather than a template for one. It's easier to talk about.

## Before you start

Update `.bash_profile`

```sh
# the root of all the Go projects ie one higher than go-docker
export DEV_DIR="$HOME/..."

export PATH=$HOME/.../go-docker/bin:$HOME/.../go-docker/bin/localhost:$PATH

source go-settings.sh
source go-secrets.sh
```

Get an account on Docker Hub.

You'll need it to share the images you create (`go-dev`, `go-hello` and `go-http`, more later) and push them to production.

Update `bin/localhost/go-settings.sh` and `bin/localhost/go-secrets.sh` with the credentials.

You'll need this to auto-login to Docker in `go-startup.sh` (more later).

Once we have the credentials, we'll need to uncomment all the `docker pull` and `docker push` commands in the scripts.

### Sometime later

Install [Transcrypt](https://github.com/elasticdog/transcrypt) in `bin/production` so that `bin/production/go-secrets.sh` will be encrypted on GitHub. 

Not needed until you have real production secrets.

## Highly recommended

Invest in centralized logging. It's really hard to track down errors from the logs on multiple Docker containers running on multiple production servers.

Centralized logging is 12 Factor.

We used Solarwinds Loggly. [They work with Go](https://www.loggly.com/solution/golang-logging/).

You might be able to get away with the [Lite plan](https://www.loggly.com/plans-and-pricing/), which is free.

Of course, there are other solutions.

## Dev machine pre-reqs

Docker and git, that's it. 

Also the `.bash_profile` settings described above.

Because dev is done inside the `go-dev` container, everyone is guaranteed to build, test and deploy using the exact same versions of Go, Alpine etc etc.

## Prod server pre-reqs

Just Docker and git also.

Each server must be initialized with `git clone https://github.com/.../go-docker.git`.

Set `.bash_profile`

```sh
export PATH=$HOME/.../go-docker/bin:$HOME/.../go-docker/bin/production:$PATH

source go-settings.sh
source go-secrets.sh
```

Whenever the settings change:

```sh
git clone https://github.com/.../go-docker.git
source ~/.bash_profile
```

## Dev workflow

After a boot, run `go-startup.sh`. 

It will emulate the 'always on' production services, like MySQL.

Also, it will login to Docker.

Also, it runs `go-cleanup.sh` which prunes orphan Docker artifacts. 

> NOTE: `docker system prune` is too aggressive. Don't use it.

To start a dev session -- to build, test or deploy Go code -- run `go-dev.sh`.

To start another session -- maybe a second Go component is dependent on the first --just run `go-dev.sh` in another terminal tab/window. It will tap into the exact same container.

Because it is important to always know whether you're running inside the `go-dev` container, it has a distinctive command prompt.

Tweak the prompt in `images/go-dev/bashrc`.

If you feel virtuous, before you shutdown, run `go-shutdown.sh`.

It will close MySQL gracefully, but it isn't really necessary. Maybe once in many years I suspected a corrupted MySQL database.

## Rule of thumb

All the scripts in `go-docker` run on the host machine, because they establish the dev (or prod) environment.

Source code edits and git commits etc are done with VSCode (or whatever) directly on the host machine.

All building, testing and deploying of actual code happens *inside* the `go-dev` container.

## MySQL

`go-docker` sets up MySQL on the dev machine as a model for all the middleware that's 'always on' on the prod servers, because you're using managed services.

`go-mysqld.sh` launches the MySQL daemon and is itself launched by `go-startup.sh`. You should never need to run it manually.

`go-mysqld-stop.sh` shuts down the MySQL daemon and is likewise launched  by `go-shutdown.sh`.

`go-mytop.sh` is most useful in production for observing server activity.

`go-mysql.sh` launches the command line for entering MySQL statements. Very useful for debugging.

The MySQL credentials are defined in `go-settings.sh` and `go-secrets.sh` both in `bin/localhost` and `bin/production`.

## go-dev

There's only one custom image `go-dev` and it is very simple.

It is based on `golang:1.14-alpine` and adds Docker.

Docker is necessary because deployment -- part of which creates a Docker image and pushes it to the hub -- is done inside the `go-dev` container.

`go-dev` mounts `$DEV_DIR` (set in `.bash_profile`) and that's the CWD at start.

## Application containers

`go-docker` contains the scripts to launch all the applications.

* dev
  * `bin/localhost/go-hello.sh`
  * `bin/localhost/go-http.sh`
* production
  * `bin/production/go-hello.sh`
  * `bin/production/go-http.sh`

They're absolutely necessary in production, of course. But you'll rarely use them in development and then mostly to test the structure of the image.

Almost all testing is done *inside* the `go-dev` container.

## Everything else

Best done in a demo or walkthru if and when you're interested.
