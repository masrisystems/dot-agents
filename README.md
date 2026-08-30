# 🤖 Masri Systems Portable Multi-Agent Hub (`.agents`)

Universal, portable multi-agent configuration, skills catalog, instruction sets, and synchronization engine for **Google Antigravity**, **Claude Code**, **OpenAI Codex**, and **Cursor / OpenClaw**.

---

## ⚡ Quick 1-Command Installation

Install or sync on any new machine with a single command:

### Windows (PowerShell)
```powershell
irm https://raw.githubusercontent.com/masrisystems/dot-agents/main/install.ps1 | iex
```

### macOS / Linux (Bash)
```bash
curl -fsSL https://raw.githubusercontent.com/masrisystems/dot-agents/main/install.sh | bash
```

---

## 🏛️ Architecture & Philosophy

```
~/.agents/
├── skills/                     # 43 Active Core Skills (Loaded into system prompts)
│   ├── viral-article-writer/
│   ├── seo-audit/
│   ├── systematic-debugging/
│   ├── image-webp-geotag/
│   └── ...
├── catalogs/                   # 286 Offline ECC Skills & Extensions (Zero Token Overhead)
│   ├── ecc/                    # Sourced from affaan-m/ecc (Skills, Agents, Commands)
│   ├── skills-index.json       # Searchable catalog index
│   └── manage-catalog.ps1      # Instant on-demand skill linker
├── instructions/               # Universal Agent Directives & Personality
│   ├── global.md               # Unified behavioral guidelines (Think Before Coding, Simplicity)
│   └── adapters/               # Engine-specific adapters (Claude, Codex, Gemini)
├── tools/                      # Cross-Agent Helpers (Telegram push alerts, test runners)
└── sync.ps1                    # Automatic live sync across Antigravity, Claude, Codex
```

### 1. Canonical Single Source of Truth
- Keep all custom skills in `~/.agents/skills/`.
- `sync.ps1` automatically synchronizes rule files and creates verified filesystem junctions for:
  - **Google Antigravity & Gemini CLI** (`~/.gemini/`)
  - **Claude Code** (`~/.claude/skills/`)
  - **OpenAI Codex** (`~/.codex/skills/`)

### 2. Guarded Token Budget (The Catalog System)
- **Active Skills (`skills/`):** 43 carefully curated daily drivers (SEO, CRO, debugging, testing, copywriting, local media geotagging).
- **On-Demand Catalog (`catalogs/`):** 286 specialized domain skills (Kubernetes, AI harnesses, mobile architecture, security pentesting) ready to be activated in seconds without bloating active LLM context windows.

---

## 🔍 On-Demand Catalog Search & Activation

Search or activate any catalog skill using `manage-catalog.ps1`:

```powershell
# Search for skills, agents, or commands
.\catalogs\manage-catalog.ps1 -Search "kubernetes"
.\catalogs\manage-catalog.ps1 -Search "docker"

# Enable a skill (automatically links and syncs across all agents)
.\catalogs\manage-catalog.ps1 -EnableSkill "docker-patterns"

# Disable when no longer needed
.\catalogs\manage-catalog.ps1 -DisableSkill "docker-patterns"
```

---

## 🧩 Claude Code Plugins & Marketplaces

`config/plugins.json` is the portable manifest of every Claude Code marketplace and
user-scope plugin. The installers run the restore automatically; re-run it any time with:

```powershell
.	oolsestore-plugins.ps1     # Windows
```
```bash
bash tools/restore-plugins.sh    # macOS / Linux
```

Project-scoped plugins (listed under `projectPlugins`) must be installed from inside
that project's directory.

After adding or removing a plugin locally, refresh the manifest by hand from
`~/.claude/plugins/installed_plugins.json` and `known_marketplaces.json`, then commit.

---

## 📱 Telegram Mobile Bridge

The included `tools/telegram.mjs` allows background tasks and automations to push alerts and ask questions directly to your phone:

```powershell
# Send alert
node tools/telegram.mjs send "Deployment complete on server u8."

# Ask question and wait for response
node tools/telegram.mjs ask "Approve release v2.1? (yes/no)"
```

Copy `config/telegram.json.example` to `config/telegram.json` and fill in your Bot Token and Chat ID to enable.

---

## 📜 License & Attribution
- Core customizations & Masri Systems workflows © Masri Systems.
- Catalog extensions sourced from [`affaan-m/ecc`](https://github.com/affaan-m/ecc) under MIT License.
