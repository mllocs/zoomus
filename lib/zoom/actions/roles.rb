# frozen_string_literal: true

module Zoom
  module Actions
    module Roles
      def roles_list(*args)
        options = Params.new(Utils.extract_options!(args))
        Utils.parse_response self.class.get("/roles", query: options, headers: request_headers)
      end

      def roles_create(*args)
        options = Params.new(Utils.extract_options!(args))
        options.require(:name).permit(%i[description privileges])
        Utils.parse_response self.class.post("/roles", body: options, headers: request_headers)
      end

      def roles_members(*args)
        options = Params.new(Utils.extract_options!(args))
        options.require(:role_id)
        Utils.parse_response self.class.get("/roles/#{options[:role_id]}/members", headers: request_headers)
      end

      def roles_assign(*args)
        options = Params.new(Utils.extract_options!(args))
        options.require(%i[role_id members])
        Utils.parse_response self.class.post("/roles/#{options[:role_id]}/members", body: options.except(:role_id), headers: request_headers)
      end

      def roles_unassign(*args)
        options = Params.new(Utils.extract_options!(args))
        options.require(%i[role_id member_id])
        Utils.parse_response self.class.delete("/roles/#{options[:role_id]}/members/#{options[:member_id]}", headers: request_headers)
      end

      def roles_get(*args)
        options = Params.new(Utils.extract_options!(args))
        options.require(:role_id)
        Utils.parse_response self.class.get("/roles/#{options[:role_id]}", headers: request_headers)
      end

      def roles_update(*args)
        raise Zoom::NotImplemented, 'roles_update is not yet implemented'
      end

      def roles_delete(*args)
        raise Zoom::NotImplemented, 'roles_delete is not yet implemented'
      end
    end
  end
end
