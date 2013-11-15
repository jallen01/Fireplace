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

  FIRST_NAME_MAX_LENGTH = 10
  validates :first_name, presence: true, length: { maximum: User::FIRST_NAME_MAX_LENGTH }

  LAST_NAME_MAX_LENGTH = 10
  validates :last_name, presence: true, length: { maximum: User::LAST_NAME_MAX_LENGTH }

  # Add special "All Locations" to locations list.
  after_create { self.add_location(Location::ALL_LOCATIONS_NAME, {}) }


  # Methods
  # -------

  def add_location(name, address_hash)
    return self.locations.create(name: name, address_hash: address_hash)
  end

  def include_location(location)
    return self.locations.exists?(location)
  end

  def add_task(title, content)
    return self.tasks.create(title: title, content: content)
  end

  def include_task(task)
    return self.tasks.exists?(task)
  end

  POLICIES = [:only_important, :show_long_lasting, :today, :tomorrow, :week]
  def update_policies(policies)
    policies.each do |k, v|
      if (POLICIES.include?(k.to_sym))
        session[k.to_sym] = !!v # Ensure that value is boolean
      end
    end
  end
end
