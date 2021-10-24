# frozen_string_literal: true

module Zoom
  module Actions
    module Groups
      def groups_list(*_args)
        Utils.parse_response self.class.get('/groups', headers: request_headers)
      end

      def group_create(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.permit(%i[name])
        Utils.parse_response self.class.post("/groups", body: params, headers: request_headers)
      end

      def group_update(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:group_id).permit(%i[name])
        Utils.parse_response self.class.patch("/groups/#{params[:group_id]}", body: params.except(:group_id).to_json, headers: request_headers)
      end

      def groups_get(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:group_id)
        Utils.parse_response self.class.get("/groups/#{params[:group_id]}", headers: request_headers)
      end
    end
  end
end