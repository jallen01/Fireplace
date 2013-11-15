# Primary Author: Jonathan Allen (jallen01)
class TagRelation < ActiveRecord::Base

  # Attributes
  # ----------

  belongs_to :parent_tag, class_name: "Tag"
  belongs_to :child_tag, class_name: "Tag"


  # Validations
  # -----------

  validates :parent_tag, existance: true
  validates :child_tag, existance: true

  # Check that parent tag user and child tag user are the same
  validates :same_user
  def same_user
    errors[:base] << "parent tag user and child tag user are not the same" unless parent_tag.user == child_tag.user
  end
end
