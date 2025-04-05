#!/bin/bash

LUA_SRC=$CACHE/lua
LUA_RPM_NAME=Lua
LUA_VERSION="5.4.7"
LUA_FULLNAME=$LUA_RPM_NAME-$LUA_VERSION
$ROOT/download_and_untar.sh "https://www.lua.org/ftp/lua-5.4.7.tar.gz" "$LUA_SRC"

if [ ! -f $LUA_SRC/src/lua ]
then
  cd $LUA_SRC

  patch -p1 < $ROOT/patches/lua.patch
  sed -i '/CC= gcc/s/gcc/${TARGET}-gcc/g' src/Makefile
  make -j$(nproc) SYSCFLAGS="-fPIC"
fi

cd $LUA_SRC
if [ -f Makefile.bak ]
then
  mv Makefile.bak Makefile
fi
sed -i.bak "\|INSTALL_TOP=|s|/usr/local|${LUA_SRC}/${LUA_FULLNAME}/usr|g" Makefile

$ROOT/generate_tar.sh make $LUA_SRC/$LUA_FULLNAME.tar $LUA_FULLNAME \
                      usr/lib/liblua.{a,so} \
                      usr/include/{lua,lauxlib,lualib,luaconf}.h \
                      usr/include/lua.hpp \
                      usr/bin/{lua,luac}

$ROOT/generate_rpm.sh "$ISO_RPMS" \
                      "$LUA_SRC/rpmbuild" \
                      "$LUA_RPM_NAME" \
                      "$LUA_VERSION" \
                      "Lua is a powerful, efficient, lightweight, embeddable scripting language. It supports procedural programming, object-oriented programming, functional programming, data-driven programming, and data description." \
                      "Lua combines simple procedural syntax with powerful data description constructs based on associative arrays and extensible semantics. Lua is dynamically typed, runs by interpreting bytecode with a register-based virtual machine, and has automatic memory management with incremental garbage collection, making it ideal for configuration, scripting, and rapid prototyping." \
                      "MIT" \
                      "$LUA_SRC/$LUA_FULLNAME.tar" \
                      "usr/lib/liblua.so" "%{_libdir}/liblua.so" \
                      "usr/lib/liblua.a" "%{_libdir}/liblua.a" \
                      "usr/include/lua.h" "%{_includedir}/lua.h" \
                      "usr/include/lauxlib.h" "%{_includedir}/lauxlib.h" \
                      "usr/include/lualib.h" "%{_includedir}/lualib.h" \
                      "usr/include/lua.hpp" "%{_includedir}/lua.hpp" \
                      "usr/include/luaconf.h" "%{_includedir}/luaconf.h" \
                      "usr/bin/luac" "%{_bindir}/luac" \
                      "usr/bin/lua" "%{_bindir}/lua"
