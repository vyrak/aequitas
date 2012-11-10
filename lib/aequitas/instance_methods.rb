module Aequitas
  module InstanceMethods

    # Return validated subject
    #
    # @return [Object]
    #
    # @api private
    #
    attr_reader :subject

    # Return violation set
    #
    # @return [ViolationSet]
    #
    # @api private
    #
    attr_reader :violations

    # Test if validator is valid
    #
    # @return [true]
    #   if valid
    #
    # @return [false]
    #   otherwise
    #
    def valid?
      violations.empty?
    end

    # Return validation rules
    #
    # @return [RuleSet]
    # 
    # @api private
    #
    def rules
      self.class.validation_rules
    end

    # Retrieve the value of the given property name for the purpose of validation
    #
    # Defaults to sending the attribute name arg to the receiver and
    # using the resulting value as the attribute value for validation
    #
    # @param [Symbol] attribute_name
    #   the name of the attribute for which to retrieve
    #   the attribute value for validation.
    #
    # @return [Object]
    #   the value of the attribute identified by +attribute_name+
    #   for the purpose of validation
    #
    # @api public
    #
    def validation_attribute_value(attribute_name)
      subject.public_send(attribute_name) 
    end

  private

    # Initialize subject
    #
    # @param [Object] subject
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(subject)
      @subject = subject
      @violations = ViolationSet.new(rules.validate(self))
    end

  end
end