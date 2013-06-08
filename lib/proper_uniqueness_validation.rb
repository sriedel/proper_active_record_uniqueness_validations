module ProperUniquenessValidation
  UNIQUE_INDEX_VIOLATION_RE = %r{^DETAIL:\s+Key \((.*?)\)=\((.*?)\) already exists.$}m

  private
  def create_or_update
    super
  rescue ActiveRecord::RecordNotUnique => e
    logger.warn "Caught #{e.message}!"
    e.message.match( UNIQUE_INDEX_VIOLATION_RE ) do |match|
      error_attribute = match[1].split(',', 2).first

      self.errors.add( error_attribute.to_sym, :taken, :value => self.send( error_attribute.to_sym ) )
    end

    return false
  end
end
