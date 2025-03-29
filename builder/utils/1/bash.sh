#!/bin/bash

BASH_SRC=$CACHE/bash
BASH_RPM_NAME=Bash
BASH_VERSION="5.2.37"
BASH_FULLNAME=$BASH_RPM_NAME-$BASH_VERSION
$ROOT/download_and_untar.sh "https://ftp.gnu.org/gnu/bash/bash-5.2.37.tar.gz" "$BASH_SRC"
chmod +x $BASH_SRC/support/config.guess

if [ ! -d $BASH_SRC/build ]
then
  mkdir -p $BASH_SRC/build
  cd $BASH_SRC/build
  CFLAGS="-Wno-implicit-function-declaration" ../configure --prefix=/usr --without-bash-malloc --build=$(../support/config.guess) --host=$TARGET
  make -j$(nproc)
fi
cd $BASH_SRC/build
make DESTDIR=$ISO_SYSROOT install

mkdir -p $ISO_SYSROOT/bin
ln -sf /usr/bin/bash $ISO_SYSROOT/bin/sh

# Make TAR ball
cd $BASH_SRC/build
$ROOT/generate_tar.sh make $BASH_SRC/build/$BASH_FULLNAME.tar $BASH_FULLNAME \
                      usr/bin/{bash,bashbug} \
                      usr/include/bash/{alias,arrayfunc,array,assoc,bashansi}.h \
                      usr/include/bash/{bashintl,bashjmp,bashtypes,builtins}.h \
                      usr/include/bash/{command,config-bot,config,config-top,conftypes}.h \
                      usr/include/bash/{dispose_cmd,error,execute_cmd,externs,general}.h \
                      usr/include/bash/{hashlib,jobs,make_cmd,pathnames,quit,shell,sig}.h \
                      usr/include/bash/{siglist,signames,subst,syntax,unwind_prot}.h \
                      usr/include/bash/{variables,version,xmalloc,y.tab}.h \
                      usr/include/bash/builtins/{bashgetopt,builtext,common,getopt}.h \
                      usr/include/bash/include/{ansi_stdlib,chartypes,filecntl,gettext}.h \
                      usr/include/bash/include/{maxpath,memalloc,ocache,posixdir,posixjmp}.h \
                      usr/include/bash/include/{posixstat,posixtime,posixwait,shmbchar}.h \
                      usr/include/bash/include/{shmbutil,shtty,stat-time,stdc,systimes}.h \
                      usr/include/bash/include/{typemax,unionwait}.h \
                      usr/lib/bash/{accept,basename,csv,cut,dirname,dsv,fdflags,finfo} \
                      usr/lib/bash/{getconf,head,id,ln,loadables.h,logname,Makefile.inc} \
                      usr/lib/bash/{Makefile.sample,mkdir,mkfifo,mktemp,mypid,pathchk,print} \
                      usr/lib/bash/{printenv,push,realpath,rm,rmdir,seq,setpgid,sleep,stat} \
                      usr/lib/bash/{strftime,sync,tee,truefalse,tty,uname,unlink,whoami} \
                      usr/lib/pkgconfig/bash.pc


