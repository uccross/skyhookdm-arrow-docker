import pyarrow as pa
import pyarrow.dataset as ds
import pyarrow.parquet as pq

format_ = ds.SkyhookFileFormat("parquet", "/etc/ceph/ceph.conf", "cephfs-data0")
partitioning_ = ds.partitioning(
    pa.schema([("payment_type", pa.int32()), ("VendorID", pa.int32())]),
    flavor="hive"
)
dataset_ = ds.dataset("file:///mnt/cephfs/nyc", partitioning=partitioning_, format=format_)
print(dataset_.to_table(
        columns=['total_amount', 'DOLocationID', 'payment_type'], 
        filter=(ds.field('payment_type') > 2)
).to_pandas())