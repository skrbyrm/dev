# Kubernetes Cluster installation

Set up a new Kubernetes cluster on cloud vm machines (Google Cloud Compute Engine - AWS EC2 - Alibaba Compute). 
Configure necessary ports, network settings, and install container runtime.

!After creating cloud Compute Engine's set firewall rules for necessary ports on cloud platform! Then connect your vm machines with ssh and follow steps.

### Configure necessary ports

To configure necessary ports for Kubernetes, run:
```
sudo ufw allow 6443/tcp
sudo ufw allow 2379:2380/tcp
sudo ufw allow 10250/tcp
sudo ufw allow 10259/tcp
sudo ufw allow 10257/tcp

sudo ufw status
```
### Add machine IP addresses to hosts file
To add vm machines IP addresses to the hosts file, run:
```
echo $(hostname -I) $(hostname) | sudo tee -a /etc/hosts
```
```
sudo tee -a /etc/hosts <<EOF
<vm-ip> instance-1
<vm-ip> instance-2
<vm-ip> instance-3
<vm-ip> alibaba
<vm-ip> aws
EOF
```
### Set up Kubernetes runtime and enable forwarding features
To configure Kubernetes runtime and enable forwarding features, run:
```
sudo swapoff -a
sudo grep -i swap /etc/fstab

sudo tee /etc/modules-load.d/kubernetes.conf <<EOF
overlay
br_netfilter
EOF

sudo tee /etc/modules-load.d/k8s.conf <<EOF
overlay
br_netfilter
EOF
```
```
sudo modprobe overlay
sudo modprobe br_netfilter

sudo lsmod | grep netfilter
```
```
sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sudo sysctl --system
```
```
export -p NEEDRESTART_MODE="a"
echo "\$nrconf{restart} = 'a';" | sudo tee -a /etc/needrestart/needrestart.conf
```
### Install container runtime
Next, we install the required packages - curl, gnupg2, software-properties-common, apt-transport-https, and ca-certificates. 
We also add the Docker repository, and install docker, containerd.io.
```
sudo apt install -y curl gnupg software-properties-common apt-transport-https ca-certificates

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
Then, we configure containerd by creating the /etc/containerd/config.toml file and restarting the containerd service.
```
sudo su -
mkdir -p /etc/containerd
```
```
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
```
```
sudo systemctl restart containerd
sudo systemctl enable containerd
systemctl status containerd
```
Finally, we enable the systemd cgroup driver.
```
systemd cgroup driver
```

### Installing kubeadm, kubelet and kubectl on the control-plane node
Now that we have installed the container runtime, we can move on to installing the Kubernetes components - kubeadm, kubelet and kubectl.

We add the Kubernetes apt keyring and repository to our system.
```
sudo curl -sLo /etc/apt/trusted.gpg.d/kubernetes-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

sudo apt-add-repository -y "deb http://apt.kubernetes.io/ kubernetes-xenial main"
```
We then install kubeadm, kubelet and kubectl.
```
sudo apt install -y kubelet kubeadm kubectl

sudo systemctl enable kubelet
```
After installing these packages, we can join the node to an existing Kubernetes cluster by running the appropriate command provided by the cluster administrator.

Alternatively, we can create a new Kubernetes cluster by running the kubeadm init command. 
We provide the --pod-network-cidr flag to specify the Pod network CIDR, and the --cri-socket flag to specify the socket file used by the containerd runtime. 
We also provide the --upload-certs flag to upload certificates to the Kubernetes API server, and the --control-plane-endpoint flag to specify the external endpoint of the control plane. 
We ignore all preflight checks by providing the --ignore-preflight-errors=all flag.

```
sudo kubeadm config images pull
```

```
sudo kubeadm init \
  --pod-network-cidr=10.244.0.0/16 \
  --cri-socket /run/containerd/containerd.sock \
  --upload-certs \
  --control-plane-endpoint=master-ext:6443 \
  --ignore-preflight-errors=all --v=5
```
***
```
To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

