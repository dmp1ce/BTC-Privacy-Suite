# LND node with Tor

Docker Compose configuration which enables a LND node to run through Tor with a Bitcoin node also running through Tor.

# Requirements

A networked computer capable of running Docker and Docker Compose is all that should be needed. It is also recommended to have 1 TB of hard drive space to store the Bitcoin blockchain. The more CPU, RAM and network bandwidth the better as Bitcoin uses CPU to validate, RAM to store and bandwidth to broadcast and receive data.

## Software

- Docker
- Docker Compose
- Bash (for helper scripts)

## Hardware

- Broadband internet
- 1 TB of hard drive space (Recommended)

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

# Enabling overrides

Only Tor, Bitcoin Daemon and LND are started considered core services. Everything else needs to be enabled using a Docker Compose override. To enable a Docker Compose override, create a `.yml` file in the `overrides` directory and then remember to use the `build.bash` and `start.bash` scripts when building and running docker-compose commands.

Some supported overrides are explained in further detail.

## Exposing Bitcoin Ports

By default, bitcoin ports are only availble to the LND container. To expose bitcoin ports copy the `overrides/bitcoin-expose-ports.yml.tpl` to `overrides/bitcoin-expose-ports.yml`. This will allow `./start.bash` script to find the an additional configuration file for Docker Compose to load.

To allow access from any computer (other than the one running docker) the `bitcoin.conf` needs to be modified to allow additional IP addresses such as the `rpcallowip=0.0.0.0/0` wildcard which will allow any IP address to use RPC.

## Electrum Server

To enable the Electrum Server service copy the `overrides/electrs.yml.tpl` to `overrides/electrs.yml` and then run `./build.bash` to build the container.

Add (uncomment) the following lines in the `tor_config/torrc` file in order to enable the Tor service for Electrum Server. The `5000*` ports are for mainnet. The `6000*` ports are for testnet.

```
HiddenServiceDir /var/lib/tor/electrs/
HiddenServiceVersion 3
HiddenServicePort 50001 127.0.0.1:50001
HiddenServicePort 50002 127.0.0.1:50002
HiddenServicePort 60001 127.0.0.1:60001
HiddenServicePort 60002 127.0.0.1:60002
```

Restart the Tor service with with `./start.bash restart tor` for the Electrum Server hidden server to be created. Then `use ./start.bash` to start the Electrum Server which includes `electrs` and `nginx`. `nginx` is for allowing for a TLS endpoint.

To connect Electrum to the Electrum Server, please see the [Electrum documentation on connecting to a single server through a Tor proxy](https://electrum.readthedocs.io/en/latest/tor.html#option-1-single-server).

For a one liner, you can use `electrum -1 -s electrums3lojbuj.onion:50002:s -p socks5:localhost:9050` but you may want to also ensure one server and no auto connect in the configuration file as well like so:

``` json
    "auto_connect": false,
    "oneserver": true,
```

For reference, the `:s` in `electrums3lojbuj.onion:50002:s` specifies a secure (TLS) connection. A `:t` would specify an unsecure (TCP) connect. Both are supported. `50001` uses unsecure connections and `50002` uses secure connections. Both are ultimately secure if using and onion address, because Tor is encrypted from client to hidden service. The secure (TLS) endpoing is important if connecting an Electrum Android client and maybe some other clients. To get the `.onion` to connect to, run the `.onion.bash` script.

# LND compatible clients

Both Joule and Zeus are supported for this docker configuration. Both are intended to be connected directly to the IP address, not going through Tor or an onion. The reason for not using Tor is because it is unclear to if it is secure to allow the LND RPC to be exposed publicly. To connect globally from to the LND server will require a VPN which is not covered by this project currently.

Before trying to connect a client, don't forget to create a wallet and unlock LND. For example:

```
# Create wallet
./start exec -u lnd lnd lncli create

# Unlock wallet
./start exec -u lnd lnd lncli unlock
```

## Joule

Joule needs to connect to the LND server with the IP address and on the `8080` port. For example https://localhost:8080. In the browser, an "unsafe" certificate may need to be allowed. The reason it is marked as "unsafe" by the browser is because it hasn't been signed by a certificate authority.

The macaroons are located in `lnd_data/data/chain/bitcoin/mainnet` and can be upload to Joule as needed. The admin and readonly macaroons are needed for Joule.

## Zeus

Zeue needs to connect to the LND server with the IP address and on the `8080` port. For example, `localhost` for the host and `8080` for the REST port. The admin macaroons need to be copied as Hex format. To get the macaroons in Hex format the `macaroon.bash` script can be used. For example, to get the admin macaroon try `./macaroon.bash mainnet admin`.

# Why?

The intention of this Docker Compose configuration is to make it easy to get a private Bitcoin services up and running. It should be as easy as building the containers with `./build.bash` and starting them up with the `./start.bash` command.

Please open and issue or pull request for suggestions on either the configuration or documentation. I would like this to be a resource for getting all required Bitcoin services up and running on a single, modern day server.
