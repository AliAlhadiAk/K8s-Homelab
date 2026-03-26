# K8s-Homelab

A premium Kubernetes cluster environment provisioned locally using IaC principles to demonstrate advanced cloud-native architecture. 

## 🏗️ Architecture
This homelab uses:
- **Infrastructure Layer**: Terraform and `kind` (Kubernetes in Docker).
- **Topology**: 1 Control Plane, 2 Worker Nodes.
- **Networking**: Host ports 80 and 443 are mapped securely to the control plane, preparing the cluster for an NGINX Ingress Controller.

## 🚀 Running the Cluster

### Primary Method (Terraform)
We utilize Terraform to declaratively establish the Kubernetes nodes. The schema is tracked inside the `terraform/` directory.

```bash
cd terraform/
terraform init
terraform apply -auto-approve
```

### Alternative Method (Direct Kind YAML)
In enterprise environments with strict VPNs, proxy requirements, or blocked Terraform registries (e.g. `registry.terraform.io` blocks), you can spin up the exact same declarative topology directly via our `kind-config.yaml` using the local binary.

```bash
# If Terraform registries are blackholed on your host network:
./bin/kind.exe create cluster --config kind-config.yaml
```

Both methods guarantee an identical 3-node cluster with `ingress-ready` labels and host networking established.
