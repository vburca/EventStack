class User < ActiveRecord::Base

  # ASSOCIATIONS

  # should I use the plural / singular ??? 
  has_many :comments, inverse_of: :user
  has_many :created_events, class_name: 'Event', inverse_of: :creator
  
  # has_and_belongs_to_many :voted_events, class_name: 'Event'
  has_and_belongs_to_many :events

  has_and_belongs_to_many :majors, :interests

  attr_accessible :date_of_birth, :first_name, :last_name, :major, :nickname, :sex

  # VALIDATIONS

  validates :nickname, length: { maximum: 20 }
  validates :first_name, allow_blank: false, presence: true
  validates :last_name, allow_blank: false, presence: true

  # How would I validate DATE? 
  # I am thinking of using the 'validates_timeliness' gem
  # https://github.com/adzap/validates_timeliness

  # validates :date_of_birth, allow_blank: true

end
