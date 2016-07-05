class AmplitudeAPI
  # AmplitudeAPI::Event
  class Event
    # @!attribute [ rw ] user_id
    #   @return [ String ] the user_id to be sent to Amplitude
    attr_accessor :user_id
    # @!attribute [ rw ] event_type
    #   @return [ String ] the event_type to be sent to Amplitude
    attr_accessor :event_type
    # @!attribute [ rw ] event_properties
    #   @return [ String ] the event_properties to be attached to the Amplitude Event
    attr_accessor :event_properties
    # @!attribute [ rw ] user_properties
    #   @return [ String ] the user_properties to be passed for the user
    attr_accessor :user_properties
    # @!attribute [ rw ] time
    #   @return [ Time ] Time that the event occurred (defaults to now)
    attr_accessor :time
    # @!attribute [ rw ] ip
    #   @return [ String ] IP address of the user
    attr_accessor :ip
    # @!attribute [ rw ] price
    #   @return [ Float ] Price of the item purchased
    attr_accessor :price
    # @!attribute [ rw ] quantity
    #   @return [ Integer ] Quantity of the item purchased
    attr_accessor :quantity
    # @!attribute [ rw ] revenueType
    #   @return [ String ] Type of revenue
    attr_accessor :revenueType
    # @!attribute [ rw ] productId
    #   @return [ String ] An identifier for the product
    attr_accessor :productId

    # Create a new Event
    #
    # @param [ String ] user_id a user_id to associate with the event
    # @param [ String ] event_type a name for the event
    # @param [ Hash ] event_properties various properties to attach to the event
    # @param [ Time ] Time that the event occurred (defaults to now)
    # @param [ String ] IP address of the user
    def initialize(options = {})
      self.user_id = options.fetch(:user_id, '')
      self.event_type = options.fetch(:event_type, '')
      self.event_properties = options.fetch(:event_properties, {})
      self.user_properties = options.fetch(:user_properties, {})
      self.time = options[:time]
      self.ip = options.fetch(:ip, '')
      self.price = options[:price]
      self.quantity = options[:quantity]
      self.revenueType = options[:revenueType]
      self.productId = options[:productId]
    end

    def user_id=(value)
      @user_id =
        if value.respond_to?(:id)
          value.id
        else
          value || AmplitudeAPI::USER_WITH_NO_ACCOUNT
        end
    end

    # @return [ Hash ] A serialized Event
    #
    # Used for serialization and comparison
    def to_hash
      serialized_event = {}
      serialized_event[:event_type] = event_type
      serialized_event[:user_id] = user_id
      serialized_event[:event_properties] = event_properties
      serialized_event[:user_properties] = user_properties
      serialized_event[:time] = formatted_time if time
      serialized_event[:ip] = ip if ip
      serialized_event[:price] = price if price
      serialized_event[:quantity] = quantity if quantity
      serialized_event[:revenueType] = revenueType if revenueType
      serialized_event[:productId] = productId if productId
      serialized_event
    end

    # @return [ true, false ]
    #
    # Compares +to_hash+ for equality
    def ==(other)
      if other.respond_to?(:to_hash)
        to_hash == other.to_hash
      else
        false
      end
    end

    private

    def formatted_time
      time.to_i * 1_000
    end
  end
end
