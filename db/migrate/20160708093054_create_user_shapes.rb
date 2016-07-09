class CreateUserShapes < ActiveRecord::Migration
  def change
    create_table :user_shapes do |t|
      t.belongs_to :user, index: true
      t.belongs_to :shape, index: true
      t.integer :x , default: 10
      t.integer :y, default: 10
      t.integer :w , default: 100
      t.integer :h, default: 100
      t.integer :r, default: 50
      t.string :text, default: 'some text here'
      t.text :data
      t.timestamps null: false
    end
  end
end
