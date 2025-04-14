#!/bin/bash

UTILLINUX_SRC=$CACHE/utillinux
UTILLINUX_RPM_NAME=UtilLinux
UTILLINUX_VERSION="2.41"
UTILLINUX_FULLNAME=$UTILLINUX_RPM_NAME-$UTILLINUX_VERSION
$ROOT/download_and_untar.sh "https://www.kernel.org/pub/linux/utils/util-linux/v2.41/util-linux-2.41-rc2.tar.xz" "$UTILLINUX_SRC"

if [ ! -d $UTILLINUX_SRC/build ]
then
  mkdir -p $UTILLINUX_SRC/build
  cd $UTILLINUX_SRC/build
  ../configure --prefix=/usr \
                --build=$(../config/config.guess) \
                --host=$TARGET \
                --enable-usrdir-path \
                --disable-switch_root \
                --disable-pivot_root \
                --disable-liblastlog2 \
                --disable-makeinstall-chown \
                --disable-makeinstall-setuid \
                --disable-makeinstall-tty-setgid \
                --without-tinfo \
                --without-systemd
  sed -i "s/-ltinfo//g" Makefile
  make -j$(nproc)
fi
cd $UTILLINUX_SRC/build
#make DESTDIR=$ISO_SYSROOT install

$ROOT/generate_tar.sh make $UTILLINUX_SRC/build/$UTILLINUX_FULLNAME.tar $UTILLINUX_FULLNAME \
                      bin/{dmesg,kill,lsblk,wdctl,findmnt,su,mountpoint,umount,login,pipesz,more,mount,lsfd} \
                      usr/bin/{unshare,last,rev,lsns,ipcs,nsenter,look,fincore,chsh,setpgid,renice,uname26,scriptreplay,uuidgen,ionice,ipcmk,bits,taskset,rename,linux64,lsclocks,eject,chrt,setarch,waitpid,lscpu,chmem,colrm,irqtop,flock,mcookie,cal,script,linux32,wall,x86_64,column,lsmem,ul,lslogins,chfn,uclampset,lslocks,logger,scriptlive,hexdump,ipcrm,hardlink,colcrt,whereis,lsipc,namei,isosize,prlimit,getopt,lastb,setsid,choom,fadvise,fallocate,setterm,mesg,uuidparse,lsirq,exch,utmpdump,col,enosys,i386,coresched} \
                      lib/{libfdisk.so.1.1.0,libmount.so.1,libsmartcols.so.1,libblkid.so.1.1.0,libuuid.so.1.3.0,libuuid.so.1,libblkid.so.1,libsmartcols.so.1.1.0,libfdisk.so.1,libmount.so.1.1.0} \
                      usr/lib/{libmount.so,libblkid.so,libmount.a,libfdisk.so,libfdisk.a,libsmartcols.a,libuuid.so,libblkid.a,libsmartcols.so,libuuid.a,pkgconfig/mount.pc,pkgconfig/fdisk.pc,pkgconfig/blkid.pc,pkgconfig/smartcols.pc,pkgconfig/uuid.pc} \
                      sbin/{findfs,sulogin,blockdev,blkpr,swapoff,losetup,nologin,wipefs,fsck.minix,blkdiscard,blkzone,chcpu,fsfreeze,fsck.cramfs,cfdisk,ctrlaltdel,mkfs.bfs,hwclock,mkfs.minix,mkfs.cramfs,runuser,sfdisk,fsck,blkid,mkswap,fstrim,agetty,zramctl,fdisk,swaplabel,mkfs,swapon} \
                      usr/sbin/{ldattach,rfkill,rtcwake,delpart,addpart,readprofile,resizepart,uuidd,partx} \
                      usr/include/{libmount/libmount.h,uuid/uuid.h,libsmartcols/libsmartcols.h,blkid/blkid.h,libfdisk/libfdisk.h} \
                      usr/share/bash-completion/{completions/findfs,completions/unshare,completions/last,completions/rev,completions/lsns,completions/ipcs,completions/nsenter,completions/look,completions/blockdev,completions/swapoff,completions/fincore,completions/chsh,completions/setpgid,completions/ldattach,completions/dmesg,completions/renice,completions/losetup,completions/wipefs,completions/scriptreplay,completions/uuidgen,completions/fsck.minix,completions/ionice,completions/ipcmk,completions/blkdiscard,completions/lsblk,completions/taskset,completions/rename,completions/blkzone,completions/lsclocks,completions/chcpu,completions/fsfreeze,completions/fsck.cramfs,completions/rfkill,completions/eject,completions/cfdisk,completions/chrt,completions/setarch,completions/ctrlaltdel,completions/wdctl,completions/mkfs.bfs,completions/waitpid,completions/lscpu,completions/findmnt,completions/su,completions/hwclock,completions/chmem,completions/mkfs.minix,completions/colrm,completions/mkfs.cramfs,completions/mountpoint,completions/irqtop,completions/runuser,completions/flock,completions/mcookie,completions/cal,completions/script,completions/sfdisk,completions/fsck,completions/rtcwake,completions/umount,completions/wall,completions/column,completions/lsmem,completions/ul,completions/blkid,completions/lslogins,completions/mkswap,completions/chfn,completions/uclampset,completions/lslocks,completions/logger,completions/scriptlive,completions/hexdump,completions/ipcrm,completions/hardlink,completions/colcrt,completions/fstrim,completions/delpart,completions/whereis,completions/lsipc,completions/addpart,completions/namei,completions/isosize,completions/prlimit,completions/pipesz,completions/getopt,completions/lastb,completions/more,completions/readprofile,completions/setsid,completions/resizepart,completions/zramctl,completions/fadvise,completions/fallocate,completions/setterm,completions/fdisk,completions/mesg,completions/mount,completions/swaplabel,completions/uuidparse,completions/lsirq,completions/mkfs,completions/uuidd,completions/exch,completions/swapon,completions/utmpdump,completions/col,completions/partx,completions/enosys} \
                      usr/share/locale/{de/LC_MESSAGES/util-linux.mo,pt_BR/LC_MESSAGES/util-linux.mo,tr/LC_MESSAGES/util-linux.mo,hu/LC_MESSAGES/util-linux.mo,gl/LC_MESSAGES/util-linux.mo,da/LC_MESSAGES/util-linux.mo,hr/LC_MESSAGES/util-linux.mo,sr/LC_MESSAGES/util-linux.mo,fi/LC_MESSAGES/util-linux.mo,et/LC_MESSAGES/util-linux.mo,ka/LC_MESSAGES/util-linux.mo,pl/LC_MESSAGES/util-linux.mo,cs/LC_MESSAGES/util-linux.mo,ca/LC_MESSAGES/util-linux.mo,eu/LC_MESSAGES/util-linux.mo,it/LC_MESSAGES/util-linux.mo,nl/LC_MESSAGES/util-linux.mo,es/LC_MESSAGES/util-linux.mo,sk/LC_MESSAGES/util-linux.mo,ko/LC_MESSAGES/util-linux.mo,sl/LC_MESSAGES/util-linux.mo,fr/LC_MESSAGES/util-linux.mo,uk/LC_MESSAGES/util-linux.mo,zh_TW/LC_MESSAGES/util-linux.mo,vi/LC_MESSAGES/util-linux.mo,ja/LC_MESSAGES/util-linux.mo,ru/LC_MESSAGES/util-linux.mo,sv/LC_MESSAGES/util-linux.mo,zh_CN/LC_MESSAGES/util-linux.mo,id/LC_MESSAGES/util-linux.mo,ro/LC_MESSAGES/util-linux.mo,pt/LC_MESSAGES/util-linux.mo}

