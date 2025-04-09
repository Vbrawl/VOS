#!/bin/bash

OPENSSL_SRC=$CACHE/openssl
OPENSSL_RPM_NAME=OpenSSL
OPENSSL_VERSION="3.4.1"
OPENSSL_FULLNAME=$OPENSSL_RPM_NAME-$OPENSSL_VERSION
$ROOT/download_and_untar.sh "https://github.com/openssl/openssl/releases/download/openssl-3.4.1/openssl-3.4.1.tar.gz" "$OPENSSL_SRC"

if [ ! -d $OPENSSL_SRC/build ]
then
  mkdir -p $OPENSSL_SRC/build
  cd $OPENSSL_SRC/build
  ../Configure --cross-compile-prefix=$TARGET- --prefix=/usr
  make -j$(nproc)
fi
cd $OPENSSL_SRC/build
make DESTDIR=$ISO_SYSROOT install

$ROOT/generate_tar.sh make $OPENSSL_SRC/build/$OPENSSL_FULLNAME.tar $OPENSSL_FULLNAME \
                      usr/bin/{c_rehash,openssl} \
                      usr/include/openssl/{crmf.h,cmp.h,conftypes.h,async.h,seed.h,aes.h,proverr.h,ssl2.h,symhacks.h,hmac.h,sslerr_legacy.h,cms.h,safestack.h,core_object.h,tls1.h,cmperr.h,prov_ssl.h,buffererr.h,ebcdic.h,pem2.h,ct.h,trace.h,bn.h,bnerr.h,conf.h,modes.h,macros.h,asn1err.h,cryptoerr_legacy.h,md2.h,core.h,provider.h,dh.h,opensslv.h,pkcs12.h,cterr.h,obj_mac.h,kdf.h,conferr.h,x509_acert.h,ripemd.h,http.h,evp.h,srtp.h,x509v3.h,opensslconf.h,ssl3.h,ossl_typ.h,storeerr.h,hpke.h,txt_db.h,dherr.h,mdc2.h,rc2.h,pemerr.h,ui.h,srp.h,asn1t.h,sha.h,decodererr.h,ecerr.h,cmserr.h,asn1.h,randerr.h,camellia.h,indicator.h,md4.h,types.h,self_test.h,pkcs7.h,evperr.h,e_os2.h,quic.h,pem.h,asyncerr.h,encodererr.h,rsaerr.h,idea.h,dtls1.h,ec.h,uierr.h,sslerr.h,pkcs12err.h,cast.h,bio.h,core_names.h,fips_names.h,rc4.h,rsa.h,thread.h,ess.h,crmferr.h,err.h,ocsp.h,decoder.h,httperr.h,tserr.h,cryptoerr.h,whrlpool.h,esserr.h,buffer.h,objectserr.h,dsaerr.h,blowfish.h,lhash.h,cmp_util.h,x509err.h,param_build.h,encoder.h,ts.h,dsa.h,ocsperr.h,kdferr.h,crypto.h,comperr.h,ssl.h,x509_vfy.h,params.h,rc5.h,comp.h,x509.h,stack.h,e_ostime.h,ecdh.h,bioerr.h,engineerr.h,cmac.h,conf_api.h,des.h,x509v3err.h,ecdsa.h,configuration.h,md5.h,fipskey.h,rand.h,engine.h,store.h,asn1_mac.h,objects.h,pkcs7err.h,core_dispatch.h} \
                      usr/lib64/{libssl.so,libssl.a,ossl-modules/legacy.so,libcrypto.so,cmake/OpenSSL/OpenSSLConfig.cmake,cmake/OpenSSL/OpenSSLConfigVersion.cmake,pkgconfig/libssl.pc,pkgconfig/openssl.pc,pkgconfig/libcrypto.pc,libssl.so.3,libcrypto.so.3,libcrypto.a,engines-3/loader_attic.so,engines-3/padlock.so,engines-3/afalg.so,engines-3/capi.so} \
                      usr/ssl/{ct_log_list.cnf,ct_log_list.cnf.dist,openssl.cnf.dist,misc/CA.pl,misc/tsget.pl,misc/tsget,openssl.cnf}

