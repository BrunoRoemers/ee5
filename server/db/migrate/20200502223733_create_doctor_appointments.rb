class CreateDoctorAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :doctor_appointments do |t|
      t.references :stay, null: false, foreign_key: true
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false

      t.timestamps
    end
  end
end
