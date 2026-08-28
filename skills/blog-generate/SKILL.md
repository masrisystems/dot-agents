---
name: blog-generate
description: "Executes the authoritative weekly blog generation workflow from content/conductor/weekly-blog-workflow.md. Activates when user asks to make the blog, generate blog, blog generate, write blog post, draft article, or new weekly blog for Masri Systems."
license: MIT
metadata:
  author: "Masri Systems"
---

# Blog Generate Skill

> [!important] Master Workflow Protocol
> Whenever the user asks to generate or make a blog, execute the complete interactive workflow defined in:
> [`content/conductor/weekly-blog-workflow.md`](file:///c:/Users/super/Desktop/obsidian/masrisystems-app/content/conductor/weekly-blog-workflow.md)
>
> You can also reference the sibling portable skill [`weekly-blog-workflow`](file:///C:/Users/super/.agents/skills/weekly-blog-workflow/SKILL.md).

## Quick Summary of Invariant Constraints:
1. **Interactive Review Gate:** Always save with `draft: true` and `status: draft` in Obsidian Flavored Markdown under `content/Articles/[Category]/[Subfolder]/[slug].md`. Never auto-publish.
2. **Keywords SSOT:** Source 1 prime target keyword + 6 secondary keywords from `[[.agents/keywords.md]]`.
3. **Hero Image & GBP JPG Pipeline:** Google Business Profile (GBP) does **NOT** accept WebP. Generate 16:9 hero image with Nano Banana, save high-res **JPG** (`.jpg`) for GBP and WebP (`.webp`) for web, and optimize with `image-webp-geotag` (Oldenburg GPS + IPTC metadata).
4. **Humanized Technical Voice:** Sub-1000 words body, zero AI clichés (*delve, revolutionize, tapestry*), no duplicate `# Title` H1 in markdown body, and clean YAML tags without `#` prefixes.
5. **Backlog Update:** Update `content/conductor/blog-optimization-backlog.md` upon completion.
