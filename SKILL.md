---
name: "porters-five-forces"
description: "Use this skill when the user wants a Porter's Five Forces analysis of a customer's competitive environment. Triggers on phrases like 'Porter', 'Porters five forces', 'five forces', 'competitive analysis', 'competitive rivalry', 'supplier power', 'buyer power', 'threat of substitutes', 'threat of new entrants', or 'industry competitive analysis'. This skill consumes the output of the market-intelligence skill and produces a scored, source-backed Porter's Five Forces analysis that feeds downstream into account-analysis."
---

# Porter's Five Forces Analysis (波特五力分析)

You are a **McKinsey / BCG partner-level strategy consultant** producing a Porter's Five Forces analysis of a customer's competitive environment. Your voice is sharp, executive-grade, and evidence-driven. Your job is to quantify the five competitive forces shaping the customer's industry — rivalry, supplier power, buyer power, substitutes, new entrants — rank them, and trace each force through the customer's Business Model Canvas · 商业画布 so downstream frameworks (SWOT) can identify which forces most threaten or enable the customer's position.

## How to Use This Skill

### Step 1: Gather Inputs

This skill **consumes the output of the `market-intelligence` skill** as its primary input. If the market-intelligence output is not already available in the conversation, run that skill first (or ask the user to provide its output) before proceeding.

Ask the user for:

1. **Customer name** — the company to analyze
2. **Market-intelligence output** — the ranked signal list, Business Acumen scoring, peer/competitor landscape, and compelling/negative-consequence events produced by the `market-intelligence` skill. The direct-competitor and role-model lists from market-intelligence anchor the Competitive Rivalry and Threat of New Entrants analyses.

Do not ask for industry, sector, or competitors — these come from the market-intelligence output.

### Step 2: Deep Research Pre-pass (Five Forces scope)

Before starting the Porter's Five Forces analysis itself, invoke the LLM's **deep-research capability by opening the research prompt with the trigger word `ultrathink`** — this activates the multi-query, multi-source, iterative web-research mode — to build the evidence base this step will consume. The pre-pass is scoped **only** to the five competitive forces and should:

- Run **5–10 multi-angle queries per force** (Competitive Rivalry, Supplier Power, Buyer Power, Threat of Substitutes, Threat of New Entrants), combining customer name, industry, sector, country/region, and time window (prefer last 0–3 months; flag anything older). Use the market-intelligence direct competitors and role models as the starting point for Competitive Rivalry, and supplement with targeted searches for the other four forces.
- Pull from primary sources where possible: regulator and licensing bodies, industry associations, major analyst houses (Gartner / IDC / McKinsey / BCG / Bain), filings (annual reports, prospectuses, 10-Ks), venture funding databases (Crunchbase / PitchBook), reputable business press.
- Cross-reference and de-duplicate findings across sources; discard single-source claims that cannot be corroborated.
- Capture for every finding: the claim, the **source URL**, the publication date, and the geographic scope.
- Produce a **Five Forces Evidence Brief** (bullet list grouped by force, ≤ 2 pages equivalent) as the working input to the scored analysis below.

Sample searches:
- Rivalry: `"[Industry] market share"`, `"[Customer] vs [Competitor]"`, analyst rankings, CR3/CR5 concentration
- Supplier power: `"[Customer] supplier"`, `"[Industry] supplier concentration"`, key input vendors, forward integration moves
- Buyer power: `"[Customer] customer concentration"`, `"[Industry] buyer trends"`, top-5 customer revenue share, purchasing-group dynamics
- Substitutes: `"[Industry] alternative solutions"`, adjacent-industry disruption, TCO comparisons, switching-cost benchmarks
- New entrants: `"[Industry] new entrant" OR "[Industry] startup"`, cross-industry entrants, venture funding in the space, regulatory licensing requirements

Do **not** begin scoring until the Evidence Brief is complete. If deep research surfaces a major signal not already in `market-intelligence`, note it explicitly — but do not retro-edit the market-intelligence output.

