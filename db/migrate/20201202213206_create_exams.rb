class CreateExams < ActiveRecord::Migration[6.0]
  def change
    create_table :exams do |t|
      t.references :college, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
