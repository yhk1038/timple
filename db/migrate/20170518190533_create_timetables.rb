class CreateTimetables < ActiveRecord::Migration[5.0]
    def change
        create_table :timetables do |t|
            t.references :group, foreign_key: true
            t.datetime :start_date
            t.datetime :end_date
            t.datetime :start_day_time
            t.datetime :end_day_time
            
            t.timestamps
        end
    end
end
