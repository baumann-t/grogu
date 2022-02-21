class ChangeDefaultValueForConfirmedBookings < ActiveRecord::Migration[6.1]
  def change
    change_column_default :bookings, :confirmed, false
  end
end
