require_relative 'http_request'

module Src
  module Api
    class Word < HttpRequest
      def initialize
        super('random')
      end
    end
  end
end
