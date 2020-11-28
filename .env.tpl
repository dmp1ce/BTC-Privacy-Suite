# Variables here are used to generate the bitcoin.conf and lnd.conf
# afterwords they are no longer used unless the .conf file is deleted

# LND name and color
LND_ALIAS=LND Node
LND_COLOR=#ffffff
LND_LISTEN_PORT=9735
LND_RPC_PORT=10009
LND_REST_PORT=8080

# Change RPC user and password to secure RPC access
RPCUSER=alice
RPCPASSWORD=some_password_here

# testnet for bitcoin and lnd:
# 0 = testnet off, 1 = testnet on
TESTNET_NUM=0

# mainnet or testnet (used for ElectRS and JoinMarket)
NETWORK=mainnet
NETWORK_PORT=8332

# local user and group id used by contains to make sure file ownership matches local user
LOCAL_USER_ID=${LOCAL_USER_ID}
LOCAL_GROUP_ID=${LOCAL_USER_GROUP}
