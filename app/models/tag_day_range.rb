class TagDayRange < ActiveRecord::Base

  # Attributes
  # ----------

  belongs_to :day_range
  belongs_to :tag

end
