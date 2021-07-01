# Build variables used by all services

# local user and group id used by contains to make sure file ownership matches local user
LOCAL_USER_ID=${LOCAL_USER_ID}
LOCAL_GROUP_ID=${LOCAL_USER_GROUP}

# Additional variables for various service yml files.

# Tor mounts
_HOST_TOR_DATA=./.data/tor/data
_GUEST_TOR_DATA=/var/lib/tor
_HOST_TOR_CONFIG=./.data/tor/config
_GUEST_TOR_CONFIG=/etc/tor

# Bitcoin mounts
_HOST_BITCOIN=./.data/bitcoin
_GUEST_BITCOIN=/home/bitcoin/.bitcoin

# LND mounts
_HOST_LND=./.data/lnd
_GUEST_LND=/home/lnd/.lnd

# LND ports
_HOST_LND_REST_PORT=8080
_GUEST_LND_REST_PORT=8080
_HOST_LND_RPC_PORT=10009
_GUEST_LND_RPC_PORT=10009

# ElectRS mounts
_HOST_ELECTRS_DATA=./.data/electrs/electrs
_GUEST_ELECTRS_DATA=/home/user/.electrs
_HOST_ELECTRS_NGINX=./.data/electrs/nginx
_GUEST_ELECTRS_NGINX=/root/keys

# JoinMarket mounts
_HOST_JOINMARKET=./.data/joinmarket
_GUEST_JOINMARKET=/home/joinmarket/.joinmarket

# Lightning Terminal mounts
_HOST_LIT_LIT=./.data/lit/lit
_GUEST_LIT_LIT=/home/lit/.lit
_HOST_LIT_FARADAY=./.data/lit/faraday
_GUEST_LIT_FARADAY=/home/lit/.faraday
_HOST_LIT_LOOP=./.data/lit/loop
_GUEST_LIT_LOOP=/home/lit/.loop
_HOST_LIT_POOL=./.data/lit/pool
_GUEST_LIT_POOL=/home/lit/.pool

# RTL mounts
_HOST_RTL=./.data/rtl
_GUEST_RTL=/home/node/.rtl

# Sphinx Chat
_SPHINX_CHAT_PORT_GUEST=3001
_SPHINX_CHAT_PORT_HOST=3001
