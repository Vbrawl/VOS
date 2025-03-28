#!/bin/bash

set -e

GZIP_SRC=$CACHE/gzip
GZIP_RPM_NAME=Gzip
GZIP_VERSION="1.13"
$ROOT/download_and_untar.sh "https://ftp.gnu.org/gnu/gzip/gzip-1.13.tar.xz" $GZIP_SRC

if [ ! -d $GZIP_SRC/build ]
then
  mkdir -p $GZIP_SRC/build
  cd $GZIP_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi
#cd $GZIP_SRC/build
#make DESTDIR=$ISO_SYSROOT install

# Build TAR ball ($GZIP_SRC/build/${GZIP_RPM_NAME}-${GZIP_VERSION}.tar)
cd $GZIP_SRC/build
$ROOT/generate_tar.sh make $GZIP_SRC/build/${GZIP_RPM_NAME}-${GZIP_VERSION}.tar ${GZIP_RPM_NAME}-${GZIP_VERSION} usr/bin/{gunzip,gzip,zcat,zdiff,zfgrep,zgrep,zmore,gzexe,uncompress,zcmp,zegrep,zforce,zless,znew}

# Build RPM
rm -r $GZIP_SRC/build/rpmbuild || true
mkdir -p $GZIP_SRC/build/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
cp ${GZIP_RPM_NAME}-$GZIP_VERSION.tar $GZIP_SRC/build/rpmbuild/SOURCES

cat > $GZIP_SRC/build/rpmbuild/SPECS/${GZIP_RPM_NAME}.spec << EOF
Name: $GZIP_RPM_NAME
Version: $GZIP_VERSION
Release: 1
Summary: Gzip terminal utility/program
ExclusiveArch: $ARCH
License: GPL
Source0: ${GZIP_RPM_NAME}-${GZIP_VERSION}.tar

%description
GNU Gzip is a popular data compression program originally written by Jean-loup Gailly for the GNU project. Mark Adler wrote the decompression part.

%prep
%setup -q
%install
rm -rf %{buildroot}
mkdir -p %{buildroot}/%{_bindir}
cp -a usr/bin/* %{buildroot}/%{_bindir}

%files
%{_bindir}/gunzip
%{_bindir}/gzip
%{_bindir}/zcat
%{_bindir}/zdiff
%{_bindir}/zfgrep
%{_bindir}/zgrep
%{_bindir}/zmore
%{_bindir}/gzexe
%{_bindir}/uncompress
%{_bindir}/zcmp
%{_bindir}/zegrep
%{_bindir}/zforce
%{_bindir}/zless
%{_bindir}/znew
EOF

rpmbuild --define "_topdir ${GZIP_SRC}/build/rpmbuild" -ba $GZIP_SRC/build/rpmbuild/SPECS/${GZIP_RPM_NAME}.spec
cp $GZIP_SRC/build/rpmbuild/RPMS/$ARCH/${GZIP_RPM_NAME}-${GZIP_VERSION}-1.$ARCH.rpm $ISO_RPMS
