#!/bin/bash

GAWK_SRC=$CACHE/gawk
GAWK_RPM_NAME=Gawk
GAWK_VERSION="5.3.1"
$ROOT/download_and_untar.sh "https://ftp.gnu.org/gnu/gawk/gawk-5.3.1.tar.xz" "$GAWK_SRC"

if [ ! -d $GAWK_SRC/build ]
then
  mkdir -p $GAWK_SRC/build
  cd $GAWK_SRC/build
  ../configure --prefix=/usr --sysconfdir=/etc --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi
cd $GAWK_SRC/build

# Build TAW ball ($GAWK_SRC/build/${GAWK_RPM_NAME}-${GAWK_VERSION}.tar)
cd $GAWK_SRC/build
$ROOT/generate_tar.sh make $GAWK_SRC/build/${GAWK_RPM_NAME}-${GAWK_VERSION}.tar ${GAWK_RPM_NAME}-${GAWK_VERSION} \
    usr/bin/{awk,gawk,gawk-$GAWK_VERSION,gawkbug} \
    usr/include/gawkapi.h \
    usr/lib/gawk/{filefuncs,fork,intdiv,readdir,revoutput,rwarray}.so \
    usr/lib/gawk/{fnmatch,inplace,ordchr,readfile,revtwoway,time}.so \
    usr/libexec/awk/{grcat,pwcat} \
    usr/share/awk/{assert,bits2str,cliff_rand,ctime,ftrans,getopt}.awk \
    usr/share/awk/{gettime,group,have_mpfr,inplace,intdiv0,isnumeric}.awk \
    usr/share/awk/{join,libintl,noassign,ns_passwd,ord,passwd}.awk \
    usr/share/awk/{processarray,quicksort,readable,readfile,rewind}.awk \
    usr/share/awk/{round,shellquote,strtonum,tocsv,walkarray,zerofile}.awk \
    etc/profile.d/{gawk.csh,gawk.sh}

# Build RPM
rm -r $GAWK_SRC/build/rpmbuild || true
mkdir -p $GAWK_SRC/build/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
cp ${GAWK_RPM_NAME}-${GAWK_VERSION}.tar $GAWK_SRC/build/rpmbuild/SOURCES

cat > $GAWK_SRC/build/rpmbuild/SPECS/${GAWK_RPM_NAME}.spec << EOF
Name: $GAWK_RPM_NAME
Version: $GAWK_VERSION
Release: 1
Summary: Gawk terminal utility/program and libraries
ExclusiveArch: $ARCH
License: GPL
Source0: ${GAWK_RPM_NAME}-${GAWK_VERSION}.tar

%description
The awk/gawk utility interprets a special-purpose programming language that makes it possible to handle simple data-reformatting jobs with just a few lines of code.

%prep
%setup -q
%install
rm -rf %{buildroot}
mkdir -p %{buildroot}/%{_bindir}
cp -a usr/bin/* %{buildroot}/%{_bindir}

mkdir -p %{buildroot}/%{_includedir}
cp -a usr/include/* %{buildroot}/%{_includedir}

mkdir -p %{buildroot}/%{_libdir}
cp -a usr/lib/* %{buildroot}/%{_libdir}

mkdir -p %{buildroot}/%{_libexecdir}
cp -a usr/libexec/* %{buildroot}/%{_libexecdir}

mkdir -p %{buildroot}/%{_datadir}
cp -a usr/share/* %{buildroot}/%{_datadir}

mkdir -p %{buildroot}/%{_sysconfdir}
cp -a etc/* %{buildroot}/%{_sysconfdir}

%files
%{_bindir}/awk
%{_bindir}/gawk
%{_bindir}/gawk-$GAWK_VERSION
%{_bindir}/gawkbug
%{_includedir}/gawkapi.h
%{_libdir}/gawk/filefuncs.so
%{_libdir}/gawk/fork.so
%{_libdir}/gawk/intdiv.so
%{_libdir}/gawk/readdir.so
%{_libdir}/gawk/revoutput.so
%{_libdir}/gawk/rwarray.so
%{_libdir}/gawk/fnmatch.so
%{_libdir}/gawk/inplace.so
%{_libdir}/gawk/ordchr.so
%{_libdir}/gawk/readfile.so
%{_libdir}/gawk/revtwoway.so
%{_libdir}/gawk/time.so
%{_libexecdir}/awk/grcat
%{_libexecdir}/awk/pwcat
%{_datadir}/awk/assert.awk
%{_datadir}/awk/bits2str.awk
%{_datadir}/awk/cliff_rand.awk
%{_datadir}/awk/ctime.awk
%{_datadir}/awk/ftrans.awk
%{_datadir}/awk/getopt.awk
%{_datadir}/awk/gettime.awk
%{_datadir}/awk/group.awk
%{_datadir}/awk/have_mpfr.awk
%{_datadir}/awk/inplace.awk
%{_datadir}/awk/intdiv0.awk
%{_datadir}/awk/isnumeric.awk
%{_datadir}/awk/join.awk
%{_datadir}/awk/libintl.awk
%{_datadir}/awk/noassign.awk
%{_datadir}/awk/ns_passwd.awk
%{_datadir}/awk/ord.awk
%{_datadir}/awk/passwd.awk
%{_datadir}/awk/processarray.awk
%{_datadir}/awk/quicksort.awk
%{_datadir}/awk/readable.awk
%{_datadir}/awk/readfile.awk
%{_datadir}/awk/rewind.awk
%{_datadir}/awk/round.awk
%{_datadir}/awk/shellquote.awk
%{_datadir}/awk/strtonum.awk
%{_datadir}/awk/tocsv.awk
%{_datadir}/awk/walkarray.awk
%{_datadir}/awk/zerofile.awk
%{_sysconfdir}/profile.d/gawk.csh
%{_sysconfdir}/profile.d/gawk.sh
EOF

rpmbuild --define "_topdir ${GAWK_SRC}/build/rpmbuild" -ba $GAWK_SRC/build/rpmbuild/SPECS/${GAWK_RPM_NAME}.spec
cp $GAWK_SRC/build/rpmbuild/RPMS/x86_64/${GAWK_RPM_NAME}-${GAWK_VERSION}-1.$ARCH.rpm $ISO_RPMS
