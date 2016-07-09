class CreateShapes < ActiveRecord::Migration
  def change
    create_table :shapes do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
