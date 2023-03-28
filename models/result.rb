require_relative 'types'

module Models
  class Result < Dry::Struct
    transform_keys(&:to_sym)
    attribute :wid, Types::Strict::Integer.optional.default(0)
    attribute :word, Types::Strict::String.optional.default(nil)
    attribute :type, Types::Strict::String.optional.default(nil)
  end
end
