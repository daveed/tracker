class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks, id: :uuid do |t|
      t.string :name, null: false
      t.text :description
      t.references :project, index: true, foreign_key: true, type: :uuid
      t.integer :state, default: 0

      t.timestamps null: false
    end
  end
end
