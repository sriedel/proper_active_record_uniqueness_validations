class Thing < ActiveRecord::Base
  attr_accessible :name, :some_id, :description

  private
  def create_or_update
    super
  rescue ActiveRecord::RecordNotUnique => e
    logger.warn "Caught #{e.message}!"
    return false
  end
end
