# frozen_string_literal: true

module Zoom
  class Params < SimpleDelegator
    def initialize(parameters = {})
      @parameters = parameters
      super
    end

    def require(*keys)
      missing_keys = find_missing_keys(keys.flatten)
      return self.class.new(except(keys)) if missing_keys.empty?
      raise Zoom::ParameterMissing, missing_keys.to_s
    end

    def require_one_of(*keys)
      required_keys = keys
      keys = find_matching_keys(keys.flatten)
      unless keys.any?
        message = required_keys.length > 1 ? "You are missing atleast one of #{required_keys}" : required_keys
        raise Zoom::ParameterMissing, message
      end
    end

    def permit(*filters)
      permitted_keys = filters.flatten.each_with_object([]) do |filter, array|
                         case filter
                         when Symbol, String
                           array << filter
                         when Hash
                           array << hash_filter(filter)
                         end
                       end
      non_permitted_params = @parameters.keys - permitted_keys.flatten
      raise Zoom::ParameterNotPermitted, non_permitted_params.to_s unless non_permitted_params.empty?
    end

    def except(*keys)
      dup.except!(keys.flatten)
    end

    def except!(keys)
      keys.each { |key| delete(key) }
      self
    end

    EMPTY_ARRAY = [].freeze
    EMPTY_HASH  = {}.freeze

    def hash_filter(filter)
      # Slicing filters out non-declared keys.
      slice(*filter.keys).each do |key, value|
        next unless value
        next unless key? key
        next if filter[key] == EMPTY_ARRAY
        next if filter[key] == EMPTY_HASH
        # Declaration { user: :name } or { user: [:name, :age, { address: ... }] }.
        self.class.new(value).permit(filter[key])
      end
      filter.keys
    end

    def find_matching_keys(keys)
      keys.flatten.each_with_object([]) do |key, array|
        array << key if self[key]
      end
    end

    def find_missing_keys(keys)
      keys.each_with_object([]) do |k, array|
        array << k if self[k].nil?
      end
    end

    def permit_value(key, values)
      value = @parameters[key]
      unless values.include?(value)
        raise Zoom::ParameterValueNotPermitted, "#{key}: #{value}"
      end
    end
  end
end
