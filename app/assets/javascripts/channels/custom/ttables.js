$(document).ready(function(){
    var col;
    var colWday;
    var colDateTime;

    $('.fc-slats .ui-widget-content:not(.fc-axis)').mousedown(function(){
        console.log('start!');
        console.log($(this));
        console.log($(this)[0].offsetTop, $(this)[0].offsetHeight);
        var s_time = offsetToTime($(this)[0].offsetTop / 40);
        var e_time = offsetToTime2(($(this)[0].offsetTop + $(this)[0].offsetHeight - 20) / 40);
        console.log(s_time, e_time);

        $('.fc-bg').attr('style', 'z-index: 3');
        console.log($('.fc-bg').css('z-index')); // open to get column elements data

        $('.fc-bg .ui-widget-content:not(.fc-axis)').unbind('mousemove').mousemove(function(){
            $('.fc-bg').attr('style','');
            console.log($('.fc-bg'), $('.fc-bg').css('z-index')); // close to reset column elements status

            col = $(this);
            colWday = col.attr('class').split(' ')[2]; // DEBUG: console.log(calWeekdayNum(col));
            // var ymd = col.data('date').split('-');
            // console.log(ymd);
            // colDateTime = new Date(ymd[0], ymd[1], ymd[2]);
            // console.log(colDateTime);

            var target = $('.fc-helper-skeleton tr td:nth-child('+ calWeekdayNum(colWday) +') .fc-event-container'); // DEBUG:
            console.log(target);

            addEvent([s_time, e_time], target, 'scroll');

            $('a.fc-time-grid-event.fc-v-event').mouseleave(function() {
                modEvent([s_time, e_time], $(this));

                $(this).mouseup(function(){

                    $('a.fc-time-grid-event.fc-v-event').off('mouseenter mouseleave');
                });
            });

            console.log('================================================');
        });
    });


});

function offsetToTime(arg){
    var hour = arg;
    var min = '00';
    var divide = arg / 0.5;

    if (divide % 2 === 1){ // 30분
        min = '30';
        hour = hour - 0.5;
    }
    hour = String(hour);

    return hour+':'+min
}

function offsetToTime2(arg){
    var hour = arg;
    var min = '30';
    var divide = arg / 0.5;

    if (divide % 2 === 1){ // 30분
        min = '00';
        hour = hour + 0.5;
    }
    hour = String(hour);

    return hour+':'+min
}

function calWeekdayNum(col){
    var weekdays = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];
    return weekdays.indexOf(col.replace('fc-','')) + 2
}

function addEvent(ev, addLoc, status){
    var eventDom = makeEventDom(ev);
    console.log(eventDom);
    var originalDom = '';

    if (status === 'scroll') {
        originalDom = '';
    }

    if (status === 'new') {
        originalDom = addLoc.html();
    }

    addLoc.append(eventDom);
}

function modEvent(ev, target){
    var e_time  = ev[1];
    var update_e_time = update_Etime(e_time);

    var original_bottom = target.css('bottom');
    var update_bottom = '-' + String(parseInt(original_bottom.replace('-','').replace('px')) + 20) + 'px';
    target.css('bottom', update_bottom);

    var timer = target.find('.fc-time');
    var original_full = timer.data('full');
    var update_full = original_full.replace(e_time, update_e_time);
    timer.attr('data-full', update_full);

    var timeTxt = timer.find('span');
    var original_Ttxt = timeTxt.text();
    var update_Ttxt = original_Ttxt.replace(original_Ttxt.split(' - ')[1], update_Etime(original_Ttxt.split(' - ')[1]));
    timeTxt.text(update_Ttxt);
    console.log(original_Ttxt, update_Ttxt);

    console.log(e_time, target);
}

function update_Etime(e_time){
    var split   = e_time.split(':');
    var hour    = split[0];
    var min     = split[1];

    if (parseInt(min) + 30 === 60){
        hour = String(parseInt(hour) + 1);
        min = '00';
    } else {
        min = '30';
    }
    var update_e_time = hour + ':' + min;
    return update_e_time;
}

function makeEventDom(ev){
    var s_ev = strf(ev[0]);
    var e_ev = strf(ev[1]);
    var s_evp = strfp(ev[0]);
    var e_evp = strfp(ev[1]);
    console.log(s_ev, e_ev, s_evp, e_evp);

    var html =  '<a class="fc-time-grid-event fc-v-event fc-event fc-start fc-end fc-helper" style="top: '+bg_top(ev[0])+'px; bottom: -'+bg_bottom(ev[1])+'px; z-index: 1; left: 0%; right: 0%;">'+
                    '<div class="fc-content">'+
                        '<div class="fc-time" data-start="'+s_ev+'" data-full="'+s_evp+' - '+e_evp+'"><span>'+s_ev+' - '+e_ev+'</span></div>'+
                    '</div>'+
                    '<div class="fc-bg"></div>'+
                '</a>';

    return html;
}

function bg_top(time){
    var split = time.split(':');
    var hour = split[0]; //
    var min = split[1]; //

    var top_px = parseInt(hour) * 2 * 20; //

    if (parseInt(min) === 30){
        top_px = top_px + 20; //
    }
    return top_px;
}

function bg_bottom(time){
    var split = time.split(':');
    var hour = split[0]; //
    var min = split[1]; //

    var bottom_px = parseInt(hour) * 2 * 20; //

    if (parseInt(min) === 30){
        bottom_px = bottom_px + 20 //
    }
    return bottom_px
}

function strf(time){
    var t = time.split(':');
    var hour = parseInt(t[0]);
    var tt;

    if (hour > 12){
        hour = hour - 12;
        tt = hour + ':' + t[1] + '';
    }

    if (hour <= 12){
        tt = hour + ':' + t[1] + '';
    }

    return tt
}

function strfp(time){
    var t = time.split(':');
    var hour = parseInt(t[0]);

    if (hour > 12){
        hour = hour - 12;
        t = hour + ':' + t[1] + ' PM';
    }

    if (hour <= 12){
        t = hour + ':' + t[1] + ' AM';
    }

    return t
}
