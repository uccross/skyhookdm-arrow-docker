# SkyhookDM-Arrow Docker ![skyhookdm](https://github.com/JayjeetAtGithub/skyhookdm-arrow-rook/workflows/skyhookdm/badge.svg?branch=master)

Docker image containing SkyhookDM built on top of Arrow along with C++ and Python API clients.

### Deploying SkyhookDM-Arrow on a Rook cluster
* Change the Ceph image tag in the Rook CRD [here](https://github.com/rook/rook/blob/master/cluster/examples/kubernetes/ceph/cluster.yaml#L24) to the image built from [this](./docker) dir (or you can quickly use `jcnitdgp25/skyhookdm-arrow:latest` as the image tag) to change your Rook Ceph cluster to the Arrow based SkyhookDM cluster. 

* After the cluster is updated, we need to deploy a Pod with the Arrow Python (with RadosDataset API) library installed to start interacting with the cluster. This can be achieved by following these steps:

  1) Create a Pod for connecting to the SkyhookDM cluster using the SkyhookDM image that also has PyArrow with RadosDataset bindings pre-installed. The Pod config can be found [here](./client.yaml). The Pod can be created by doing,
  
  ```bash
  kubectl create -f client.yaml
  ```

  2) After the Pod is `running`, copy the Ceph configuration and keyring to `/etc/ceph/ceph.conf` and `/etc/ceph/keyring` respectively inside the Pod. You can verify the connection to the SkyhookDM cluster by executing `ceph -s` from inside the Pod.
