class Mark < ApplicationRecord
    belongs_to :group
    belongs_to :timetable
    belongs_to :user

    scope :on_this_week, -> { where("start_time >= :start_time AND end_time <= :end_time", {start_time: Time.now.beginning_of_week, end_time: Time.now.end_of_week}) }
end