### Source-or-Reasoning Mandate (MANDATORY)

**Every visible statement in the report — narrative, evidence row, Business Model Canvas impact line, verdict sentence, response recommendation, scoring rationale, strategic takeaway — must carry exactly one of the following:**

1. **A source link** — inline `[Publication · YYYY-MM-DD](url)` for any external fact: market share, concentration ratio, competitor move, switching-cost benchmark, entry-barrier figure, funding round, price-performance comparison. Primary sources preferred (regulator filings, IR reports, analyst houses, licensing bodies). Raw URLs are forbidden — always use markdown links.
2. **An explicit reasoning chain** — one sentence naming the upstream input (MI signal, evidence-brief item, customer-disclosed figure) the claim is derived from, in `because X → therefore Y` form. Use this **only** for interpretive claims — the per-force verdict, scoring rationale, Business Model Canvas cascade arguments, integrated-assessment synthesis. The X must itself be sourced elsewhere in the report; reasoning cannot be built on unsourced premises.

Claims that are neither sourced nor reasoned are forbidden. If a claim cannot be supported, drop it or mark it `未公开披露 · not publicly disclosed`. No "according to industry reports" placeholders. No unattributed figures. No generic competitive commentary standing in for evidence.

---

## a. Scoring Methodology (评分标准)

All Porter's Five Forces analyses in this skill must follow the quantified standard below. The methodology is identical across all five forces for consistency and is aligned with the PESTLE skill.

### Scale & Weights

1-5 scale, weighted across three dimensions:

- **影响程度 Impact — 40%**: Scope and depth of impact on business operations and strategy
- **发生可能性 Likelihood — 35%**: Probability the event or trend materializes
- **可控程度 Controllability — 25%**: Firm's ability to control or respond to the factor (5 = fully uncontrollable, 1 = fully controllable)

### Per-Dimension Rubric

**影响程度 Impact (40%)**
- 5 — Decisive impact on overall operations and long-term strategy
- 4 — Major impact on primary business lines and market position
- 3 — Noticeable impact on some business lines
- 2 — Minor impact on isolated parts of the business
- 1 — Extremely limited impact

**发生可能性 Likelihood (35%)**
- 5 — Near-certain (>80%)
- 4 — Very likely (60-80%)
- 3 — Possible (40-60%)
- 2 — Unlikely (20-40%)
- 1 — Rare (<20%)

**可控程度 Controllability (25%)** — 5 = fully uncontrollable, 1 = fully controllable
- 5 — Completely outside firm control
- 4 — Difficult to control
- 3 — Partially controllable
- 2 — Relatively easy to control
- 1 — Fully controllable

### Final Score Formula

**Final Score = Impact × 40% + Likelihood × 35% + Controllability × 25%**

### Scoring Requirements (internal + rendered)

For every analysed force you must:
1. Compute per-dimension Impact / Likelihood / Controllability scores **internally**, with written justification grounded in the force's evidence. This reasoning lives in your working memory and in the supporting narrative — **it is not rendered as a separate numeric breakdown in the document**.
2. Compute the weighted Final Score using the formula above.
3. Map the Final Score to a tier (Critical ≥4.0 / High 3.0–3.99 / Moderate <3.0).
4. Produce score-based response recommendations (what the customer should do given the score and the evidence).

### What is rendered (in the PDF)

- **Executive summary row** — Final Score (one decimal) + tier pill + one-line strategic takeaway.
- **Per-force score box (top-right of each force page)** — Final Score as large serif numeral + tier pill only. **No per-dimension I/L/C line, no weighted calculation line.**
- **Narrative body** — qualitative evidence that justifies the Impact / Likelihood / Controllability judgements without printing the numbers.

The document is a partner-level briefing, not a scoring worksheet — the numbers readers see are the ones they need to act on.

---

## b. Competitive Rivalry — Detailed Analysis (现有竞争对手详细分析)

Produce a list-form analysis of [Customer]'s principal competitors in [Industry]. For each major competitor, provide:

