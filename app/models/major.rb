class Major < ActiveRecord::Base
  
  # ASSOCIATIONS
  has_and_belongs_to_many :users 
  has_and_belongs_to_many :events

  attr_accessible :name

  # VALIDATIONS
  validates :name, presence: true, allow_blank: false, length: { maximum: 50 }

end
