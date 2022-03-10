# == Schema Information
#
# Table name: houses
#
#  id                :integer          not null, primary key
#  city              :string
#  primary_residence :string
#  purchase_date     :date
#  state             :string
#  street_address    :string
#  zip_code          :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  owner_id          :integer
#
class House < ApplicationRecord

  has_many(:projects, { :class_name => "Project", :foreign_key => "house_id", :dependent => :destroy })
  has_many(:appliances, { :class_name => "Appliance", :foreign_key => "house_id", :dependent => :destroy })
  belongs_to(:owner, { :required => true, :class_name => "User", :foreign_key => "owner_id" })
  
end
