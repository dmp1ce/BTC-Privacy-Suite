# Variables here are used to generate the bitcoin.conf. Manually delete bitcoin.conf to regenerate
# with variables here.
# These variables are also be used to access bitcoind for some services

# Change RPC user and password to secure RPC access
RPCUSER=alice
RPCPASSWORD=some_password_here

# testnet for bitcoin and lnd:
# 0 = testnet off, 1 = testnet on
TESTNET_NUM=0

# mainnet or testnet (used for ElectRS and JoinMarket)
NETWORK=mainnet
NETWORK_PORT=8332
