#!/bin/sh
set -e

if test -z "${WASI_SYSROOT}"; then
    echo "WASI_SYSROOT not set" >&2
    exit 2
fi

VERSION=1.2.12
SHA256SUM=91844808532e5ce316b3c010929493c0244f3d37593afd6de04f71821d5136d9

SRCDIR=zlib-${VERSION}
TARBALL=${SRCDIR}.tar.gz

BUILDDIR=$(pwd)
DESTDIR=${BUILDDIR}/wasi-sysroot
INSTALL="install -m644 -D -v"

trap "rm -rf ${BUILDDIR}/${SRCDIR} ${BUILDDIR}/${TARBALL} ${BUILDDIR}/${TARBALL}.sha256sum" INT TERM EXIT

curl -sSf https://zlib.net/${TARBALL} -o ${TARBALL}

echo "SHA256 (${TARBALL}) = ${SHA256SUM}" > ${TARBALL}.sha256sum
sha256sum --check ${TARBALL}.sha256sum

tar xzf ${TARBALL}
cd ${SRCDIR}

./configure --static --prefix=/
make libz.a

# create pkg-config file without extra -L and -I
cat > zlib.pc << EOF
Name: zlib
Description: zlib compression library
Version: ${VERSION}

Requires:
Libs: -lz
Cflags:
EOF

$INSTALL -t ${DESTDIR}/include zconf.h zlib.h
$INSTALL -t ${DESTDIR}/lib/wasm32-wasi libz.a
$INSTALL -t ${DESTDIR}/lib/pkgconfig zlib.pc
