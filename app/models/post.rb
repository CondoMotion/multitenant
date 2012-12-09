class Post < ActiveRecord::Base
  attr_accessible :name, :title, :content, :attachment
  before_save :set_type

  belongs_to :page
  belongs_to :user

  validates_presence_of :title

  default_scope { where(company_id: Company.current_id) }
  default_scope { order('created_at DESC') }

private
  def set_type
    self.post_type = self.page.post_type
  end
end
