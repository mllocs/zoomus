# frozen_string_literal: true

module Zoom
  module Actions
    module Account
      def account_list(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.permit(%i[page_size page_number])
        Utils.parse_response self.class.get('/accounts', query: params, headers: request_headers)
      end

      def account_create(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(%i[first_name last_name email password]).permit(options: %i[share_rc room_connectors share_mc meeting_connectors pay_mode])
        Utils.parse_response self.class.post('/accounts', body: params.to_json, headers: request_headers)
      end

      def account_get(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:account_id)
        Utils.parse_response self.class.get("/accounts/#{params[:account_id]}", headers: request_headers)
      end

      def account_delete(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:account_id)
        Utils.parse_response self.class.delete("/accounts/#{params[:account_id]}", headers: request_headers)
      end

      def account_options_update(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:account_id).permit(%i[share_rc room_connectors share_mc meeting_connectors pay_mode])
        Utils.parse_response self.class.patch("/accounts/#{params[:account_id]}/options", body: params.except(:account_id).to_json, headers: request_headers)
      end

      def account_settings_get(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:account_id).permit(:option)
        Utils.parse_response self.class.get("/accounts/#{params[:account_id]}/settings", query: params.except(:account_id), headers: request_headers)
      end

      def account_settings_update(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:account_id).permit(:option, Zoom::Constants::Account::Settings::PERMITTED_KEYS)
        params.permit_value(:option, Zoom::Constants::Account::Settings::PERMITTED_OPTIONS)
        Utils.parse_response self.class.patch("/accounts/#{params[:account_id]}/settings", query: params.slice(:option), body: params.except(%i[account_id option]).to_json, headers: request_headers)
      end

      def account_managed_domains(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:account_id)
        Utils.parse_response self.class.get("/accounts/#{params[:account_id]}/managed_domains", headers: request_headers)
      end

      def account_get_locked_settings(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:account_id)
        Utils.parse_response self.class.get("/accounts/#{params[:account_id]}/lock_settings", headers: request_headers)
      end

      def account_trusted_domains(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:account_id)
        Utils.parse_response self.class.get("/accounts/#{params[:account_id]}/trusted_domains", headers: request_headers)
      end
    end
  end
end
