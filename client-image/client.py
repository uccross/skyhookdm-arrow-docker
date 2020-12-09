import urllib
import pyarrow.dataset as ds
import pyarrow.parquet as pq

dataset = ds.dataset(
        source="rados:///etc/ceph/ceph.conf?cluster=ceph \
                &pool=test-pool&ids={}".format(
            urllib.parse.quote(
                str(['obj.0', 'obj.1', 'obj.2', 'obj.3']), safe='')
        )
    )

t = dataset.to_table(filter=(ds.field("VendorID") == 1))
print(t.to_pandas())
