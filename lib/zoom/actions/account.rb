# frozen_string_literal: true

module Zoom
  module Actions
    module Account
      def account_list(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.permit(:page_size, :page_number)
        Utils.parse_response self.class.get("/accounts", query: params, headers: request_headers)
      end

      def account_create(*args)
        # TODO: implement accounts_create
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'accounts_create is not yet implemented'
      end

      def account_get(*args)
        # TODO: implement account_get
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'account_get is not yet implemented'
      end

      def account_delete(*args)
        # TODO: implement account_delete
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'account_delete is not yet implemented'
      end

      def account_options_update(*args)
        # TODO: implement account_options_update
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'account_options_update is not yet implemented'
      end

      def account_settings_get(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:id)
        Utils.parse_response self.class.get("/accounts/#{params[:id]}/settings", query: params.except(:id), headers: request_headers)
      end

      def account_settings_update(*args)
        # TODO: implement account_settings_update
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'account_settings_update is not yet implemented'
      end

      # Billing related API Endpoints

      def account_billing_get(*args)
        # TODO: implement account_billing_get
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'account_billing_get is not yet implemented'
      end

      def account_billing_update(*args)
        # TODO: implement account_billing_update
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'account_billing_update is not yet implemented'
      end

      def account_plans_list(*args)
        # TODO: implement account_plans_list
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'account_plans_list is not yet implemented'
      end
    end
  end
end