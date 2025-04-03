#!/bin/bash

CORE_SRC=$CACHE/coreutils
CORE_RPM_NAME=CoreUtils
CORE_VERSION="9.6"
CORE_FULLNAME=$CORE_RPM_NAME-$CORE_VERSION
$ROOT/download_and_untar.sh "https://ftp.gnu.org/gnu/coreutils/coreutils-9.6.tar.xz" "$CORE_SRC"

if [ ! -d $CORE_SRC/build ]
then
  mkdir -p $CORE_SRC/build
  cd $CORE_SRC/build
  ../configure --prefix=/usr --host=$TARGET --build=$(../build-aux/config.guess)
  make -j$(nproc)
fi
cd $CORE_SRC/build
make DESTDIR=$ISO_SYSROOT install

$ROOT/generate_tar.sh make $CORE_SRC/build/$CORE_FULLNAME.tar $CORE_FULLNAME \
        usr/bin/{'[',b2sum,base32,base64,basename,basenc,cat,chcon,chgrp} \
        usr/bin/{chmod,chown,chroot,cksum,comm,cp,csplit,cut,date,dd,df,dir} \
        usr/bin/{dircolors,dirname,du,echo,env,expand,expr,factor,false,fmt} \
        usr/bin/{fold,groups,head,hostid,id,install,join,kill,link,ln,logname} \
        usr/bin/{ls,md5sum,mkdir,mkfifo,mknod,mktemp,mv,nice,nl,nohup,nproc} \
        usr/bin/{numfmt,od,paste,pathchk,pinky,pr,printenv,printf,ptx,pwd} \
        usr/bin/{readlink,realpath,rm,rmdir,runcon,seq,sha1sum,sha224sum} \
        usr/bin/{sha256sum,sha384sum,sha512sum,shred,shuf,sleep,sort,split} \
        usr/bin/{stat,stdbuf,stty,sum,sync,tac,tail,tee,test,timeout,touch} \
        usr/bin/{tr,true,truncate,tsort,tty,uname,unexpand,uniq,unlink,uptime} \
        usr/bin/{users,vdir,wc,who,whoami,yes} \
        usr/libexec/coreutils/libstdbuf.so

