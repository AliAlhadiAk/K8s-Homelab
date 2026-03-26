# Project Phase & Context Switch Status

**Last Updated:** _Initial Setup_

## Current Phase: Stage 2 (Infrastructure as Code)
**Goal:** Provision a multi-node Kind cluster using Terraform local provider.

### Completed Tasks
- ✅ Stage 1: Repository Foundation
  - Initialized Git repository.
  - Linked GitHub origin (`https://github.com/AliAlhadiAk/K8s-Homelab.git`).
  - Added initial `README.md`.
  - Created idempotent tool download script (`setup.ps1`).
  - Set up `.gitignore` for binaries and terraform state.
  - Setup `.agents/rule.md` and `.agents/status.md`.

### Current Tasks
- 🔄 Setting up Terraform configurations.
  - Currently working on `terraform/providers.tf` and `terraform/main.tf` to instantiate the kind cluster.

### Upcoming Tasks
- Define multi-node `kind` cluster with ingress port mappings in Terraform.
- Stage 3: Helm deployments for NGINX ingress and Observability stack (Prometheus / Grafana).
- Stage 4: Cloud-native dashboard application (Vite / React).

---

## Technical Context

### Folder Structure
```
c:\Users\user\k8s-homelab\
├── .git/                 # Git repository configuration
├── .agents/              # AI Rules and status tracking
│   ├── rule.md
│   └── status.md
├── bin/                  # Downloaded local binaries (gitignored)
│   └── kind.exe
├── terraform/            # Terraform configurations (Current Working Directory)
│   └── providers.tf      # Kind provider declaration
├── .gitignore            # Rules to ignore binaries and TF states
├── README.md             # Public-facing documentation
└── setup.ps1             # Local tool dependency downloader
```

### Constraints & Important Notes
- **Recruiter Perspective**: The user is using this repository to demonstrate complex systems skill for big tech scale. Everything must be deeply documented and explicitly professional.
- **Micro-Commits**: Agents must make frequent, tiny `git` commits referencing the specific stage change.

---

**Next Action for Agent**: Complete the Terraform Kind cluster definition in `terraform/main.tf` and commit.
