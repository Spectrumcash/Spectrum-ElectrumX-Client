#!/bin/bash
set -ev

if [[ -z $TRAVIS_TAG ]]; then
  echo TRAVIS_TAG unset, exiting
  exit 1
fi

BUILD_REPO_URL=https://github.com/akhavr/electrum-chaincoin.git

cd build

git clone --branch $TRAVIS_TAG $BUILD_REPO_URL electrum-chaincoin

cd electrum-chaincoin

export PY36BINDIR=/Library/Frameworks/Python.framework/Versions/3.6/bin/
export PATH=$PATH:$PY36BINDIR
source ./contrib/chaincoin/travis/electrum_chaincoin_version_env.sh;
echo wine build version is $ELECTRUM_CHAINCOIN_VERSION

sudo pip3 install --upgrade pip
sudo pip3 install -r contrib/deterministic-build/requirements.txt
sudo pip3 install \
    x11_hash>=1.4 \
    pycryptodomex==3.6.0 \
    btchip-python==0.1.27 \
    keepkey==4.0.2 \
    trezor==0.10.1

pyrcc5 icons.qrc -o gui/qt/icons_rc.py

export PATH="/usr/local/opt/gettext/bin:$PATH"
./contrib/make_locale
find . -name '*.po' -delete
find . -name '*.pot' -delete

cp contrib/chaincoin/osx.spec .
cp contrib/chaincoin/pyi_runtimehook.py .
cp contrib/chaincoin/pyi_tctl_runtimehook.py .

pyinstaller \
    -y \
    --name electrum-chaincoin-$ELECTRUM_CHAINCOIN_VERSION.bin \
    osx.spec

sudo hdiutil create -fs HFS+ -volname "Electrum-CHAINCOIN" \
    -srcfolder dist/Electrum-CHAINCOIN.app \
    dist/electrum-chaincoin-$ELECTRUM_CHAINCOIN_VERSION-macosx.dmg
