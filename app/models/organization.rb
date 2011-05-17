class Organization < ActiveRecord::Base
  has_many :accounts, :class_name => 'Member'
end

