This uses multipass to automatically bring up a bare metal k8s cluster running in VMs.

Run `./create.sh <COUNT>` to bring up `COUNT` nodes (including master node)
Run `./action.sh delete <COUNT>` to delete `COUNT` nodes. Run `multipass purge` afterwards to _really_ delete them.

NB: node1 will be the master node.

Example for accessing the cluster:

```
multipass exec node1 kubectl get nodes
```
