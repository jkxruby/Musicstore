class AddNameToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string
    add_column :users, :phonenumber, :string
    add_column :users, :address, :string
  end
end
