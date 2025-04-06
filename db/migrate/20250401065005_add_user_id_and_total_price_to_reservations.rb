class AddUserIdAndTotalPriceToReservations < ActiveRecord::Migration[6.1]
  def change
    add_reference :reservations, :user, null: false, foreign_key: true
    add_column :reservations, :total_price, :decimal
  end
end
