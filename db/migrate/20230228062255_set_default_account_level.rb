class SetDefaultAccountLevel < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :stratus_role, from: nil, to: 0
  end
end