$ROOT/generate_rpm.sh "$ISO_RPMS" \
                      "$OPENSSL_SRC/build/rpmbuild" \
                      "$OPENSSL_RPM_NAME" \
                      "$OPENSSL_VERSION" \
                      "OpenSSL utilities and libraries" \
                      "OpenSSL is a robust, commercial-grade, full-featured Open Source Toolkit for the TLS (formerly SSL), DTLS and QUIC protocols." \
                      "Apache-2.0" \
                      "$OPENSSL_SRC/build/$OPENSSL_FULLNAME.tar" \
"usr/bin/c_rehash" "%{_bindir}/c_rehash" \
"usr/bin/openssl" "%{_bindir}/openssl" \
"usr/include/openssl/crmf.h" "%{_includedir}/openssl/crmf.h" \
"usr/include/openssl/cmp.h" "%{_includedir}/openssl/cmp.h" \
"usr/include/openssl/conftypes.h" "%{_includedir}/openssl/conftypes.h" \
"usr/include/openssl/async.h" "%{_includedir}/openssl/async.h" \
"usr/include/openssl/seed.h" "%{_includedir}/openssl/seed.h" \
"usr/include/openssl/aes.h" "%{_includedir}/openssl/aes.h" \
"usr/include/openssl/proverr.h" "%{_includedir}/openssl/proverr.h" \
"usr/include/openssl/ssl2.h" "%{_includedir}/openssl/ssl2.h" \
"usr/include/openssl/symhacks.h" "%{_includedir}/openssl/symhacks.h" \
"usr/include/openssl/hmac.h" "%{_includedir}/openssl/hmac.h" \
"usr/include/openssl/sslerr_legacy.h" "%{_includedir}/openssl/sslerr_legacy.h" \
"usr/include/openssl/cms.h" "%{_includedir}/openssl/cms.h" \
"usr/include/openssl/safestack.h" "%{_includedir}/openssl/safestack.h" \
"usr/include/openssl/core_object.h" "%{_includedir}/openssl/core_object.h" \
"usr/include/openssl/tls1.h" "%{_includedir}/openssl/tls1.h" \
"usr/include/openssl/cmperr.h" "%{_includedir}/openssl/cmperr.h" \
"usr/include/openssl/prov_ssl.h" "%{_includedir}/openssl/prov_ssl.h" \
"usr/include/openssl/buffererr.h" "%{_includedir}/openssl/buffererr.h" \
"usr/include/openssl/ebcdic.h" "%{_includedir}/openssl/ebcdic.h" \
"usr/include/openssl/pem2.h" "%{_includedir}/openssl/pem2.h" \
"usr/include/openssl/ct.h" "%{_includedir}/openssl/ct.h" \
"usr/include/openssl/trace.h" "%{_includedir}/openssl/trace.h" \
"usr/include/openssl/bn.h" "%{_includedir}/openssl/bn.h" \
"usr/include/openssl/bnerr.h" "%{_includedir}/openssl/bnerr.h" \
"usr/include/openssl/conf.h" "%{_includedir}/openssl/conf.h" \
"usr/include/openssl/modes.h" "%{_includedir}/openssl/modes.h" \
"usr/include/openssl/macros.h" "%{_includedir}/openssl/macros.h" \
"usr/include/openssl/asn1err.h" "%{_includedir}/openssl/asn1err.h" \
"usr/include/openssl/cryptoerr_legacy.h" "%{_includedir}/openssl/cryptoerr_legacy.h" \
"usr/include/openssl/md2.h" "%{_includedir}/openssl/md2.h" \
"usr/include/openssl/core.h" "%{_includedir}/openssl/core.h" \
"usr/include/openssl/provider.h" "%{_includedir}/openssl/provider.h" \
"usr/include/openssl/dh.h" "%{_includedir}/openssl/dh.h" \
"usr/include/openssl/opensslv.h" "%{_includedir}/openssl/opensslv.h" \
"usr/include/openssl/pkcs12.h" "%{_includedir}/openssl/pkcs12.h" \
"usr/include/openssl/cterr.h" "%{_includedir}/openssl/cterr.h" \
"usr/include/openssl/obj_mac.h" "%{_includedir}/openssl/obj_mac.h" \
"usr/include/openssl/kdf.h" "%{_includedir}/openssl/kdf.h" \
"usr/include/openssl/conferr.h" "%{_includedir}/openssl/conferr.h" \
"usr/include/openssl/x509_acert.h" "%{_includedir}/openssl/x509_acert.h" \
"usr/include/openssl/ripemd.h" "%{_includedir}/openssl/ripemd.h" \
"usr/include/openssl/http.h" "%{_includedir}/openssl/http.h" \
"usr/include/openssl/evp.h" "%{_includedir}/openssl/evp.h" \
"usr/include/openssl/srtp.h" "%{_includedir}/openssl/srtp.h" \
"usr/include/openssl/x509v3.h" "%{_includedir}/openssl/x509v3.h" \
"usr/include/openssl/opensslconf.h" "%{_includedir}/openssl/opensslconf.h" \
"usr/include/openssl/ssl3.h" "%{_includedir}/openssl/ssl3.h" \
"usr/include/openssl/ossl_typ.h" "%{_includedir}/openssl/ossl_typ.h" \
"usr/include/openssl/storeerr.h" "%{_includedir}/openssl/storeerr.h" \
"usr/include/openssl/hpke.h" "%{_includedir}/openssl/hpke.h" \
"usr/include/openssl/txt_db.h" "%{_includedir}/openssl/txt_db.h" \
"usr/include/openssl/dherr.h" "%{_includedir}/openssl/dherr.h" \
"usr/include/openssl/mdc2.h" "%{_includedir}/openssl/mdc2.h" \
"usr/include/openssl/rc2.h" "%{_includedir}/openssl/rc2.h" \
"usr/include/openssl/pemerr.h" "%{_includedir}/openssl/pemerr.h" \
"usr/include/openssl/ui.h" "%{_includedir}/openssl/ui.h" \
"usr/include/openssl/srp.h" "%{_includedir}/openssl/srp.h" \
"usr/include/openssl/asn1t.h" "%{_includedir}/openssl/asn1t.h" \
"usr/include/openssl/sha.h" "%{_includedir}/openssl/sha.h" \
"usr/include/openssl/decodererr.h" "%{_includedir}/openssl/decodererr.h" \
"usr/include/openssl/ecerr.h" "%{_includedir}/openssl/ecerr.h" \
"usr/include/openssl/cmserr.h" "%{_includedir}/openssl/cmserr.h" \
"usr/include/openssl/asn1.h" "%{_includedir}/openssl/asn1.h" \
"usr/include/openssl/randerr.h" "%{_includedir}/openssl/randerr.h" \
"usr/include/openssl/camellia.h" "%{_includedir}/openssl/camellia.h" \
"usr/include/openssl/indicator.h" "%{_includedir}/openssl/indicator.h" \
"usr/include/openssl/md4.h" "%{_includedir}/openssl/md4.h" \
"usr/include/openssl/types.h" "%{_includedir}/openssl/types.h" \
"usr/include/openssl/self_test.h" "%{_includedir}/openssl/self_test.h" \
"usr/include/openssl/pkcs7.h" "%{_includedir}/openssl/pkcs7.h" \
"usr/include/openssl/evperr.h" "%{_includedir}/openssl/evperr.h" \
"usr/include/openssl/e_os2.h" "%{_includedir}/openssl/e_os2.h" \
"usr/include/openssl/quic.h" "%{_includedir}/openssl/quic.h" \
"usr/include/openssl/pem.h" "%{_includedir}/openssl/pem.h" \
"usr/include/openssl/asyncerr.h" "%{_includedir}/openssl/asyncerr.h" \
"usr/include/openssl/encodererr.h" "%{_includedir}/openssl/encodererr.h" \
"usr/include/openssl/rsaerr.h" "%{_includedir}/openssl/rsaerr.h" \
"usr/include/openssl/idea.h" "%{_includedir}/openssl/idea.h" \
"usr/include/openssl/dtls1.h" "%{_includedir}/openssl/dtls1.h" \
"usr/include/openssl/ec.h" "%{_includedir}/openssl/ec.h" \
"usr/include/openssl/uierr.h" "%{_includedir}/openssl/uierr.h" \
"usr/include/openssl/sslerr.h" "%{_includedir}/openssl/sslerr.h" \
"usr/include/openssl/pkcs12err.h" "%{_includedir}/openssl/pkcs12err.h" \
"usr/include/openssl/cast.h" "%{_includedir}/openssl/cast.h" \
"usr/include/openssl/bio.h" "%{_includedir}/openssl/bio.h" \
"usr/include/openssl/core_names.h" "%{_includedir}/openssl/core_names.h" \
"usr/include/openssl/fips_names.h" "%{_includedir}/openssl/fips_names.h" \
"usr/include/openssl/rc4.h" "%{_includedir}/openssl/rc4.h" \
"usr/include/openssl/rsa.h" "%{_includedir}/openssl/rsa.h" \
"usr/include/openssl/thread.h" "%{_includedir}/openssl/thread.h" \
"usr/include/openssl/ess.h" "%{_includedir}/openssl/ess.h" \
"usr/include/openssl/crmferr.h" "%{_includedir}/openssl/crmferr.h" \
"usr/include/openssl/err.h" "%{_includedir}/openssl/err.h" \
"usr/include/openssl/ocsp.h" "%{_includedir}/openssl/ocsp.h" \
"usr/include/openssl/decoder.h" "%{_includedir}/openssl/decoder.h" \
"usr/include/openssl/httperr.h" "%{_includedir}/openssl/httperr.h" \
"usr/include/openssl/tserr.h" "%{_includedir}/openssl/tserr.h" \
"usr/include/openssl/cryptoerr.h" "%{_includedir}/openssl/cryptoerr.h" \
"usr/include/openssl/whrlpool.h" "%{_includedir}/openssl/whrlpool.h" \
"usr/include/openssl/esserr.h" "%{_includedir}/openssl/esserr.h" \
"usr/include/openssl/buffer.h" "%{_includedir}/openssl/buffer.h" \
"usr/include/openssl/objectserr.h" "%{_includedir}/openssl/objectserr.h" \
"usr/include/openssl/dsaerr.h" "%{_includedir}/openssl/dsaerr.h" \
"usr/include/openssl/blowfish.h" "%{_includedir}/openssl/blowfish.h" \
"usr/include/openssl/lhash.h" "%{_includedir}/openssl/lhash.h" \
"usr/include/openssl/cmp_util.h" "%{_includedir}/openssl/cmp_util.h" \
"usr/include/openssl/x509err.h" "%{_includedir}/openssl/x509err.h" \
"usr/include/openssl/param_build.h" "%{_includedir}/openssl/param_build.h" \
"usr/include/openssl/encoder.h" "%{_includedir}/openssl/encoder.h" \
"usr/include/openssl/ts.h" "%{_includedir}/openssl/ts.h" \
"usr/include/openssl/dsa.h" "%{_includedir}/openssl/dsa.h" \
"usr/include/openssl/ocsperr.h" "%{_includedir}/openssl/ocsperr.h" \
"usr/include/openssl/kdferr.h" "%{_includedir}/openssl/kdferr.h" \
"usr/include/openssl/crypto.h" "%{_includedir}/openssl/crypto.h" \
"usr/include/openssl/comperr.h" "%{_includedir}/openssl/comperr.h" \
"usr/include/openssl/ssl.h" "%{_includedir}/openssl/ssl.h" \
"usr/include/openssl/x509_vfy.h" "%{_includedir}/openssl/x509_vfy.h" \
"usr/include/openssl/params.h" "%{_includedir}/openssl/params.h" \
"usr/include/openssl/rc5.h" "%{_includedir}/openssl/rc5.h" \
"usr/include/openssl/comp.h" "%{_includedir}/openssl/comp.h" \
"usr/include/openssl/x509.h" "%{_includedir}/openssl/x509.h" \
"usr/include/openssl/stack.h" "%{_includedir}/openssl/stack.h" \
"usr/include/openssl/e_ostime.h" "%{_includedir}/openssl/e_ostime.h" \
"usr/include/openssl/ecdh.h" "%{_includedir}/openssl/ecdh.h" \
"usr/include/openssl/bioerr.h" "%{_includedir}/openssl/bioerr.h" \
"usr/include/openssl/engineerr.h" "%{_includedir}/openssl/engineerr.h" \
"usr/include/openssl/cmac.h" "%{_includedir}/openssl/cmac.h" \
"usr/include/openssl/conf_api.h" "%{_includedir}/openssl/conf_api.h" \
"usr/include/openssl/des.h" "%{_includedir}/openssl/des.h" \
"usr/include/openssl/x509v3err.h" "%{_includedir}/openssl/x509v3err.h" \
"usr/include/openssl/ecdsa.h" "%{_includedir}/openssl/ecdsa.h" \
"usr/include/openssl/configuration.h" "%{_includedir}/openssl/configuration.h" \
"usr/include/openssl/md5.h" "%{_includedir}/openssl/md5.h" \
"usr/include/openssl/fipskey.h" "%{_includedir}/openssl/fipskey.h" \
"usr/include/openssl/rand.h" "%{_includedir}/openssl/rand.h" \
"usr/include/openssl/engine.h" "%{_includedir}/openssl/engine.h" \
"usr/include/openssl/store.h" "%{_includedir}/openssl/store.h" \
"usr/include/openssl/asn1_mac.h" "%{_includedir}/openssl/asn1_mac.h" \
"usr/include/openssl/objects.h" "%{_includedir}/openssl/objects.h" \
"usr/include/openssl/pkcs7err.h" "%{_includedir}/openssl/pkcs7err.h" \
"usr/include/openssl/core_dispatch.h" "%{_includedir}/openssl/core_dispatch.h" \
"usr/lib64/libssl.so" "%{_libdir}/libssl.so" \
"usr/lib64/libssl.a" "%{_libdir}/libssl.a" \
"usr/lib64/ossl-modules/legacy.so" "%{_libdir}/ossl-modules/legacy.so" \
"usr/lib64/libcrypto.so" "%{_libdir}/libcrypto.so" \
"usr/lib64/cmake/OpenSSL/OpenSSLConfig.cmake" "%{_libdir}/cmake/OpenSSL/OpenSSLConfig.cmake" \
"usr/lib64/cmake/OpenSSL/OpenSSLConfigVersion.cmake" "%{_libdir}/cmake/OpenSSL/OpenSSLConfigVersion.cmake" \
"usr/lib64/pkgconfig/libssl.pc" "%{_libdir}/pkgconfig/libssl.pc" \
"usr/lib64/pkgconfig/openssl.pc" "%{_libdir}/pkgconfig/openssl.pc" \
"usr/lib64/pkgconfig/libcrypto.pc" "%{_libdir}/pkgconfig/libcrypto.pc" \
"usr/lib64/libssl.so.3" "%{_libdir}/libssl.so.3" \
"usr/lib64/libcrypto.so.3" "%{_libdir}/libcrypto.so.3" \
"usr/lib64/libcrypto.a" "%{_libdir}/libcrypto.a" \
"usr/lib64/engines-3/loader_attic.so" "%{_libdir}/engines-3/loader_attic.so" \
"usr/lib64/engines-3/padlock.so" "%{_libdir}/engines-3/padlock.so" \
"usr/lib64/engines-3/afalg.so" "%{_libdir}/engines-3/afalg.so" \
"usr/lib64/engines-3/capi.so" "%{_libdir}/engines-3/capi.so" \
"usr/ssl/ct_log_list.cnf" "%{_prefix}/ssl/ct_log_list.cnf" \
"usr/ssl/ct_log_list.cnf.dist" "%{_prefix}/ssl/ct_log_list.cnf.dist" \
"usr/ssl/openssl.cnf.dist" "%{_prefix}/ssl/openssl.cnf.dist" \
"usr/ssl/misc/CA.pl" "%{_prefix}/ssl/misc/CA.pl" \
"usr/ssl/misc/tsget.pl" "%{_prefix}/ssl/misc/tsget.pl" \
"usr/ssl/misc/tsget" "%{_prefix}/ssl/misc/tsget" \
"usr/ssl/openssl.cnf" "%{_prefix}/ssl/openssl.cnf"
