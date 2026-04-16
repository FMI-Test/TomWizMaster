# October 7 Traceability Matrix

| Requirement ID | Requirement | Layer | Component(s) | Test Case(s) | Risk(s) | Mitigation(s) |
| --- | --- | --- | --- | --- | --- | --- |
| SR-001 | Capture scenario assumptions for negotiation-first, mixed, and force-dominant paths | App | [October-7.md](October-7.md), [October-7-system-requirements.md](October-7-system-requirements.md) | Review scenario labels and scope coverage | Ambiguous scenario definitions | State assumptions explicitly |
| SR-002 | Normalize costs across financial, legal, humanitarian, and geopolitical categories | App | [October-7-system-requirements.md](October-7-system-requirements.md), [October-7-change-analysis.md](October-7-change-analysis.md) | Check category list completeness | Cross-category confusion | Label metrics by category |
| SR-003 | Support low, base, and high ranges | App | [October-7.md](October-7.md), [October-7-decision-options.md](October-7-decision-options.md) | Confirm range-based language appears in scope and recommendation | False precision | Use range-based outputs only |
| SR-004 | Compute illustrative cost-per-life and hostage-outcome metrics | App | [October-7.md](October-7.md) | Verify output expectations mention these metrics | Misleading single-number conclusions | Require sensitivity tables |
| SR-005 | Record provenance for material inputs | App | [October-7-system-requirements.md](October-7-system-requirements.md), [October-7-change-analysis.md](October-7-change-analysis.md) | Confirm provenance requirement and mitigation language | Unsupported claims | Require source notes or assumption tags |
| SR-006 | Export narrative summary and tabular comparison in markdown | App | [October-7-decision-options.md](October-7-decision-options.md), [October-7-traceability-matrix.md](October-7-traceability-matrix.md) | Confirm final artifacts are markdown and cross-linked | Incomplete packet | Keep packet limited and linked |
