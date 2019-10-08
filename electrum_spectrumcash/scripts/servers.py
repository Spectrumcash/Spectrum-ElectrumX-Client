#!/usr/bin/env python3
import json
import asyncio

from electrum_spectrumcash.simple_config import SimpleConfig
from electrum_spectrumcash.network import filter_version, Network
from electrum_spectrumcash.util import create_and_start_event_loop, log_exceptions
from electrum_spectrumcash import constants

# testnet?
#constants.set_testnet()
config = SimpleConfig({'testnet': False})

loop, stopping_fut, loop_thread = create_and_start_event_loop()
network = Network(config)
network.start()

@log_exceptions
async def f():
    try:
        peers = await network.get_peers()
        peers = filter_version(peers)
        print(json.dumps(peers, sort_keys=True, indent=4))
    finally:
        stopping_fut.set_result(1)

asyncio.run_coroutine_threadsafe(f(), loop)
