# lex-cognitive-homeostasis

**Level 3 Leaf Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-agentic/CLAUDE.md`
- **Gem**: `lex-cognitive-homeostasis`

## Purpose

Models the regulatory mechanisms that keep cognitive variables near their setpoints. Each tracked variable has a setpoint, a tolerance band, and a correction rate. Variables can be perturbed away from setpoint and actively corrected back. Passive drift simulates background noise that disturbs variables over time. Variables outside tolerance are flagged as out-of-range. The engine computes an overall balance score (mean distance from setpoints) and a stress index (proportion of out-of-range variables). A periodic maintenance actor drives automatic correction and drift.

## Gem Info

| Field | Value |
|---|---|
| Gem name | `lex-cognitive-homeostasis` |
| Version | `0.1.0` |
| Namespace | `Legion::Extensions::CognitiveHomeostasis` |
| Ruby | `>= 3.4` |
| License | MIT |
| GitHub | https://github.com/LegionIO/lex-cognitive-homeostasis |

## File Structure

```
lib/legion/extensions/cognitive_homeostasis/
  cognitive_homeostasis.rb          # Top-level require
  version.rb                        # VERSION = '0.1.0'
  client.rb                         # Client class
  helpers/
    constants.rb                    # Variable categories, rates, thresholds, balance/deviation labels
    cognitive_variable.rb           # CognitiveVariable value object
    homeostasis_engine.rb           # Engine: variables, perturbation, correction, drift
  runners/
    cognitive_homeostasis.rb        # Runner module
```

## Key Constants

| Constant | Value | Meaning |
|---|---|---|
| `MAX_VARIABLES` | 100 | Variable cap |
| `DEFAULT_SETPOINT` | 0.5 | Default equilibrium target |
| `DEFAULT_TOLERANCE` | 0.15 | Acceptable deviation from setpoint |
| `CORRECTION_RATE` | 0.08 | Correction strength per call |
| `DRIFT_RATE` | 0.02 | Random drift magnitude per tick |
| `BALANCE_LABELS` | hash | `stable` (0.05 mean deviation) through `critical` |
| `DEVIATION_LABELS` | hash | Labels for per-variable deviation magnitude |
| `VARIABLE_CATEGORIES` | array | `[:arousal, :attention, :stress, :motivation, :mood, :energy, :focus, :anxiety, :confidence, :curiosity]` |

## Helpers

### `CognitiveVariable`

A regulated cognitive quantity with setpoint and tolerance.

- `initialize(name:, category:, setpoint: DEFAULT_SETPOINT, tolerance: DEFAULT_TOLERANCE, variable_id: nil)`
- `perturb!(amount)` — shifts current value away from setpoint
- `correct!(rate)` — moves current value toward setpoint by `CORRECTION_RATE`
- `drift!(rate)` — applies small random noise
- `reset!` — returns to setpoint
- `out_of_range?` — `|current - setpoint| > tolerance`
- `deviation` — absolute distance from setpoint
- `deviation_label`, `balance_label`
- `to_h`

### `HomeostasisEngine`

- `create_variable(name:, category:, setpoint: DEFAULT_SETPOINT, tolerance: DEFAULT_TOLERANCE)` — returns `{ created:, variable_id:, variable: }` or capacity error
- `perturb(variable_id:, amount:)` — applies perturbation; returns before/after/out_of_range
- `correct(variable_id:)` — moves variable toward setpoint
- `correct_all` — corrects all out-of-range variables
- `drift_all` — applies passive drift to all variables
- `reset_variable(variable_id:)` — snaps to setpoint
- `out_of_range_variables` — returns all variables where `out_of_range? == true`
- `overall_balance` — mean deviation across all variables; lower = more balanced
- `stress_index` — proportion of out-of-range variables (0.0 to 1.0)
- `homeostasis_report` — full stats including balance, stress, category distribution

## Runners

**Module**: `Legion::Extensions::CognitiveHomeostasis::Runners::CognitiveHomeostasis`

| Method | Key Args | Returns |
|---|---|---|
| `create_cognitive_variable` | `name:`, `category:`, `setpoint: 0.5`, `tolerance: 0.15` | `{ success:, variable_id:, variable: }` |
| `perturb_variable` | `variable_id:`, `amount:` | `{ success:, before:, after:, out_of_range: }` |
| `correct_variable` | `variable_id:` | `{ success:, variable: }` |
| `correct_all_variables` | — | `{ success:, corrected: N }` |
| `drift_all_variables` | — | `{ success:, drifted: N }` |
| `reset_variable` | `variable_id:` | `{ success:, variable: }` |
| `out_of_range_report` | — | `{ success:, variables: [...] }` |
| `variables_by_category_report` | — | `{ success:, categories: }` |
| `most_deviated_report` | `limit: 10` | `{ success:, variables: }` |
| `homeostasis_report` | — | Full report hash |
| `update_cognitive_homeostasis` | — | `{ success:, corrected:, drifted: }` — maintenance cycle |
| `cognitive_homeostasis_stats` | — | engine `to_h` |

Private: `homeostasis_engine` — memoized `HomeostasisEngine`. Logs via `log_debug` helper.

## Integration Points

- **`lex-emotion`**: Emotional valence perturbations from `lex-emotion` can drive corresponding homeostasis variable changes (e.g., high arousal perturbs `:arousal` variable out of range). Homeostasis correction then damps the emotional spike.
- **`lex-tick`**: `update_cognitive_homeostasis` fits naturally into `memory_consolidation` or a dedicated regulatory phase. The stress_index could feed tick mode selection (high stress -> sentinel mode).
- **`lex-cognitive-fatigue-model`**: Fatigue-induced depletion in `lex-cognitive-fatigue-model` maps to perturbation of energy/focus variables in homeostasis.

## Development Notes

- `drift_all` applies random noise within `DRIFT_RATE` bounds. The direction is random per call, so drift accumulates as a random walk over time.
- `correct_all` only corrects variables that are `out_of_range?`. Variables within tolerance are skipped to avoid over-correction.
- `stress_index` is a proportion (0.0 = all variables in range; 1.0 = all out of range), not an absolute count.
- In-memory only.

---

**Maintained By**: Matthew Iverson (@Esity)
