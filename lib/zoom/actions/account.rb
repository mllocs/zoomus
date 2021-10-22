# frozen_string_literal: true

module Zoom
  module Actions
    module Account
      extend Zoom::Actions

      get_action('account_list', '/accounts',
        permit: %i[page_size page_number]
      )

      post_action('account_create', '/accounts',
        require: %i[first_name last_name email password],
        permit: { options: %i[share_rc room_connectors share_mc meeting_connectors pay_mode] }
      )

      get_action('account_get', '/accounts/:account_id')

      delete_action('account_delete', '/accounts/:account_id')

      patch_action('account_options_update', '/accounts/:account_id/options',
        permit: %i[share_rc room_connectors share_mc meeting_connectors pay_mode]
      )

      get_action('account_settings_get', '/accounts/:account_id/settings',
        permit: :option
      )

      patch_action('account_settings_update', '/accounts/:account_id/settings',
        permit: [:option, Zoom::Constants::Account::Settings::PERMITTED_KEYS]
      )

      get_action('account_managed_domains', '/accounts/:account_id/managed_domains')

      get_action('account_get_locked_settings', '/accounts/:account_id/lock_settings')

      get_action('account_trusted_domains', '/accounts/:account_id/trusted_domains')
    end
  end
end
