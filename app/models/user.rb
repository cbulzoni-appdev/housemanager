# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  first_name      :string
#  last_name       :string
#  password_digest :string
#  phone_number    :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  has_many(:houses, { :class_name => "House", :foreign_key => "owner_id", :dependent => :destroy })
  has_many(:contacts, { :class_name => "Contact", :foreign_key => "owner_id", :dependent => :destroy })
  has_many(:appliances, { :through => :houses, :source => :appliances })
  has_many(:projects, { :through => :houses, :source => :projects })
end
