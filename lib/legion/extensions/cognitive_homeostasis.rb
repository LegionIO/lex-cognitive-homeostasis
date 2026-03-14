# frozen_string_literal: true

require_relative 'cognitive_homeostasis/version'
require_relative 'cognitive_homeostasis/helpers/constants'
require_relative 'cognitive_homeostasis/helpers/cognitive_variable'
require_relative 'cognitive_homeostasis/helpers/homeostasis_engine'
require_relative 'cognitive_homeostasis/runners/cognitive_homeostasis'
require_relative 'cognitive_homeostasis/client'

module Legion
  module Extensions
    module CognitiveHomeostasis
      extend Legion::Extensions::Core if defined?(Legion::Extensions::Core)
    end
  end
end
