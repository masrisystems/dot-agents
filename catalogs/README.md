# Agent Skills & Tools Catalog System

This directory houses the offline, categorized catalog of **286 skills, 68 agents, and 94 commands** sourced from [`affaan-m/ecc`](https://github.com/affaan-m/ecc).

---

## 🎯 Architecture: Why Catalog instead of Global Loading?
* **Zero Token Bloat:** Registering 280+ skills globally adds ~50,000 fixed tokens to every LLM turn.
* **Sharp Tool Routing:** Keeping your primary `skills/` directory lean (~43 active core skills) ensures high accuracy and prevents tool collision.
* **Instant On-Demand Activation:** Any skill or agent from this catalog can be activated in seconds into `.agents/skills/` and synchronized across Antigravity, Claude Code, and Codex.

---

## 📊 Catalog Overview

| Resource | Count | Source Path |
| :--- | :---: | :--- |
| **Catalog Skills** | **286** | `C:\Users\super\.agents\catalogs\ecc\skills\` |
| **Catalog Agents** | **68** | `C:\Users\super\.agents\catalogs\ecc\agents\` |
| **Catalog Commands** | **94** | `C:\Users\super\.agents\catalogs\ecc\commands\` |
| **Currently Active** | **43** | `C:\Users\super\.agents\skills\` |

---

## 🛠️ How to Search & Manage Skills

Use the included PowerShell helper script `manage-catalog.ps1`:

### 1. Search for any skill, agent, or command
```powershell
.\manage-catalog.ps1 -Search "kubernetes"
.\manage-catalog.ps1 -Search "react"
.\manage-catalog.ps1 -Search "security"
```

### 2. Enable / Activate a skill globally
```powershell
.\manage-catalog.ps1 -EnableSkill "docker-patterns"
```
*(This copies the skill to `C:\Users\super\.agents\skills\` and runs `sync.ps1 -Apply` across Antigravity, Claude, and Codex).*

### 3. Disable / Deactivate a skill
```powershell
.\manage-catalog.ps1 -DisableSkill "docker-patterns"
```

### 4. View active skills
```powershell
.\manage-catalog.ps1 -ListActive
```

---

## 📁 Key Domain Categories in the Catalog

1. **Backend & Microservices:** API design, database patterns (PostgreSQL, MongoDB, Redis, GraphQL, tRPC, Prisma), async workers, distributed architectures.
2. **Frontend & Mobile:** Vue, React, Svelte, Angular, iOS (Swift/Capacitor), Android Clean Architecture, Tailwind, Web Performance, Animation.
3. **DevOps & Infrastructure:** Docker patterns, Kubernetes, CI/CD, Terraform, Cloudflare, AWS/GCP architecture, SRE observability.
4. **AI & Agent Systems:** Agent harness construction, autonomous loops, eval benchmarks, RAG, prompt optimization, vector databases.
5. **Security & Quality Assurance:** Security audits, OWASP penetration testing, a11y debugging, end-to-end testing, memory leak diagnostics.
