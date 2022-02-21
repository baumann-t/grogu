class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.references :offer, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :user_message
      t.boolean :confirmed
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
