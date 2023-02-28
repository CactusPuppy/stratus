class AddUsersToRoleRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :role_requests, :requester_user_id, :integer
    add_column :role_requests, :approver_user_id, :integer

    add_foreign_key :role_requests, :users, column: :requester_user_id
    add_foreign_key :role_requests, :users, column: :approver_user_id
  end
end
