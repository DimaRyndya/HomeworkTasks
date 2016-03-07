class Petition < ActiveRecord::Base
  #attr_accessible :name, :description, :author

  validates :name, :description, presence: true
end
