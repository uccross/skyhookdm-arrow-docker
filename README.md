# Deploying SkyhookDM with Arrow CLS plugins on Rook

* Change the Ceph image tag [here](https://github.com/rook/rook/blob/master/cluster/examples/kubernetes/ceph/cluster.yaml#L24) to the      image built from this repo (or you can quickly use `jcnitdgp25/skyhookdm-arrow:0.1` as the image tag) to
change your Rook Ceph cluster to the Arrow based SkyhookDM cluster. 

* After the cluster is updated, we need to deploy a client Pod with the Arrow Python (with RadosDataset API) library installed to start interacting with the cluster. This can be achieved by following these steps:

  1) Create a client Pod for connecting to the SkyhookDM cluster using [this](https://github.com/JayjeetAtGithub/skyhookdm-client) client image that has PyArrow with RadosDataset bindings pre-installed. The Pod config can be found [here](https://github.com/JayjeetAtGithub/skyhookdm-client/blob/master/client.yaml). The Pod can be created by doing,
  
  ```bash
  kubectl create -f client.yaml
  ```

  2) After the client Pod is `running`, copy the Ceph configuration and keyring to `/etc/ceph/ceph.conf` and `/etc/ceph/keyring` respectively inside the client Pod. You can verify the connection to the SkyhookDM cluster by executing `ceph -s` from inside the Pod.

  3) Next, we need to write some objects containing Arrow IPC Tables. This can be done by using the `rados put` utility.
     ```
     rados -p test-pool put nyctaxi.4mb.arrow obj.0
     rados -p test-pool put nyctaxi.4mb.arrow obj.1
     rados -p test-pool put nyctaxi.4mb.arrow obj.2
     ...
     ```

  5) Lastly, the example Python script given [here](https://github.com/JayjeetAtGithub/skyhookdm-client/blob/master/client.py) can be executed from inside the client Pod to connect to the SkyhookDM cluster and start executing queries.
