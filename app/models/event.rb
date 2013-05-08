class Event < ActiveRecord::Base

  searchable do 
    text :name, :boost => 5
    text :description, :location
    text :start_date, :when_tokenizer
  end

  def start_date
    start_datetime.strftime("%a %A %d %B %Y") + " " + start_datetime.to_date.to_s
  end

  def when_tokenizer
    WEEKEND = ["Fri", "Sat", "Sun"]

    when_token = ""
    
    when_token += "today " if start_datetime.to_date == Date.today
    when_token += "tomorrow " if start_datetime.to_date + 1 == Date.tomorrow
    when_token += "weekend "  if WEEKEND.include? start_datetime.strftime("%a")
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
