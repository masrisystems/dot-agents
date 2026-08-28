# Shared Global Agent Rules

## Shared configuration source

- Treat `C:\Users\super\.agents` as the canonical source for portable user-level skills, shared instructions, catalogs, and synchronization tooling.
- Add or update portable skills under `C:\Users\super\.agents\skills` first. Do not maintain independent editable copies for Codex, Claude, and Gemini.
- Keep agent-specific permissions, authentication, UI metadata, extensions, and plugin settings in their native configuration locations.
- Run `C:\Users\super\.agents\sync.ps1` without arguments to preview synchronization. Use `-Apply` only after reviewing the reported changes and conflicts.

## Graphify

- When the user types `/graphify`, use the installed `graphify` skill before doing anything else.

## Document processing

- When the user uploads, references, or asks to analyze a supported document or data file, use the `markitdown` skill to extract clean Markdown before analysis.
- Keep conversion output in temporary task storage unless the user requests a persistent output file.

## Image optimization and local SEO

- When the user asks to optimize, tag, geotag, convert, or prepare an image for web, blog, or Google Business Profile use, activate the `image-webp-geotag` skill and follow its brand and format rules.
- **Google Business Profile (GBP) Constraint:** Google Business Profile does **NOT** accept WebP uploads. Always produce high-res **JPG** (`.jpg`) images with embedded GPS & IPTC metadata for GBP, Apple Business Connect, and local citation platforms.

## Blog Generation & Workflow

- When the user asks to generate, write, draft, or make a blog post (e.g., `blog generate`, `make the blog`, `write blog post`, `generate blog`, `weekly blog`, `draft blog`, `new blog`, or `/blog`), activate the `weekly-blog-workflow` (or `blog-generate`) skill and execute the authoritative workflow defined in `C:\Users\super\Desktop\obsidian\masrisystems-app\content\conductor\weekly-blog-workflow.md`.
- Drafts MUST always be saved with `draft: true` and `status: draft` in Obsidian-flavored markdown under `content/Articles/[Category]/[Subfolder]/` — never auto-publish.

## Git worktree freshness

- At the start of coding work in an agent worktree and again before handoff or integration, inspect the current branch and working-tree status, fetch the configured remote, and compare the branch with the remote main branch.
- Keep feature branches current by merging the remote main branch (normally `origin/main`) into the agent branch. Do not rebase shared branches unless the user explicitly requests it.
- Never pull or merge over uncommitted changes. If the worktree is dirty, preserve the changes and report that synchronization was skipped.
- Use the `parallel-agent-worktrees` skill for multi-agent repositories. Preview its freshness helper before applying it; if a merge conflicts, abort that merge and report the affected worktree instead of guessing at conflict resolution.
- For long tasks, refresh before beginning another substantial unit of work. Do not repeatedly fetch during one uninterrupted unit merely to satisfy a timer.

## Work tracking

- When finishing work for a client or project that has a matching Kanban board under `C:\Users\super\Desktop\obsidian\masrisystems-app\content\private\Work`, update that board with the completed work.
- For Ranalp, use `C:\Users\super\Desktop\obsidian\masrisystems-app\content\private\Work\MasriGMBH\Kunden\Abdullah Celebi\Ranalp\Kanban Ranalp.md`.
- Do not claim a Kanban update when no matching board exists or the board cannot be accessed.

## Behavioral guidelines

Behavioral guidelines to reduce common LLM coding mistakes across all projects.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

### 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

### 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

### 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

### 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

