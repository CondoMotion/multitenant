class Page < ActiveRecord::Base
	extend FriendlyId
  friendly_id :url
  before_save :set_url

  belongs_to :company
  belongs_to :site
  has_many :posts, dependent: :destroy
  attr_accessible :ancestry, :content, :name, :parent_id, :has_posts
  has_ancestry
  acts_as_list

  validates_presence_of :name

  default_scope { where(company_id: Company.current_id) }
  default_scope { order('position') }

  def set_url
    self.url = self.name.parameterize
  end

end
