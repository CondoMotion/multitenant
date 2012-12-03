class Site < ActiveRecord::Base
	after_create :create_default_pages

  belongs_to :user
  belongs_to :company
  has_many :pages, dependent: :destroy
  has_many :posts, :through => :pages
  attr_accessible :name, :subdomain, :posts_attributes, :layout, :custom_layout_content

  accepts_nested_attributes_for :posts

  validates_uniqueness_of :subdomain
  
  default_scope { where(company_id: Company.current_id) }

private
	def create_default_pages
		@page = self.pages.build(name: "Home", content: "Welcome to our community!")
		@page.save
	end
end
