class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.integer :request_state
      t.integer :requested_template_id

      t.timestamps
    end
  end
end
