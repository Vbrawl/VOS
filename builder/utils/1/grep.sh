#!/bin/bash

GREP_SRC=$CACHE/grep
GREP_RPM_NAME=Grep
GREP_VERSION="3.11"
$ROOT/download_and_untar.sh "https://ftp.gnu.org/gnu/grep/grep-3.11.tar.xz" "$GREP_SRC"

if [ ! -d $GREP_SRC/build ]
then
  mkdir -p $GREP_SRC/build
  cd $GREP_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi

# Build TAR ball ($GREP_SRC/build/sysroot/grep-${GREP_VERSION}.tar)
if [ -d $GREP_SRC/build/${GREP_RPM_NAME}-${GREP_VERSION} ]
then
  rm -r $GREP_SRC/build/${GREP_RPM_NAME}-${GREP_VERSION}
  rm $GREP_SRC/build/${GREP_RPM_NAME}-${GREP_VERSION}.tar
fi

cd $GREP_SRC/build
make DESTDIR=$GREP_SRC/build/${GREP_RPM_NAME}-${GREP_VERSION} install
tar -cf ${GREP_RPM_NAME}-${GREP_VERSION}.tar ${GREP_RPM_NAME}-${GREP_VERSION}/usr/bin/{egrep,fgrep,grep}

# Build RPM
if [ -d $GREP_SRC/build/rpmbuild ]
then
  rm -r $GREP_SRC/build/rpmbuild
fi
mkdir -p $GREP_SRC/build/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
cp ${GREP_RPM_NAME}-${GREP_VERSION}.tar $GREP_SRC/build/rpmbuild/SOURCES

cat > $GREP_SRC/build/rpmbuild/SPECS/${GREP_RPM_NAME}.spec << EOF
Name: $GREP_RPM_NAME
Version: $GREP_VERSION
Release: 1
Summary: Grep terminal utility/program
ExclusiveArch: $ARCH
License: GPL
Source0: ${GREP_RPM_NAME}-${GREP_VERSION}.tar

%description
Grep searches one or more input files for lines containing a match to a specified pattern.

%prep
%setup -q
%install
rm -rf \$RPM_BUILD_ROOT
mkdir -p \$RPM_BUILD_ROOT/%{_bindir}
cp usr/bin/grep \$RPM_BUILD_ROOT/%{_bindir}/grep

%files
%{_bindir}/grep
EOF

rpmbuild --define "_topdir ${GREP_SRC}/build/rpmbuild" -ba $GREP_SRC/build/rpmbuild/SPECS/${GREP_RPM_NAME}.spec
cp $GREP_SRC/build/rpmbuild/RPMS/x86_64/Grep-3.11-1.x86_64.rpm $ISO_RPMS
