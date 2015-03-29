class CreateAbsentDates < ActiveRecord::Migration
  def change
    create_table :absent_dates do |t|
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :absent_dates, :users
  end
end
