class User < ActiveRecord::Base

  # Attributes
  # ----------

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
  validates :name, presence: true, length: { maximum: User::NAME_MAX_LENGTH }

  # Make sure that owner is a group user
  after_save { self.add_location("all_locations", {}) }, if: :locations_changed?


  # Methods
  # -------

  def add_location(name, address_hash)
    if 
      self.locations.create_with(address_hash: address_hash).find_or_create_by(name: name)
  end

  def get_location(name)

  end

  def remove_location(name)
    Location
  end

  def include_location?(name)
    return self.locations.find_by(:name)
  end
end
