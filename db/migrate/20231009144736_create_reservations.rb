class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.date :date, null: false
      t.references :schedule, null: false, foreign_key: true
      t.references :sheet, null: false, foreign_key: true
      t.string :email, null: false, comment: '予約者メールアドレス'
      t.string :name, null: false, comment: '予約者名'

      t.timestamps
    end

    # 同じ日付、スケジュール、座席の組み合わせに複数の予約を防ぐための制約
    add_index :reservations, [:date, :schedule_id, :sheet_id], unique: true, name: 'reservation_schedule_sheet_unique'
  end
end
