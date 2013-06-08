class Thing < ActiveRecord::Base
  include ProperUniquenessValidation
  attr_accessible :name, :some_id, :description

end
