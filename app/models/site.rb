class Site < ActiveRecord::Base
	after_create :create_default_pages
	after_create :create_default_roles
	before_save :subdomain_param

	has_many :memberships
	has_many :members, :through => :memberships, :source => :user
	has_many :roles
  belongs_to :user
  belongs_to :company
  has_many :pages, dependent: :destroy, :order => "position"
  has_many :posts, :through => :pages
  attr_accessible :name, :subdomain, :posts_attributes, :layout, :custom_layout_content, :member_ids

  accepts_nested_attributes_for :posts

  validates_presence_of :name, :subdomain
  validates_uniqueness_of :subdomain
  
  default_scope { where(company_id: Company.current_id) }

private
	def subdomain_param
		self.subdomain = self.subdomain.parameterize
	end

	def create_default_pages
		@page = self.pages.create(name: "Home", content: "<p>Welcome to our community!</p>", has_posts: false)
		@page = self.pages.create(name: "News", content: "", has_posts: true, post_type: "news")
		@page = self.pages.create(name: "Documents", content: "", has_posts: true, post_type: "documents")
		@page = self.pages.create(name: "Photos", content: "", has_posts: true, post_type: "photos")	
	end

	def create_default_roles
		@role = self.roles.create(name: "Resident", permission: 1)
		@role = self.roles.create(name: "Admin", permission: 2)
		@role = self.roles.create(name: "Trustee", permission: 3)
		@role = self.roles.create(name: "Manager", permission: 4)
	end
end
