<ins>__Launching two ubuntu server named masternode (t2. small) and workernode(t2. micro)__</ins>

**<ins>On masternode and workernode</ins>**
sudo apt-get update
sudo apt-get install docker.io
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg -- dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee
/etc/apt/sources.list.d/kubernetes.list
sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list sudo apt-get install -y kubectl kubeadm kubelet

**<ins>On masternode</ins>**
sudo kubeadm init --ignore-preflight-errors=all mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.0/manifests/cal ico.yaml
kubeadm token create --print-join-command

#[add port 6443 in both master and worker node]

On Worker - >
#Use kubeadm join command with token (copy the command from master and paste on worker) which you see on 17_line

sudo (command)
**<ins>On masternode</ins>**

**On Master** - -> kubectl get nodes #to_list_nodes
