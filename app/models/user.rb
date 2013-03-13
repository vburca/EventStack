class User < ActiveRecord::Base

  # ASSOCIATIONS

  has_many :created_events, class_name: 'Event', inverse_of: :creator
  
  has_and_belongs_to_many :voted_events, class_name: 'Event', join_table: :votes, foreign_key: :voter_id, association_foreign_key: :voted_event_id

  has_and_belongs_to_many :majors

  attr_accessible :date_of_birth, :first_name, :last_name, :nickname, :sex

  # VALIDATIONS

  validates :nickname, length: { maximum: 20 }
  validates :first_name, allow_blank: false, presence: true
  validates :last_name, allow_blank: false, presence: true

  # TODO: Date validations

end
