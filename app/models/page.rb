class Page < ActiveRecord::Base
  belongs_to :company
  belongs_to :site
  has_many :posts, dependent: :destroy
  attr_accessible :ancestry, :content, :name, :parent_id
  has_ancestry
  acts_as_list

  default_scope { where(company_id: Company.current_id) }
  default_scope { order('position') }
end
