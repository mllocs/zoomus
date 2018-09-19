# frozen_string_literal: true

module Zoom
  module Actions
    module Webinar
      def webinar_list(*args)
        options = Utils.extract_options!(args)
        Utils.require_params(:user_id, options)
        Utils.process_datetime_params!(:start_time, options)
        Utils.parse_response self.class.get("/users/#{options[:user_id]}/webinars", query: options.merge(access_token: access_token))
      end

      def webinar_create(*args)
        options = Utils.extract_options!(args)
        Utils.require_params(%i[user_id topic], options)
        Utils.process_datetime_params!(:start_time, options)
        Utils.parse_response self.class.post("/users/#{options[:user_id]}/webinars", body: options.to_json, query: { access_token: access_token })
      end

      def webinar_get(*args)
        options = Utils.extract_options!(args)
        Utils.require_params([:id], options)
        Utils.parse_response self.class.get("/webinars/#{options[:id]}", query: options)
      end

      def webinar_update(*args)
        options = Utils.extract_options!(args)
        Utils.require_params([:id], options)
        Utils.process_datetime_params!(:start_time, options)
        Utils.parse_response self.class.post("/webinars/#{options[:id]}", query: options)
      end

      def webinar_delete(*args)
        options = Utils.extract_options!(args)
        Utils.require_params([:id], options)
        Utils.parse_response self.class.delete("/webinars/#{options[:id]}", query: options)
      end

      def webinar_status_update(*args)
        options = Utils.extract_options!(args)
        Utils.require_params(%i[id status], options)
        Utils.parse_response self.class.post("/webinars/#{options[:id]}/status}", query: options)
      end

      def webinar_panelists_list(*args)
        # TODO: implement webinar_panelists_list
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'webinar_panelists_list is not yet implemented'
      end

      def webinar_panelist_add(*args)
        # TODO: implement webinar_panelist_add
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'webinar_panelist_add is not yet implemented'
      end

      def webinar_panelists_delete_all(*args)
        # TODO: implement webinar_panelists_delete_all
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'webinar_panelists_delete_all is not yet implemented'
      end

      def webinar_panelist_delete(*args)
        # TODO: implement webinar_panelist_delete
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'webinar_panelist_delete is not yet implemented'
      end

      def webinar_registrants_list(*args)
        # TODO: implement webinar_registrants_list
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'webinar_registrants_list is not yet implemented'
      end

      def webinar_registrant_add(*args)
        # TODO: implement webinar_registrant_add
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'webinar_registrant_add is not yet implemented'
      end

      def webinar_registrants_status_update(*args)
        # TODO: implement webinar_registrants_status_update
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'webinar_registrants_status_update is not yet implemented'
      end

      def past_webinar_list(*args)
        # TODO: implement past_webinars_list
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'past_webinars_list is not yet implemented'
      end

      Utils.define_bang_methods(self)
    end
  end
end
