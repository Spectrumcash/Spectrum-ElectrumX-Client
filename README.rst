Electrum-CHAINCOIN - Lightweight Chaincoinpay client
=====================================

::

  Licence: MIT Licence
  Author: Thomas Voegtlin
  Language: Python
  Homepage: https://electrum.chaincoin.org/


.. image:: https://travis-ci.org/akhavr/electrum-chaincoin.svg?branch=master
    :target: https://travis-ci.org/akhavr/electrum-chaincoin
    :alt: Build Status





Getting started
===============

Electrum-CHAINCOIN is a pure python application. If you want to use the
Qt interface, install the Qt dependencies::

    sudo apt-get install python3-pyqt5

If you downloaded the official package (tar.gz), you can run
Electrum-CHAINCOIN from its root directory, without installing it on your
system; all the python dependencies are included in the 'packages'
directory (except x11-hash).

To install x11-hash dependency in the 'packages' dir run once::

    pip3 install -t packages x11-hash

To run Electrum-CHAINCOIN from its root directory, just do::

    ./electrum-chaincoin

You can also install Electrum-CHAINCOIN on your system, by running this command::

    sudo apt-get install python3-setuptools
    pip3 install .[fast]

This will download and install the Python dependencies used by
Electrum-CHAINCOIN, instead of using the 'packages' directory.
The 'fast' extra contains some optional dependencies that we think
are often useful but they are not strictly needed.

If you cloned the git repository, you need to compile extra files
before you can run Electrum-CHAINCOIN. Read the next section, "Development
Version".



Development version
===================

Check out the code from GitHub::

    git clone https://github.com/akhavr/electrum-chaincoin.git
    cd electrum-chaincoin

Run install (this should install dependencies)::

    pip3 install .[fast]

Render the SVG icons to PNGs (optional)::

    for i in lock unlock confirmed status_lagging status_disconnected status_connected_proxy status_connected status_waiting preferences; do convert -background none icons/$i.svg icons/$i.png; done

Compile the icons file for Qt::

    sudo apt-get install pyqt5-dev-tools
    pyrcc5 icons.qrc -o gui/qt/icons_rc.py

Compile the protobuf description file::

    sudo apt-get install protobuf-compiler
    protoc --proto_path=lib/ --python_out=lib/ lib/paymentrequest.proto

Create translations (optional)::

    sudo apt-get install python-requests gettext
    ./contrib/make_locale




Creating Binaries
=================


To create binaries, create the 'packages' directory::

    ./contrib/make_packages

This directory contains the python dependencies used by Electrum-CHAINCOIN.

Android
-------

See `gui/kivy/Readme.txt` file.
