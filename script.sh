#!/bin/bash
set -e

git clone https://github.com/uccross/arrow --branch rados-dataset-dev

cd arrow/cpp
mkdir -p debug
cd debug
cmake -DCMAKE_BUILD_TYPE=Debug \
          -DARROW_CLS=ON \
          -DARROW_PARQUET=ON \
          -DARROW_BUILD_TESTS=ON \
          -DARROW_DATASET=ON \
          -DARROW_CSV=ON \
          ..
    
make install

cp ./debug/libcls_arrow* /usr/lib64/rados-classes/
