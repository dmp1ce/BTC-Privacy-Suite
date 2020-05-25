# Variables here are used to generate the bitcoin.conf and lnd.conf
# afterwords they are no longer used unless the .conf file is deleted

# LND name and color
LND_ALIAS=LND Node
LND_COLOR=#ffffff

# Change RPC user and password to secure RPC access
RPCUSER=alice
RPCPASSWORD=some_password_here

# testnet for bitcoin and lnd:
# 0 = testnet off, 1 = testnet on
TESTNET_NUM=0

# mainnet or testnet (used for ElectRS and JoinMarket)
NETWORK=mainnet
NETWORK_PORT=8332