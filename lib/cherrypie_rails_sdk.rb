# frozen_string_literal: true

require_relative "cherrypie_rails_sdk/version"
require 'concurrent'

module CherrypieRailsSdk
  class Error < StandardError; end
  class Middleware
    include Concurrent::Async

    def initialize(app, api_key, identity_function, api_url: "https://api.cherrypie.app")
      super()
      @app = app
      @api_key = api_key
      @api_url = api_url
      @identity_function = identity_function
    end
  
    def call env
      dup._call env
    end
  
    def _build_request_payload(request)
      headers = {}
      request.headers.each {|key, value|
        headers.merge(key: value)
      }
      return {
        "path"=> request.fullpath,
        "method"=> request.method,
        "headers"=> headers,
        "body"=> request.body,
      }
    end
  
    def _build_response_payload(status, headers, response)
      body = nil
      if response.respond_to?(:body)
        body = response.body
      end
      return {
        "headers"=> headers,
        "body"=> body,
        "statusCode"=> status,
      }
    end

    def _send_log(http, request)
      http.request(request)
    end

    def _call env
      request_started_on = Time.now
      @status, @headers, @response = @app.call(env)
      request_ended_on = Time.now
      request = ActionDispatch::Request.new(env)

      @log_level = :info
      # Rails.logger.send(@log_level, '=' * 50)
      # Rails.logger.send(@log_level, "Request delta time: #{request_ended_on - request_started_on} seconds.")
      # Rails.logger.send(@log_level, '=' * 50)

      response_time = (request_ended_on - request_started_on) * 1000
  
      account = @identity_function[request]
      payload = {
        "logEntry" => {
            "account"=> account,
            "clientIP"=> request.ip,
            "request"=> _build_request_payload(request),
            "response"=> _build_response_payload(@status, @headers, @response),
            "responseTime"=> response_time, # ms
        }
      } .to_json

      uri = URI("#{@api_url}/v1/logs")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      cherrypie_request = Net::HTTP::Post.new(
        uri.request_uri,
        {
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{@api_key}",
          'Accept'=>'application/json',
        }
      )
      cherrypie_request.body = payload
      # Only log non-300 statuses.
      if !(@status >= 300 && @status <= 399)
        cherrypie_response = self.async._send_log(http, cherrypie_request)
      end
      [@status, @headers, @response]
    end
  end
end
