class Group < ApplicationRecord

  has_many :group_users, dependent: :destroy

  attachment :group_image, destroy: false

end
