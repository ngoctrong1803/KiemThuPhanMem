/*-------------------------------------------------------------------------------*/
$(document).ready(function () {// thực hiện khi click vào button
    $("#result").hide();
    $("#loadanswer").hide();
    $('#submit').click(function () { // khi click vào buttoncheck thì thực hiện
        //gọi hàm chỗ này
        /*----------------------------------------*/
        //không cho người dùng làm nữa!!!

        //lăn lên trên
        document.body.scrollTop = 0;
        document.documentElement.scrollTop = 0;
        //
        $("#savetest").hide();
        $("#submit").hide();
        $("#clock").attr("style", "display: none !important");
        $(".notdoquiz").attr("style", "display: block !important");
        $("#result").show();
        $("#loadanswer").show();
        time = -1;// trả về thời gian 00:00
        document.getElementById('countdown').innerHTML = "";
        var x = document.getElementsByClassName("radiobutton");
        var i;
        for (i = 0; i < x.length; i++) {
            x[i].disabled = true;
        }
        /*----------------------------------------*/
        var arrayTemp = [];
        var ob = {name: 0, value: 0};
        var array = $('input[type=radio]:checked', '#myForm').toArray();
        for (var i of array) {
            arrayTemp.push({name: i.getAttribute("name"), value: i.getAttribute("value")});
        }

// console.log(array);
        var idofuser = $('#idofuser').html();// tạo 1 biến name để truyền tham số vào á
        var idofsubject = $('#idofsubject').html();
        var idofquiz = $('#idofquiz').html();
        var json = JSON.stringify(arrayTemp);
//                   console.log(json);
//                   var questionID
        $.ajax({
            type: 'POST', // thực hiện method doPost của controller AjaxController   
            data: {'json': json, 'idofuser': idofuser, 'idofsubject': idofsubject, 'idofquiz': idofquiz}, // đây là chỗ truyền tham số 
            url: '/hatquiz/CheckQuestionServlet', // gọi cái controller ra ở đây nè
//                      dataType: 'json',
            success: function (result) {
                //   $('#result').html(result);
                var obj = JSON.parse(result);
                $('#score').html(obj.score);
                $('#sumcorrectanswer').html(obj.sumcorrectanswer);
                $('#sumquestions').html(obj.sumquestions);
                $('#minutes').html(obj.minutes);
                $('#seconds').html(obj.seconds);
                console.log(result);
            }
        });
    });

    $('#loadanswer').click(function () { // khi click vào buttoncheck thì thực hiện
        ////lăn lên trên
        document.body.scrollTop = 0;
        document.documentElement.scrollTop = 0;
        //gọi hàm chỗ này
//                   undisable();
        /*----------------------------------------*/
        //không cho người dùng làm nữa!!!
        $('#loadanswer').hide();
        var idofuser = $('#idofuser').html();// tạo 1 biến name để truyền tham số vào á
        var idofsubject = $('#idofsubject').html();
        var idofquiz = $('#idofquiz').html();
        $.ajax({
            type: 'POST', // thực hiện method doPost của controller AjaxController   
            data: {'idofuser': idofuser, 'idofsubject': idofsubject, 'idofquiz': idofquiz}, // đây là chỗ truyền tham số 
            url: 'LoadCorrectAnswerServlet', // gọi cái controller ra ở đây nè
            success: function (result) {
                var obj = JSON.parse(result);

                var res = [];
                for (var i in obj)// đưa json vừa convert vào mảng res[]
                {
                    res.push(obj[i]);
                }
                for (var i of res) {
                    $('#' + i.id).html(i.result);
                    console.log(i.id + i.result);
                }
                console.log(result);

            }
        });
    });
    //check đáp án người dùng
    $('#submit').click(function () { // khi click vào buttoncheck thì thực hiện
        //gọi hàm chỗ này
//                   undisable();
        /*----------------------------------------*/
        //không cho người dùng làm nữa!!!
        document.getElementById('countdown').innerHTML = "";
        var x = document.getElementsByClassName("radiobutton");
        var i;
        for (i = 0; i < x.length; i++) {
            x[i].disabled = true;
        }
        /*----------------------------------------*/
        var arrayTemp = [];
        var ob = {name: 0, value: 0};
        var array = $('input[type=radio]:checked', '#myForm').toArray();
        for (var i of array) {
            arrayTemp.push({name: i.getAttribute("name"), value: i.getAttribute("value")});
        }


// console.log(array);
        var idofuser = $('#idofuser').html();// tạo 1 biến name để truyền tham số vào á
        var idofsubject = $('#idofsubject').html();
        var idofquiz = $('#idofquiz').html();
        var json = JSON.stringify(arrayTemp);
//                   console.log(json);
//                   var questionID
        $.ajax({
            type: 'POST', // thực hiện method doPost của controller AjaxController   
            data: {'json': json, 'idofuser': idofuser, 'idofsubject': idofsubject, 'idofquiz': idofquiz}, // đây là chỗ truyền tham số 
            url: 'CheckUserAnswerServlet', // gọi cái controller ra ở đây nè
//                      dataType: 'json',
            success: function (result) {
                var obj = JSON.parse(result);
                var res = [];
                for (var i in obj)// đưa json vừa convert vào mảng res[]
                {
                    res.push(obj[i]);
                }
                for (var i of res)
                {
                    $('#' + i.name).html(i.value); // trả hình qua cái thẻ span
                    console.log(i.name + i.value);
                }
                console.log("danh sách những câu đã chọn:" + json);
            }
        });
    });
    $('#savetest').click(function () { // khi click vào buttoncheck thì thực hiện

        var arrayTemp = [];
        var ob = {name: 0, value: 0};
        var array = $('input[type=radio]:checked', '#myForm').toArray();
        for (var i of array) {
            arrayTemp.push({name: i.getAttribute("name"), value: i.getAttribute("value")});
        }
        var idofuser = $('#idofuser').html();// tạo 1 biến name để truyền tham số vào á
        var idofsubject = $('#idofsubject').html();
        var idofquiz = $('#idofquiz').html();
        var json = JSON.stringify(arrayTemp);

        $.ajax({
            type: 'POST', // thực hiện method doPost của controller AjaxController   
            data: {'json': json, 'idofuser': idofuser, 'idofsubject': idofsubject, 'idofquiz': idofquiz}, // đây là chỗ truyền tham số 
            url: '/hatquiz/TakeAnswerServlet', // gọi cái controller ra ở đây nè
//                      dataType: 'json',
            success: function (result) {
                //   $('#result').html(result);
                var obj = JSON.parse(result);
                $('#savetest').html(obj.savetest);
                console.log("thực hiện lưu bài");
                console.log(json);
            }
        });
    });

});
