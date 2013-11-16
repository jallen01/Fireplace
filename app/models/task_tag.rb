# Primary Author: Jonathan Allen (jallen01)
class TaskTag < ActiveRecord::Base

  # Attributes
  # ----------

  belongs_to :task
  belongs_to :tag

end
