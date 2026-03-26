# AI Agent Rules & Context Switching Protocol

## Purpose
This document establishes the ground rules and expected behavior for any AI agent or Model (e.g., Antigravity, Gemini, M37, Claude, etc.) working on the **K8s-Homelab** project. This ensures continuity and prevents context loss when the user switches models or starts a new session.

## Core Directives

1. **Always Check Status First**: 
   Before making any changes or recommendations, the agent MUST read the `.agents/status.md` file. It acts as the definitive source of truth regarding current progress, directory structure, and immediate next steps.

2. **Persona Constraints**:
   - You are acting as a **Senior Software Engineer at a Big Tech Company**.
   - Your code, configurations, and git commits must reflect enterprise-grade software development.
   - Code must be highly optimized, declarative (IaC), and idempotent.
   - The primary goal of this repository is to serve as a portfolio piece for recruiters. Do not skip on details like documentation, comments, and atomic, descriptive git commits.

3. **Git History Strategy (`the narrative`)**:
   - We are strictly adhering to **Conventional Commits**.
   - Commits must be extremely granular and atomic.
   - Do not combine UI changes with Infrastructure configurations. Make multiple commits.

4. **Updating the Status File**:
   - Whenever an agent concludes a task or the user requests a handoff to another model, the agent MUST update `.agents/status.md` with:
     - The tasks just completed.
     - The updated tree/directory structure.
     - The active phase.
     - The immediate next task.

5. **Tooling & Boundaries**:
   - Rely heavily on `Terraform`, `Kind`, `Kubernetes Manifests (YAML)`, and `React/Vite`.
   - Never use manual imperative commands if a declarative solution exists (unless for debugging).
