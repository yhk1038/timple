# 1. 현재 주에 대한 정보를 연산한다.(시작일, 종료일, 몇월 몇주차인지)
# 2. 현 1주일의 사작일 부터 종료일 까지의 날짜를 연산한다.
# 2.

class Ttable
    attr_accessor :current_date, :beginning_date, :ending_date, :weekdays, :time_range, :events

    def initialize(marking_events = [], current_date = Time.zone.now, start_time = DateTime.now.to_date.to_time, end_time = (DateTime.now.to_date.to_time + 1.day))
        @current_date   = current_date
        start_hour      = start_time.hour
        end_hour        = (end_time - 1.hour).hour
        @time_range     = (start_hour..end_hour).to_a.map{|h| Time.new(start_time.year, start_time.month, start_time.day, h)}

        take_start_and_end_date
        event_picker_this_week(marking_events)
    end

    def take_start_and_end_date
        @beginning_date = current_date.beginning_of_week
        @ending_date = current_date.end_of_week
        @weekdays = {
                date: [
                              @beginning_date,
                              @beginning_date + 1.day,
                              @beginning_date + 2.day,
                              @beginning_date + 3.day,
                              @beginning_date + 4.day,
                              @beginning_date + 5.day,
                              @beginning_date + 6.day
                      ],
                date_strf: [
                                   @beginning_date,
                                   @beginning_date + 1.day,
                                   @beginning_date + 2.day,
                                   @beginning_date + 3.day,
                                   @beginning_date + 4.day,
                                   @beginning_date + 5.day,
                                   @beginning_date + 6.day
                      ].map{|d| "#{d.month}/#{d.day}"},
                ko: {
                        long: %w(월요일 화요일 수요일 목요일 금요일 토요일 일요일),
                        short: %w(월요일 화요일 수요일 목요일 금요일 토요일 일요일).map{|w| w.gsub('요일','')}
                },
                en: {
                        long: %w(monday tuesday wednesday thursday friday saturday sunday).map{|w| w.capitalize},
                        short: %w(mon tue wed thu fri sat sun)
                }
        }
    end

    def event_picker_this_week(marking_events)
        @events = {}
        return '' if marking_events.count.zero?

        weekdays[:en][:short].each do |wday|
            index_num   = weekdays[:en][:short].index(wday)
            this_       = weekdays[:date][index_num]
            marked_evnt = marking_events.where("start_time LIKE ?", "%#{this_.year}-#{this_.month}-#{this_.day}%")

            @events[wday.to_sym] = marked_evnt unless marked_evnt.count.zero?
        end

    end

    # Main Board
    def draw
        drawing = ''

        drawing =   dom_toolbar
        drawing +=  dom_table

        drawing
    end


    def dom_toolbar
        html = ''
        html += "<div class=\"fc-toolbar\">"
        html +=     "<div class=\"fc-left\"></div>"
        html +=     "<div class=\"fc-right\"></div>"
        html +=     "<div class=\"fc-center\">"
        html +=         "<button type=\"button\" class=\"fc-prev-button ui-button ui-state-default ui-corner-left ui-corner-right\"><span class=\"ui-icon ui-icon-circle-triangle-w\"></span></button>"
        html +=         "<h2>#{beginning_date.strftime('%a %d')} — #{ending_date.strftime('%a %d')}, #{current_date.year.to_s}</h2>"
        html +=         "<button type=\"button\" class=\"fc-next-button ui-button ui-state-default ui-corner-left ui-corner-right\"><span class=\"ui-icon ui-icon-circle-triangle-e\"></span></button>"
        html +=     "</div>"
        html +=     "<div class=\"fc-clear\"></div>"
        html += "</div>"

        html.html_safe
    end

    def dom_table
        html =      dom_table_wrapper('open')
        html +=         dom_weekday_lists
        html +=         dom_table_body
        html +=     dom_table_wrapper('close')

        html.html_safe
    end

    def dom_weekday_lists
        weekdayLists = weekdays[:en][:short]

        html = ''
        html += "<thead class=\"fc-head\">"
        html +=     "<tr>"
        html +=         "<td class=\"ui-widget-header\">"
        html +=             "<div class=\"fc-row ui-widget-header\" style=\"border-right-width: 1px !important; margin-right: 14px !important;\">"
        html +=                 "<table>"
        html +=                     "<thead>"
        html +=                         "<tr>"
        html +=                             "<th class=\"fc-axis ui-widget-header\" style=\"width:39px\"></th>"

        weekdayLists.each do |weekday|
            index = weekdayLists.index(weekday)
            html +=                         "<th class=\"fc-day-header ui-widget-header fc-#{weekday}\">#{weekdays[:ko][:short][index]} #{weekdays[:date_strf][index]}</th>"
        end

        html +=                         "</tr>"
        html +=                     "</thead>"
        html +=                 "</table>"
        html +=             "</div>"
        html +=         "</td>"
        html +=     "</tr>"
        html += "</thead>"

        html.html_safe
    end

    def dom_table_wrapper(tag)
        html = ''

        case tag
        when 'open'
            html += "<div class=\"fc-view-container\" style=\"\">"
            html +=    "<div class=\"fc-view fc-agendaWeek-view fc-agenda-view\">"
            html +=        "<table>"

        when 'close'
            html +=        "</table>"
            html +=    "</div>"
            html += "</div>"
        end

        html.html_safe
    end

    def dom_table_body
        html = ''

        # table's body open
        html += dom_table_body_wrapper('open')

        # Divider for header(allDay) with body
        html += '<hr class="fc-divider ui-widget-header">'.html_safe

        # table's main body
        html += dom_table_body_table_wrapper('open')

        html +=     dom_table_body_table_grid
        html +=     dom_table_body_table
        html +=     '<hr class="fc-divider ui-widget-header" style="display: none;">'.html_safe
        html +=     dom_table_body_table_skeleton
        html +=     dom_table_body_table_skeleton_helper

        html += dom_table_body_table_wrapper('close')

        # table's body close
        html += dom_table_body_wrapper('close')

        html.html_safe
    end

    def dom_table_body_wrapper(tag)
        html = ''

        case tag
        when 'open'
            html += "<tbody class=\"fc-body\">"
            html +=     "<tr>"
            html +=         "<td class=\"ui-widget-content\">"

        when 'close'
            html +=         "</td>"
            html +=     "</tr>"
            html += "</tbody>"
        end

        html.html_safe
    end

    def dom_table_body_table_wrapper(tag)
        html = ''

        case tag
        when 'open'
            html += "<div class=\"fc-time-grid-container fc-scroller\" style=\"height: 745px;\">"
            html +=     "<div class=\"fc-time-grid\">"

        when 'close'
            html +=     "</div>"
            html += "</div>"

        end

        html.html_safe
    end

    def dom_table_body_table_grid
        html = ''

        html += '<div class="fc-bg">'
        html +=     '<table>'
        html +=         '<tbody>'
        html +=             '<tr>'
        html +=                 '<td class="fc-axis ui-widget-content" style="width:39px"></td>'

        weekdays[:date].each do |datetime|
            html +=             grid_leak(datetime)
        end

        html +=             '</tr>'
        html +=         '</tbody>'
        html +=     '</table>'
        html += '</div>'

        html.html_safe
    end

    def grid_leak(datetime)
        status = datetime.to_date <=> current_date.to_date
        wday = datetime.strftime('%a').downcase
        result = nil

        case status.to_s
        when '-1'   # past status
            result ||= "<td class=\"fc-day ui-widget-content fc-#{wday} fc-past\" data-date=\"#{datetime.to_date.to_s}\"></td>"

        when '0'    # today status
            result ||= "<td class=\"fc-day ui-widget-content fc-#{wday} fc-today ui-state-highlight\" data-date=\"#{datetime.strftime('%F')}\"></td>"

        when '1'    # future status
            result ||= "<td class=\"fc-day ui-widget-content fc-#{wday} fc-future\" data-date=\"#{datetime.to_date.to_s}\"></td>"

        end

        result
    end

    def dom_table_body_table
        html = ''

        html += '<div class="fc-slats">
                    <table>
                        <tbody>'

        time_range.each do |time|
            html +=    dom_by_each_time('clock', time)
            html +=    dom_by_each_time('half', time)
        end

        html +=         '</tbody>
                    </table>
                </div>'
        html.html_safe
    end

    def dom_by_each_time(clock, time)
        html = ''

        case clock
        when 'clock'
            html +=    '<tr>'
            html +=         "<td class=\"fc-axis fc-time ui-widget-content\" style=\"width:39px\"><span>#{time.strftime('%I%P')}</span></td>"

        when 'half'
            html +=     '<tr class="fc-minor">'
            html +=         "<td class=\"fc-axis fc-time ui-widget-content\" style=\"width:39px\"></td>"

        end

        html +=         "<td class=\"ui-widget-content\"></td>"
        html +=     '</tr>'

        html.html_safe
    end

    def dom_table_body_table_skeleton
        html = '<div class="fc-content-skeleton">
                    <table>
                        <tbody>
                        <tr>
                            <td class="fc-axis" style="width:39px"></td>
                            <td>
                                <div class="fc-event-container"></div>
                            </td>
                            <td>
                                <div class="fc-event-container"></div>
                            </td>
                            <td>
                                <div class="fc-event-container"></div>
                            </td>
                            <td>
                                <div class="fc-event-container"></div>
                            </td>
                            <td>
                                <div class="fc-event-container"></div>
                            </td>
                            <td>
                                <div class="fc-event-container"></div>
                            </td>
                            <td>
                                <div class="fc-event-container"></div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>'

        html.html_safe
    end

    def dom_table_body_table_skeleton_helper
        # return ' ' if events.size.zero?

        html = '<div class="fc-helper-skeleton">'
        html +=     '<table>'
        html +=         '<tbody>'
        html +=             '<tr>'
        html +=                 '<td class="fc-axis" style="width:39px"></td>'

        if !events.size.zero?
            weekdays[:en][:short].each do |wday|
                html +=                 events_leak_on_a_day(wday.to_sym)
            end
        else
            weekdays[:en][:short].each do |wday|
                html +=                 '<td><div class="fc-event-container"></div></td>'
            end
        end

        html +=             '</tr>'
        html +=         '</tbody>'
        html +=     '</table>'
        html += '</div>'

        html.html_safe
    end

    def events_leak_on_a_day(wday)
        html = ''

        html +=                 '<td>'

        if events[wday].size.zero?
            html +=                 '<div class="fc-event-container"></div>'
        else
            html +=                 event_leaks(wday)
        end

        html +=                 '</td>'

        html.html_safe
    end

    def event_leaks(wday)
        html = ''

        events[wday].each do |ev|
            html +=                     '<div class="fc-event-container">'
            html +=                         "<a class=\"fc-time-grid-event fc-v-event fc-event fc-start fc-end fc-helper\" style=\"top: #{bg_top(ev[:s_time])}px; bottom: -#{bg_top(ev[:e_time])}px; z-index: 1; left: 0%; right: 0%;\">"
            html +=                             "<div class=\"fc-content\">"
            html +=                                 "<div class=\"fc-time\" data-start=\"#{ev[:s_time].strftime('%h:%m')}\" data-full=\"#{ev[:s_time].strftime('%h:%m %p')} - #{ev[:e_time].strftime('%h:%m %p')}\"><span>#{ev[:s_time].strftime('%h:%m')} - #{ev[:e_time].strftime('%h:%m')}</span></div>"
            html +=                             "</div>"
            html +=                             "<div class=\"fc-bg\"></div>"
            html +=                         "</a>"
            html +=                     '</div>'
        end

        html.html_safe
    end

    def bg_top(time)
        hour = time.hour
        min = time.min

        top_px = hour * 2 * 20
        top_px = top_px + 20 if min.to_s == '30'

        top_px
    end
end
