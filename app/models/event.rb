class Event < ActiveRecord::Base

  searchable do 
    text :name, :description, :location
    time :start_datetime, :end_datetime
  end

  # ASSOCIATIONS
  belongs_to :creator, class_name: 'User', inverse_of: :created_events
  has_and_belongs_to_many :voters, class_name: 'User', join_table: :votes, foreign_key: :voted_event_id, association_foreign_key: :voter_id
  has_and_belongs_to_many :majors
  attr_accessible :description, :end_datetime, :food_provided, :location, :name, :start_datetime

  # VALIDATIONS
  validates :name, presence: true, allow_blank: false, length: { maximum: 40 }
  validates :description, presence: true, allow_blank: false, length: { maximum: 800 }

  # TODO: datetime validations
  # validates :start_datetime, presence: true, allow_blank: false
  # validates :end_datetime, presence: true, allow_blank: false
  # validates :string, presence: true, allow_blank: false

end
