class CreateMarks < ActiveRecord::Migration[5.0]
    def change
        create_table :marks do |t|
            t.references :groups, foreign_key: true
            t.references :timetable, foreign_key: true
            t.references :user, foreign_key: true
            t.datetime :start_time
            t.datetime :end_time
            t.boolean :white_list
            t.string :title
            t.text :content
            t.string :url
            t.string :image
            
            t.timestamps
        end
    end
end
