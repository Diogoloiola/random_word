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

  def request(body: {}, verbose: false) # rubocop:disable Metrics/MethodLength
    body = body.to_h
    body = body.delete_if { |_k, v| v.nil? || v.to_s.empty? }
    body = body.to_json

    response = Typhoeus::Request.new(
      "#{@base_url}/#{@url}",
      method: :get,
      body:,
      headers: { 'Content-Type': 'application/json' },
      verbose:
    ).run

    if response.success?
      Models::Result.new(response.body) unless response.body.empty?
    else
      error_api = JSON.parse(response.body)
      { error: error_api }
    end
  end
end
