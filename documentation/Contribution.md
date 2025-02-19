# FS

Everything under fs is going to be copied to the ISO file by the build.sh script.
If we need an empty directory we need to place a file named "EMPTY_DIR" which will be
removed on the final build.

# 
The build.sh script will create an ISO bootable file that will run
fs/installer/install.sh when booted.
