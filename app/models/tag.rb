require 'date'
require 'set'

class Tag < ActiveRecord::Base
  serialize :time_set, class_name: :TimeSet
  serialize :day_set, class_name: :Set

  has_many :location_tags
  has_many :locations, through: :location_tags

  has_many :tag_relations, foreign_key: :parent_tag_id, dependent: :destroy
  has_many :reverse_tag_relations, class_name: :TagRelation,
      foreign_key: :child_tag_id, dependent: :destroy

  has_many :child_tags, :through => :tag_relations, :source => :child_tag

  def add_time_range(start_t, end_t)
    self.time_set.add_range(start_t, end_t)
    self.save
  end

  def remove_time_range(start_t, end_t)
    self.time_set.remove_range(start_t, end_t)
    self.save
  end

  def get_discretized_time(n)

  end

  def include_time?(time)
    self.time_set.include?(time)
  end
  

  def add_day(day)
    if Date::DAYNAMES.include?(day)
      self.day_set.add(day)
      self.save
    else
      self.errors[:base] << "Invalid day"
    end
  end

  def remove_day(day)
    if Date::DAYNAMES.include?(day)
      self.day_set.delete(day)
      self.save
    else
      self.errors[:base] << "Invalid day"
    end
  end

  def include_day?(day)
    return self.days.include?(day)
  end

  def add_location(locations)
    self.locations.
  end

  def remove_location

  end

  def include_location?(location)
    self.locations.exists?(location)
  end
end
