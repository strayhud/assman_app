class Album < ActiveRecord::Base
  has_many :assets
  attr_accessible :name
end
