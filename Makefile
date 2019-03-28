#
# == Paths & Directories ==
#

ROOT_DIR  := $(shell pwd)
VENV_DIR := .virtualenv

#
# == Configuration ==
#

TESTRPC_PORT ?= 8545
DAPP_PORT    ?= 8435

#
# == Commands ==
#

MKDIR      := mkdir -p
LN         := ln
FIND       := find
TRUFFLE    := $(NODE_DIR)/truffle/build/cli.bundled.js
PIP        := $(VENV_DIR)/bin/pip
PYTHON3    := $(shell command -v python3 2> /dev/null)

#
# == Top-Level Targets ==
#

contract: build/contracts/MultiSig2of3.json

testrpc:
	$(TESTRPC) --port $(TESTRPC_PORT)

freeze:
	$(PIP) freeze > requirements.frozen.txt

#
# == Contract ==
#

build/contracts/MultiSig2of3.json: contracts/MultiSig2of3.sol
	$(TRUFFLE) compile

#
# == Dependencies ==
#

$(VENV_DIR):
	$(PYTHON3) -m venv $(VENV_DIR)


python-dependencies: $(VENV_DIR)
	$(PYTHON3) -m ensurepip --upgrade
	$(PIP) install -r requirements.frozen.txt
