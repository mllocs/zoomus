# frozen_string_literal: true

module Zoom
  module Actions
    module Roles
      def roles_list(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        Utils.parse_response self.class.get("/roles", query: params, headers: request_headers)
      end

      def roles_create(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:name).permit(%i[description privileges])
        Utils.parse_response self.class.post("/roles", body: params, headers: request_headers)
      end

      def roles_members(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:role_id)
        Utils.parse_response self.class.get("/roles/#{params[:role_id]}/members", headers: request_headers)
      end

      def roles_assign(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(%i[role_id members])
        Utils.parse_response self.class.post("/roles/#{params[:role_id]}/members", body: params.except(:role_id), headers: request_headers)
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

      def roles_update(*args)
        # params = Zoom::Params.new(Utils.extract_options!(args))
        raise Zoom::NotImplemented, 'roles_update is not yet implemented'
      end

      def roles_delete(*args)
        # params = Zoom::Params.new(Utils.extract_options!(args))
        raise Zoom::NotImplemented, 'roles_delete is not yet implemented'
      end
    end
  end
end
