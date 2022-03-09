# == Schema Information
#
# Table name: maintenance_events
#
#  id               :integer          not null, primary key
#  description      :text
#  maintenance_date :date
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  house_id         :integer
#
class MaintenanceEvent < ApplicationRecord

  belongs_to(:house, { :required => true, :class_name => "House", :foreign_key => "house_id" })
  has_one(:owner, { :through => :house, :source => :owner })
end
