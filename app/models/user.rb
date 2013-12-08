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

  # NOTE ABOUT PARENTS BEING NIL:
  # 
  # If a tag has a parent task, it means that tag is a hidden tag because the parent task had custom details.
  # If a day/time range has a parent tag, it means that day/time range is a hidden day/time range because
  #   the parent tag had custom details.
  # Hidden tags are an implementation detail to which the user is not aware, they are not part of the user's
  #   tag list, which is why get_tags only returns tags without a parent task (parent_task_id: nil).
  # Same idea for hidden time/day ranges.

  def create_time_range(name)
    TimeRange.create(user: self, name: name)
  end

  def get_time_ranges
    self.time_ranges.where(parent_tag_id: nil)
  end

  def create_day_range(name)
    DayRange.create(user: self, name: name)
  end

  def get_day_ranges
    self.day_ranges.where(parent_tag_id: nil)
  end

  def create_tag(name)
    Tag.create(user: self, name: name)
  end

  def get_tags
    self.tags.where(parent_task_id: nil)
  end

  def create_location(params)
    Location.create(user: self, name: params[:name], address_hash: params[:address_hash])
  end

  def get_locations
    self.locations
  end

  def closest_location(userLat, userLong)
    closest_location_distance = 1000 #closest location 
    closest_location = ''
    threshold = 1 #one mile
    current_user.get_locations.each do |location|
      distance = Location.calc_distance([location.latitude, location.longitude], [userLat, userLong])
      if distance <= closest_location_distance #if within a mile of current location.
        closest_location_distance = distance
        closest_location = location
      end
    end

    if closest_location_distance <= threshold
      return closest_location
    else
      return nil
    end

  end

  def create_task(title, content)
    Task.create(user: self, title: title, content: content)
  end

  def get_tasks
    self.tasks
  end

  def get_context(time_frame, utc_offset, location)
    context = {}

    utc_offset = 0 if utc_offset.nil?
    time = Time.now.getlocal(utc_offset)

    context[:date] = Date.parse(time.to_s)
    context[:time] = SimpleTime.new(time.hour, time.min)
    context[:day] = SimpleDay.new(time.wday)
    context[:location] = location

    case time_frame
    when :today
      context[:time] = nil
      context[:location] = nil
    when :tomorrow
      context[:time] = nil
      context[:day] = context[:day].succ
      context[:location] = nil
      context[:date] += 1
    when :week
      context[:time] = nil
      context[:day] = nil
      context[:location] = nil
    else
      # :now or nil
      context[:time] = SimpleTime.new(Time.now.hour, Time.now.min)
      context[:day] = SimpleDay.new(Time.now.wday)
    end

    context
  end
end
