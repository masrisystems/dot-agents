---
name: kanon-pruefung
description: Bestimmt den Kanonstatus von Geschichten und Quellen eines fiktionalen Werks anhand der festgehaltenen Kanonregeln. Verwenden, wenn geklärt werden muss, ob eine Quelle oder Geschichte als kanonisch gilt.
---

# kanon-pruefung

## Ablauf

Kanonstatus einer Quelle oder Geschichte anhand der in `canon.md` der Story Bible festgehaltenen Kanonregeln bestimmen. Rangfolge:

1. explizite Festlegung des Nutzers für das konkrete Werk
2. explizite Kanonkennzeichnung innerhalb der erfassten Werkquellen
3. in der Story Bible bereits festgelegte Quellenhierarchie
4. bei fehlender Entscheidungsgrundlage: `ungeklaert`

## Statuswerte

- `kanon`
- `nicht-kanon`
- `teilweise-kanon` — die konkret als kanonisch geltenden Bestandteile werden festgehalten
- `alternative-kontinuitaet` — die zugehörige Kontinuität wird benannt
- `ungeklaert`

## Pflichtregeln

- MUSS GELTEN: Jede Kanonentscheidung verweist auf die Grundlage, aus der sie abgeleitet wurde.
- MUSS GELTEN: Änderungen am Kanonstatus aktualisieren die davon betroffenen Story-Bible-Einträge.
- Der Fall `ungeklaert` erfordert eine Nutzerentscheidung, bevor er als Kanonstatus festgehalten wird.
