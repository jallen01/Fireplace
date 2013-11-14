class Tag < ActiveRecord::Base
  serialize :time_data
  serialize :

  has_and_belongs_to_many :child_tags
  has_and_belongs_to_many :parent_tags
end
