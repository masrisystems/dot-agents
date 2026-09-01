---
name: story-bible
description: Erstellt und pflegt pro fiktionalem Werk eine strukturierte Wissensbasis (Story Bible). Verwenden, wenn Werkfakten dauerhaft festgehalten oder eine bestehende Wissensbasis nach neuem Material aktualisiert werden soll.
---

# story-bible

## Zielpfad

Die Story Bible liegt unter `docs/story/<werk-slug>/`, sofern der Auftrag keinen anderen Zielpfad vorgibt.

## Templates

| Datei | Verwendung |
|---|---|
| `templates/overview.md` | Werkidentität, Prämisse, Medium, Grundstruktur |
| `templates/sources.md` | Laufende Liste der Werkquellen |
| `templates/canon.md` | Kanonregeln und Kanonstatus je Quelle/Geschichte |
| `templates/characters.md` | Figuren, Identitäten, Eigenschaften, Beziehungen |
| `templates/locations.md` | Orte |
| `templates/world.md` | Regeln, Systeme, Organisationen, Gegenstände, sonstige Weltfakten |
| `templates/timeline.md` | Ereignisse und Chronologie |
| `templates/continuity.md` | Bekannte Widersprüche, offene Konflikte, Fundstellen |

## Quellenkonvention

Jede in `sources.md` erfasste Quelle erhält beim ersten Eintrag eine fortlaufende Kurz-ID (`S1`, `S2`, ...), die innerhalb des Werks nie wiederverwendet wird. Einträge in den übrigen sieben Dateien verweisen auf diese Kurz-ID zusammen mit der Fundstelle im Werk (z. B. Kapitel, Szene, Seite).

## Ablauf bei erneutem Einlesen

Bestehende Einträge werden anhand der neu erfassten Quellen aktualisiert; weiterhin gültige Informationen bleiben erhalten. Welche Angaben als weiterhin gültig gelten und welche durch neue Quellen ersetzt werden, entscheidet der Nutzer.

## Umgang mit widersprüchlichen Quellen

Widersprüchliche Quellen werden als konkurrierende Aussagen mit jeweiligem Quellen- und Kanonstatus dokumentiert — keine Überschreibung.
