class Company < ActiveRecord::Base
	after_create :add_owner_to_company
  attr_accessible :name, :subdomain
  has_many :users
  has_many :sites, dependent: :destroy
  has_many :pages
  has_many :membersips
  belongs_to :owner, :class_name => "User"
  
  def self.current_id=(id)
    Thread.current[:company_id] = id
  end
  
  def self.current_id
    Thread.current[:company_id]
  end

private
	def add_owner_to_company
		@owner = self.owner
		@owner.company_id = self.id
		@owner.manager = true
		@owner.save
	end
end
