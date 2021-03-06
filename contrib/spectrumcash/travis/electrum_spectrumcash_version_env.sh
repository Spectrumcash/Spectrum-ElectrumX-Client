#!/bin/bash

VERSION_STRING=(`grep ELECTRUM_VERSION electrum_spectrumcash/version.py`)
SPECTRUMCASH_ELECTRUM_VERSION=${VERSION_STRING[2]}
SPECTRUMCASH_ELECTRUM_VERSION=${SPECTRUMCASH_ELECTRUM_VERSION#\'}
SPECTRUMCASH_ELECTRUM_VERSION=${SPECTRUMCASH_ELECTRUM_VERSION%\'}
export SPECTRUMCASH_ELECTRUM_VERSION

APK_VERSION_STRING=(`grep APK_VERSION electrum_spectrumcash/version.py`)
SPECTRUMCASH_ELECTRUM_APK_VERSION=${APK_VERSION_STRING[2]}
SPECTRUMCASH_ELECTRUM_APK_VERSION=${SPECTRUMCASH_ELECTRUM_APK_VERSION#\'}
SPECTRUMCASH_ELECTRUM_APK_VERSION=${SPECTRUMCASH_ELECTRUM_APK_VERSION%\'}
export SPECTRUMCASH_ELECTRUM_APK_VERSION
