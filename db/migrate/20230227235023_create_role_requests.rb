class CreateRoleRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :role_requests do |t|
      t.integer :request_state, default: 0
      t.integer :requested_template_id

      t.timestamps
    end
  end
end
