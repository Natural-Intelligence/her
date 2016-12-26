module Her
  module Errors
    class PathError < StandardError
      attr_reader :missing_parameter

      def initialize(message, missing_parameter=nil)
        super(message)
        @missing_parameter = missing_parameter
      end
    end

    class AssociationUnknownError < StandardError
    end

    class ParseError < StandardError
    end

    class ResourceInvalid < StandardError
      attr_reader :resource
      def initialize(resource)
        @resource = resource
        errors = []
        if(@resource.respond_to? :response_errors)
          @resource.response_errors.each_pair do |key, value|
            errors.push "#{key}: #{value.join(", ")}"
          end
        end
        super("Remote validation failed: #{errors.join("; ")}")
      end
    end
  end
end
