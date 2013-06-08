class Widget < ActiveRecord::Base
  attr_accessible :some_id, :name, :description

  validates :some_id, :uniqueness => true
  validates :name, :uniqueness => { :scope => :description }
end
