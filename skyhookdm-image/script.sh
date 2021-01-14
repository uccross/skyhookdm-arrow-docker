#!/bin/bash
set -e

cd arrow/cpp

git checkout $BRANCH

mkdir -p debug
cd debug
cmake -DCMAKE_BUILD_TYPE=Debug \
          -DARROW_CLS=ON \
          -DARROW_PARQUET=ON \
          -DARROW_BUILD_TESTS=ON \
          -DARROW_DATASET=ON \
          -DARROW_PYTHON=ON \
          -DARROW_CSV=ON \
          ..
    
make -j4 install

cp ./debug/libcls_arrow* /usr/lib64/rados-classes/
cp -r /usr/local/lib64/. /usr/local/lib
