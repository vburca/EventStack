class Comment < ActiveRecord::Base
  
  # ASSOCIATIONS

  # should it be plural 'comments' ???
  belongs_to :user, inverse_of: :comments
  belongs_to :event, inverse_of: :comments
  attr_accessible :content

  # VALIDATIONS

  validates :content, presence: true, allow_blank: false, length: { maximum: 500 }
end
