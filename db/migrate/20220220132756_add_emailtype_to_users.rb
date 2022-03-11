class AddEmailtypeToUsers < ActiveRecord::Migration[6.1]
  def change
  add_column :users, :emailtype, :string
  end
end
