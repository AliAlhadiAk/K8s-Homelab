# Project Phase & Context Switch Status

**Last Updated:** _Phase 2 In Progress_
**Active Branch:** `development`

---

## 🌿 Branching Strategy (Solo / Senior Engineer)
Since this is a solo portfolio project, we avoid overly complex Gitflow. We use a **Main/Development Pipeline**:
- **`main`**: The production-ready state. Only contains complete, verified, and stable phases that are deployable at any time.
- **`development`**: The active branch. All work, micro-commits, tests, and configurations happen here. 
- **Commits**: Granular, atomic, and conventionally formatted `type(scope): message`.
- **Workflow**: We work on `development`, complete a phase, and seamlessly merge to `main`.

---

## 📈 Multi-Phase Plan & Tasks Tracking

### ✅ Phase 0: Foundation & Tooling 
**Goal:** Initialize repository, git logic, AI agent persistence context, and core scripts.
- [x] Init local git repository & connect remote (`main`).
- [x] Create deterministic dependency download script (`setup.ps1`).
- [x] Add global Gitignore for TF state and downloaded `.exe` binaries.
- [x] Draft initial `README.md`.
- [x] Create `./agents` rules constraint and tracking mechanism.
- [x] Branch out to `development` for active infrastructure drafting.

### ✅ Phase 1: Infrastructure Provisioning (IaC via Terraform & Kind)
**Goal:** Declaratively scaffold a multi-node Kubernetes cluster.
- [x] Define `terraform/providers.tf` for local Kind driver.
- [x] Define cluster schema inside `terraform/main.tf` (1 Control Plane, 2 Workers).
- [x] Map ingress ports (80, 443) from host to Kind control plane networking API.
- [x] Apply Terraform configuration to spin up the cluster effectively.
- [x] Document the successful cluster creation process in README or comments.

### 🔄 Phase 2: Core Cluster Services
**Goal:** Expose the internal network via an Ingress Controller using Helm via Terraform.
- [x] Setup NGINX Ingress controller using the official Helm Chart provider in Terraform.
- [x] Configure `ingress-nginx` hostPort mode corresponding to the host mappings defined in Phase 1.
- [x] Create echo-server K8s manifests (Deployment, Service, Ingress) for validation.
- [ ] Apply ingress controller and echo-server to cluster (blocked: Docker Desktop daemon restart needed).
- [ ] Verify end-to-end routing: `curl -H "Host: echo.homelab.local" http://localhost`

### ⏭ Phase 3: The Observability Stack
**Goal:** Add prometheus and grafana for real-time local cluster health checking.
- [ ] Ensure Prometheus Operator Helm Chart is deployed via Terraform.
- [ ] Make Grafana accessible continuously via a local route, e.g., `grafana.homelab.local`.
- [ ] Optionally configure one nice dashboard or link it properly for recruiters.

### ⏭ Phase 4: Cloud-Native Dashboard UI ("Cluster Pulse")
**Goal:** Code a visually striking, premium web application querying mock metrics or the kubernetes API to serve as a portfolio front.
- [ ] Setup project using Vite (React + TypeScript).
- [ ] Implement a dynamic, glassmorphism design with an interactive, modern user interface.
- [ ] Build key components (Cluster Status, Node Health, Resource Load, Live Terminal Emulator UI).

### ⏭ Phase 5: Application Deployment & Hardening
**Goal:** Bring the dashboard onto the infrastructure.
- [ ] Containerize the Vite App using a robust multi-stage `Dockerfile`.
- [ ] Author declarative Kubernetes manifests: `Deployment`, `Service`, `Ingress`.
- [ ] Apply to Kind cluster and verify the application resolves at `pulse.homelab.local`.
- [ ] Clean up structure, perform a final squash/merge to `main`, and finalize the overarching README.md for recruiter consumption.

---

## Technical Context
### Folder Structure
```
c:\Users\user\k8s-homelab\
├── .git/                 
├── .agents/              
│   ├── phase2-plan.md     # Detailed Phase 2 execution plan
│   ├── rules.md           # AI agent rules and code style
│   └── status.md          # (This File)
├── bin/                   # Downloaded binaries (gitignored)
├── k8s/
│   └── echo-server/
│       ├── deployment.yaml
│       ├── service.yaml
│       └── ingress.yaml
├── terraform/            
│   ├── providers.tf       # Kind + Helm + Kubernetes providers
│   ├── main.tf            # Kind cluster definition
│   ├── variables.tf       # All configurable inputs
│   ├── ingress.tf         # NGINX Ingress Helm release
│   └── outputs.tf         # Cluster endpoint output
├── .gitignore            
├── kind-config.yaml       # Fallback cluster config for Kind CLI
├── README.md             
└── setup.ps1             
```

---
**Agent Directive:** Constantly review this specific file when transferring contextual boundaries. Next task is currently -> "**Apply ingress controller and echo-server to cluster after Docker Desktop daemon restart.**"
