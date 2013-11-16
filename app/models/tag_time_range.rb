# Primary Author: Jonathan Allen (jallen01)
class TagTimeRange < ActiveRecord::Base

  # Attributes
  # ----------

  belongs_to :time_range
  belongs_to :tag

end
