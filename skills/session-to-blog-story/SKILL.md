---
name: session-to-blog-story
description: Distills an active conversation, idea, or completed coding session into a famous storytelling archetype (Hero's Journey, PAS, CAR, Contrarian), logs the technical work to 'What I worked.md', and appends the story hook directly into 'Blog Ideas.md'.
---

# Session to Blog Story & Work Logger

Transform development sessions, breakthroughs, and architectural problem-solving into **famous storytelling narratives** that feed directly into the editorial blog pipeline and keep your professional build log updated.

---

## When to Activate This Skill

Activate whenever the user says:
- *"Add this session to blog ideas"*
- *"Add this idea to blog ideas"*
- *"Add my work to blog ideas"*
- *"Document what I worked on and turn it into a blog story"*
- *"Capture this session as a story"*
- *"Turn this build into a blog post idea"*
- *"Log my work and create a story"*
- Or uses the slash command `/work-story` or `/session-story`

---

## Where Everything is Documented (The Two Authoritative Vault Locations)

1. **The Continuous Master Work Log (Technical Truth)**:
   - **Path**: `content/private/Work/MasriSystems/What I worked.md`
   - **Role**: High-density engineering changelog of features, bugfixes, architectures, and devops deployments.
2. **The Blog Ideas Backlog (Narrative Ideas Incubator)**:
   - **Path**: `content/private/Prompts/Blogs/Blog Ideas.md`
   - **Role**: Append-only backlog feeding into `weekly-blog-workflow`.
3. **Optional Standalone Build Story (Deep Case Studies)**:
   - **Path**: `content/private/Work/MasriSystems/Projects/Build Stories/YYYY-MM-DD - [Title].md`
   - **Role**: Detailed case study note created when a session produces major breakthroughs, complete code diffs, or architecture designs.

---

## The 4 Famous Story Archetypes

Every session or technical build must be mapped to one of these 4 classic, high-converting storytelling frameworks:

### 1. The Monster Slay (Hero's Journey / Pixar Spine)
* **Best for**: Debugging nightmares, mysterious memory leaks, silent performance killers, security vulnerabilities, or eliminating massive technical bloat.
* **The Arc**:
  - *The Trap*: A hidden obstacle was silently wrecking systems (e.g. 78 KB duplicate prompt rules or a leaking private key).
  - *The Ordeal*: Standard assumptions failed; why trivial fixes did not work.
  - *The Breakthrough*: The non-obvious engineering insight that cracked the problem.
  - *The Victory*: Quantified transformation (e.g. 0 leaks, 12,000 tokens saved, sub-second responses).

### 2. Problem-Agitation-Solution (PAS / Before-After-Bridge)
* **Best for**: Architectural redesigns, workflow automation, developer tooling improvements, and customer pain points.
* **The Arc**:
  - *Problem*: A familiar nuisance that teams accept as "normal".
  - *Agitation*: Showing the real hidden cost (wasted hours, context truncation, desynchronized code).
  - *Solution*: A clean, elegant system or tool that eliminates the friction.
  - *Bridge*: How any team can transition from chaos to clarity in 3 steps.

### 3. The Contrarian Hook ("David vs. Goliath" / Busting Conventional Wisdom)
* **Best for**: Framework decisions (e.g. VILT stack vs. SPA+REST, Vanilla CSS vs. massive build tools, lean markdown pointers vs. monolithic mega-prompts).
* **The Arc**:
  - *The Myth*: What "everyone in tech" does by default.
  - *The Trap*: Why that popular consensus breaks down at scale.
  - *The Contrarian Approach*: What we built instead and why it outperforms the industry giant.
  - *The Evidence*: Real benchmarks, speed tests, or simplicity metrics.

### 4. The Executive CAR (Challenge - Action - Result)
* **Best for**: Business deliverables, client projects, high-stakes launches, and ROI-driven engineering.
* **The Arc**:
  - *Challenge*: The high stakes, tight timeline, or strict constraint.
  - *Action*: The disciplined, surgical moves executed to hit the target.
  - *Result*: Business outcome, revenue protected, speed achieved, or zero defects verified.

---

## Execution Protocol (Step-by-Step)

### Step 1: Harvest the Session Truth
Inspect the conversation history and workspace status:
1. **The Goal**: What problem did the user set out to solve?
2. **The Obstacle / Struggle**: What was difficult, broken, bloated, or unclear?
3. **The Solution**: What files were modified, created, or deleted? (Inspect `git status -s` or diffs).
4. **The Results & Metrics**: What are the concrete metrics? (e.g. file size reductions, 0 leaks, build speed, test passes).

### Step 2: Update the Master Work Log (`What I worked.md`)
Open `content/private/Work/MasriSystems/What I worked.md` and append a clean, high-density technical log entry under the relevant project heading or under today's date:

```markdown
### [Feature / Task Title] - YYYY-MM-DD
- Implemented / Refactored / Fixed: <concise technical action>
- Architecture / Strategy: <key design decisions made>
- Verification & Metrics: <e.g., 0 errors, tests passed, token footprint reduced by X%>
```

### Step 3: Append the Story to `Blog Ideas.md`
Open `content/private/Prompts/Blogs/Blog Ideas.md`:
1. Formulate a punchy, famous story angle (1 sentence combining the chosen archetype, goal, action, and result in short words).
2. Format the single-line inbox entry:
   ```markdown
   - [ ] YYYY-MM-DD - **[3-8 Word Story Title]** - angle: [Archetype] <One punchy sentence explaining the conflict, breakthrough, and takeaway in short words> - source: [[What I worked#[Feature Title] - YYYY-MM-DD]] - status: new
   ```
3. Insert the bullet at the very end of `## Inbox`, immediately above the `<!-- INBOX-END -->` marker.
4. Update the frontmatter `updated: YYYY-MM-DD` to today's date.

### Step 4: Present the Narrative Story Card to the User
Conclude the response by presenting a structured Story Card so the user immediately sees the narrative potential:

```markdown
### 📖 Blog Story Pitch: [Title]
* **Story Archetype:** [e.g., The Monster Slay / Contrarian / PAS / CAR]
* **The Hook:** <1-2 sentences grabbing attention>
* **The Struggle (What was done):** <Brief narrative of the technical obstacle & breakthrough>
* **The Payoff (The Results):** <The quantified victory and lesson for the audience>
* **Logged in:**
  - 📝 Backlog: `content/private/Prompts/Blogs/Blog Ideas.md`
  - 🛠️ Work Log: `content/private/Work/MasriSystems/What I worked.md`
```