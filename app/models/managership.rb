class Managership < ActiveRecord::Base
  belongs_to :user
  belongs_to :site
  belongs_to :company
  # attr_accessible :title, :body

  default_scope { where(company_id: Company.current_id) }
end
