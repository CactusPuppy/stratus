class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 64 }
  validates :password, presence: true, length: { minimum: 8 }, if: :password

  has_many :submitted_requests, foreign_key: :requesting_user_id, class_name: "Request"
  has_many :approved_requests, foreign_key: :approving_user_id, class_name: "Request"

  enum stratus_role: { user: 0, manager: 1 }
end
