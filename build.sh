#!/bin/bash -e
# Build script for gnuplot
. /etc/profile.d/modules.sh

module add ci
# Dependencies
module add lua

SOURCE_FILE=${NAME}-${VERSION}.tar.gz

echo "REPO_DIR is "
echo $REPO_DIR
echo "SRC_DIR is "
echo $SRC_DIR
echo "WORKSPACE is "
echo $WORKSPACE
echo "SOFT_DIR is"
echo $SOFT_DIR

mkdir -p ${WORKSPACE}
mkdir -p ${SRC_DIR}
mkdir -p ${SOFT_DIR}

#  Download the source file

if [ ! -e ${SRC_DIR}/${SOURCE_FILE}.lock ] && [ ! -s ${SRC_DIR}/${SOURCE_FILE} ] ; then
  touch  ${SRC_DIR}/${SOURCE_FILE}.lock
  echo "seems like this is the first build - let's geet the source"
  wget https://downloads.sourceforge.net/project/${NAME}/${NAME}/${VERSION}/${SOURCE_FILE} -O ${SRC_DIR}/${SOURCE_FILE}
  echo "releasing lock"
  rm -v ${SRC_DIR}/${SOURCE_FILE}.lock
elif [ -e ${SRC_DIR}/${SOURCE_FILE}.lock ] ; then
  # Someone else has the file, wait till it's released
  while [ -e ${SRC_DIR}/${SOURCE_FILE}.lock ] ; do
    echo " There seems to be a download currently under way, will check again in 5 sec"
    sleep 5
  done
else
  echo "continuing from previous builds, using source at " ${SRC_DIR}/${SOURCE_FILE}
fi
tar xzf  ${SRC_DIR}/${SOURCE_FILE} -C ${WORKSPACE} --skip-old-files
mkdir -p ${WORKSPACE}/${NAME}-${VERSION}/build-${BUILD_NUMBER}
cd ${WORKSPACE}/${NAME}-${VERSION}/build-${BUILD_NUMBER}
#export LDFLAGS="-L${READLINE_DIR}/lib -L${NCURSES_DIR}/lib -lncurses -lreadline"
 #export LDFLAGS="-L${READLINE_DIR}/lib -L${NCURSES_DIR}/lib -L${ZLIB_DIR}/lib -L${LUA_DIR}/lib -lreadline -lncurses -lz -llua"
#export CPPFLAGS="-I${NCURSES_DIR}/include -I${READLINE_DIR}/include -I${ZLIB_DIR}/include -I${LUA_DIR}/include"
export CPPFLAGS="-I${LUA_DIR}/include"
export LDFLAGS="-L${LUA_DIR}/lib -llua"
../configure --prefix=${SOFT_DIR} \
--with-readline=gnu \
LUA_LIBS="-L${LUA_DIR} -llua" \
--with-qt=no
make
