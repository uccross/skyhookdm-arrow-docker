#!/bin/bash
set -e

cd /arrow/python

yum install -y python3-rados
pip3 install -r requirements-build.txt -r requirements-test.txt
pip3 install wheel

export WORKDIR=${WORKDIR:-$HOME}
export ARROW_HOME=$WORKDIR/dist
export LD_LIBRARY_PATH=$ARROW_HOME/lib:$LD_LIBRARY_PATH
export PYARROW_BUILD_TYPE=Debug
export PYARROW_WITH_DATASET=1
export PYARROW_WITH_PARQUET=1
export PYARROW_WITH_RADOS=1

mkdir -p /root/dist/lib
mkdir -p /root/dist/include

cp -r /usr/local/lib/. /root/dist/lib
cp -r /usr/local/include/. /root/dist/include

python3 setup.py build_ext --inplace --bundle-arrow-cpp bdist_wheel
pip3 install dist/*.whl

python3 -c "import pyarrow"