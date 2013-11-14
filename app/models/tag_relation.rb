class TagRelation < ActiveRecord::Base
  belongs_to :parent_tag, class_name: "Tag"
  belongs_to :child_tag, class_name: "Tag"
end
