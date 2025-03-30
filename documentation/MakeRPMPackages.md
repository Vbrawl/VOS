
# RPM package generation steps:

1) generate_tar
2) generate_rpm

# generate_tar

To make an RPM we first need to make a TAR file.

We call `$ROOT/generate_tar.sh` with the following parameters:
1) INSTALL_METHOD (make, cmake, meson)
2) DST_TAR - Fullpath to output TAR
3) SRC_DIR - Directory to package

After the 3rd parameter all parameters are the files to be packed.
NOTE: We need to write the path relative to SRC_DIR

# generate_rpm

Finally we can generate an RPM package.
We call `$ROOT/generate_rpm.sh` with the following parameters:
1) RPMDEST - Destination directory for the RPM package (1)
2) RPMBUILD - RPM build directory for this project/package
3) RPMNAME - Name of the RPM package
4) VERSION - Version of the package
5) SUMMARY - A mini description of the package
6) DESCRIPTION - A complete description of the package
7) LICENSE - The license used by the package
8) TARFILE - The tar file generated in the previous step

After the 8th parameter all parameters are a source/destination pair:
- source: path/to/source (relative to .tar)
- destination: path/to/destination (as a .rpm macro)

NOTE: For the parameters after TARFILE we can do the following:

```
source environment.sh
# ATTENTION: Make sure to find the build directory created by the builder script
cd $CACHE/package/build
# ATTENTION: You may need to replace the command with another equivalent
make DESTDIR=$(pwd)/ii install
cd ii
```

Now find the directories you wish to include, for example to include the
usr/bin directory:

```
$ROOT/find_files_for_rpm.sh "$(pwd)" "usr/bin" "%{_bindir}"
```

Another example, to include usr/lib directory:

```
$ROOT/find_files_for_rpm.sh "$(pwd)" "usr/lib" "%{_libdir}"
```

And then copy the output and paste it to the parameter list of
`$ROOT/generate_rpm.sh`
