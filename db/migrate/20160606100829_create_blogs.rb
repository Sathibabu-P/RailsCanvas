class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :description
      t.boolean :publish, default: false
      t.belongs_to :user, index: true  
      t.timestamps null: false
    end
  end
end
