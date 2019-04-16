# LND node with Tor

Docker Compose configuration which enables a LND node to run through Tor with a Bitcoin node also running through Tor.

# Quick Start

Edit the `.env` file to change the LND alias and/or color. You could also override the variables on the command line with `-e` option.

```
docker-compose build --build-arg LOCAL_USER_ID=$(id -u $USER) --build-arg LOCAL_GROUP_ID=$(id -g $USER)
docker-compose up -d && docker-compose logs -f
```

Use the `build.bash` script if you cannot remember the `--build-arg` syntax.

**Beware! This will start downloading the entire bitcoin blockchain over Tor which is over 500 GB in size.**

To directly interact with the lnd service using the command line use `docker-compose exec -u lnd lnd lncli --help`. To enter a command prompt use the command `docker-compose exec -u lnd lnd sh`.

After the bitcoin blockchain has been synced, the lightning node can be unlocked and connected to on port 8080.

You probably will need to delete the `tls.cert` (and `tls.key` ?) and restart the lnd service at least once because the certificate is bound to 127.0.0.1 only.

```
rm lnd_data/tls.cert
docker-compose restart lnd
```

Then a client like Joule can be connected to the LND node using the `https://localhost:8080` URL.

# Why?

The intention of this Docker Compose configuration is to make it easy to get a private LND node up and running. If you are familiar with Docker then it should be as easy as building the containers with `./build.sh` and starting them up with the `docker-compose up -d` command.

Managing the node and connecting other applications such as Zap or Joule to the node is another story! Good luck, have fun!
