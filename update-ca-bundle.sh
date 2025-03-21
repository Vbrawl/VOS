#!/bin/bash

URL="https://curl.se/ca/cacert.pem"

mkdir -p $ROOT/fs/usr/ssl/
wget "$URL" -O $ROOT/fs/usr/ssl/bundle.crt