You can now join any number of the control-plane node running the following command on each as root:

  kubeadm join master-ext:6443 --token b0h5ld.k6q4wfgfni84eot0 \
        --discovery-token-ca-cert-hash sha256:177ecaae679bbccd0e54936fcaaad05380e9b3fe73a45aa642e22f342ef5c93b                               \
        --control-plane --certificate-key 261335eb408faa2d86b89d22e5e7eb0c0b5da99852c0f0c517270095a06d24dd

Please note that the certificate-key gives access to cluster sensitive data, keep it secret!
As a safeguard, uploaded-certs will be deleted in two hours; If necessary, you can use
"kubeadm init phase upload-certs --upload-certs" to reload certs afterward.

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join master-ext:6443 --token b0h5ld.k6q4wfgfni84eot0 \
        --discovery-token-ca-cert-hash sha256:177ecaae679bbccd0e54936fcaaad05380e9b3fe73a45aa642e22f342ef5c93b   
```
***

Check cluster status:
```
kubectl cluster-info
```
### Download installation manifest.
```
wget https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
```

!If your Kubernetes installation is using custom podCIDR (not 10.244.0.0/16) you need to modify the network to match your one in downloaded manifest.
```
nano kube-flannel.yml

net-conf.json: |
    {
      "Network": "10.244.0.0/16",
      "Backend": {
        "Type": "vxlan"
      }
    }
```

### Then install Flannel by creating the necessary resources.
```
kubectl apply -f kube-flannel.yml
```
Confirm flannel pods are ready.
```
kubectl get pods -n kube-flannel
```
Check nodes;
```
kubectl get nodes -o wide
```
### Generating join token
If the join token is expired;
```
 kubeadm token create --print-join-command
 kubeadm init phase upload-certs --upload-certs
```

### Prepare nodes and some kubectl codes
```
kubectl label nodes <node-name> node-role.kubernetes.io/worker=worker --overwrite
```
This command adds the label node-role.kubernetes.io/worker=worker to the specified node node-name, which is typically used to identify the node's role in the cluster. 
The --overwrite flag indicates that any existing label with the same key should be overwritten.

* Finally our Cluster
```
root@master:/home/ubuntu# kubectl get nodes
NAME         STATUS   ROLES           AGE   VERSION
instance-1   Ready    worker          14m   v1.27.1
instance-2   Ready    worker          14m   v1.27.1
master       Ready    control-plane   18m   v1.27.1
```

```
kubectl get po
```
This command retrieves a list of all pods in the current Kubernetes namespace, along with their current status, name, and other basic details.

```
kubectl describe po
```
This command provides detailed information about a specific pod, including its current status, events, labels, and annotations.

```
kubectl logs pod-command-hello --follow
```
This command retrieves the logs of the pod named pod-command-hello and follows them in real-time. This is useful for monitoring the output of long-running processes or troubleshooting issues.

```
kubectl get po --selector="env=production" --show-labels
```
This command retrieves a list of all pods in the current namespace that have a label with the key env and value production. 
The --show-labels flag includes the labels as additional columns in the output, making it easy to identify pods with specific characteristics.

```
kubectl delete -f filename.yaml
```
This command deletes the resources defined in the YAML file filename.yaml from the Kubernetes cluster.

```
kubectl drain <node-name>
```
This command gracefully evicts all the pods running on the specified node node-name and prevents new pods from being scheduled on the node. 
This is typically done before taking a node offline for maintenance or decommissioning.

```
kubectl drain <node-name> --force
```
This command forcefully evicts all the pods running on the specified node node-name without waiting for them to gracefully terminate. 
This is useful when the node is unresponsive or needs to be taken offline immediately.

```
kubectl delete pod <pod-name> --force --grace-period=0
```
This command forcefully deletes the specified pod pod-name without waiting for it to gracefully terminate. 
It sets the grace period to 0, which means that the pod is immediately terminated. This is useful when the pod is stuck in a terminating state and needs to be forcibly removed.
