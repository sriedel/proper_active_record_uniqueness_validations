class Thing < ActiveRecord::Base
  include ProperUniquenessValidation
  attr_accessible :name, :some_id, :description, :unregistered

  uniqueness_error_attribute_for 'index_things_on_some_id', :some_id
  uniqueness_error_attribute_for 'index_things_on_name_and_description', :name

end