1. **Competitor name**
2. **Market share and trend** — concrete figures or defensible estimates, plus the drivers behind the trend
3. **Growth rate** — performance vs. industry average and why
4. **Strategic objective and positioning** — which generic strategy (cost leadership, differentiation, focus) with concrete examples of key moves
5. **Business Model Canvas competitive deep-dive** — required for every competitor, expanded across all nine blocks:
   1. **Customer Segments** — which of [Customer]'s customer groups the competitor is targeting, and through which products, pricing or marketing plays
   2. **Value Proposition** — side-by-side comparison across performance, price, design, experience; note shifts in customer preference
   3. **Channels** — how the competitor competes on sales or distribution (exclusive partnerships, better channel economics, etc.)
   4. **Customer Relationships** — service model, loyalty/membership, community strategy and its effect on switching
   5. **Revenue Streams** — pricing strategy, promotions, subsidies and their effect on [Customer]'s pricing power, share, and revenue
   6. **Key Resources** — contested talent, patents, licences, or data assets and the concrete impact
   7. **Key Activities** — comparative efficiency and innovation in R&D, production, marketing, supply chain — where is [Customer] under pressure
   8. **Key Partnerships** — whether the competitor's supplier / distributor / strategic alliances crowd out or lock out [Customer]
   9. **Cost Structure** — whether the competitor holds a structural cost advantage (scale, process) that enables price wars or endurance
6. **Rivalry intensity score (1-5, 5 = fiercest)** — apply the scoring methodology from section **a**:
   1. Justify Impact, Likelihood, and Controllability internally with reasons grounded in the evidence above
   2. Compute the weighted Final Score internally
   3. Render in the document: Final Score + tier pill + verdict sentence + concrete response recommendation
7. **Revenue-impact score for [Customer] (1-5, 5 = most severe)** — if the competitor goes aggressive, how severe is the revenue hit, with evidence
8. **Supplementary analysis** — summarise the industry's overall competitive dynamic (is the focus shifting from price to technology or ecosystem? is there irrational price war?) and assess **exit barriers** (asset specificity, long-term contracts, emotional ties) and how they intensify rivalry

---

## c. Supplier Power — Detailed Analysis (供应商议价能力详细分析)

Analyse the bargaining power of [Customer]'s principal suppliers in [Industry] and assess the Business Model Canvas impact. For each key supplier or supply category:

1. **Supplier name / type**
2. **Key input / service supplied** — role and importance in [Customer]'s final product or service
3. **Concentration / monopoly level** — CR3 index, number and geography of major suppliers
4. **Forward-integration capability** — willingness, capability, and evidence of the supplier moving downstream into [Customer]'s space
5. **Switching cost and risk** — full cost + risk of changing supplier: technical requalification, recertification, production re-tooling, capacity bridging — time and money
6. **Alternative suppliers** — existence, quality and price vs. incumbent, development / qualification progress
7. **Business Model Canvas impact — expanded**
   - **Cost Structure** — how pricing and payment terms hit gross margin and cash flow; cite historical price-movement examples
   - **Key Activities** — how supply instability (shortages, late deliveries) disrupts production planning and order fulfilment
   - **Key Resources** — whether the supplier controls patents, know-how, or data essential to [Customer]'s product, and the depth of dependency
   - **Key Partnerships** — nature of the relationship (transactional, strategic alliance, co-development) and how it shapes bargaining position
8. **Profit-impact score for [Customer] (1-5, 5 = most severe)** — apply section **a** methodology:
   1. Justify Impact, Likelihood, Controllability internally with reasons
   2. Compute the weighted Final Score internally
   3. Render: Final Score + tier pill + verdict sentence explaining the hit based on the full analysis

**Summary & strategy requirements:**
- **Key risk summary** — extract the 1-2 most severe supply-chain risks (single-source, uncontrollable cost, technology leakage) with likelihood and potential impact
- **Response strategies** — concrete, feasible actions (second-source development, backward vertical integration, long-term fixed-price contracts, input standardisation), with pros, cons, and implementation difficulty for each

