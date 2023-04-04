class RoleRequest < ApplicationRecord
  belongs_to :requester_user, class_name: :User
  belongs_to :approver_user, class_name: :User

  enum request_state: { submitted: 0, approved: 1, rejected: 2, completed: 3 }

  validates :requested_template_id, presence: true
  validates :request_state, presence: true
  validates :description, presence: true
end
