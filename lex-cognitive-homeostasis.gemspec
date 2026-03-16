# frozen_string_literal: true

require_relative 'lib/legion/extensions/cognitive_homeostasis/version'

Gem::Specification.new do |spec|
  spec.name    = 'lex-cognitive-homeostasis'
  spec.version = Legion::Extensions::CognitiveHomeostasis::VERSION
  spec.authors = ['Esity']
  spec.email   = ['matthewdiverson@gmail.com']

  spec.summary     = 'Cognitive variable homeostasis for LegionIO'
  spec.description = 'Maintains balance across cognitive variables via setpoint tracking, ' \
                     'deviation detection, and automatic correction for LegionIO agents.'
  spec.homepage    = 'https://github.com/LegionIO/lex-cognitive-homeostasis'
  spec.license     = 'MIT'

  spec.required_ruby_version = '>= 3.4'

  spec.metadata['homepage_uri']      = spec.homepage
  spec.metadata['source_code_uri']   = 'https://github.com/LegionIO/lex-cognitive-homeostasis'
  spec.metadata['documentation_uri'] = 'https://github.com/LegionIO/lex-cognitive-homeostasis'
  spec.metadata['changelog_uri']     = 'https://github.com/LegionIO/lex-cognitive-homeostasis/blob/main/CHANGELOG.md'
  spec.metadata['bug_tracker_uri']   = 'https://github.com/LegionIO/lex-cognitive-homeostasis/issues'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir['lib/**/*']
  spec.add_development_dependency 'legion-gaia'
end
