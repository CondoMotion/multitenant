class Page < ActiveRecord::Base
	extend FriendlyId
  friendly_id :url #, use: :history
  before_save :set_url

  belongs_to :company
  belongs_to :site
  has_many :posts, dependent: :destroy
  attr_accessible :ancestry, :content, :name, :parent_id, :has_posts, :post_type
  has_ancestry
  acts_as_list :scope => :site

  validates_presence_of :name
  validates_uniqueness_of :name, scope: :site_id

  default_scope { where(company_id: Company.current_id) }

  def set_url
    self.url = self.name.parameterize
  end

end
