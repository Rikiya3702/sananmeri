class CreateLikeposts < ActiveRecord::Migration[6.0]
  def change
    create_table :likeposts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
