class CreateUserlists < ActiveRecord::Migration[5.0]
  def change
    create_table :userlists do |t|
      t.references :user, foreign_key: true
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
