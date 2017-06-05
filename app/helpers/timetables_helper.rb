module TimetablesHelper
    
    def publish_method_label
        private_group ? private_label_format : public_label_format
    end
    
    def generate_timetable
        weekdays = [
                {en: 'mon', ko: '월'},
                {en: 'tue', ko: '화'},
                {en: 'wed', ko: '수'},
                {en: 'thu', ko: '목'},
                {en: 'fri', ko: '금'},
                {en: 'sat', ko: '토'},
                {en: 'sun', ko: '일'}]
        weekdays.unshift({en: 'no-date',ko: '#'})
    
        time_ranges = %w(12am) << ' '
        (1..11).to_a.each do |i|
            time_ranges << "#{i}am"
            time_ranges << ' '
        end
        time_ranges << '12pm' << ' '
        (1..11).to_a.each do |i|
            time_ranges << "#{i}pm"
            time_ranges << ' '
        end
        
        
    end
    
    
    ########
    #
    # HTML Source Bundles
    
    ## > 1-1
    ## 비공개 그룹의 라벨 태그
    def private_label_format
        '<span class="label label-warning">Private</span>'.html_safe
    end
    
    ## > 1-2
    ## 공개 그룹의 라벨 태그
    def public_label_format
        '<span class="label label-danger">Public</span>'.html_safe
    end
    
    protected
    def private_group
        @group.is_private?
    end
end
