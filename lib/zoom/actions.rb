# frozen_string_literal: true

module Zoom
  module Actions
    def self.extract_url_keys(url)
      url.scan(/:\w+/).map { |match| match[1..].to_sym }
    end

    def self.parse_url(url, url_keys, params)
      parsed_url = url.dup
      url_keys.each do |key|
        value       = params[key].to_s
        parsed_url  = parsed_url.sub(":#{key}", value)
      end
      parsed_url
    end

    def self.make_request(obj, method, parsed_url, filtered_params)
      request_options = {
        headers: obj.request_headers
      }
      case method
      when :get
        request_options[:query] = filtered_params
      when :post, :patch
        request_options[:body] = filtered_params.to_json
      end
      obj.class.public_send(method, parsed_url, **request_options)
    end

    def define_action(name:, method:, url:, required: [], permitted: [])
      required  = [required]  if required.is_a?(Symbol)
      permitted = [permitted] if permitted.is_a?(Symbol)

      define_method(name) do |*args|
        url_keys = Zoom::Actions.extract_url_keys(url)
        params = Zoom::Params.new(Utils.extract_options!(args))
        parsed_url = Zoom::Actions.parse_url(url, url_keys, params)
        params = params.require(url_keys) unless url_keys.empty?
        params_without_required = required.empty? ? params : params.require(required)
        params_without_required.permit(permitted) unless permitted.empty?
        response = Zoom::Actions.make_request(self, method, parsed_url, params)
        Utils.parse_response(response)
      end
    end
  end
end
