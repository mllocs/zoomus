# frozen_string_literal: true

module Zoom
  module Actions
    module Account
      extend Zoom::Actions

      define_action(
        name: 'account_list',
        method: :get,
        url: '/accounts',
        permitted: %i[page_size page_number]
      )

      define_action(
        name: 'account_create',
        method: :post,
        url: '/accounts',
        required: %i[first_name last_name email password],
        permitted: { options: %i[share_rc room_connectors share_mc meeting_connectors pay_mode] }
      )

      define_action(
        name: 'account_get',
        method: :get,
        url: '/accounts/:account_id'
      )

      define_action(
        name: 'account_delete',
        method: :delete,
        url: '/accounts/:account_id'
      )

      define_action(
        name: 'account_options_update',
        method: :patch,
        url: '/accounts/:account_id/options',
        permitted: %i[share_rc room_connectors share_mc meeting_connectors pay_mode]
      )

      define_action(
        name: 'account_settings_get',
        method: :get,
        url: '/accounts/:account_id/settings',
        permitted: :option
      )

      define_action(
        name: 'account_settings_update',
        method: :patch,
        url: '/accounts/:account_id/settings',
        permitted: [:option, Zoom::Constants::Account::Settings::PERMITTED_KEYS]
      )

      define_action(
        name: 'account_managed_domains',
        method: :get,
        url: '/accounts/:account_id/managed_domains'
      )

      define_action(
        name: 'account_get_locked_settings',
        method: :get,
        url: '/accounts/:account_id/lock_settings'
      )

      define_action(
        name: 'account_trusted_domains',
        method: :get,
        url: '/accounts/:account_id/trusted_domains'
      )
    end
  end
end
