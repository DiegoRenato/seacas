#! /bin/sh

### The following assumes you are building in a subdirectory of ACCESS Root
if [ "X$ACCESS" == "X" ] ; then
  ACCESS=$(cd ../../..; pwd)
  echo "ACCESS set to ${ACCESS}"
fi

if [ "$CRAY" == "ON" ]
then
    USE_SHARED="--disable-shared"
else
    SHARED="${SHARED:-ON}"
    if [[ "$SHARED" == "ON" || "$SHARED" == "YES" ]]
    then
	USE_SHARED="--enable-shared"
    else
	USE_SHARED="--disable-shared"
    fi
fi

rm -f config.cache
if [ "$CRAY" == "ON" ]
then
  CC=cc
else
  CC=mpicc
fi
MPICC=$(CC); export MPICC
export CFLAGS="-fPIC -I${ACCESS}/include"
export CPPFLAGS="-DNDEBUG"
export AR_FLAGS="cru"

LDFLAGS='-L${ACCESS}/lib'; export LDFLAGS
./configure --disable-fortran ${USE_SHARED} --disable-cxx --prefix=${ACCESS}

echo ""
echo "COMPILER: ${CC}"
echo "  ACCESS: ${ACCESS}"
echo ""
