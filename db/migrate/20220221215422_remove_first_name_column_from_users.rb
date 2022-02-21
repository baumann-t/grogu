class RemoveFirstNameColumnFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :first_name, :string
    rename_column :users, :last_name, :username
  end
end
