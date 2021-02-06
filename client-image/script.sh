#!/bin/bash
set -eux

cd /arrow/python

pip3 install -r requirements-build.txt -r requirements-test.txt
pip3 install wheel

export WORKDIR=${WORKDIR:-$HOME}
export ARROW_HOME=$WORKDIR/dist
export LD_LIBRARY_PATH=$ARROW_HOME/lib
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

# check installation
python3 -c "import pyarrow"
python3 -c "import pyarrow.dataset"
