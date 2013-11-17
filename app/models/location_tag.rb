# Primary Author: Jonathan Allen (jallen01)

# Join table for adding locations to tags.
class LocationTag < ActiveRecord::Base

  # Attributes
  # ----------

  belongs_to :location
  belongs_to :tag
  
end
