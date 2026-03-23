# AAK: Payment Rails Update (Wert Supported Countries)

Date: 2026-02-08
Status: Completed
Owner: Copilot (per user request)

## Context
The repo now includes a payment rails availability list (CSV + YAML). User requested a review update using Wert's supported countries list and asked to proceed with AAK logging.

## Source
- Wert supported countries: https://support.wert.io/en/articles/5194509-supported-countries

## Actions
- Parsed the Wert support article table and refreshed the payment rails dataset.
- Rebuilt CSV and YAML outputs with the full country list and updated summary counts.

## Decisions
- Source of truth: Wert supported countries article (public support page).
- Output formats: CSV for data imports, YAML for config/reference.

## Outputs
AAK BIND: PAYMENT-RAILS-AVAILABILITY.csv
AAK BIND: PAYMENT-RAILS-AVAILABILITY.yaml

## Results
- Total countries: 249
- Fiat onramp available: 185
- NFT checkout available: 227
- Both unavailable: 22

## Next
- Optional: add a source note in documentation for traceability.
- Optional: generate a delta report vs the original 65-country list.
