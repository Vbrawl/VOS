#!/bin/bash

dd if=/dev/urandom of=$BUILD_ISO/$MAGIC_FILE_NAME bs=1024 count=1
export MAGIC_FILE_HASH=$(sha256sum $BUILD_ISO/$MAGIC_FILE_NAME | cut -d ' ' -f 1)
