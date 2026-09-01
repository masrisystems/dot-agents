---
name: profession-entwicklung
description: Führt durch die Erstellung oder Überarbeitung einer Professionsdatei nach dem Framework-Standard. Verwenden, wenn eine neue Profession angelegt oder eine bestehende inhaltlich überarbeitet werden soll.
---

# profession-entwicklung

## Ablauf

1. **Agentengrenze prüfen:** „Mechanik vor Agentenanweisung" aus
   `.agent/professions/konstrukteur.md` anwenden. Nur der danach verbleibende agentische
   Anteil wird als Profession ausgefüllt.

2. **Template laden:** `.agent/templates/profession.md`

3. **Invariante 1 prüfen:** Die Profession enthält ausschließlich Funktion, Primärziel, Entscheidungsrechte, Eskalationspflichten, Regelmodule und bevorzugte Skills.

4. **Pflichtabschnitte ausfüllen:**
   - YAML-Frontmatter: `name` (kebab-case), `description` (dritte Person, "was + wann")
   - Funktion, Primärziel, Optimierungskriterien
   - Entscheidungsrechte (eigenständig / nicht eigenständig)
   - Eskalationspflichten
   - Geltende Regelmodule
   - Bevorzugte Skills — als Trigger-Tabelle: Auftrag → Skill

5. **Schicht-1-Prinzipien** aus `.agent/professions/konstrukteur.md` anwenden.
