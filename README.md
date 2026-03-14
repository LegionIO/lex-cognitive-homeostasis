# lex-cognitive-homeostasis

Cognitive regulatory balance engine for brain-modeled agentic AI in the LegionIO ecosystem.

## What It Does

Models the regulatory mechanisms that maintain cognitive equilibrium. Each tracked variable (arousal, attention, stress, motivation, mood, energy, focus, anxiety, confidence, curiosity) has a setpoint and a tolerance band. Variables can be perturbed by external events or passive drift and actively corrected back toward setpoint. The engine computes an overall balance score and a stress index (proportion of out-of-range variables). A maintenance cycle drives automatic correction and drift simultaneously.

## Usage

```ruby
require 'legion/extensions/cognitive_homeostasis'

client = Legion::Extensions::CognitiveHomeostasis::Client.new

# Create a regulated variable
result = client.create_cognitive_variable(
  name: 'baseline_stress',
  category: :stress,
  setpoint: 0.3,
  tolerance: 0.1
)
variable_id = result[:variable_id]

# Simulate a stressful event
client.perturb_variable(variable_id: variable_id, amount: 0.4)
# => { success: true, before: 0.3, after: 0.7, out_of_range: true }

# Correct all out-of-range variables
client.correct_all_variables
# => { success: true, corrected: 1 }

# Run full maintenance cycle (correct + drift)
client.update_cognitive_homeostasis
# => { success: true, corrected: 0, drifted: 1 }

# Check system balance
client.homeostasis_report
# => { success: true, report: { overall_balance: 0.04, stress_index: 0.0, ... } }
```

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## License

MIT