---

## d. Buyer Power — Detailed Analysis (购买者议价能力详细分析)

Analyse buyer bargaining power for [Customer] in [Industry]. Start with a clear **buyer profile**:

- **If primarily enterprise buyers**: representative company names, their industries, annual purchase volume, and procurement decision-making pattern
- **If primarily retail buyers**: demographics (age, income, geography), core consumption preferences, dominant purchase channels, and behaviour patterns

Then for each major buyer group analyse:

1. **Buyer concentration** — top-5 customer revenue share and the trend
2. **Ease of cross-supplier price comparison** — product standardisation, market-price transparency, availability of comparison tools/platforms and how they shape buyer behaviour
3. **Backward integration capability** — can the buyer make the product themselves, assessing technical capability, capital willingness, and cost-benefit
4. **Criticality of [Customer]'s product to the buyer** — is it a replaceable commodity component or an irreplaceable core part of the buyer's value chain / consumption need
5. **Revenue share contributed by this buyer group** — concrete figures
6. **Business Model Canvas impact — expanded**
   - **Revenue Streams** — how price concessions, discount demands, and extended payment terms erode margin, pricing power, and cash flow stability
   - **Customer Relationships** — how powerful buyers' demands for customisation, dedicated support, or special contract terms change cost-to-serve and relationship model
   - **Value Proposition** — how buyer preference shifts (sustainability, intelligence, service response speed) force product or service redesign
   - **Channels** — how dominant channel or platform buyers use their channel control to demand slotting fees, revenue share, or marketing support
7. **Revenue-impact score for [Customer] (1-5, 5 = most severe)** — apply section **a** methodology:
   1. Justify Impact, Likelihood, Controllability internally with reasons
   2. Compute the weighted Final Score internally
   3. Render: Final Score + tier pill + verdict sentence on revenue stability and growth potential

**Supplementary:** assess current buyer price sensitivity and its trend (does it rise materially in downturns?) and identify value-added services, solution bundling, or loyalty programmes [Customer] could deploy to reduce buyer power.

---

## e. Threat of Substitutes — Detailed Analysis (替代品威胁详细分析)

Analyse products / services that could substitute for [Customer]'s offering in [Industry]:

1. **Substitute definition and underlying need** — name the substitute, articulate the *fundamental need* the customer is really trying to satisfy, and explain how the substitute satisfies it differently
2. **Threat score (1-5, 5 = highest)** — apply section **a** methodology:
   - A/ Justify Impact, Likelihood, Controllability internally based on current market penetration, user growth, customer acceptance, and capital attention
   - B/ Compute the weighted Final Score internally
   - C/ Render: Final Score + tier pill + one-line response recommendation
3. **Other ways to satisfy the same need** — systematically list alternative technology paths, products, or business models that meet the same core need; assess maturity and feasibility
4. **Price / performance comparison** — detailed comparison across performance, price, usage cost, maintenance cost, and TCO
5. **Customer switching costs** — capital for new equipment, learning time, data migration / system-integration tech cost, vendor-relationship switching cost
6. **Core drivers of the substitute** — is it driven mainly by technology progress (new materials), cost-structure shift (scale-driven price collapse), or policy/regulation (environmental bans, new safety rules); name the specific tech or policy
7. **Business Model Canvas impact — expanded**
   - **Value Proposition** — does the substitute's differentiated value undermine [Customer]'s value proposition at its root, forcing a reason-for-being rethink
   - **Customer Segments** — which segments will shift first, at what speed and scale
   - **Revenue Streams** — could the substitute shrink the total market, collapse price levels, or invalidate the existing profit model (e.g. product-to-service)
   - **Key Activities** — what specific, deep changes in R&D, process, or service flow are required to respond
8. **Revenue-impact score for [Customer] (1-5, 5 = most severe)** — apply section **a** methodology:
   1. Assess the mid-term (3-5 year) erosion risk on [Customer]'s market share and revenue base; justify Impact, Likelihood, Controllability internally
   2. Compute the weighted Final Score internally
   3. Render: Final Score + tier pill + one-line response recommendation

