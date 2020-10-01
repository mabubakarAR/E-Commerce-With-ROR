class User < ApplicationRecord
  acts_as_token_authenticatable
  extend Enumerize
  enumerize  :role, in: [:buyer, :seller, :admin]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true
  validates :role, presence: true
  validates :password,
            length: { minimum: 8 },
            if: -> { new_record? || !password.nil? }

  def buyer?
    if self.role == "buyer"
      true
    else
      self.errors[:base] << "User is not an buyer"
      false
    end
  end

  def admin?
    if self.role == "admin"
      true
    else
      self.errors[:base] << "You are not an admin"
      false
    end
  end

  def seller?
    if self.role == "seller"
      #if self.is_approved
      #  true
      #else
      #  self.errors[:base] << "product is not approved"
      #end
    else
      self.errors[:base] << "User is not a seller"
      false
    end
  end

  def check_role(role)
    if role.present?
      if role == "buyer"
        self.buyer?
      elsif role == "seller"
        self.seller?
      elsif role == "admin"
        self.admin?
      else
        self.errors[:base] << "Role does not exist"
        false
      end
    else
      self.errors[:base] << "Role can't be blank"
      false
    end
  end
end
