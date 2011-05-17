class Organization < ActiveRecord::Base
  has_many :members, :class_name => 'Member'
end

