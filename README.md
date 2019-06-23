# LND node with Tor

Docker Compose configuration which enables a LND node to run through Tor with a Bitcoin node also running through Tor.

# Quick Start

Edit the `.env` file to change the LND alias and/or color.

```
./build.bash
./start.bash && docker-compose logs -f
```

**Beware! This will start downloading the entire bitcoin blockchain over Tor which is over 500 GB in size.**

To directly interact with the lnd service using the command line use `docker-compose exec -u lnd lnd lncli --help`. To enter a command prompt use the command `docker-compose exec -u lnd lnd sh`.

After the bitcoin blockchain has been synced, the lightning node can be unlocked and connected to on port 8080.

You probably will need to delete the `tls.cert` (and `tls.key` ?) and restart the lnd service at least once because the certificate is bound to 127.0.0.1 only.

```
rm lnd_data/tls.cert
docker-compose restart lnd
```

Then a client like Joule can be connected to the LND node using the `https://localhost:8080` URL.

# Exposing Bitcoin Ports

By default, bitcoin ports are only availble to the LND container. To expose bitcoin ports copy the `overrides/bitcoin-expose-ports.yml.tpl` to `overrides/bitcoin-expose-ports.yml`. This will allow `./start.bash` script to find the an additional configuration file for Docker Compose to load.

# Why?

The intention of this Docker Compose configuration is to make it easy to get a private LND node up and running. It should be as easy as building the containers with `./build.bash` and starting them up with the `./start.bash` command.

Managing the node and connecting other applications such as Zap or Joule to the node is another story! Good luck, have fun!
