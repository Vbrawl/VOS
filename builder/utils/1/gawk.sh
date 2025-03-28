#!/bin/bash

GAWK_SRC=$CACHE/gawk
GAWK_RPM_NAME=Gawk
GAWK_VERSION="5.3.1"
GAWK_FULLNAME=$GAWK_RPM_NAME-$GAWK_VERSION
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
$ROOT/generate_tar.sh make $GAWK_SRC/build/$GAWK_FULLNAME.tar $GAWK_FULLNAME \
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
cd $GAWK_SRC/build
$ROOT/generate_rpm.sh "$ISO_RPMS" \
                      "$GAWK_SRC/build/rpmbuild" \
                      "$GAWK_RPM_NAME" \
                      "$GAWK_VERSION" \
                      "Gawk terminal utility/program and libraries" \
                      "The awk/gawk utility interprets a special-purpose programming language that makes it possible to handle simple data-reformatting jobs with just a few lines of code." \
                      "GPL" \
                      "$GAWK_SRC/build/$GAWK_FULLNAME.tar" \
                      "usr/bin/awk" "%{_bindir}/awk" \
                      "usr/bin/gawk" "%{_bindir}/gawk" \
                      "usr/bin/gawk-$GAWK_VERSION" "%{_bindir}/gawk-$GAWK_VERSION" \
                      "usr/bin/gawkbug" "%{_bindir}/gawkbug" \
                      "usr/include/gawkapi.h" "%{_includedir}/gawkapi.h" \
                      "usr/lib/gawk/filefuncs.so" "%{_libdir}/gawk/filefuncs.so" \
                      "usr/lib/gawk/fork.so" "%{_libdir}/gawk/fork.so" \
                      "usr/lib/gawk/intdiv.so" "%{_libdir}/gawk/intdiv.so" \
                      "usr/lib/gawk/readdir.so" "%{_libdir}/gawk/readdir.so" \
                      "usr/lib/gawk/revoutput.so" "%{_libdir}/gawk/revoutput.so" \
                      "usr/lib/gawk/rwarray.so" "%{_libdir}/gawk/rwarray.so" \
                      "usr/lib/gawk/fnmatch.so" "%{_libdir}/gawk/fnmatch.so" \
                      "usr/lib/gawk/inplace.so" "%{_libdir}/gawk/inplace.so" \
                      "usr/lib/gawk/ordchr.so" "%{_libdir}/gawk/ordchr.so" \
                      "usr/lib/gawk/readfile.so" "%{_libdir}/gawk/readfile.so" \
                      "usr/lib/gawk/revtwoway.so" "%{_libdir}/gawk/revtwoway.so" \
                      "usr/lib/gawk/time.so" "%{_libdir}/gawk/time.so" \
                      "usr/libexec/awk/grcat" "%{_libexecdir}/awk/grcat" \
                      "usr/libexec/awk/pwcat" "%{_libexecdir}/awk/pwcat" \
                      "usr/share/awk/assert.awk" "%{_datadir}/awk/assert.awk" \
                      "usr/share/awk/bits2str.awk" "%{_datadir}/awk/bits2str.awk" \
                      "usr/share/awk/cliff_rand.awk" "%{_datadir}/awk/cliff_rand.awk" \
                      "usr/share/awk/ctime.awk" "%{_datadir}/awk/ctime.awk" \
                      "usr/share/awk/ftrans.awk" "%{_datadir}/awk/ftrans.awk" \
                      "usr/share/awk/getopt.awk" "%{_datadir}/awk/getopt.awk" \
                      "usr/share/awk/gettime.awk" "%{_datadir}/awk/gettime.awk" \
                      "usr/share/awk/group.awk" "%{_datadir}/awk/group.awk" \
                      "usr/share/awk/have_mpfr.awk" "%{_datadir}/awk/have_mpfr.awk" \
                      "usr/share/awk/inplace.awk" "%{_datadir}/awk/inplace.awk" \
                      "usr/share/awk/intdiv0.awk" "%{_datadir}/awk/intdiv0.awk" \
                      "usr/share/awk/isnumeric.awk" "%{_datadir}/awk/isnumeric.awk" \
                      "usr/share/awk/join.awk" "%{_datadir}/awk/join.awk" \
                      "usr/share/awk/libintl.awk" "%{_datadir}/awk/libintl.awk" \
                      "usr/share/awk/noassign.awk" "%{_datadir}/awk/noassign.awk" \
                      "usr/share/awk/ns_passwd.awk" "%{_datadir}/awk/ns_passwd.awk" \
                      "usr/share/awk/ord.awk" "%{_datadir}/awk/ord.awk" \
                      "usr/share/awk/passwd.awk" "%{_datadir}/awk/passwd.awk" \
                      "usr/share/awk/processarray.awk" "%{_datadir}/awk/processarray.awk" \
                      "usr/share/awk/quicksort.awk" "%{_datadir}/awk/quicksort.awk" \
                      "usr/share/awk/readable.awk" "%{_datadir}/awk/readable.awk" \
                      "usr/share/awk/readfile.awk" "%{_datadir}/awk/readfile.awk" \
                      "usr/share/awk/rewind.awk" "%{_datadir}/awk/rewind.awk" \
                      "usr/share/awk/round.awk" "%{_datadir}/awk/round.awk" \
                      "usr/share/awk/shellquote.awk" "%{_datadir}/awk/shellquote.awk" \
                      "usr/share/awk/strtonum.awk" "%{_datadir}/awk/strtonum.awk" \
                      "usr/share/awk/tocsv.awk" "%{_datadir}/awk/tocsv.awk" \
                      "usr/share/awk/walkarray.awk" "%{_datadir}/awk/walkarray.awk" \
                      "usr/share/awk/zerofile.awk" "%{_datadir}/awk/zerofile.awk" \
                      "etc/profile.d/gawk.csh" "%{_sysconfdir}/profile.d/gawk.csh" \
                      "etc/profile.d/gawk.sh" "%{_sysconfdir}/profile.d/gawk.sh"
