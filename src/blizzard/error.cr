require "http/client/response"

module Blizzard
  module Error
    class Error < Exception; end

    class APIError < Error
      getter response
      getter uri

      def initialize(@uri : String, @response : HTTP::Client::Response)
        super(build_error_message)
      end

      private def build_error_message
        content_type = @response.headers.get?("content-type")
        message = case content_type
        when Nil
          "#{response.body[0..50]}..."
        when .includes?("json")
          response_body = JSON.parse(response.body)
          response_body["reason"]?
        else
          "#{response.body[0..50]}..."
        end

        "Server responded with code #{response.status_code}, message: " \
        "#{message}. " \
        "Request URI: #{uri}"
      end
    end

    class BadRequest < APIError; end
    class NotFound < APIError;  end
    class Unauthorized < APIError; end
    class Forbidden < APIError; end
    class MethodNotAllowed < APIError; end
    class InternalServerError < APIError; end
    class Unprocessable < APIError; end
    class BadGateway < APIError; end
    class ServiceUnavailable < APIError; end
  end
end
