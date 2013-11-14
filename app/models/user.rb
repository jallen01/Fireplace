class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :locations

  def full_name
    [first_name, last_name].join(' ')
  end

  def full_name=(name)
    split = name.split(' ', 2)
    self.first_name = split.first
    self.last_name = split.last
  end

  # Validations
  # -----------

  NAME_MAX_LENGTH = 20
  validates :name, presence: true, length: { maximum: Group::NAME_MAX_LENGTH }, uniqueness: { scope: :owner }

  # Capitalize first letter of each word in name
  before_validation { self.name = self.name.downcase.split.map(&:capitalize).join(' ') }

  # Make sure that owner is a group user
  after_save { self.add_user(self.owner) }


  # Methods
  # -------

  def add_location

  end

  def remove_location
    Location
  end
end
