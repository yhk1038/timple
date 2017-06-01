$(document).ready(function () {
    /*
     * 그룹 생성시 입력창에서
     * 비공개 그룹 생성을 선택했을 때
     * 알림을 띄워주는 함수
     */
    $('#private-labeled').click(function () {
        $('#private-announcer').slideDown();
    });
    $('#public-labeled').click(function () {
        $('#private-announcer').slideUp();
    });
});