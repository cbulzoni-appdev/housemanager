# == Schema Information
#
# Table name: contacts
#
#  id           :integer          not null, primary key
#  company_name :string
#  contact_name :string
#  contact_type :string
#  email        :string
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  owner_id     :integer
#
class Contact < ApplicationRecord

  belongs_to(:owner, { :required => true, :class_name => "User", :foreign_key => "owner_id" })
  has_many(:appliances, { :class_name => "Appliance", :foreign_key => "contact_id", :dependent => :nullify })
  has_many(:projects, { :class_name => "Project", :foreign_key => "contact_id", :dependent => :nullify })
end
