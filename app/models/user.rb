class User < ActiveRecord::Base

  # Attributes
  # ----------

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :locations

  def full_name
    [first_name, last_name].compact.join(' ')
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
  DEFAULT_NAME = "All Locations"
  after_create { self.add_location(DEFAULT_NAME, {}) }


  # Methods
  # -------

  def add_location(name, address_hash)
    return self.locations.create(name: name, address_hash: address_hash)
  end

  def remove_location(location)
    location.destroy
  end

  def add_task(title, content)
    return self.tasks.create()
  end

  def remove_task(task)
    task.destroy
  end

  def include_location(location)
    return self.locations.exists?(location)
  end
end
