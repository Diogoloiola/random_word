require 'typhoeus'
require 'json'
require_relative '../models/result'

class HttpRequest # rubocop:disable Style/Documentation
  def initialize(url, base_url = 'https://api.dicionario-aberto.net')
    @url = url
    @base_url = base_url
  end

  def get
    request
  end

  protected

  def request(verbose: false)
    @response = Typhoeus::Request.new(
      "#{@base_url}/#{@url}",
      method: :get,
      headers: { 'Content-Type': 'application/json' },
      verbose:
    ).run
    parse_response
  end

  private

  def parse_response
    if @response.success?
      Models::Result.new(JSON.parse(@response.body)) unless @response.body.empty?
    else
      error_api = JSON.parse(@response.body)
      { error: error_api }
    end
  end
end
