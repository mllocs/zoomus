# frozen_string_literal: true

module Zoom
  module Actions
    module Groups
      extend Zoom::Actions

      get 'groups_list', '/groups'

      get 'groups_get', '/groups/:group_id'
    end
  end
end
