class TagTimeRange < ActiveRecord::Base

  # Attributes
  # ----------

  belongs_to :time_range
  belongs_to :tag

end
