#!/bin/bash

PAM_SRC=$CACHE/pam
PAM_RPM_NAME=Pam
PAM_VERSION="1.7.0"
PAM_FULLNAME=$PAM_RPM_NAME-$PAM_VERSION
$ROOT/download_and_untar.sh "https://github.com/linux-pam/linux-pam/releases/download/v1.7.0/Linux-PAM-1.7.0.tar.xz" "$PAM_SRC"

if [ ! -d $PAM_SRC/build ]
then
  cd $PAM_SRC
  patch -p1 < $ROOT/patches/pam.patch
  meson setup build --cross-file $MESON_CROSS_FILE -Dc_args="-Wno-implicit-function-declaration -Wno-int-conversion -I${ISO_SYSROOT}/usr/include"
  cd $PAM_SRC/build
  meson compile
fi
cd $PAM_SRC/build
DESTDIR=$ISO_SYSROOT meson install

$ROOT/generate_tar.sh meson $PAM_SRC/build/$PAM_FULLNAME.tar $PAM_FULLNAME \
                      etc/environment \
                      etc/security/{faillock.conf,access.conf,pam_env.conf,time.conf,group.conf,namespace.init,limits.conf,namespace.conf,pwhistory.conf} \
                      usr/include/security/{pam_client.h,pam_modules.h,_pam_types.h,_pam_macros.h,pam_appl.h,pam_misc.h,_pam_compat.h,pam_ext.h,pam_filter.h,pam_modutil.h} \
                      usr/lib/{libpamc.so,libpam.so,libpamc.so.0,libpam_misc.so.0,libpam.so.0,security/pam_deny.so,security/pam_access.so,security/pam_nologin.so,security/pam_permit.so,security/pam_timestamp.so,security/pam_securetty.so,security/pam_ftp.so,security/pam_loginuid.so,security/pam_time.so,security/pam_debug.so,security/pam_pwhistory.so,security/pam_faildelay.so,security/pam_rhosts.so,security/pam_xauth.so,security/pam_stress.so,security/pam_env.so,security/pam_wheel.so,security/pam_motd.so,security/pam_faillock.so,security/pam_localuser.so,security/pam_shells.so,security/pam_listfile.so,security/pam_limits.so,security/pam_mail.so,security/pam_group.so,security/pam_unix.so,security/pam_canonicalize_user.so,security/pam_setquota.so,security/pam_namespace.so,security/pam_filter.so,security/pam_succeed_if.so,security/pam_warn.so,security/pam_issue.so,security/pam_filter/upperLOWER,security/pam_exec.so,security/pam_usertype.so,security/pam_umask.so,security/pam_rootok.so,security/pam_mkhomedir.so,security/pam_echo.so,libpamc.so.0.82.1,systemd/system/pam_namespace.service,libpam_misc.so,libpam.so.0.85.1,pkgconfig/pamc.pc,pkgconfig/pam.pc,pkgconfig/pam_misc.pc,libpam_misc.so.0.82.1} \
                      usr/sbin/{pwhistory_helper,pam_namespace_helper,faillock,mkhomedir_helper,pam_timestamp_check,unix_chkpwd} \
                      usr/share/locale/{de/LC_MESSAGES/Linux-PAM.mo,bs/LC_MESSAGES/Linux-PAM.mo,km/LC_MESSAGES/Linux-PAM.mo,pt_BR/LC_MESSAGES/Linux-PAM.mo,ta/LC_MESSAGES/Linux-PAM.mo,yo/LC_MESSAGES/Linux-PAM.mo,sr@latin/LC_MESSAGES/Linux-PAM.mo,tr/LC_MESSAGES/Linux-PAM.mo,hu/LC_MESSAGES/Linux-PAM.mo,gl/LC_MESSAGES/Linux-PAM.mo,lv/LC_MESSAGES/Linux-PAM.mo,da/LC_MESSAGES/Linux-PAM.mo,hr/LC_MESSAGES/Linux-PAM.mo,he/LC_MESSAGES/Linux-PAM.mo,sr/LC_MESSAGES/Linux-PAM.mo,be/LC_MESSAGES/Linux-PAM.mo,or/LC_MESSAGES/Linux-PAM.mo,fi/LC_MESSAGES/Linux-PAM.mo,de_CH/LC_MESSAGES/Linux-PAM.mo,si/LC_MESSAGES/Linux-PAM.mo,fa/LC_MESSAGES/Linux-PAM.mo,mk/LC_MESSAGES/Linux-PAM.mo,kn/LC_MESSAGES/Linux-PAM.mo,nn/LC_MESSAGES/Linux-PAM.mo,pa/LC_MESSAGES/Linux-PAM.mo,et/LC_MESSAGES/Linux-PAM.mo,ka/LC_MESSAGES/Linux-PAM.mo,pl/LC_MESSAGES/Linux-PAM.mo,cs/LC_MESSAGES/Linux-PAM.mo,lt/LC_MESSAGES/Linux-PAM.mo,sq/LC_MESSAGES/Linux-PAM.mo,ia/LC_MESSAGES/Linux-PAM.mo,gu/LC_MESSAGES/Linux-PAM.mo,ca/LC_MESSAGES/Linux-PAM.mo,eu/LC_MESSAGES/Linux-PAM.mo,it/LC_MESSAGES/Linux-PAM.mo,bg/LC_MESSAGES/Linux-PAM.mo,nl/LC_MESSAGES/Linux-PAM.mo,es/LC_MESSAGES/Linux-PAM.mo,sk/LC_MESSAGES/Linux-PAM.mo,az/LC_MESSAGES/Linux-PAM.mo,cy/LC_MESSAGES/Linux-PAM.mo,zu/LC_MESSAGES/Linux-PAM.mo,bn_IN/LC_MESSAGES/Linux-PAM.mo,el/LC_MESSAGES/Linux-PAM.mo,eo/LC_MESSAGES/Linux-PAM.mo,ne/LC_MESSAGES/Linux-PAM.mo,ko/LC_MESSAGES/Linux-PAM.mo,kk/LC_MESSAGES/Linux-PAM.mo,as/LC_MESSAGES/Linux-PAM.mo,sl/LC_MESSAGES/Linux-PAM.mo,mn/LC_MESSAGES/Linux-PAM.mo,fr/LC_MESSAGES/Linux-PAM.mo,bn/LC_MESSAGES/Linux-PAM.mo,hi/LC_MESSAGES/Linux-PAM.mo,uk/LC_MESSAGES/Linux-PAM.mo,ga/LC_MESSAGES/Linux-PAM.mo,kw_GB/LC_MESSAGES/Linux-PAM.mo,am/LC_MESSAGES/Linux-PAM.mo,is/LC_MESSAGES/Linux-PAM.mo,zh_TW/LC_MESSAGES/Linux-PAM.mo,vi/LC_MESSAGES/Linux-PAM.mo,af/LC_MESSAGES/Linux-PAM.mo,th/LC_MESSAGES/Linux-PAM.mo,ja/LC_MESSAGES/Linux-PAM.mo,zh_HK/LC_MESSAGES/Linux-PAM.mo,nb/LC_MESSAGES/Linux-PAM.mo,ru/LC_MESSAGES/Linux-PAM.mo,ms/LC_MESSAGES/Linux-PAM.mo,my/LC_MESSAGES/Linux-PAM.mo,sv/LC_MESSAGES/Linux-PAM.mo,ar/LC_MESSAGES/Linux-PAM.mo,tg/LC_MESSAGES/Linux-PAM.mo,zh_CN/LC_MESSAGES/Linux-PAM.mo,id/LC_MESSAGES/Linux-PAM.mo,ur/LC_MESSAGES/Linux-PAM.mo,ro/LC_MESSAGES/Linux-PAM.mo,pt/LC_MESSAGES/Linux-PAM.mo,ml/LC_MESSAGES/Linux-PAM.mo,mr/LC_MESSAGES/Linux-PAM.mo,te/LC_MESSAGES/Linux-PAM.mo,ky/LC_MESSAGES/Linux-PAM.mo}

