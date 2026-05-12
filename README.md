# porters-five-forces

A Kiro skill that produces a **scored, source-backed Porter's Five Forces analysis** of the customer's competitive environment — rivalry, supplier power, buyer power, substitutes, new entrants — and traces each force through the customer's **Business Model Canvas** so downstream frameworks (SWOT/TOWS) can identify which forces most threaten or enable the customer's position. Rendered as a designed PDF.

Every visible claim carries either a clickable source link or an explicit `because X → therefore Y` reasoning chain anchored to a sourced premise. No unattributed figures, no "according to industry reports" placeholders.

## Pipeline position

```
market-intelligence → porters-five-forces → account-analysis → ...
```

Consumes the direct-competitor and role-model lists from `market-intelligence` to anchor Competitive Rivalry and Threat of New Entrants; feeds into `account-analysis`.

## What ships

- `SKILL.md` — skill definition
- `templates/porter_template.html` — PDF template
- `templates/render.sh` — HTML → PDF render script

## Triggers

`Porter`, `Porters five forces`, `five forces`, `competitive analysis`, `competitive rivalry`, `supplier power`, `buyer power`, `threat of substitutes`, `threat of new entrants`, `industry competitive analysis`.

## Usage

Drop this folder into your Kiro `.kiro/skills/` directory. See `SKILL.md` for the full skill definition.