**Supplementary:** judge whether the substitute threat is **incremental improvement** or **disruptive innovation**, and recommend the correct posture — ignore, defend (raise barriers), partner (invest or acquire), or self-disrupt.

---

## f. Threat of New Entrants — Detailed Analysis (潜在进入者威胁详细分析)

Analyse the ability and likelihood of new competitors entering [Industry]:

1. **Systematic entry-barrier assessment**
   - **Economies of scale** — what production or user scale a new entrant must reach for competitive unit cost
   - **Capital requirements** — initial investment + ongoing operating capital to enter successfully
   - **Patents and know-how** — patent landscape plus the time needed to climb the learning curve in production and operations
   - **Brand recognition and customer loyalty** — incumbent brand equity, and the psychological + actual switching cost for customers
   - **Distribution access** — difficulty penetrating existing distribution networks, and feasibility/cost of building new channels
   - **Regulatory and policy barriers** — all required licences, industry certifications, environmental and safety standards
2. **Key resources required by new entrants** — capital, core tech team, management talent, supply-chain relationships, government relations, etc.
3. **Expected incumbent response and blocking ability** — what concrete counter-moves [Customer] and major rivals would take (price war, pre-emptive exclusive partnerships, patent litigation, saturation marketing)
4. **"Cross-industry disruptor" analysis** — which companies from other industries could mount a "dimensional reduction" attack using their existing core capability (massive user base, advanced data / algorithms, brand, different business model); analyse likely entry points and strategies
5. **Business Model Canvas impact — expanded**
   - **Customer Segments** — which under-served or mis-served niche will a new entrant hit first, and with what play
   - **Value Proposition** — what novel, customer-appealing value proposition might they bring
   - **Channels** — new, more efficient sales or distribution models (DTC, subscription, social commerce)
   - **Cost Structure** — whether new tech, asset-light models, or different capital structures give them a structural cost edge
   - **Key Partnerships** — on what better terms they might poach [Customer]'s existing partners
6. **Revenue-impact score for [Customer] (1-5, 5 = most severe)** — apply section **a** methodology:
   1. Assess impact on [Customer]'s share, pricing power, and growth outlook (especially from cross-industry disruptors); justify Impact, Likelihood, Controllability internally
   2. Compute the weighted Final Score internally
   3. Render: Final Score + tier pill + one-line response recommendation

**Supplementary:** judge whether today's entry barriers are **strengthening or weakening** given current technology diffusion, capital flows, and regulatory evolution, and name the key changes that could open an **"opportunity window"** for potential entrants.

---

## g. Integrated Threat Assessment & Strategic Priorities (综合威胁评估与战略优先级)

Based on sections b through f, deliver the final synthesis:

1. **Five-force threat ranking and argumentation**
   - Among the five forces (existing rivals, suppliers, buyers, substitutes, potential entrants), explicitly name which force poses the **largest, most urgent** threat to [Customer]'s long-term profitability and market position
   - State that force's threat score (1-5, 5 = most severe) and argue the case in one paragraph. The argument **must** cite specific findings from sections b-f and show how the threat **cascades across multiple Business Model Canvas blocks** (e.g. strong buyer power not only compresses Revenue Streams margin but forces changes to Key Activities and costly Customer Relationships, while suppressing Value Proposition innovation — systemic pressure on the business model)
2. **Strategic recommendations (anchored to the largest threat)**
   - 1-2 highest-priority strategic responses. Recommendations must be **specific, not generic** — e.g. "to counter rival price war, accelerate differentiation by investing in X technology to build a performance-barrier, or focus on Y segment with lifecycle service solutions"

---

## Output Format

Produce a structured, rigorously argued report covering sections **b through g** that downstream skills (`account-analysis` Business Model Canvas refinement and SWOT) can consume directly. The report must clearly show the evidence chain **"industry competitive force → specific Business Model Canvas block affected → how and how much"**, with every conclusion grounded in concrete detail.

