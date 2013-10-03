module ProperUniquenessValidation
  def self.included( base )
    base.extend ClassMethods
  end

  def self.extract_index_name_from_exception( connection, exception )
    case connection
      when ActiveRecord::ConnectionAdapters::PostgreSQLAdapter
        extract_index_name_from_postgres_exception( exception )

      else raise exception
    end
  end

  def self.extract_index_name_from_postgres_exception( exception )
    match = exception.original_exception.result.error_field( PGresult::PG_DIAG_MESSAGE_PRIMARY ).match(/"([^"]+)"/ )
    match[1]
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
    klass = self.class
    raise unless klass.respond_to?( :connection )

    index_name = ProperUniquenessValidation.extract_index_name_from_exception( klass.connection, e )
    attribute = klass._uniqueness_error_attribute_for( index_name )

    if !attribute
      #TODO: Test this
      logger.warn "Caught uniqueness exceptions but index '#{index_name}' was not registered\nAdd a \"uniqueness_error_attribute_for 'index_name', :error_attribute_name\"\nclause to your model '#{klass}'!"
      raise
    end

    self.errors.add( attribute, :taken, :value => self.send( attribute ) )

    return false
  end
end
