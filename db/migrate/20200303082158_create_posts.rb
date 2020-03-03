class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content, null: false
      t.boolean :public, defalut: true

      t.timestamps
    end
  end
end
