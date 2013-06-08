module ProperUniquenessValidation
  UNIQUE_INDEX_VIOLATION_RE = %r{duplicate key value violates unique constraint "([^"]+)"}

  def self.included( base )
    base.extend ClassMethods
  end

  module ClassMethods
    def uniqueness_error_attribute_for( index_name, attribute_name ) 
      @_uniqueness_index_attribute_mapping ||= {}
      @_uniqueness_index_attribute_mapping[index_name.to_sym] = attribute_name.to_sym
    end

    def _uniqueness_error_attribute_for( index_name )
      @_uniqueness_index_attribute_mapping[index_name.to_sym]
    end
  end

  private
  def create_or_update
    super
  rescue ActiveRecord::RecordNotUnique => e
    e.message.match( UNIQUE_INDEX_VIOLATION_RE ) do |match|
      attribute = self.class._uniqueness_error_attribute_for( match[1] )

      if !attribute
        #TODO: Test this
        logger.warn "Caught uniqueness exceptions but index '#{match[1]}' was not registered\nAdd a uniquness_error_attribute_for clause to your model #{self.class}!"
        raise
      end

      self.errors.add( attribute, :taken, :value => self.send( attribute ) )
    end

    return false
  end
end
