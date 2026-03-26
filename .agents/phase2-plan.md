# Phase 2 Execution Plan: Core Cluster Services (Ingress & Networking)

**Author:** Senior DevOps Engineer  
**Phase:** 2 of 5  
**Branch:** `development`  
**Prerequisite:** Phase 1 complete — 3-node Kind cluster running (1 CP with `ingress-ready=true` label, 2 workers, host ports 80/443 mapped)

---

## Objective
Deploy an enterprise-grade NGINX Ingress Controller onto the Kind cluster and validate end-to-end traffic routing from `localhost` through the Ingress to a backend service. This proves the networking stack is fully operational before layering observability and application workloads in later phases.

---

## Execution Steps

### Step 1: Extend Terraform Providers for Helm & Kubernetes
**Why:** We need the `hashicorp/helm` and `hashicorp/kubernetes` providers to manage Helm chart deployments and K8s resources declaratively. This keeps everything in IaC — no imperative `helm install` commands.

**Files Modified:**
- `terraform/providers.tf` — Add `helm` and `kubernetes` providers, configured to read the Kind-generated kubeconfig.
- `terraform/variables.tf` — Add `ingress_nginx_chart_version` variable for chart pinning.

**Commit:** `feat(infra): register helm and kubernetes providers for declarative chart management`

---

### Step 2: Deploy NGINX Ingress Controller via Helm Release
**Why:** The official `ingress-nginx` Helm chart is the production-standard way to install the controller. We configure it with `hostPort` mode (not `NodePort` or `LoadBalancer`) because Kind exposes container ports directly to the host via our Phase 1 `extraPortMappings`.

**Files Created:**
- `terraform/ingress.tf` — `helm_release` resource for `ingress-nginx` with Kind-specific values:
  - `controller.hostPort.enabled = true`
  - `controller.service.type = "ClusterIP"` (no LoadBalancer in Kind)
  - `controller.nodeSelector."ingress-ready" = "true"` (schedule only on CP node)
  - `controller.tolerations` for control-plane taint
  - `controller.admissionWebhooks.enabled = false` (avoid webhook timeout issues in local clusters)

**Commit:** `feat(helm): deploy nginx ingress controller with kind-optimized host port configuration`

---

### Step 3: Deploy Echo-Server for End-to-End Validation
**Why:** Before declaring the networking stack "done," we need verifiable proof that traffic flows: `localhost:80 → Ingress → Service → Pod`. A lightweight echo-server returns request metadata, making it trivial to confirm routing.

**Files Created:**
- `k8s/echo-server/deployment.yaml` — Deployment with `hashicorp/http-echo` or `ealen/echo-server` image
- `k8s/echo-server/service.yaml` — ClusterIP Service exposing port 80
- `k8s/echo-server/ingress.yaml` — Ingress resource with host `echo.homelab.local` routing to the service

**Commit:** `feat(k8s): add echo-server deployment for ingress validation`

---

### Step 4: Apply & Validate
**Why:** We execute the Terraform plan and deploy K8s manifests, then run validation commands to confirm packets route correctly.

**Commands:**
```bash
# Apply Terraform (ingress controller)
terraform -chdir=terraform init -upgrade
terraform -chdir=terraform apply -auto-approve

# Apply echo-server manifests
kubectl apply -f k8s/echo-server/

# Validate ingress controller pods are running
kubectl get pods -n ingress-nginx

# Validate echo-server pod is running
kubectl get pods

# Test end-to-end routing
curl -H "Host: echo.homelab.local" http://localhost
```

> [!NOTE]
> Since Terraform registry is blocked in this region, we will use `kubectl` + `helm` binaries from `bin/` as the fallback execution path, identical to the Phase 1 approach.

**Commit:** `docs(infra): verify end-to-end ingress routing with echo-server`

---

### Step 5: Update Documentation & Status
**Why:** Maintain the "senior engineer narrative" in the git history and ensure agent context continuity.

**Files Modified:**
- `.agents/status.md` — Mark Phase 2 tasks complete, update folder structure, advance directive to Phase 3
- `README.md` — Add "Networking & Ingress" section documenting infra stack

**Commit:** `docs: complete phase 2 status tracking and readme networking section`

---

## Fallback Strategy
Since `registry.terraform.io` is blocked in this region:
1. **Primary path:** Attempt Terraform via Docker container (`hashicorp/terraform:1.7.0`) with mounted workspace and Docker socket.
2. **Fallback path:** Use `bin/helm.exe` and `bin/kubectl.exe` directly. The Helm values and K8s manifests are identical — the only difference is the execution engine.
3. **Both paths produce the same cluster state** — the IaC definitions in `terraform/` remain the source of truth regardless of execution method.

---

## Commit Sequence Summary
| # | Commit Message | Scope |
|---|---------------|-------|
| 1 | `feat(infra): register helm and kubernetes providers for declarative chart management` | Terraform providers |
| 2 | `feat(helm): deploy nginx ingress controller with kind-optimized host port configuration` | Helm release |
| 3 | `feat(k8s): add echo-server deployment for ingress validation` | K8s manifests |
| 4 | `docs(infra): verify end-to-end ingress routing with echo-server` | Validation |
| 5 | `docs: complete phase 2 status tracking and readme networking section` | Tracking |

---

## Success Criteria
- [ ] NGINX Ingress Controller pods are `Running` in `ingress-nginx` namespace
- [ ] Echo-server pod is `Running` in `default` namespace  
- [ ] `curl -H "Host: echo.homelab.local" http://localhost` returns a valid response
- [ ] All Terraform/Helm/K8s definitions are committed atomically on `development`
- [ ] `.agents/status.md` reflects Phase 2 completion
