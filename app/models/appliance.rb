# == Schema Information
#
# Table name: appliances
#
#  id             :integer          not null, primary key
#  appliance_type :string
#  category       :string
#  last_serviced  :date
#  make           :string
#  model          :string
#  notes          :text
#  service_due    :date
#  year           :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  contact_id     :integer
#  house_id       :integer
#
class Appliance < ApplicationRecord

  belongs_to(:house, { :required => true, :class_name => "House", :foreign_key => "house_id" })
  belongs_to(:contact, { :class_name => "Contact", :foreign_key => "contact_id" })
  has_one(:owner, { :through => :house, :source => :owner })
end
