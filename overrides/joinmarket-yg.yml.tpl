version: '3.8'

x-jm-settings: &jm-settings

  # Yield Generator settings
  JM_ORDERTYPE: reloffer    # [string, 'reloffer' or 'absoffer'] / which fee type to actually use
  JM_CJFEE_A: 500           # [satoshis, any integer] / absolute offer fee you wish to receive for coinjoins (cj)
  JM_CJFEE_R: "0.00002"     # [fraction, any str between 0-1] / relative offer fee you wish to receive based on a cj's amount
  JM_CJFEE_FACTOR: 0.1      # [fraction, 0-1] / variance around the average fee. Ex: 200 fee, 0.2 var = fee is btw 160-240
  JM_TXFEE: 0               # [satoshis, any integer] / the average transaction fee you're adding to coinjoin transactions
  JM_TXFEE_FACTOR: 0.3      # [fraction, 0-1] / variance around the average fee. Ex: 1000 fee, 0.2 var = fee is btw 800-1200
  JM_MINSIZE: 100000        # [satoshis, any integer] / minimum size of your cj offer. Lower cj amounts will be disregarded
  JM_SIZE_FACTOR: 0.1       # [fraction, 0-1] / variance around all offer sizes. Ex: 500k minsize, 0.1 var = 450k-550k
  JM_GAPLIMIT: 6

  # Wrapper script settings
  JM_WALLET_FILE: "yg.jmdat"                # [filename] / Wallet file to use
  JM_WALLET_PASSWORD: "password"            # [string] / Password for the wallet
  JM_YG_SCRIPT: "yield-generator-basic.py"  # [filename, 'yield-generator-basic.py' or 'yg-privacyenhanced.py'] / Script to use for market making 
  JM_NATIVE_SEGWIT: "false"

services:
  joinmarket-yg:
    build:
      context: docker/joinmarket
    restart: always
    network_mode: service:tor
    depends_on:
      - joinmarketd
      - tor
      - bitcoin
    volumes:
      - ${_HOST_TOR_DATA:?}:${_GUEST_TOR_DATA:?}:ro
      - ${_HOST_TOR_CONFIG:?}:${_GUEST_TOR_CONFIG:?}:ro
      - ${_HOST_JOINMARKET:?}:${_GUEST_JOINMARKET:?}
    command: yg-wrapper.sh
    tty: true
    env_file:
      - .env
      - env/bitcoin.env
    environment:
      <<: *jm-settings
