# frozen_string_literal: true

module Zoom
  module Actions
    def self.parse_url(url, params)
      parsed_url = url.dup
      url.scan(/:\w+/).each do |match|
        key         = match[1..].to_sym
        value       = params[key].to_s
        parsed_url  = parsed_url.gsub(match, value)
      end
      parsed_url
    end

    def self.make_request(obj, method, url, params, required_params)
      request_options = {
        headers: obj.request_headers
      }
      case method
      when :get
        request_options[:query] = required_params
      when :post, :patch
        request_options[:body] = required_params.to_json
      end
      parsed_url = Zoom::Actions.parse_url(url, params)
      obj.class.public_send(method, parsed_url, **request_options)
    end

    def define_action(name:, method:, url:, required: [], permitted: [])
      required  = [required]  if required.is_a?(Symbol)
      permitted = [permitted] if permitted.is_a?(Symbol)

      define_method(name) do |*args|
        params = Zoom::Params.new(Utils.extract_options!(args))
        required_params = required.empty? ? params : params.require(required)
        required_params.permit(permitted) unless permitted.empty?
        response = Zoom::Actions.make_request(self, method, url, params, required_params)
        Utils.parse_response(response)
      end
    end
  end
end
