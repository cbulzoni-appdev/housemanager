# == Schema Information
#
# Table name: projects
#
#  id             :integer          not null, primary key
#  date_completed :date
#  date_started   :date
#  description    :text
#  notes          :text
#  status         :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  contact_id     :integer
#  house_id       :integer
#
class Project < ApplicationRecord

  belongs_to(:house, { :required => true, :class_name => "House", :foreign_key => "house_id" })
  belongs_to(:contact, { :class_name => "Contact", :foreign_key => "contact_id" })
  has_one(:owner, { :through => :house, :source => :owner })
end