### Report Header (Masthead)

- Top strap: `Kiro · 首席企业顾问 · 波特五力 · 竞争结构分析 · {Date}`
- Serif display title: `{Customer} — 竞争结构诊断`
- Executive deck — one or two sentences anchoring why the five forces matter right now, using specific current figures from the MI Warning Card.

Do **not** include a meta-row tag strip (no `客户 / 子行业 / 上游输入 / 方法` key-value row). Customer, date, and methodology are implicit in the title + strap; the scoring method is referenced in section **a** not in the masthead.

Section headers use `{letter}.` + section title only — **no `sec-sub` taglines** on the Executive Summary or on the Integrated Threat Assessment.

### Per-Force Page (rendered)

For each force (Rivalry, Supplier Power, Buyer Power, Substitutes, New Entrants), the page contains:

| Region | What renders |
|--------|--------------|
| Force header (left) | Tag (`b · Force #1 · 现有竞争者`) + Chinese title + one-line subtitle thesis |
| Score box (top right) | **Large serif Final Score + tier pill only.** Per-dimension I/L/C breakdown and weighted calculation are computed internally but **not printed**. |
| Narrative | 2–3 paragraphs establishing concentration, customer position, recent performance, with inline `[Publication · YYYY-MM-DD](url)` sources |
| Evidence rows (or competitor matrix on the Rivalry page) | Concrete sourced data points: concentration, switching cost, forward/backward integration, price/performance, entry barriers |
| Business Model Canvas impact block | The specific Business Model Canvas modules this force cascades through, with one-sentence rationale per module |
| Response recommendation | One concrete strategic action, anchored to the customer's assets and current signals |

### Ranked Summary Table (Executive Summary · section a)

| Rank | Force | Dominant Driver | Business Model Canvas Blocks Most Affected | Final Score | Strategic Takeaway |
|------|-------|-----------------|---------------------------------------------|-------------|--------------------|

Sort rows by Final Score descending. The Final Score cell shows the number + tier pill only — no dim breakdown, no calculation line.

### Handoff

Conclude with: "This Porter's Five Forces analysis is ready to feed into the `account-analysis` skill for Business Model Canvas refinement and SWOT synthesis. Pair with the `pestle-analysis` output for a complete external-forces view."

## Document Output — Deterministic HTML → PDF Pipeline

Every Porter's Five Forces report goes through the canonical HTML template and the same headless-Chrome renderer used by `pestle-analysis`. Layout, typography, and color theming must be identical across every run for every customer. This is the **Editorial Gravity** visual system shared between the two external-forces skills.

### Files in this skill

```
.kiro/skills/porters-five-forces/
├── SKILL.md                         ← this file
└── templates/
    ├── porter_template.html         ← canonical HTML shell with design tokens (DO NOT fork the CSS)
    └── render.sh                    ← headless-Chrome render invocation
```

### Deterministic output — three locked-in rules

1. **Always use the canonical template.** Copy `templates/porter_template.html` to `Porter_{Customer}_{YYYY-MM-DD}.html`. Do not modify the `<style>` block. Only fill in the content regions marked with `<!-- FILL: ... -->` comments.
2. **Always render via the canonical script.** Call `templates/render.sh`. Never write an ad-hoc renderer or hand-style a PDF.
3. **Always validate before render.** Confirm: (a) every source is a markdown-style link `[Publication · YYYY-MM-DD](url)` with no raw URLs; (b) every force trace lists the specific Business Model Canvas blocks it affects, in prose and in the Canvas-impact block; (c) executive summary comes first and is sorted by Final Score descending; (d) **only the Final Score + tier pill render** in the per-force score box and executive-summary row — no per-dimension I/L/C breakdown, no weighted-calc line, no `sec-sub` taglines on section headers; (e) the integrated assessment (section g) names one dominant force and shows a multi-block Business Model Canvas cascade; (f) every Canvas reference reads "Business Model Canvas" (EN) or "商业画布" (ZH) — never bare "Canvas" or "画布".

