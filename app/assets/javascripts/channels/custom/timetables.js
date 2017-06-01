$(document).ready(function () {
    console.log('loaded!');

    //
    // 초대 코드 토글 장치
    $('#code_g').click(function () {
        $(this).hide();
        $('#code_m').fadeIn();
    });
    $('#code_m a').click(function () {
        $('#code_m').hide();
        $('#code_g').fadeIn();
    });

    /*
     * 타임 테이블 마킹 컨트롤
     */
    $('.time_cell').mousedown(function () {
        if ($(this).attr('class').indexOf('active') === -1) {
            console.log($(this).data('weekday'));

            // 드래그를 시작한 첫 번째 셀을 통제하고,
            // 무슨 요일의 시간을 긁고 있는지 알아낸다.
            first_pressed($(this));

            // 테이블을 편집 모드로 변경한다.
            table_edit_mode(true);

            // 드래그 시작점을 이탈하고,
            // 드래그를 지속하는 단계를 통제한다.
            $('.time_cell.'+weekday()).mouseenter(function () {

                // enter_cell($(this));
                if ($('#table').attr('class').indexOf('edit-mode') !== -1) {
                    $(this).addClass('active');
                    countPlus($(this), $(this).val());
                }
            });
        } else {
            var count = parseInt($(this).text()) - 1;
            var opacity = parseFloat($(this).css('opacity')) - 0.5;
            console.log(opacity);
            if (count === 0){
                $(this).text('');
            } else {
                $(this).text(count);
            }
            $(this).removeClass('active');
        }
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
    countPlus(cell, cell.val());
}

function table_edit_mode(mode) {
    if (mode === true) {
        $('#table').addClass('edit-mode');
    }

    if (mode === false) {
        $('#table').removeClass('edit-mode');
        weekday_ = 'stop';
    }
}

function enter_cell(cell) {
    var table_mode = $('#table').data('mode');

    if (table_mode === 'edit-mode') {
        cell.addClass('active');
        countPlus(cell, cell.val());
    }
}

function stop(event) {
    console.log('$$$$$$$$');
    event.preventDefault();
    event.stopPropagation();
}

function countPlus(cell, count) {
    if (count.length === 0){
        count = 0;
    }
    count = parseInt(count) + 1;
    cell.text(count);
}

function weekday() {
    return weekday_
}

