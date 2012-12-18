class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :owned_company_attributes, :receive_post_mails
  # validates_uniqueness_of :email #, scope: :company_id

  has_many :memberships
  has_many :sites, :through => :memberships

  has_many :managerships, dependent: :destroy
  has_many :sites, :through => :managerships

  has_many :sites
  has_many :posts
  has_one :owned_company, :class_name => "Company", :foreign_key => "owner_id"
  belongs_to :company

  accepts_nested_attributes_for :owned_company

  # default_scope { where(company_id: Company.current_id) }

  def site_role(site)
  	Membership.find_by_user_id_and_site_id(self.id, site.id).role
  end

  def manages?(site)
    Managership.find_by_user_id_and_site_id(self.id, site.id).present?
  end
end
