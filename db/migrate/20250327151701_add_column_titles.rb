class AddColumnTitles < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :address, :string, null: false
  end
end