$ROOT/generate_rpm.sh "$ISO_RPMS" \
                      "$UTILLINUX_SRC/build/rpmbuild" \
                      "$UTILLINUX_RPM_NAME" \
                      "$UTILLINUX_VERSION" \
                      "Linux Utilities" \
                      "util-linux is a random collection of Linux utilities" \
                      "GPL-2.0" \
                      "$UTILLINUX_SRC/build/$UTILLINUX_FULLNAME.tar" \
"bin/dmesg" "%{_bindir}/dmesg" \
"bin/kill" "%{_bindir}/kill" \
"bin/lsblk" "%{_bindir}/lsblk" \
"bin/wdctl" "%{_bindir}/wdctl" \
"bin/findmnt" "%{_bindir}/findmnt" \
"bin/su" "%{_bindir}/su" \
"bin/mountpoint" "%{_bindir}/mountpoint" \
"bin/umount" "%{_bindir}/umount" \
"bin/login" "%{_bindir}/login" \
"bin/pipesz" "%{_bindir}/pipesz" \
"bin/more" "%{_bindir}/more" \
"bin/mount" "%{_bindir}/mount" \
"bin/lsfd" "%{_bindir}/lsfd" \
"usr/bin/unshare" "%{_bindir}/unshare" \
"usr/bin/last" "%{_bindir}/last" \
"usr/bin/rev" "%{_bindir}/rev" \
"usr/bin/lsns" "%{_bindir}/lsns" \
"usr/bin/ipcs" "%{_bindir}/ipcs" \
"usr/bin/nsenter" "%{_bindir}/nsenter" \
"usr/bin/look" "%{_bindir}/look" \
"usr/bin/fincore" "%{_bindir}/fincore" \
"usr/bin/chsh" "%{_bindir}/chsh" \
"usr/bin/setpgid" "%{_bindir}/setpgid" \
"usr/bin/renice" "%{_bindir}/renice" \
"usr/bin/uname26" "%{_bindir}/uname26" \
"usr/bin/scriptreplay" "%{_bindir}/scriptreplay" \
"usr/bin/uuidgen" "%{_bindir}/uuidgen" \
"usr/bin/ionice" "%{_bindir}/ionice" \
"usr/bin/ipcmk" "%{_bindir}/ipcmk" \
"usr/bin/bits" "%{_bindir}/bits" \
"usr/bin/taskset" "%{_bindir}/taskset" \
"usr/bin/rename" "%{_bindir}/rename" \
"usr/bin/linux64" "%{_bindir}/linux64" \
"usr/bin/lsclocks" "%{_bindir}/lsclocks" \
"usr/bin/eject" "%{_bindir}/eject" \
"usr/bin/chrt" "%{_bindir}/chrt" \
"usr/bin/setarch" "%{_bindir}/setarch" \
"usr/bin/waitpid" "%{_bindir}/waitpid" \
"usr/bin/lscpu" "%{_bindir}/lscpu" \
"usr/bin/chmem" "%{_bindir}/chmem" \
"usr/bin/colrm" "%{_bindir}/colrm" \
"usr/bin/irqtop" "%{_bindir}/irqtop" \
"usr/bin/flock" "%{_bindir}/flock" \
"usr/bin/mcookie" "%{_bindir}/mcookie" \
"usr/bin/cal" "%{_bindir}/cal" \
"usr/bin/script" "%{_bindir}/script" \
"usr/bin/linux32" "%{_bindir}/linux32" \
"usr/bin/wall" "%{_bindir}/wall" \
"usr/bin/x86_64" "%{_bindir}/x86_64" \
"usr/bin/column" "%{_bindir}/column" \
"usr/bin/lsmem" "%{_bindir}/lsmem" \
"usr/bin/ul" "%{_bindir}/ul" \
"usr/bin/lslogins" "%{_bindir}/lslogins" \
"usr/bin/chfn" "%{_bindir}/chfn" \
"usr/bin/uclampset" "%{_bindir}/uclampset" \
"usr/bin/lslocks" "%{_bindir}/lslocks" \
"usr/bin/logger" "%{_bindir}/logger" \
"usr/bin/scriptlive" "%{_bindir}/scriptlive" \
"usr/bin/hexdump" "%{_bindir}/hexdump" \
"usr/bin/ipcrm" "%{_bindir}/ipcrm" \
"usr/bin/hardlink" "%{_bindir}/hardlink" \
"usr/bin/colcrt" "%{_bindir}/colcrt" \
"usr/bin/whereis" "%{_bindir}/whereis" \
"usr/bin/lsipc" "%{_bindir}/lsipc" \
"usr/bin/namei" "%{_bindir}/namei" \
"usr/bin/isosize" "%{_bindir}/isosize" \
"usr/bin/prlimit" "%{_bindir}/prlimit" \
"usr/bin/getopt" "%{_bindir}/getopt" \
"usr/bin/lastb" "%{_bindir}/lastb" \
"usr/bin/setsid" "%{_bindir}/setsid" \
"usr/bin/choom" "%{_bindir}/choom" \
"usr/bin/fadvise" "%{_bindir}/fadvise" \
"usr/bin/fallocate" "%{_bindir}/fallocate" \
"usr/bin/setterm" "%{_bindir}/setterm" \
"usr/bin/mesg" "%{_bindir}/mesg" \
"usr/bin/uuidparse" "%{_bindir}/uuidparse" \
"usr/bin/lsirq" "%{_bindir}/lsirq" \
"usr/bin/exch" "%{_bindir}/exch" \
"usr/bin/utmpdump" "%{_bindir}/utmpdump" \
"usr/bin/col" "%{_bindir}/col" \
"usr/bin/enosys" "%{_bindir}/enosys" \
"usr/bin/i386" "%{_bindir}/i386" \
"usr/bin/coresched" "%{_bindir}/coresched" \
"lib/libfdisk.so.1.1.0" "%{_libdir}/fdisk.so.1.1.0" \
"lib/libmount.so.1" "%{_libdir}/mount.so.1" \
"lib/libsmartcols.so.1" "%{_libdir}/smartcols.so.1" \
"lib/libblkid.so.1.1.0" "%{_libdir}/blkid.so.1.1.0" \
"lib/libuuid.so.1.3.0" "%{_libdir}/uuid.so.1.3.0" \
"lib/libuuid.so.1" "%{_libdir}/uuid.so.1" \
"lib/libblkid.so.1" "%{_libdir}/blkid.so.1" \
"lib/libsmartcols.so.1.1.0" "%{_libdir}/smartcols.so.1.1.0" \
"lib/libfdisk.so.1" "%{_libdir}/fdisk.so.1" \
"lib/libmount.so.1.1.0" "%{_libdir}/mount.so.1.1.0" \
"usr/lib/libmount.so" "%{_libdir}/libmount.so" \
"usr/lib/libblkid.so" "%{_libdir}/libblkid.so" \
"usr/lib/libmount.a" "%{_libdir}/libmount.a" \
"usr/lib/libfdisk.so" "%{_libdir}/libfdisk.so" \
"usr/lib/libfdisk.a" "%{_libdir}/libfdisk.a" \
"usr/lib/libsmartcols.a" "%{_libdir}/libsmartcols.a" \
"usr/lib/libuuid.so" "%{_libdir}/libuuid.so" \
"usr/lib/libblkid.a" "%{_libdir}/libblkid.a" \
"usr/lib/libsmartcols.so" "%{_libdir}/libsmartcols.so" \
"usr/lib/libuuid.a" "%{_libdir}/libuuid.a" \
"usr/lib/pkgconfig/mount.pc" "%{_libdir}/pkgconfig/mount.pc" \
"usr/lib/pkgconfig/fdisk.pc" "%{_libdir}/pkgconfig/fdisk.pc" \
"usr/lib/pkgconfig/blkid.pc" "%{_libdir}/pkgconfig/blkid.pc" \
"usr/lib/pkgconfig/smartcols.pc" "%{_libdir}/pkgconfig/smartcols.pc" \
"usr/lib/pkgconfig/uuid.pc" "%{_libdir}/pkgconfig/uuid.pc" \
"sbin/findfs" "%{_sbindir}/findfs" \
"sbin/sulogin" "%{_sbindir}/sulogin" \
"sbin/blockdev" "%{_sbindir}/blockdev" \
"sbin/blkpr" "%{_sbindir}/blkpr" \
"sbin/swapoff" "%{_sbindir}/swapoff" \
"sbin/losetup" "%{_sbindir}/losetup" \
"sbin/nologin" "%{_sbindir}/nologin" \
"sbin/wipefs" "%{_sbindir}/wipefs" \
"sbin/fsck.minix" "%{_sbindir}/fsck.minix" \
"sbin/blkdiscard" "%{_sbindir}/blkdiscard" \
"sbin/blkzone" "%{_sbindir}/blkzone" \
"sbin/chcpu" "%{_sbindir}/chcpu" \
"sbin/fsfreeze" "%{_sbindir}/fsfreeze" \
"sbin/fsck.cramfs" "%{_sbindir}/fsck.cramfs" \
"sbin/cfdisk" "%{_sbindir}/cfdisk" \
"sbin/ctrlaltdel" "%{_sbindir}/ctrlaltdel" \
"sbin/mkfs.bfs" "%{_sbindir}/mkfs.bfs" \
"sbin/hwclock" "%{_sbindir}/hwclock" \
"sbin/mkfs.minix" "%{_sbindir}/mkfs.minix" \
"sbin/mkfs.cramfs" "%{_sbindir}/mkfs.cramfs" \
"sbin/runuser" "%{_sbindir}/runuser" \
"sbin/sfdisk" "%{_sbindir}/sfdisk" \
"sbin/fsck" "%{_sbindir}/fsck" \
"sbin/blkid" "%{_sbindir}/blkid" \
"sbin/mkswap" "%{_sbindir}/mkswap" \
"sbin/fstrim" "%{_sbindir}/fstrim" \
"sbin/agetty" "%{_sbindir}/agetty" \
"sbin/zramctl" "%{_sbindir}/zramctl" \
"sbin/fdisk" "%{_sbindir}/fdisk" \
"sbin/swaplabel" "%{_sbindir}/swaplabel" \
"sbin/mkfs" "%{_sbindir}/mkfs" \
"sbin/swapon" "%{_sbindir}/swapon" \
"usr/sbin/ldattach" "%{_sbindir}/ldattach" \
"usr/sbin/rfkill" "%{_sbindir}/rfkill" \
"usr/sbin/rtcwake" "%{_sbindir}/rtcwake" \
"usr/sbin/delpart" "%{_sbindir}/delpart" \
"usr/sbin/addpart" "%{_sbindir}/addpart" \
"usr/sbin/readprofile" "%{_sbindir}/readprofile" \
"usr/sbin/resizepart" "%{_sbindir}/resizepart" \
"usr/sbin/uuidd" "%{_sbindir}/uuidd" \
"usr/sbin/partx" "%{_sbindir}/partx" \
"usr/include/libmount/libmount.h" "%{_includedir}/libmount/libmount.h" \
"usr/include/uuid/uuid.h" "%{_includedir}/uuid/uuid.h" \
"usr/include/libsmartcols/libsmartcols.h" "%{_includedir}/libsmartcols/libsmartcols.h" \
"usr/include/blkid/blkid.h" "%{_includedir}/blkid/blkid.h" \
"usr/include/libfdisk/libfdisk.h" "%{_includedir}/libfdisk/libfdisk.h" \
"usr/share/locale/de/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/de/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/pt_BR/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/pt_BR/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/tr/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/tr/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/hu/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/hu/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/gl/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/gl/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/da/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/da/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/hr/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/hr/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/sr/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/sr/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/fi/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/fi/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/et/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/et/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/ka/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/ka/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/pl/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/pl/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/cs/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/cs/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/ca/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/ca/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/eu/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/eu/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/it/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/it/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/nl/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/nl/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/es/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/es/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/sk/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/sk/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/ko/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/ko/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/sl/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/sl/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/fr/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/fr/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/uk/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/uk/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/zh_TW/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/zh_TW/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/vi/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/vi/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/ja/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/ja/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/ru/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/ru/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/sv/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/sv/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/zh_CN/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/zh_CN/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/id/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/id/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/ro/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/ro/LC_MESSAGES/util-linux.mo" \
"usr/share/locale/pt/LC_MESSAGES/util-linux.mo" "%{_datadir}/locale/pt/LC_MESSAGES/util-linux.mo" \
"usr/share/bash-completion/completions/findfs" "%{_datadir}/bash-completion/completions/findfs" \
"usr/share/bash-completion/completions/unshare" "%{_datadir}/bash-completion/completions/unshare" \
"usr/share/bash-completion/completions/last" "%{_datadir}/bash-completion/completions/last" \
"usr/share/bash-completion/completions/rev" "%{_datadir}/bash-completion/completions/rev" \
"usr/share/bash-completion/completions/lsns" "%{_datadir}/bash-completion/completions/lsns" \
"usr/share/bash-completion/completions/ipcs" "%{_datadir}/bash-completion/completions/ipcs" \
"usr/share/bash-completion/completions/nsenter" "%{_datadir}/bash-completion/completions/nsenter" \
"usr/share/bash-completion/completions/look" "%{_datadir}/bash-completion/completions/look" \
"usr/share/bash-completion/completions/blockdev" "%{_datadir}/bash-completion/completions/blockdev" \
"usr/share/bash-completion/completions/swapoff" "%{_datadir}/bash-completion/completions/swapoff" \
"usr/share/bash-completion/completions/fincore" "%{_datadir}/bash-completion/completions/fincore" \
"usr/share/bash-completion/completions/chsh" "%{_datadir}/bash-completion/completions/chsh" \
"usr/share/bash-completion/completions/setpgid" "%{_datadir}/bash-completion/completions/setpgid" \
"usr/share/bash-completion/completions/ldattach" "%{_datadir}/bash-completion/completions/ldattach" \
"usr/share/bash-completion/completions/dmesg" "%{_datadir}/bash-completion/completions/dmesg" \
"usr/share/bash-completion/completions/renice" "%{_datadir}/bash-completion/completions/renice" \
"usr/share/bash-completion/completions/losetup" "%{_datadir}/bash-completion/completions/losetup" \
"usr/share/bash-completion/completions/wipefs" "%{_datadir}/bash-completion/completions/wipefs" \
"usr/share/bash-completion/completions/scriptreplay" "%{_datadir}/bash-completion/completions/scriptreplay" \
"usr/share/bash-completion/completions/uuidgen" "%{_datadir}/bash-completion/completions/uuidgen" \
"usr/share/bash-completion/completions/fsck.minix" "%{_datadir}/bash-completion/completions/fsck.minix" \
"usr/share/bash-completion/completions/ionice" "%{_datadir}/bash-completion/completions/ionice" \
"usr/share/bash-completion/completions/ipcmk" "%{_datadir}/bash-completion/completions/ipcmk" \
"usr/share/bash-completion/completions/blkdiscard" "%{_datadir}/bash-completion/completions/blkdiscard" \
"usr/share/bash-completion/completions/lsblk" "%{_datadir}/bash-completion/completions/lsblk" \
"usr/share/bash-completion/completions/taskset" "%{_datadir}/bash-completion/completions/taskset" \
"usr/share/bash-completion/completions/rename" "%{_datadir}/bash-completion/completions/rename" \
"usr/share/bash-completion/completions/blkzone" "%{_datadir}/bash-completion/completions/blkzone" \
"usr/share/bash-completion/completions/lsclocks" "%{_datadir}/bash-completion/completions/lsclocks" \
"usr/share/bash-completion/completions/chcpu" "%{_datadir}/bash-completion/completions/chcpu" \
"usr/share/bash-completion/completions/fsfreeze" "%{_datadir}/bash-completion/completions/fsfreeze" \
"usr/share/bash-completion/completions/fsck.cramfs" "%{_datadir}/bash-completion/completions/fsck.cramfs" \
"usr/share/bash-completion/completions/rfkill" "%{_datadir}/bash-completion/completions/rfkill" \
"usr/share/bash-completion/completions/eject" "%{_datadir}/bash-completion/completions/eject" \
"usr/share/bash-completion/completions/cfdisk" "%{_datadir}/bash-completion/completions/cfdisk" \
"usr/share/bash-completion/completions/chrt" "%{_datadir}/bash-completion/completions/chrt" \
"usr/share/bash-completion/completions/setarch" "%{_datadir}/bash-completion/completions/setarch" \
"usr/share/bash-completion/completions/ctrlaltdel" "%{_datadir}/bash-completion/completions/ctrlaltdel" \
"usr/share/bash-completion/completions/wdctl" "%{_datadir}/bash-completion/completions/wdctl" \
"usr/share/bash-completion/completions/mkfs.bfs" "%{_datadir}/bash-completion/completions/mkfs.bfs" \
"usr/share/bash-completion/completions/waitpid" "%{_datadir}/bash-completion/completions/waitpid" \
"usr/share/bash-completion/completions/lscpu" "%{_datadir}/bash-completion/completions/lscpu" \
"usr/share/bash-completion/completions/findmnt" "%{_datadir}/bash-completion/completions/findmnt" \
"usr/share/bash-completion/completions/su" "%{_datadir}/bash-completion/completions/su" \
"usr/share/bash-completion/completions/hwclock" "%{_datadir}/bash-completion/completions/hwclock" \
"usr/share/bash-completion/completions/chmem" "%{_datadir}/bash-completion/completions/chmem" \
"usr/share/bash-completion/completions/mkfs.minix" "%{_datadir}/bash-completion/completions/mkfs.minix" \
"usr/share/bash-completion/completions/colrm" "%{_datadir}/bash-completion/completions/colrm" \
"usr/share/bash-completion/completions/mkfs.cramfs" "%{_datadir}/bash-completion/completions/mkfs.cramfs" \
"usr/share/bash-completion/completions/mountpoint" "%{_datadir}/bash-completion/completions/mountpoint" \
"usr/share/bash-completion/completions/irqtop" "%{_datadir}/bash-completion/completions/irqtop" \
"usr/share/bash-completion/completions/runuser" "%{_datadir}/bash-completion/completions/runuser" \
"usr/share/bash-completion/completions/flock" "%{_datadir}/bash-completion/completions/flock" \
"usr/share/bash-completion/completions/mcookie" "%{_datadir}/bash-completion/completions/mcookie" \
"usr/share/bash-completion/completions/cal" "%{_datadir}/bash-completion/completions/cal" \
"usr/share/bash-completion/completions/script" "%{_datadir}/bash-completion/completions/script" \
"usr/share/bash-completion/completions/sfdisk" "%{_datadir}/bash-completion/completions/sfdisk" \
"usr/share/bash-completion/completions/fsck" "%{_datadir}/bash-completion/completions/fsck" \
"usr/share/bash-completion/completions/rtcwake" "%{_datadir}/bash-completion/completions/rtcwake" \
"usr/share/bash-completion/completions/umount" "%{_datadir}/bash-completion/completions/umount" \
"usr/share/bash-completion/completions/wall" "%{_datadir}/bash-completion/completions/wall" \
"usr/share/bash-completion/completions/column" "%{_datadir}/bash-completion/completions/column" \
"usr/share/bash-completion/completions/lsmem" "%{_datadir}/bash-completion/completions/lsmem" \
"usr/share/bash-completion/completions/ul" "%{_datadir}/bash-completion/completions/ul" \
"usr/share/bash-completion/completions/blkid" "%{_datadir}/bash-completion/completions/blkid" \
"usr/share/bash-completion/completions/lslogins" "%{_datadir}/bash-completion/completions/lslogins" \
"usr/share/bash-completion/completions/mkswap" "%{_datadir}/bash-completion/completions/mkswap" \
"usr/share/bash-completion/completions/chfn" "%{_datadir}/bash-completion/completions/chfn" \
"usr/share/bash-completion/completions/uclampset" "%{_datadir}/bash-completion/completions/uclampset" \
"usr/share/bash-completion/completions/lslocks" "%{_datadir}/bash-completion/completions/lslocks" \
"usr/share/bash-completion/completions/logger" "%{_datadir}/bash-completion/completions/logger" \
"usr/share/bash-completion/completions/scriptlive" "%{_datadir}/bash-completion/completions/scriptlive" \
"usr/share/bash-completion/completions/hexdump" "%{_datadir}/bash-completion/completions/hexdump" \
"usr/share/bash-completion/completions/ipcrm" "%{_datadir}/bash-completion/completions/ipcrm" \
"usr/share/bash-completion/completions/hardlink" "%{_datadir}/bash-completion/completions/hardlink" \
"usr/share/bash-completion/completions/colcrt" "%{_datadir}/bash-completion/completions/colcrt" \
"usr/share/bash-completion/completions/fstrim" "%{_datadir}/bash-completion/completions/fstrim" \
"usr/share/bash-completion/completions/delpart" "%{_datadir}/bash-completion/completions/delpart" \
"usr/share/bash-completion/completions/whereis" "%{_datadir}/bash-completion/completions/whereis" \
"usr/share/bash-completion/completions/lsipc" "%{_datadir}/bash-completion/completions/lsipc" \
"usr/share/bash-completion/completions/addpart" "%{_datadir}/bash-completion/completions/addpart" \
"usr/share/bash-completion/completions/namei" "%{_datadir}/bash-completion/completions/namei" \
"usr/share/bash-completion/completions/isosize" "%{_datadir}/bash-completion/completions/isosize" \
"usr/share/bash-completion/completions/prlimit" "%{_datadir}/bash-completion/completions/prlimit" \
"usr/share/bash-completion/completions/pipesz" "%{_datadir}/bash-completion/completions/pipesz" \
"usr/share/bash-completion/completions/getopt" "%{_datadir}/bash-completion/completions/getopt" \
"usr/share/bash-completion/completions/lastb" "%{_datadir}/bash-completion/completions/lastb" \
"usr/share/bash-completion/completions/more" "%{_datadir}/bash-completion/completions/more" \
"usr/share/bash-completion/completions/readprofile" "%{_datadir}/bash-completion/completions/readprofile" \
"usr/share/bash-completion/completions/setsid" "%{_datadir}/bash-completion/completions/setsid" \
"usr/share/bash-completion/completions/resizepart" "%{_datadir}/bash-completion/completions/resizepart" \
"usr/share/bash-completion/completions/zramctl" "%{_datadir}/bash-completion/completions/zramctl" \
"usr/share/bash-completion/completions/fadvise" "%{_datadir}/bash-completion/completions/fadvise" \
"usr/share/bash-completion/completions/fallocate" "%{_datadir}/bash-completion/completions/fallocate" \
"usr/share/bash-completion/completions/setterm" "%{_datadir}/bash-completion/completions/setterm" \
"usr/share/bash-completion/completions/fdisk" "%{_datadir}/bash-completion/completions/fdisk" \
"usr/share/bash-completion/completions/mesg" "%{_datadir}/bash-completion/completions/mesg" \
"usr/share/bash-completion/completions/mount" "%{_datadir}/bash-completion/completions/mount" \
"usr/share/bash-completion/completions/swaplabel" "%{_datadir}/bash-completion/completions/swaplabel" \
"usr/share/bash-completion/completions/uuidparse" "%{_datadir}/bash-completion/completions/uuidparse" \
"usr/share/bash-completion/completions/lsirq" "%{_datadir}/bash-completion/completions/lsirq" \
"usr/share/bash-completion/completions/mkfs" "%{_datadir}/bash-completion/completions/mkfs" \
"usr/share/bash-completion/completions/uuidd" "%{_datadir}/bash-completion/completions/uuidd" \
"usr/share/bash-completion/completions/exch" "%{_datadir}/bash-completion/completions/exch" \
"usr/share/bash-completion/completions/swapon" "%{_datadir}/bash-completion/completions/swapon" \
"usr/share/bash-completion/completions/utmpdump" "%{_datadir}/bash-completion/completions/utmpdump" \
"usr/share/bash-completion/completions/col" "%{_datadir}/bash-completion/completions/col" \
"usr/share/bash-completion/completions/partx" "%{_datadir}/bash-completion/completions/partx" \
"usr/share/bash-completion/completions/enosys" "%{_datadir}/bash-completion/completions/enosys"