$ROOT/generate_rpm.sh "$ISO_RPMS" \
                      "$CORE_SRC/build/rpmbuild" \
                      "$CORE_RPM_NAME" \
                      "$CORE_VERSION" \
                      "GNU Core utilities" \
                      "The GNU Core Utilities are the basic file, shell and text manipulation utilities of the GNU operating system. These are the core utilities which are expected to exist on every operating system." \
                      "GPL-3.0" \
                      "$CORE_SRC/build/$CORE_FULLNAME.tar" \
                      "usr/libexec/coreutils/libstdbuf.so" "%{_libdir}/coreutils/libstdbuf.so" \
                      "usr/bin/dd" "%{_bindir}/dd" \
                      "usr/bin/ptx" "%{_bindir}/ptx" \
                      "usr/bin/shuf" "%{_bindir}/shuf" \
                      "usr/bin/seq" "%{_bindir}/seq" \
                      "usr/bin/wc" "%{_bindir}/wc" \
                      "usr/bin/groups" "%{_bindir}/groups" \
                      "usr/bin/echo" "%{_bindir}/echo" \
                      "usr/bin/pinky" "%{_bindir}/pinky" \
                      "usr/bin/chroot" "%{_bindir}/chroot" \
                      "usr/bin/stdbuf" "%{_bindir}/stdbuf" \
                      "usr/bin/vdir" "%{_bindir}/vdir" \
                      "usr/bin/timeout" "%{_bindir}/timeout" \
                      "usr/bin/fold" "%{_bindir}/fold" \
                      "usr/bin/tr" "%{_bindir}/tr" \
                      "usr/bin/chown" "%{_bindir}/chown" \
                      "usr/bin/dircolors" "%{_bindir}/dircolors" \
                      "usr/bin/join" "%{_bindir}/join" \
                      "usr/bin/test" "%{_bindir}/test" \
                      "usr/bin/sha256sum" "%{_bindir}/sha256sum" \
                      "usr/bin/nice" "%{_bindir}/nice" \
                      "usr/bin/sha224sum" "%{_bindir}/sha224sum" \
                      "usr/bin/printenv" "%{_bindir}/printenv" \
                      "usr/bin/sync" "%{_bindir}/sync" \
                      "usr/bin/mknod" "%{_bindir}/mknod" \
                      "usr/bin/basenc" "%{_bindir}/basenc" \
                      "usr/bin/readlink" "%{_bindir}/readlink" \
                      "usr/bin/kill" "%{_bindir}/kill" \
                      "usr/bin/cksum" "%{_bindir}/cksum" \
                      "usr/bin/chcon" "%{_bindir}/chcon" \
                      "usr/bin/fmt" "%{_bindir}/fmt" \
                      "usr/bin/tty" "%{_bindir}/tty" \
                      "usr/bin/mkfifo" "%{_bindir}/mkfifo" \
                      "usr/bin/truncate" "%{_bindir}/truncate" \
                      "usr/bin/users" "%{_bindir}/users" \
                      "usr/bin/env" "%{_bindir}/env" \
                      "usr/bin/ln" "%{_bindir}/ln" \
                      "usr/bin/rmdir" "%{_bindir}/rmdir" \
                      "usr/bin/paste" "%{_bindir}/paste" \
                      "usr/bin/tac" "%{_bindir}/tac" \
                      "usr/bin/sort" "%{_bindir}/sort" \
                      "usr/bin/pathchk" "%{_bindir}/pathchk" \
                      "usr/bin/yes" "%{_bindir}/yes" \
                      "usr/bin/cat" "%{_bindir}/cat" \
                      "usr/bin/b2sum" "%{_bindir}/b2sum" \
                      "usr/bin/tsort" "%{_bindir}/tsort" \
                      "usr/bin/printf" "%{_bindir}/printf" \
                      "usr/bin/sha512sum" "%{_bindir}/sha512sum" \
                      "usr/bin/nl" "%{_bindir}/nl" \
                      "usr/bin/nohup" "%{_bindir}/nohup" \
                      "usr/bin/uniq" "%{_bindir}/uniq" \
                      "usr/bin/whoami" "%{_bindir}/whoami" \
                      "usr/bin/base32" "%{_bindir}/base32" \
                      "usr/bin/base64" "%{_bindir}/base64" \
                      "usr/bin/uname" "%{_bindir}/uname" \
                      "usr/bin/md5sum" "%{_bindir}/md5sum" \
                      "usr/bin/stat" "%{_bindir}/stat" \
                      "usr/bin/runcon" "%{_bindir}/runcon" \
                      "usr/bin/stty" "%{_bindir}/stty" \
                      "usr/bin/expr" "%{_bindir}/expr" \
                      "usr/bin/dirname" "%{_bindir}/dirname" \
                      "usr/bin/cut" "%{_bindir}/cut" \
                      "usr/bin/df" "%{_bindir}/df" \
                      "usr/bin/comm" "%{_bindir}/comm" \
                      "usr/bin/[" "%{_bindir}/[" \
                      "usr/bin/head" "%{_bindir}/head" \
                      "usr/bin/touch" "%{_bindir}/touch" \
                      "usr/bin/unexpand" "%{_bindir}/unexpand" \
                      "usr/bin/pwd" "%{_bindir}/pwd" \
                      "usr/bin/sha384sum" "%{_bindir}/sha384sum" \
                      "usr/bin/ls" "%{_bindir}/ls" \
                      "usr/bin/split" "%{_bindir}/split" \
                      "usr/bin/chmod" "%{_bindir}/chmod" \
                      "usr/bin/uptime" "%{_bindir}/uptime" \
                      "usr/bin/expand" "%{_bindir}/expand" \
                      "usr/bin/sleep" "%{_bindir}/sleep" \
                      "usr/bin/install" "%{_bindir}/install" \
                      "usr/bin/rm" "%{_bindir}/rm" \
                      "usr/bin/tee" "%{_bindir}/tee" \
                      "usr/bin/unlink" "%{_bindir}/unlink" \
                      "usr/bin/basename" "%{_bindir}/basename" \
                      "usr/bin/hostid" "%{_bindir}/hostid" \
                      "usr/bin/tail" "%{_bindir}/tail" \
                      "usr/bin/true" "%{_bindir}/true" \
                      "usr/bin/pr" "%{_bindir}/pr" \
                      "usr/bin/realpath" "%{_bindir}/realpath" \
                      "usr/bin/numfmt" "%{_bindir}/numfmt" \
                      "usr/bin/date" "%{_bindir}/date" \
                      "usr/bin/csplit" "%{_bindir}/csplit" \
                      "usr/bin/mv" "%{_bindir}/mv" \
                      "usr/bin/od" "%{_bindir}/od" \
                      "usr/bin/link" "%{_bindir}/link" \
                      "usr/bin/id" "%{_bindir}/id" \
                      "usr/bin/who" "%{_bindir}/who" \
                      "usr/bin/sum" "%{_bindir}/sum" \
                      "usr/bin/mkdir" "%{_bindir}/mkdir" \
                      "usr/bin/cp" "%{_bindir}/cp" \
                      "usr/bin/chgrp" "%{_bindir}/chgrp" \
                      "usr/bin/sha1sum" "%{_bindir}/sha1sum" \
                      "usr/bin/shred" "%{_bindir}/shred" \
                      "usr/bin/false" "%{_bindir}/false" \
                      "usr/bin/mktemp" "%{_bindir}/mktemp" \
                      "usr/bin/nproc" "%{_bindir}/nproc" \
                      "usr/bin/dir" "%{_bindir}/dir" \
                      "usr/bin/logname" "%{_bindir}/logname" \
                      "usr/bin/du" "%{_bindir}/du" \
                      "usr/bin/factor" "%{_bindir}/factor"
