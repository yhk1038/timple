json.extract! timetable, :id, :group_id, :start_date, :end_date, :created_at, :updated_at
json.url timetable_url(timetable, format: :json)
