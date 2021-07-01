version: '3.8'

services:
  tor:
    ports:
      # RPC
      - "8332:8332"
      # zmqpubrawblock
      - "18501:18501"
      # zmqpubrawtx
      - "18502:18502"
