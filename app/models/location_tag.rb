# Primary Author: Jonathan Allen (jallen01)
class LocationTag < ActiveRecord::Base

  # Attributes
  # ----------

  belongs_to :location
  belongs_to :tag


  # Validations
  # -----------

  # Check that tag user and location user are the same
  validates :same_user
  def same_user
    errors[:base] << "tag user and location user are not the same" unless tag.user == location.user
  end
end
