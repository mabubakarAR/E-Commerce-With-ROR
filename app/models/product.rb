class Product < ApplicationRecord
  belongs_to :user
  before_save :check_user_role
  #mount_uploaders :pictures, PictureUploader
  #
   def check_user_role
     product = self
     if product.user.admin? || product.user.seller?
       true
     else
       self.errors[:base] << "Please Login as an admin"
       false
     end
   end
end
