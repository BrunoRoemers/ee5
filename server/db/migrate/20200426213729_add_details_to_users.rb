class AddDetailsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :full_name, :string
    add_column :users, :display_name, :string
    add_column :users, :birthday, :date
  end
end
