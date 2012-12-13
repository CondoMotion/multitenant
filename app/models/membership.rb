class Membership < ActiveRecord::Base
  belongs_to :site
  belongs_to :user
  belongs_to :company
  belongs_to :role
  # attr_accessible :title, :body

  default_scope { where(company_id: Company.current_id) }

  before_create :set_role

private
	def set_role
		if self.user.manager?
			self.role_id ||= self.site.roles.find_by_name("Manager").id
		else
			self.role_id ||= self.site.roles.find_by_name("Resident").id
		end
	end
end
