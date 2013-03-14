class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable

  # ASSOCIATIONS
  has_many :created_events, class_name: 'Event', inverse_of: :creator
  has_and_belongs_to_many :voted_events, class_name: 'Event', join_table: :votes, foreign_key: :voter_id, association_foreign_key: :voted_event_id
  has_and_belongs_to_many :majors
  
  attr_accessible :date_of_birth, :first_name, :last_name, :username, :sex, :email, 
                  :password, :password_confirmation

  # VALIDATIONS
  validates :username, length: { maximum: 20 }
  validates :first_name, allow_blank: false, presence: true
  validates :last_name, allow_blank: false, presence: true
  validates :email, allow_blank: false, presence: true
  # email validation -> replace this with the Mail gem later.
  validates_format_of :email, :with => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i

  # TODO: Date validations
end
