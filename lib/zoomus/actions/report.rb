module Zoomus
  module Actions
    module Report

      def report_getaccountreport(*args)
        options = Utils.extract_options!(args)
        Utils.require_params([:from, :to], options)
        Utils.process_datetime_params!([:from, :to], options)
        Utils.parse_response self.class.post("/report/getaccountreport", :query => options)
      end

      Utils.define_bang_methods(self)

    end
  end
end
