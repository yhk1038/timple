class Mark < ApplicationRecord
    belongs_to :group
    belongs_to :timetable
    belongs_to :user
end
