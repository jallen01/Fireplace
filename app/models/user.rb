# Primary Author: Jonathan Allen (jallen01)
class User < ActiveRecord::Base

  # Constants
  # ---------

  FIRST_NAME_MAX_LENGTH = 20
  LAST_NAME_MAX_LENGTH = 20

  MORNING_HOURS = (6...12).map { |hour| SimpleTime.new(hour, 0) }
  AFTERNOON_HOURS = (12...16).map { |hour| SimpleTime.new(hour, 0) }
  EVENING_HOURS = (16...20).map { |hour| SimpleTime.new(hour, 0) }
  NIGHT_HOURS = (20...24).to_a.concat((0...6).to_a).map { |hour| SimpleTime.new(hour, 0) }

  WEEKDAY_DAYS = (1...6).map { |day| SimpleDay.new(day) }
  WEEKEND_DAYS = [0, 6].map { |day| SimpleDay.new(day) }

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

  after_create do
    self.create_time_range("Morning").update_times(MORNING_HOURS)
    self.create_time_range("Afternoon").update_times(AFTERNOON_HOURS)
    self.create_time_range("Evening").update_times(EVENING_HOURS)
    self.create_time_range("Night").update_times(NIGHT_HOURS)

    self.create_day_range("Weekdays").update_days(WEEKDAY_DAYS)
    self.create_day_range("Weekend").update_days(WEEKEND_DAYS)
  end


  # Validations
  # -----------

  validates :first_name, presence: true, length: { maximum: User::FIRST_NAME_MAX_LENGTH }

  validates :last_name, presence: true, length: { maximum: User::LAST_NAME_MAX_LENGTH }


  # Methods
  # -------

  def create_time_range(name)
    TimeRange.create(user: self, name: name)
  end

  def get_time_ranges
    self.time_ranges.select { |time_range| !time_range.hidden? }
  end

  def create_day_range(name)
    DayRange.create(user: self, name: name)
  end

  def get_day_ranges
    self.day_ranges.select { |day_range| !day_range.hidden? }
  end

  def create_tag(name)
    Tag.create(user: self, name: name)
  end

  def get_tags
    self.tags.select { |tag| !tag.hidden? }
  end

  def create_location(name)
    Location.create(user: self, name: name, address_hash: address_hash)
  end

  def get_locations
    self.locations
  end

  def create_task(title, content)
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
end
