class Picture < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  belongs_to :product
end
