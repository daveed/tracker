class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects, id: :uuid do |t|
      t.string :name
      t.index :name, unique: true
      t.text :description
      t.integer :state, default: 10

      t.timestamps null: false
    end
  end
end
