class Site < ActiveRecord::Base
	after_create :create_default_pages
	before_save :subdomain_param

  belongs_to :user
  belongs_to :company
  has_many :pages, dependent: :destroy
  has_many :posts, :through => :pages
  attr_accessible :name, :subdomain, :posts_attributes, :layout, :custom_layout_content

  accepts_nested_attributes_for :posts

  validates_uniqueness_of :subdomain
  
  default_scope { where(company_id: Company.current_id) }

private
	def subdomain_param
		self.subdomain = self.subdomain.parameterize
	end

	def create_default_pages
		@page = self.pages.build(name: "Home", content: "Welcome to our community!", has_posts: false)
		@page.save

		@page = self.pages.build(name: "News", content: "", has_posts: true)
		@page.save

		@page = self.pages.build(name: "Documents", content: "", has_posts: true)
		@page.save

		@page = self.pages.build(name: "Photos", content: "", has_posts: true)
		@page.save
	end
end
