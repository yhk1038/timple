$(document).ready(function () {
    console.log('loaded!');

    $('.time_cell').mousedown(function () {
        console.log($(this).attr('id'));

        // 드래그를 시작한 첫 번째 셀을 통제하고,
        // 무슨 요일의 시간을 긁고 있는지 알아낸다.
        first_pressed($(this));

        // 테이블을 편집 모드로 변경한다.
        table_edit_mode(true);

        // 드래그 시작점을 이탈하고,
        // 드래그를 지속하는 단계를 통제한다.
        $('.time_cell.'+weekday()).mouseenter(function () {
            leave_cell($(this));
        });
    });

    // 드래그를 멈췄을 때,
    // 테이블을 편집 모드에서 일반 모드로 복귀시킨다.
    $('.time_cell').mouseup(function () {
        table_edit_mode(false);
        console.log(weekday());
    });
});

function startDrag(cell) {

}

function first_pressed(cell) {
    cell.addClass('active');
    weekday_ = cell.data('weekday');
}

function table_edit_mode(mode) {
    if (mode === true) {
        $('#table').attr('data-mode', 'edit-mode');
    }

    if (mode === false) {
        $('#table').attr('data-mode', '');
        weekday_ = 'stop';
    }
}

function leave_cell(cell) {
    var table_mode = $('#table').data('mode');

    if (table_mode === 'edit-mode') {
        cell.addClass('active');
    }
}

function stop(event) {
    console.log('$$$$$$$$');
    event.preventDefault();
    event.stopPropagation();
}

function weekday() {
    return weekday_
}