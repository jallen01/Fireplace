# Primary Author: Jonathan Allen (jallen01)
class User < ActiveRecord::Base

  # Constants
  # ---------

  FIRST_NAME_MAX_LENGTH = 10
  LAST_NAME_MAX_LENGTH = 10

  # Filter policies
  POLICIES = [:only_important, :show_long_lasting]

  # Filter time frame
  TIME_FRAMES = [:now, :today, :tomorrow, :week]

  # Attributes
  # ----------

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tags, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :locations, dependent: :destroy
  has_many :time_ranges, dependent: :destroy
  has_many :day_ranges, dependent: :destroy

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

  # validates :first_name, presence: true, length: { maximum: User::FIRST_NAME_MAX_LENGTH }

  # validates :last_name, presence: true, length: { maximum: User::LAST_NAME_MAX_LENGTH }

  # Add special "All Locations" to locations list.
  after_create { self.add_location(Location::DEFAULT_NAME, {}) }


  # Methods
  # -------

  def add_location(name, address_hash)
    self.locations.create(name: name, address_hash: address_hash)
  end

  def include_location?(location)
    self.locations.exists?(location)
  end

  def add_task(title, content)
    self.tasks.create(title: title, content: content)
  end

  def include_task?(task)
    self.tasks.exists?(task)
  end

  # Stores filter policies in session.
  # 'policies' must be a hash. Ignores keys not in 'POLICIES'.
  def update_policies(policies)
    policies.each do |k, v| 
      # Ensure that value is boolean with !!
      session[k] = !!v if User::POLICIES.include?(k)
    end
  end

  # Stores filter time frame in session. 
  # 'time_frame' must be in 'TIME_FRAMES'.
  def update_time_frame(time_frame)
    session[:time_frame] = time_frame if User::TIME_FRAMES.include?(time_frame)
  end

  def get_tasks
    time = nil
    day = nil
    location = nil

    case session[:time_frame]
    when :now
      time = SimpleTime.new(Time.now.hour, Time.now.min)
      day = SimpleDay.new(Time.now.wday)
      location = Location.current_location
    when :today
      day = SimpleDay.new(Time.now.wday).succ
    when :tomorrow
      day = SimpleDay.new(Time.now.wday).succ.succ
    end

    self.tasks.to_a.select { |tag| tag.include?(time, day, location) }
  end
end
