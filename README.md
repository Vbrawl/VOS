# VOS

This is a Linux-based operating system written by VBrawl.

It aims to be a daily driver and to support gaming, programming and hacking.

# Installer?

You need to build the installer

# Building

To build VOS simply run `build.sh` from the root directory

```
./build.sh
```

# Known Issues

* `ping` utility (and probably more) don't have the correct permissions for execution
* GCC can't compile unless you do `export PATH=/usr/libexec/gcc/x86_64-vos-linux-gnu/14.2.0/:$PATH`

# Notes

* GCC is disabled to reduce compilation time

# Requirements

These packages below refer to Debian linux distributions, you may
need to find equivalent for other linux distributions

* meson
* make
* gcc
* git
* texinfo
* libgmp-dev >= 4.2
* libmpfr-dev >= 3.1.0
* libmpc-dev >= 0.8.0
* bison
* libelf-dev
* bc
* libssl-dev
* genisoimage
* help2man
* automake
* file >= 5.44
* more... (Contributions are welcome!)