# Make RPM package
cd $BASH_SRC/build
$ROOT/generate_rpm.sh "$ISO_RPMS" \
                      "$BASH_SRC/build/rpmbuild" \
                      "$BASH_RPM_NAME" \
                      "$BASH_VERSION" \
                      "Bourne Again SHell" \
                      "Bash is the GNU Project's shell—the Bourne Again SHell. This is an sh-compatible shell that incorporates useful features from the Korn shell (ksh) and the C shell (csh). It is intended to conform to the IEEE POSIX P1003.2/ISO 9945.2 Shell and Tools standard. It offers functional improvements over sh for both programming and interactive use. In addition, most sh scripts can be run by Bash without modification." \
                      "GPL" \
                      "$BASH_SRC/build/$BASH_FULLNAME.tar" \
                      "usr/bin/bash" "%{_bindir}/bash" \
                      "usr/bin/bashbug" "%{_bindir}/bashbug" \
                      "usr/include/bash/alias.h" "%{_includedir}/bash/alias.h" \
                      "usr/include/bash/arrayfunc.h" "%{_includedir}/bash/arrayfunc.h" \
                      "usr/include/bash/array.h" "%{_includedir}/bash/array.h" \
                      "usr/include/bash/assoc.h" "%{_includedir}/bash/assoc.h" \
                      "usr/include/bash/bashansi.h" "%{_includedir}/bash/bashansi.h" \
                      "usr/include/bash/bashintl.h" "%{_includedir}/bash/bashintl.h" \
                      "usr/include/bash/bashjmp.h" "%{_includedir}/bash/bashjmp.h" \
                      "usr/include/bash/bashtypes.h" "%{_includedir}/bash/bashtypes.h" \
                      "usr/include/bash/builtins.h" "%{_includedir}/bash/builtins.h" \
                      "usr/include/bash/command.h" "%{_includedir}/bash/command.h" \
                      "usr/include/bash/config-bot.h" "%{_includedir}/bash/config-bot.h" \
                      "usr/include/bash/config.h" "%{_includedir}/bash/config.h" \
                      "usr/include/bash/config-top.h" "%{_includedir}/bash/config-top.h" \
                      "usr/include/bash/conftypes.h" "%{_includedir}/bash/conftypes.h" \
                      "usr/include/bash/dispose_cmd.h" "%{_includedir}/bash/dispose_cmd.h" \
                      "usr/include/bash/error.h" "%{_includedir}/bash/error.h" \
                      "usr/include/bash/execute_cmd.h" "%{_includedir}/bash/execute_cmd.h" \
                      "usr/include/bash/externs.h" "%{_includedir}/bash/externs.h" \
                      "usr/include/bash/general.h" "%{_includedir}/bash/general.h" \
                      "usr/include/bash/hashlib.h" "%{_includedir}/bash/hashlib.h" \
                      "usr/include/bash/jobs.h" "%{_includedir}/bash/jobs.h" \
                      "usr/include/bash/make_cmd.h" "%{_includedir}/bash/make_cmd.h" \
                      "usr/include/bash/pathnames.h" "%{_includedir}/bash/pathnames.h" \
                      "usr/include/bash/quit.h" "%{_includedir}/bash/quit.h" \
                      "usr/include/bash/shell.h" "%{_includedir}/bash/shell.h" \
                      "usr/include/bash/sig.h" "%{_includedir}/bash/sig.h" \
                      "usr/include/bash/siglist.h" "%{_includedir}/bash/siglist.h" \
                      "usr/include/bash/signames.h" "%{_includedir}/bash/signames.h" \
                      "usr/include/bash/subst.h" "%{_includedir}/bash/subst.h" \
                      "usr/include/bash/syntax.h" "%{_includedir}/bash/syntax.h" \
                      "usr/include/bash/unwind_prot.h" "%{_includedir}/bash/unwind_prot.h" \
                      "usr/include/bash/variables.h" "%{_includedir}/bash/variables.h" \
                      "usr/include/bash/version.h" "%{_includedir}/bash/version.h" \
                      "usr/include/bash/xmalloc.h" "%{_includedir}/bash/xmalloc.h" \
                      "usr/include/bash/y.tab.h" "%{_includedir}/bash/y.tab.h" \
                      "usr/include/bash/builtins/bashgetopt.h" "%{_includedir}/bash/builtins/bashgetopt.h" \
                      "usr/include/bash/builtins/builtext.h" "%{_includedir}/bash/builtins/builtext.h" \
                      "usr/include/bash/builtins/common.h" "%{_includedir}/bash/builtins/common.h" \
                      "usr/include/bash/builtins/getopt.h" "%{_includedir}/bash/builtins/getopt.h" \
                      "usr/include/bash/include/ansi_stdlib.h" "%{_includedir}/bash/include/ansi_stdlib.h" \
                      "usr/include/bash/include/chartypes.h" "%{_includedir}/bash/include/chartypes.h" \
                      "usr/include/bash/include/filecntl.h" "%{_includedir}/bash/include/filecntl.h" \
                      "usr/include/bash/include/gettext.h" "%{_includedir}/bash/include/gettext.h" \
                      "usr/include/bash/include/maxpath.h" "%{_includedir}/bash/include/maxpath.h" \
                      "usr/include/bash/include/memalloc.h" "%{_includedir}/bash/include/memalloc.h" \
                      "usr/include/bash/include/ocache.h" "%{_includedir}/bash/include/ocache.h" \
                      "usr/include/bash/include/posixdir.h" "%{_includedir}/bash/include/posixdir.h" \
                      "usr/include/bash/include/posixjmp.h" "%{_includedir}/bash/include/posixjmp.h" \
                      "usr/include/bash/include/posixstat.h" "%{_includedir}/bash/include/posixstat.h" \
                      "usr/include/bash/include/posixtime.h" "%{_includedir}/bash/include/posixtime.h" \
                      "usr/include/bash/include/posixwait.h" "%{_includedir}/bash/include/posixwait.h" \
                      "usr/include/bash/include/shmbchar.h" "%{_includedir}/bash/include/shmbchar.h" \
                      "usr/include/bash/include/shmbutil.h" "%{_includedir}/bash/include/shmbutil.h" \
                      "usr/include/bash/include/shtty.h" "%{_includedir}/bash/include/shtty.h" \
                      "usr/include/bash/include/stat-time.h" "%{_includedir}/bash/include/stat-time.h" \
                      "usr/include/bash/include/stdc.h" "%{_includedir}/bash/include/stdc.h" \
                      "usr/include/bash/include/systimes.h" "%{_includedir}/bash/include/systimes.h" \
                      "usr/include/bash/include/typemax.h" "%{_includedir}/bash/include/typemax.h" \
                      "usr/include/bash/include/unionwait.h" "%{_includedir}/bash/include/unionwait.h" \
                      "usr/lib/bash/accept" "%{_libdir}/bash/accept" \
                      "usr/lib/bash/basename" "%{_libdir}/bash/basename" \
                      "usr/lib/bash/csv" "%{_libdir}/bash/csv" \
                      "usr/lib/bash/cut" "%{_libdir}/bash/cut" \
                      "usr/lib/bash/dirname" "%{_libdir}/bash/dirname" \
                      "usr/lib/bash/dsv" "%{_libdir}/bash/dsv" \
                      "usr/lib/bash/fdflags" "%{_libdir}/bash/fdflags" \
                      "usr/lib/bash/finfo" "%{_libdir}/bash/finfo" \
                      "usr/lib/bash/getconf" "%{_libdir}/bash/getconf" \
                      "usr/lib/bash/head" "%{_libdir}/bash/head" \
                      "usr/lib/bash/id" "%{_libdir}/bash/id" \
                      "usr/lib/bash/ln" "%{_libdir}/bash/ln" \
                      "usr/lib/bash/loadables.h" "%{_libdir}/bash/loadables.h" \
                      "usr/lib/bash/logname" "%{_libdir}/bash/logname" \
                      "usr/lib/bash/Makefile.inc" "%{_libdir}/bash/Makefile.inc" \
                      "usr/lib/bash/Makefile.sample" "%{_libdir}/bash/Makefile.sample" \
                      "usr/lib/bash/mkdir" "%{_libdir}/bash/mkdir" \
                      "usr/lib/bash/mkfifo" "%{_libdir}/bash/mkfifo" \
                      "usr/lib/bash/mktemp" "%{_libdir}/bash/mktemp" \
                      "usr/lib/bash/mypid" "%{_libdir}/bash/mypid" \
                      "usr/lib/bash/pathchk" "%{_libdir}/bash/pathchk" \
                      "usr/lib/bash/print" "%{_libdir}/bash/print" \
                      "usr/lib/bash/printenv" "%{_libdir}/bash/printenv" \
                      "usr/lib/bash/push" "%{_libdir}/bash/push" \
                      "usr/lib/bash/realpath" "%{_libdir}/bash/realpath" \
                      "usr/lib/bash/rm" "%{_libdir}/bash/rm" \
                      "usr/lib/bash/rmdir" "%{_libdir}/bash/rmdir" \
                      "usr/lib/bash/seq" "%{_libdir}/bash/seq" \
                      "usr/lib/bash/setpgid" "%{_libdir}/bash/setpgid" \
                      "usr/lib/bash/sleep" "%{_libdir}/bash/sleep" \
                      "usr/lib/bash/stat" "%{_libdir}/bash/stat" \
                      "usr/lib/bash/strftime" "%{_libdir}/bash/strftime" \
                      "usr/lib/bash/sync" "%{_libdir}/bash/sync" \
                      "usr/lib/bash/tee" "%{_libdir}/bash/tee" \
                      "usr/lib/bash/truefalse" "%{_libdir}/bash/truefalse" \
                      "usr/lib/bash/tty" "%{_libdir}/bash/tty" \
                      "usr/lib/bash/uname" "%{_libdir}/bash/uname" \
                      "usr/lib/bash/unlink" "%{_libdir}/bash/unlink" \
                      "usr/lib/bash/whoami" "%{_libdir}/bash/whoami" \
                      "usr/lib/pkgconfig/bash.pc" "%{_libdir}/pkgconfig/bash.pc"
