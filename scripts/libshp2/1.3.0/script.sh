#!/usr/bin/env bash

MASON_NAME=libshp2
MASON_VERSION=1.3.0
MASON_LIB_FILE=lib/libshp.a

. ${MASON_DIR}/mason.sh

function mason_load_source {
    mason_download \
        http://download.osgeo.org/shapelib/shapelib-${MASON_VERSION}.tar.gz \
        4b3cc10fd5ac228d749ab0a19d485b475b7d5fb5

    mason_extract_tar_gz

    export MASON_BUILD_PATH=${MASON_ROOT}/.build/shapelib-${MASON_VERSION}
}

function mason_compile {
    make all -j${MASON_CONCURRENCY}

    mkdir -p ${MASON_PREFIX}/lib
	  cp libshp.a ${MASON_PREFIX}/lib
    mkdir -p ${MASON_PREFIX}/include
	  cp shapefil.h ${MASON_PREFIX}/include
}

function mason_cflags {
    echo "-I${MASON_PREFIX}/include"
}

function mason_static_libs {
    echo ${MASON_PREFIX}/lib/libshp.a
}

function mason_ldflags {
    echo "-L${MASON_PREFIX}/lib -lshp"
}

function mason_clean {
    make clean
}

mason_run "$@"
