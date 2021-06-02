class RemoveRolFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :rol, :integer
  end
end