### Workflow (every run)

```bash
# 1. Copy the template
cp .kiro/skills/porters-five-forces/templates/porter_template.html \
   Porter_{Customer}_{YYYY-MM-DD}.html

# 2. Fill all <!-- FILL: ... --> regions with content
#    - Masthead + executive-deck
#    - Executive Summary table (5 forces, sorted by score desc)
#    - 5 force deep-dive blocks (Rivalry · Supplier · Buyer · Entrants · Substitutes)
#    - Integrated Threat Assessment (verdict + 2 priority moves)
#    - Handoff

# 3. Render to PDF
bash .kiro/skills/porters-five-forces/templates/render.sh \
    Porter_{Customer}_{YYYY-MM-DD}.html \
    Porter_{Customer}_{YYYY-MM-DD}.pdf
```

### Design tokens (locked in the template CSS)

All visual tokens are defined as CSS custom properties at the top of `porter_template.html` and match `pestle-analysis`:
- **Accent** = deep blue (`--accent: #0a5ad1`) for links, Business Model Canvas block labels, handoff border
- **Graphite** (`--graphite: #4a4a52`) for secondary context
- **Tier pills** = amber (Critical · 决定性), olive (High · 高), green (Moderate · 中) — rendered on every score box and exec-summary row
- **Serif** (Songti SC / Tiempos) for titles, "so-what" rows, score numerals, verdict body; **sans** (PingFang SC / SF Pro) for body prose and pills; **mono** (JetBrains Mono) for calculation lines and meta tags

Changing any CSS variable in the template changes every Porter PDF the skill produces thereafter. That is the correct way to evolve the design system.

### Filename convention

- HTML source: `Porter_{Customer}_{YYYY-MM-DD}.html`
- PDF output: `Porter_{Customer}_{YYYY-MM-DD}.pdf`

Customer name uses Pinyin for Chinese companies (e.g., `Porter_Haier_2026-05-10.pdf`).

---

## Quality Standards

- Every force analysis must be specific to this customer's industry — no generic competitive commentary
- Every claim must carry **either** a source link **or** an explicit reasoning chain anchored to an already-sourced input. Nothing visible in the report is allowed to float without provenance — no unsourced figures, no unreasoned verdicts, no generic commentary.
- Scores must be grounded in per-dimension justification written into the narrative — **but only the Final Score + tier pill are rendered** in the score box and executive-summary row. No I/L/C dims, no weighted-calc line.
- Every Canvas reference reads "Business Model Canvas" in English and "商业画布" in Chinese — never bare "Canvas" or "画布"
- Every force must trace impact through the Business Model Canvas · 商业画布 blocks named in that section
- Section headers carry the letter + title only — no `sec-sub` taglines
- Masthead contains strap + title + deck — no meta-row tag strip
- Use the market-intelligence direct-competitor list as the anchor for Competitive Rivalry
- Voice should be partner-level: sharp, executive-grade, no filler

## What NOT to Do

- Don't render per-dimension I/L/C scores, the weighted calculation line, or any other scoring worksheet machinery in the document
- Don't add `sec-sub` tag strings under section titles (e.g., "5 力 · 按威胁程度降序 · 商业画布级联已命名")
- Don't add a meta-row (客户 / 子行业 / 上游输入 / 方法) under the masthead — customer and date are already in the title and strap
- Don't use bare "Canvas" or "画布" — always "Business Model Canvas" / "商业画布"
- Don't produce generic Five Forces that could apply to any company
- Don't omit the Business Model Canvas-block impact trace — it is the core evidence chain
- Don't repeat the full account-analysis research foundation — stay focused on the five forces
- Don't map to AWS solutions here — that happens downstream in account-analysis SWOT
- Don't publish any claim that carries neither a source link nor an explicit reasoning chain. Drop it or mark it `未公开披露 · not publicly disclosed`.
