# frozen_string_literal: true

module Zoom
  module Actions
    module Billing
      def billing_get(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:account_id)
        Utils.parse_response self.class.get("/accounts/#{params[:account_id]}/billing", headers: request_headers)
      end

      def billing_update(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:account_id).permit(%i[first_name last_name email phone_number address apt city state zip country])
        Utils.parse_response self.class.patch("/accounts/#{params[:account_id]}/billing", body: params.except(:account_id).to_json, headers: request_headers)
      end

      def billing_plans_list(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:account_id)
        Utils.parse_response self.class.get("/accounts/#{params[:account_id]}/plans", headers: request_headers)
      end

      def billing_plans_usage(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:account_id)
        Utils.parse_response self.class.get("/accounts/#{params[:account_id]}/plans/usage", headers: request_headers)
      end

      def billing_plans_subscribe(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        # TODO: Move to constants and do some data validation
        params.require(:account_id, contact: %i[first_name last_name email phone_number address city state zip country], plan_base: %i[type hosts]).permit(:plan_recording, contact: [:apt], plan_zoom_rooms: %i[type hosts], plan_room_connector: %i[type hosts], plan_large_meeting: [], plan_webinar: [], plan_audio: %i[type tollfree_countries premium_countries callout_countries ddi_numbers], plan_phone: { plan_base: %i[type hosts], plan_calling: [], plan_number: [] })
        Utils.parse_response self.class.post("/accounts/#{params[:account_id]}/plans", body: params.except(:account_id).to_json, headers: request_headers)
      end
    end
  end
end