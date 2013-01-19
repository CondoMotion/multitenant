class Site < ActiveRecord::Base
	after_create :create_default_pages
	after_create :create_default_roles
	after_create :add_company_owner_as_manager
	before_save :subdomain_param

  has_many :memberships, dependent: :destroy
	has_many :members, :through => :memberships, :source => :user

	has_many :managerships, dependent: :destroy
	has_many :managers, :through => :managerships, :source => :user

	has_many :roles, dependent: :destroy
  belongs_to :user
  belongs_to :company
  has_many :pages, dependent: :destroy, :order => "position"
  has_many :posts, :through => :pages
  attr_accessible :name, :subdomain, :posts_attributes, :layout, :custom_layout_content, :manager_ids

  accepts_nested_attributes_for :posts

  validates_presence_of :name, :subdomain
  validates_uniqueness_of :subdomain
  
  default_scope { where(company_id: Company.current_id) }

private
	def subdomain_param
		self.subdomain = self.subdomain.parameterize
	end

	def add_company_owner_as_manager
		@manager = self.company.owner
		m = @manager.managerships.new
		m.site = self
		m.save
	end

	def create_default_pages
		@page = self.pages.create(name: "Home", content: "<h1>Welcome to our community!</h1>"+
                                          "<p>Use this space to add information about your property and links to relevant pages.</p>", 
                                          has_posts: false)
		@page = self.pages.create(name: "News", content: "<h1>Recent News</h1>", has_posts: true, post_type: "news")
		@page = self.pages.create(name: "Documents", content: "<h1>Documents</h1>", has_posts: true, post_type: "documents")
		@page = self.pages.create(name: "Photos", content: "<h1>Photographs</h1>", has_posts: true, post_type: "photos")	
	end

	def create_default_roles
		@role = self.roles.create(name: "Resident", permission: 1)
		@role = self.roles.create(name: "Admin", permission: 2)
		@role = self.roles.create(name: "Trustee", permission: 3)
	end
end
