# frozen_string_literal: true

module Zoom
  class Error < StandardError; end
  class GatewayTimeout < StandardError; end
  class NotImplemented < StandardError; end
  class ParameterMissing < StandardError; end
  class ParameterNotPermitted < StandardError; end
  class ParameterValueNotPermitted < StandardError; end
  class AuthenticationError < StandardError; end
end
