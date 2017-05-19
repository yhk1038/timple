class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :description
      t.string :profile_img
      t.string :background_img
      t.string :invite_code

      t.timestamps
    end
  end
end
