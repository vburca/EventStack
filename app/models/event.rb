class Event < ActiveRecord::Base

  # ASSOCIATIONS

  belongs_to :creator, class_name: 'User', inverse_of: :created_events
  has_many :comments, inverse_of: :event

  # I want to call these users -> 'voters' and, the events that they voted on 'voted_events'
  # How should I change the migration and thesem models?
  # is this the right way of doing it?
  # also, in the intermediary relationship, I get the IDs of the :voters?
  
  # has_and_belongs_to_many :voters, class_name: 'User'
  has_and_belongs_to_many :users

  has_and_belongs_to_many :majors, :interests

  attr_accessible :description, :end_datetime, :food_provided, :location, :name, :start_datetime

  # VALIDATIONS

  validates :name, presence: true, allow_blank: false, length: { maximum: 20 }
  validates :description, presence: true, allow_blank: false, length: { maximum: 800 }

  # How to validate these datetimes?
  validates :start_datetime, presence: true, allow_blank: false
  validates :end_datetime, presence: true, allow_blank: false
  validates :string, presence: true, allow_blank: false

end
