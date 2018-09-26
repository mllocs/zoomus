# frozen_string_literal: true
require 'pry'
module Zoom
  class Params < SimpleDelegator
    # delegate :keys, :key?, :has_key?, :values, :has_value?, :value?, :empty?,
    #          :include?, :as_json, :to_s, :each_key, to: :@parameters

    def initialize(parameters = {})
      @parameters = parameters
      super
    end

    def require(key)
      return key.map { |k| require(k) } if key.is_a?(Array)
      unless self[key].nil?
        new_params = @parameters.dup
        new_params.delete(key)
        return self.class.new(new_params)
      end
      raise Zoom::ParameterMissing, key
    end

    def permit(*filters)
      permitted_keys = filters.flatten.each_with_object([]) do |filter, array|
                         case filter
                         when Symbol, String
                           array << filter
                         when Hash
                           hash_filter(self.class.new, filter)
                         end
                       end
      non_permitted_params = @parameters.keys - permitted_keys
      raise Zoom::ParameterNotPermitted, non_permitted_params.to_s unless non_permitted_params.empty?
    end

    EMPTY_ARRAY = [].freeze
    EMPTY_HASH  = {}.freeze

    def hash_filter(params, filter)
      # Slicing filters out non-declared keys.
      slice(*filter.keys).each do |key, value|
        next unless value
        next unless key? key

        if filter[key] == EMPTY_ARRAY
          # Declaration { comment_ids: [] }.
          params[key] = self[key]
        elsif filter[key] == EMPTY_HASH
          # Declaration { preferences: {} }.
          params[key] = self.class.new
        else
          # Declaration { user: :name } or { user: [:name, :age, { address: ... }] }.
          params.merge!(value)
          params.permit(filter[key])
        end
      end
    end
  end
end
