# Variables here are used by all services

# local user and group id used by contains to make sure file ownership matches local user
LOCAL_USER_ID=${LOCAL_USER_ID}
LOCAL_GROUP_ID=${LOCAL_USER_GROUP}

# Additional variables for various service yml files.

# Tor mounts
_SRC_TOR_DATA=./.data/tor/data
_DST_TOR_DATA=/var/lib/tor
_SRC_TOR_CONFIG=./.data/tor/config
_DST_TOR_CONFIG=/etc/tor

# Bitcoin mounts
_SRC_BITCOIN=./.data/bitcoin
_DST_BITCOIN=/home/bitcoin/.bitcoin

# LND mounts
_SRC_LND=./.data/lnd
_DST_LND=/home/lnd/.lnd

# ElectRS mounts
_SRC_ELECTRS_DATA=./.data/electrs/electrs
_DST_ELECTRS_DATA=/home/user/.electrs
_SRC_ELECTRS_NGINX=./.data/electrs/nginx
_DST_ELECTRS_NGINX=/root/keys

# JoinMarket mounts
_SRC_JOINMARKET=./.data/joinmarket
_DST_JOINMARKET=/home/joinmarket/.joinmarket

# Lightning Terminal mounts
_SRC_LIT_LIT=./.data/lit/lit
_DST_LIT_LIT=/home/lit/.lit
_SRC_LIT_FARADAY=./.data/lit/faraday
_DST_LIT_FARADAY=/home/lit/.faraday
_SRC_LIT_LOOP=./.data/lit/loop
_DST_LIT_LOOP=/home/lit/.loop
_SRC_LIT_POOL=./.data/lit/pool
_DST_LIT_POOL=/home/lit/.pool

# RTL mounts
_SRC_RTL=./.data/rtl
_DST_RTL=/home/node/.rtl
