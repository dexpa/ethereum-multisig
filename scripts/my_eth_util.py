#!/usr/bin/env python
from web3 import Web3, HTTPProvider, middleware
from web3.gas_strategies.time_based import medium_gas_price_strategy


all_ethereum_networks = ['local', 'mainnet', 'ropsten', 'rinkeby']


def create_node(network_type=0):
    network = all_ethereum_networks[network_type]
    if network == 'local':
        LOCAL_NODE = 'http://localhost:8545'
    else:
        LOCAL_NODE = 'https://{}.infura.io/v3/af13ffcce8c64f6796185cc860609fd0'.format(network)
    print("Creating w3 instance using {}".format(LOCAL_NODE))
    w3 = Web3(HTTPProvider(LOCAL_NODE, request_kwargs={'timeout': 60}))
    print("Chain ID {}, latest block {}".format(w3.net.chainId, w3.eth.blockNumber))
    w3.eth.setGasPriceStrategy(medium_gas_price_strategy)
    print("Caching gas price info...")
    w3.middleware_stack.add(middleware.time_based_cache_middleware)
    w3.middleware_stack.add(middleware.latest_block_based_cache_middleware)
    w3.middleware_stack.add(middleware.simple_cache_middleware)
    return w3
