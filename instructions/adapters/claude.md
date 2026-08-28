# Claude adapter

- Keep Claude-only plugins, permissions, hooks, and subagent configuration in `C:\Users\super\.claude`.
- Shared skills are linked into `C:\Users\super\.claude\skills`; do not edit linked copies through the Claude directory.

## Blog generation override (Claude only)

- For blog generation requests, Claude defaults to the `claude-blog` plugin (`/claude-blog:blog write` / its sub-skills) directly — do **not** route through the `weekly-blog-workflow` skill by default.
- Only use `weekly-blog-workflow` when the user explicitly asks for it by name (e.g. "use weekly-blog-workflow", "run the weekly blog workflow").
- This overrides the shared "Blog Generation & Workflow" instruction for Claude specifically. That shared instruction still applies as written to Codex and Gemini, which don't have the `claude-blog` plugin available.
