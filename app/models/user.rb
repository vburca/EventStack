class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable

  # ASSOCIATIONS
  has_many :created_events, class_name: 'Event', inverse_of: :creator, foreign_key: :creator_id
  has_and_belongs_to_many :voted_events, class_name: 'Event', join_table: :votes, foreign_key: :voter_id, association_foreign_key: :voted_event_id
  has_and_belongs_to_many :majors
  
  attr_accessible :date_of_birth, :first_name, :last_name, :username, :sex, :email, 
                  :password, :password_confirmation

  # VALIDATIONS
  validates :username, length: { maximum: 20 }, presence: true, uniqueness: true
  validates :first_name, allow_blank: false, presence: true
  validates :last_name, allow_blank: false, presence: true
  validates_inclusion_of :sex, in: %w( Male Female ' '), message: "can only be Male or Female"
  # email validation done through Devise
  # validates :email, allow_blank: false, presence: true
  validates_format_of :email, with: Devise.email_regexp

  # TODO: Date validations
end
