require 'rubocop'

module RuboCop
  module Cop
    module Lint
      class ActionIsStringUsage < RuboCop::Cop::Cop
        MSG = 'is_string key in used in FastlaneCore::ConfigItem. Replace with `type: <Integer|Float|String|Boolean|Array|Symbol>`'.freeze
        def on_hash(node)
          pairs = node.pairs
          return if pairs.empty?

          pairs.each do |pair|
            key = pair.key
            value = pair.value
            next unless key.source.to_sym == :is_string && value.source.to_s == "false"
            if node.parent.children[0].source == "FastlaneCore::ConfigItem"
              add_offense(pair, :expression)
            end
          end
        end
      end
    end
  end
end
