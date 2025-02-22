# FS

Everything under fs directory is going to be copied to the installed target, so it's possible
to view it the root of a filesystem.

NOTE: Empty directories will be copied but are discouraged due to git not tracking them. If
you want to add empty directories it's safer to do so in the builder script.

# CONFIGS

This directory contains ".config" files for all projects that need to be built.

# BUILDER

Directory containing all scripts that will be executed to generate the build directory. 
Each script is supposed to perform a single task such as add utilities

# INSTALLER

All scripts required by the installer, this directory is copied to the root of initrd.


# BUILD PROCESS

First build.sh script sets up some environment variables, creates all required directories
such as build, cache and dist, after that all scripts under "builder" directory are executed
in order. Lastly, it generates an ISO file from the "build/iso" directory with the selected bootloader.

The final iso is placed under "dist" directory.

NOTE: The cache directory is used to "store" some necessary components that are downloaded from the web
such as the linux kernel source code or busybox (there are more). To avoid multiple downloads
and redundant recompiles we simply reuse the components under that directory.
