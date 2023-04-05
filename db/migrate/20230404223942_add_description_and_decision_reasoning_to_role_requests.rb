class AddDescriptionAndDecisionReasoningToRoleRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :role_requests, :description, :string
    add_column :role_requests, :decision_reasoning, :string
  end
end
