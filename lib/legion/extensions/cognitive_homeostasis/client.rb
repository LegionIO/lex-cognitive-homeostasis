# frozen_string_literal: true

module Legion
  module Extensions
    module CognitiveHomeostasis
      class Client
        include Runners::CognitiveHomeostasis

        def engine
          @engine ||= Helpers::HomeostasisEngine.new
        end
      end
    end
  end
end
