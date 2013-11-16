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

  # Authentication
  
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


  # Validations
  # -----------

  # validates :first_name, presence: true, length: { maximum: User::FIRST_NAME_MAX_LENGTH }

  # validates :last_name, presence: true, length: { maximum: User::LAST_NAME_MAX_LENGTH }


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

  def get_tasks(time_frame, policy, location)
    time = nil
    day = nil

    case time_frame
    when :now
      time = SimpleTime.new(Time.now.hour, Time.now.min)
      day = SimpleDay.new(Time.now.wday)
    when :today
      day = SimpleDay.new(Time.now.wday).succ
      location = nil
    when :tomorrow
      day = SimpleDay.new(Time.now.wday).succ.succ
      location = nil
    end

    relevant_tasks = self.tasks
    
    if policies[:show_only_important]
      relevant_tasks = relevant_tasks.where(important: true)
    end

    unless polcies[:show_long_lasting]
      relevant_tasks = relevant_tasks.where(long_lasting: [false, nil])
    end

    relevant_tasks.to_a.select { |task| task.relevant?(time, day, location) }
  end
end
