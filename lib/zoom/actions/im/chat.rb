# frozen_string_literal: true

module Zoom
  module Actions
    module IM
      module Chat
        # Get chat messages for a specified period.
        def chat_get(*args)
          options = Utils.extract_options!(args)
          Utils.require_params(%i[access_token session_id from to], options)
          # TODO handle date format for `from` and `to` params
          # TODO implement `next_page_token`, will be returned whenever the set of available chat history list exceeds 100. The expiration period is 30 minutes.
          Utils.parse_response self.class.post('/chat/get', query: options)
        end

        # Get chat history list for a specified time period.
        def chat_list(*args)
          options = Utils.extract_options!(args)
          Utils.require_params(%i[access_token from to], options)
          # TODO handle date format for `from` and `to` params
          # TODO implement `next_page_token`, will be returned whenever the set of available chat history list exceeds 100. The expiration period is 30 minutes.
          Utils.parse_response self.class.post('/chat/list', query: options)
        end
      end
    end
  end
end
