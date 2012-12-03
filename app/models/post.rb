class Post < ActiveRecord::Base
  attr_accessible :name, :content, :page_id
  belongs_to :page
  belongs_to :user
  validates_presence_of :content

  default_scope { where(company_id: Company.current_id) }
  default_scope { order('created_at DESC') }
end
