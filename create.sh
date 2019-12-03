#!/bin/sh
# see https://blog.alexellis.io/kubernetes-in-10-minutes/

COUNT=${1:-3}
echo ">>>> Bringing up $COUNT nodes..."

echo ">>>> Creating master node..."

multipass launch -c 2 -m 1536M --name node1
multipass copy-files bootstrap.sh node1:/tmp/
multipass copy-files master.sh node1:/tmp/
multipass exec node1 sudo sh /tmp/bootstrap.sh

IP=`multipass list --format csv | grep "^node1" | cut -d, -f3`

multipass exec node1 -- sudo kubeadm init --apiserver-advertise-address=$IP --kubernetes-version stable-1.16
multipass exec node1 sh /tmp/master.sh

TOKEN=`multipass exec node1 sudo kubeadm token list|tail -n1|cut -d " " -f1`

for i in `seq 2 $COUNT`
do
    echo ">>>> Creating node$i..."
    multipass launch -c 2 -m 1536M --name node$i
    multipass copy-files bootstrap.sh node$i:/tmp/
    multipass exec node$i sudo sh /tmp/bootstrap.sh
    multipass exec node$i -- sudo kubeadm join $IP:6443 --token $TOKEN --discovery-token-unsafe-skip-ca-verification
done

echo ">>>> Polling nodes..."
sleep 5
multipass exec node1 kubectl get nodes

echo ">>>> All done."
