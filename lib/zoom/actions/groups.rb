# frozen_string_literal: true

module Zoom
  module Actions
    module Groups
      def groups_list(*_args)
        Utils.parse_response self.class.get('/groups', headers: request_headers)
      end
    end
  end
end