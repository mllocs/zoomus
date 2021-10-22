# frozen_string_literal: true

module Zoom
  module Actions
    module Groups
      extend Zoom::Actions

      define_action(
        name: 'groups_list',
        method: :get,
        url: '/groups'
      )

      define_action(
        name: 'groups_get',
        method: :get,
        url: '/groups/:group_id'
      )
    end
  end
end