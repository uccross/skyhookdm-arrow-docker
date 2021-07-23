#!/bin/bash
set -eux

cd /arrow/cpp

mkdir -p release
cd release
cmake \
        -DARROW_CLS=ON \
        -DARROW_PARQUET=ON \
        -DARROW_WITH_SNAPPY=ON \
        -DARROW_WITH_ZLIB=ON \
        -DARROW_WITH_LZ4=ON \
        -DPython3_EXECUTABLE=/usr/local/bin/python3.9 \
        -DARROW_DATASET=ON \
        -DARROW_PYTHON=ON \
        -DARROW_CSV=ON \
        ..

make -j4 install

cp ./release/libcls_arrow* /usr/lib64/rados-classes/
cp -r /usr/local/lib64/. /usr/lib64

cd /arrow/python

pip3.9 install --upgrade setuptools==57.0.0 wheel
pip3.9 install -r requirements-build.txt -r requirements-test.txt

export WORKDIR=${WORKDIR:-$HOME}
export ARROW_HOME=$WORKDIR/dist
export LD_LIBRARY_PATH=$ARROW_HOME/lib
export PYARROW_WITH_DATASET=1
export PYARROW_WITH_PARQUET=1
export PYARROW_WITH_RADOS=1

mkdir -p /root/dist/lib
mkdir -p /root/dist/include

cp -r /usr/local/lib64/. /root/dist/lib
cp -r /usr/local/include/. /root/dist/include

python3.9 setup.py build_ext --inplace --bundle-arrow-cpp bdist_wheel
pip3.9 install dist/*.whl
cp -r dist/*.whl /

python3.9 -c "import pyarrow"
python3.9 -c "import pyarrow.dataset"
python3.9 -c "import pyarrow.parquet"
python3.9 -c "from pyarrow.dataset import RadosParquetFileFormat"
