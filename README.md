# SkyhookDM-Arrow Docker 

Docker image containing SkyhookDM built on top of Arrow along with C++ and Python API clients.

### Deploying SkyhookDM-Arrow on a Rook cluster
* Change the Ceph image tag in the Rook CRD [here](https://github.com/rook/rook/blob/master/cluster/examples/kubernetes/ceph/cluster.yaml#L24) to the image built from [this](./docker) dir (or you can quickly use `uccross/skyhookdm-arrow:vX.Y.Z` as the image tag) to change your Rook Ceph cluster to the `vX.Y.Z` version of SkyhookDM Arrow. 

* After the cluster is updated, we need to deploy a Pod with the PyArrow (with RadosParquetFileFormat API) library installed to start interacting with the cluster. This can be achieved by following these steps:

  1) Create a Pod for connecting to the SkyhookDM cluster using the SkyhookDM image that also has PyArrow with `RadosParquetFileFormat` bindings pre-installed. The Pod config can be found [here](./client.yaml). The Pod can be created by doing,
  ```bash
  kubectl create -f client.yaml
  ```
  
  2) Copy the Ceph configuration and Keyring from some OSD/MON Pod to the playground Pod.
  ```bash
  # copy the ceph config
  kubectl -n rook-ceph cp rook-ceph-osd-0-xxxx-yyyy:/var/lib/rook/rook-ceph/rook-ceph.config rook-ceph-playground:/etc/ceph/ceph.conf

  # copy the keyring
  kubectl -n rook-ceph cp rook-ceph-osd-0-xxxx-yyyy:/var/lib/rook/rook-ceph/client.admin.keyring rook-ceph-playground:/var/lib/rook/rook-ceph/client.admin.keyring
  ```

  3) Check the connection to the cluster from the client Pod by doing a quick `ceph -s`.

  4) Now, install `ceph-fuse` and mount CephFS into some path in the client Pod using it. In a later release 
  `ceph-fuse` will come installed in the SkyhookDM image itself.

  ```bash
  yum install ceph-fuse
  mkdir -p /path/to/cephfs/mount
  ceph-fuse --client_fs myfs /path/to/cephfs/mount
  ```

  4) Download some example dataset into `/path/to/cephfs/mount`. For example,
  ```bash
  cd /path/to/cephfs/mount/
  wget https://raw.githubusercontent.com/JayjeetAtGithub/zips/main/nyc.zip
  unzip nyc.zip
  ```

  4) Modify the [example python script](./example.py) according to your needs and execute.
  ```bash
  python3 example.py
  ```
