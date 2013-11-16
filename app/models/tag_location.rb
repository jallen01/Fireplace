# Primary Author: Jonathan Allen (jallen01)
class TagLocation < ActiveRecord::Base

  # Attributes
  # ----------

  belongs_to :location
  belongs_to :tag
  
end
