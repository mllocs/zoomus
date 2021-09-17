# frozen_string_literal: true

module Zoom
  module Actions
    module Account
      extend Zoom::Actions

      def self.included(base)
        define_action(
          'account_list',
          :get,
          '/accounts',
          permitted:  %i[page_size page_number]
        )

        define_action(
          'account_create',
          :post,
          '/accounts',
          required:   %i[first_name last_name email password],
          permitted:  { options: %i[share_rc room_connectors share_mc meeting_connectors pay_mode] }
        )

        define_action(
          'account_get',
          :get,
          '/accounts/:account_id',
          required: :account_id
        )

        define_action(
          'account_delete',
          :delete,
          '/accounts/:account_id',
          required: :account_id
        )

        define_action(
          'account_options_update',
          :patch,
          '/accounts/:account_id/options',
          required:   :account_id,
          permitted:  %i[share_rc room_connectors share_mc meeting_connectors pay_mode]
        )

        define_action(
          'account_settings_get',
          :get,
          '/accounts/:account_id/settings',
          required:   :account_id,
          permitted:  :option
        )

        define_action(
          'account_settings_update',
          :patch,
          '/accounts/:account_id/settings',
          required:   :account_id,
          permitted:  [:option, Zoom::Constants::Account::Settings::PERMITTED_KEYS]
        )

        define_action(
          'account_managed_domains',
          :get,
          '/accounts/:account_id/managed_domains',
          required: :account_id
        )

        define_action(
          'account_get_locked_settings',
          :get,
          '/accounts/:account_id/lock_settings',
          required: :account_id
        )

        define_action(
          'account_trusted_domains',
          :get,
          '/accounts/:account_id/trusted_domains',
          required: :account_id
        )
      end
    end
  end
end
