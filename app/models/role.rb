class Role < ActiveRecord::Base
  belongs_to :site
  has_many :memberships
  attr_accessible :name, :permission
end
