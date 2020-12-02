class CreateExamSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :exam_sessions do |t|
      t.references :exam, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :start_time, null: false

      t.timestamps
    end
  end
end
