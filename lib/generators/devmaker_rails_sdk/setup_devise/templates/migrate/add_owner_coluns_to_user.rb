class AddOwnerColunsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :owner_id, :integer
    add_column :users, :owner_type, :string
  end
end
