# Primary Author: Jonathan Allen (jallen01)
class User < ActiveRecord::Base

  # Constants
  # ---------

  FIRST_NAME_MAX_LENGTH = 10
  LAST_NAME_MAX_LENGTH = 10

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


  # Methods
  # -------

  def add_time_range(name)
    TagTimeRange.create(user: self, name: name)
  end

  def add_day_range(name)
    TagDayRange.create(user: self, name: name)
  end

  def add_tag(name)
    Tag.create(user: self, name: name)
  end

  def add_location(name, address_hash)
    Location.create(user: self, name: name, address_hash: address_hash)
  end

  def add_task(title, content)
    Task.create(user: self, title: title, content: content)
  end

  def get_tasks(time_frame, policies, location)
    time = SimpleTime.new(Time.now.hour, Time.now.min)
    day = SimpleDay.new(Time.now.wday)
    date = Date.today

    case time_frame
    when :today
      time = nil
      day = day.succ
      location = nil
    when :tomorrow
      time = nil
      day = day.succ.succ
      location = nil
      date += 1
    when :week
      time = nil
      date += 7
      location = nil
    else
      # :now or nil
      time = SimpleTime.new(Time.now.hour, Time.now.min)
      day = SimpleDay.new(Time.now.wday)
    end

    relevant_tasks = self.tasks
    
    if policies
      relevant_tasks = relevant_tasks.where(important: true) if policies[:show_only_important]
      relevant_tasks = relevant_tasks.where(long_lasting: [false, nil]) unless policies[:show_long_lasting]
    end

    relevant_tasks.to_a.select { |task| task.relevant?(date, time, day, location) }
  end


  # Authentication
  # --------------
  
  def User.new_remember_token
      SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
      Digest::SHA1.hexdigest(token.to_s)
  end 

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
