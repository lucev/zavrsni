class Member < User
  belongs_to :organization

  validates_presence_of :organization_id
end

