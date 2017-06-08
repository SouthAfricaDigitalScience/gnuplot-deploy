#!/bin/bash -e
. /etc/profile.d/modules.sh

module add ci
# Dependencies
module add zlib
module add  lua

cd ${WORKSPACE}/${NAME}-${VERSION}/build-${BUILD_NUMBER}
make check

echo $?

make install
mkdir -p ${REPO_DIR}
mkdir -p modules
(
cat <<MODULE_FILE
#%Module1.0
## $NAME modulefile
##
proc ModulesHelp { } {
    puts stderr "       This module does nothing but alert the user"
    puts stderr "       that the [module-info name] module is not available"
}

module-whatis   "$NAME $VERSION."
setenv       GNUPLOT_VERSION       $VERSION
setenv       GNUPLOT_DIR                 /data/ci-build/$::env(SITE)/$::env(OS)/$::env(ARCH)/$NAME/$VERSION
prepend-path LD_LIBRARY_PATH   $::env(GNUPLOT_DIR)/lib
prepend-path PATH             $::env(GNUPLOT_DIR)/bin
prepend-path CFLAGS                      "-I$::env(GNUPLOT_DIR)/include"
prepend-path LDFLAGS                    "-L$::env(GNUPLOT_DIR)/lib"
MODULE_FILE
) > modules/$VERSION

mkdir -p ${LIBRARIES}/${NAME}
cp modules/$VERSION ${LIBRARIES}/${NAME}

module avail ${NAME}
module add  ${NAME}/${VERSION}

echo "do we have gnuplot in the path ? "
which gnuplot
