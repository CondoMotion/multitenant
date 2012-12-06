class Membership < ActiveRecord::Base
  belongs_to :site
  belongs_to :user
  belongs_to :company
  belongs_to :role
  # attr_accessible :title, :body

  default_scope { where(company_id: Company.current_id) }
end
