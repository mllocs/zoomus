# frozen_string_literal: true

module Zoom
  module Actions
    module Roles
      def roles_list(*_args)
        Utils.parse_response self.class.get("/roles", headers: request_headers)
      end

      def roles_create(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:name).permit(%i[description privileges])
        Utils.parse_response self.class.post("/roles", body: params.to_json, headers: request_headers)
      end

      def roles_members(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:role_id)
        Utils.parse_response self.class.get("/roles/#{params[:role_id]}/members", headers: request_headers)
      end

      def roles_assign(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(%i[role_id members])
        Utils.parse_response self.class.post("/roles/#{params[:role_id]}/members", body: params.except(:role_id).to_json, headers: request_headers)
      end

      def roles_unassign(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(%i[role_id member_id])
        Utils.parse_response self.class.delete("/roles/#{params[:role_id]}/members/#{params[:member_id]}", headers: request_headers)
      end

      def roles_get(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:role_id)
        Utils.parse_response self.class.get("/roles/#{params[:role_id]}", headers: request_headers)
      end
    end
  end
end