$ROOT/generate_rpm.sh "$ISO_RPMS" \
                      "$PAM_SRC/build/rpmbuild" \
                      "$PAM_RPM_NAME" \
                      "$PAM_VERSION" \
                      "Pluggable Authentication Modules" \
                      "Linux-PAM is a system of libraries that handle the authentication tasks of applications (services) on the system. The library provides a stable general interface (Application Programming Interface - API) that privilege granting programs (such as login(1) and su(1)) defer to to perform standard authentication tasks." \
                      "custom" \
                      "$PAM_SRC/build/$PAM_FULLNAME.tar" \
"etc/security/faillock.conf" "%{_sysconfdir}/security/faillock.conf" \
"etc/security/access.conf" "%{_sysconfdir}/security/access.conf" \
"etc/security/pam_env.conf" "%{_sysconfdir}/security/pam_env.conf" \
"etc/security/time.conf" "%{_sysconfdir}/security/time.conf" \
"etc/security/group.conf" "%{_sysconfdir}/security/group.conf" \
"etc/security/namespace.init" "%{_sysconfdir}/security/namespace.init" \
"etc/security/limits.conf" "%{_sysconfdir}/security/limits.conf" \
"etc/security/namespace.conf" "%{_sysconfdir}/security/namespace.conf" \
"etc/security/pwhistory.conf" "%{_sysconfdir}/security/pwhistory.conf" \
"etc/environment" "%{_sysconfdir}/environment" \
"usr/include/security/pam_client.h" "%{_includedir}/security/pam_client.h" \
"usr/include/security/pam_modules.h" "%{_includedir}/security/pam_modules.h" \
"usr/include/security/_pam_types.h" "%{_includedir}/security/_pam_types.h" \
"usr/include/security/_pam_macros.h" "%{_includedir}/security/_pam_macros.h" \
"usr/include/security/pam_appl.h" "%{_includedir}/security/pam_appl.h" \
"usr/include/security/pam_misc.h" "%{_includedir}/security/pam_misc.h" \
"usr/include/security/_pam_compat.h" "%{_includedir}/security/_pam_compat.h" \
"usr/include/security/pam_ext.h" "%{_includedir}/security/pam_ext.h" \
"usr/include/security/pam_filter.h" "%{_includedir}/security/pam_filter.h" \
"usr/include/security/pam_modutil.h" "%{_includedir}/security/pam_modutil.h" \
"usr/lib/libpamc.so" "%{_libdir}/libpamc.so" \
"usr/lib/libpam.so" "%{_libdir}/libpam.so" \
"usr/lib/libpamc.so.0" "%{_libdir}/libpamc.so.0" \
"usr/lib/libpam_misc.so.0" "%{_libdir}/libpam_misc.so.0" \
"usr/lib/libpam.so.0" "%{_libdir}/libpam.so.0" \
"usr/lib/security/pam_deny.so" "%{_libdir}/security/pam_deny.so" \
"usr/lib/security/pam_access.so" "%{_libdir}/security/pam_access.so" \
"usr/lib/security/pam_nologin.so" "%{_libdir}/security/pam_nologin.so" \
"usr/lib/security/pam_permit.so" "%{_libdir}/security/pam_permit.so" \
"usr/lib/security/pam_timestamp.so" "%{_libdir}/security/pam_timestamp.so" \
"usr/lib/security/pam_securetty.so" "%{_libdir}/security/pam_securetty.so" \
"usr/lib/security/pam_ftp.so" "%{_libdir}/security/pam_ftp.so" \
"usr/lib/security/pam_loginuid.so" "%{_libdir}/security/pam_loginuid.so" \
"usr/lib/security/pam_time.so" "%{_libdir}/security/pam_time.so" \
"usr/lib/security/pam_debug.so" "%{_libdir}/security/pam_debug.so" \
"usr/lib/security/pam_pwhistory.so" "%{_libdir}/security/pam_pwhistory.so" \
"usr/lib/security/pam_faildelay.so" "%{_libdir}/security/pam_faildelay.so" \
"usr/lib/security/pam_rhosts.so" "%{_libdir}/security/pam_rhosts.so" \
"usr/lib/security/pam_xauth.so" "%{_libdir}/security/pam_xauth.so" \
"usr/lib/security/pam_stress.so" "%{_libdir}/security/pam_stress.so" \
"usr/lib/security/pam_env.so" "%{_libdir}/security/pam_env.so" \
"usr/lib/security/pam_wheel.so" "%{_libdir}/security/pam_wheel.so" \
"usr/lib/security/pam_motd.so" "%{_libdir}/security/pam_motd.so" \
"usr/lib/security/pam_faillock.so" "%{_libdir}/security/pam_faillock.so" \
"usr/lib/security/pam_localuser.so" "%{_libdir}/security/pam_localuser.so" \
"usr/lib/security/pam_shells.so" "%{_libdir}/security/pam_shells.so" \
"usr/lib/security/pam_listfile.so" "%{_libdir}/security/pam_listfile.so" \
"usr/lib/security/pam_limits.so" "%{_libdir}/security/pam_limits.so" \
"usr/lib/security/pam_mail.so" "%{_libdir}/security/pam_mail.so" \
"usr/lib/security/pam_group.so" "%{_libdir}/security/pam_group.so" \
"usr/lib/security/pam_unix.so" "%{_libdir}/security/pam_unix.so" \
"usr/lib/security/pam_canonicalize_user.so" "%{_libdir}/security/pam_canonicalize_user.so" \
"usr/lib/security/pam_setquota.so" "%{_libdir}/security/pam_setquota.so" \
"usr/lib/security/pam_namespace.so" "%{_libdir}/security/pam_namespace.so" \
"usr/lib/security/pam_filter.so" "%{_libdir}/security/pam_filter.so" \
"usr/lib/security/pam_succeed_if.so" "%{_libdir}/security/pam_succeed_if.so" \
"usr/lib/security/pam_warn.so" "%{_libdir}/security/pam_warn.so" \
"usr/lib/security/pam_issue.so" "%{_libdir}/security/pam_issue.so" \
"usr/lib/security/pam_filter/upperLOWER" "%{_libdir}/security/pam_filter/upperLOWER" \
"usr/lib/security/pam_exec.so" "%{_libdir}/security/pam_exec.so" \
"usr/lib/security/pam_usertype.so" "%{_libdir}/security/pam_usertype.so" \
"usr/lib/security/pam_umask.so" "%{_libdir}/security/pam_umask.so" \
"usr/lib/security/pam_rootok.so" "%{_libdir}/security/pam_rootok.so" \
"usr/lib/security/pam_mkhomedir.so" "%{_libdir}/security/pam_mkhomedir.so" \
"usr/lib/security/pam_echo.so" "%{_libdir}/security/pam_echo.so" \
"usr/lib/libpamc.so.0.82.1" "%{_libdir}/libpamc.so.0.82.1" \
"usr/lib/systemd/system/pam_namespace.service" "%{_libdir}/systemd/system/pam_namespace.service" \
"usr/lib/libpam_misc.so" "%{_libdir}/libpam_misc.so" \
"usr/lib/libpam.so.0.85.1" "%{_libdir}/libpam.so.0.85.1" \
"usr/lib/pkgconfig/pamc.pc" "%{_libdir}/pkgconfig/pamc.pc" \
"usr/lib/pkgconfig/pam.pc" "%{_libdir}/pkgconfig/pam.pc" \
"usr/lib/pkgconfig/pam_misc.pc" "%{_libdir}/pkgconfig/pam_misc.pc" \
"usr/lib/libpam_misc.so.0.82.1" "%{_libdir}/libpam_misc.so.0.82.1" \
"usr/sbin/pwhistory_helper" "%{_sbindir}/pwhistory_helper" \
"usr/sbin/pam_namespace_helper" "%{_sbindir}/pam_namespace_helper" \
"usr/sbin/faillock" "%{_sbindir}/faillock" \
"usr/sbin/mkhomedir_helper" "%{_sbindir}/mkhomedir_helper" \
"usr/sbin/pam_timestamp_check" "%{_sbindir}/pam_timestamp_check" \
"usr/sbin/unix_chkpwd" "%{_sbindir}/unix_chkpwd" \
"usr/share/locale/de/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/de/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/bs/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/bs/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/km/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/km/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/pt_BR/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/pt_BR/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/ta/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/ta/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/yo/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/yo/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/sr@latin/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/sr@latin/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/tr/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/tr/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/hu/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/hu/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/gl/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/gl/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/lv/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/lv/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/da/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/da/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/hr/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/hr/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/he/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/he/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/sr/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/sr/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/be/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/be/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/or/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/or/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/fi/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/fi/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/de_CH/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/de_CH/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/si/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/si/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/fa/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/fa/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/mk/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/mk/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/kn/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/kn/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/nn/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/nn/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/pa/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/pa/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/et/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/et/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/ka/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/ka/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/pl/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/pl/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/cs/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/cs/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/lt/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/lt/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/sq/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/sq/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/ia/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/ia/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/gu/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/gu/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/ca/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/ca/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/eu/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/eu/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/it/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/it/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/bg/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/bg/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/nl/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/nl/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/es/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/es/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/sk/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/sk/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/az/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/az/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/cy/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/cy/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/zu/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/zu/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/bn_IN/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/bn_IN/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/el/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/el/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/eo/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/eo/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/ne/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/ne/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/ko/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/ko/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/kk/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/kk/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/as/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/as/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/sl/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/sl/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/mn/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/mn/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/fr/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/fr/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/bn/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/bn/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/hi/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/hi/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/uk/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/uk/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/ga/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/ga/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/kw_GB/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/kw_GB/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/am/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/am/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/is/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/is/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/zh_TW/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/zh_TW/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/vi/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/vi/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/af/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/af/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/th/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/th/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/ja/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/ja/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/zh_HK/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/zh_HK/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/nb/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/nb/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/ru/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/ru/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/ms/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/ms/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/my/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/my/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/sv/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/sv/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/ar/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/ar/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/tg/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/tg/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/zh_CN/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/zh_CN/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/id/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/id/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/ur/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/ur/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/ro/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/ro/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/pt/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/pt/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/ml/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/ml/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/mr/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/mr/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/te/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/te/LC_MESSAGES/Linux-PAM.mo" \
"usr/share/locale/ky/LC_MESSAGES/Linux-PAM.mo" "%{_datadir}/locale/ky/LC_MESSAGES/Linux-PAM.mo"
