document.addEventListener("DOMContentLoaded", function (e) {
    var m = document.getElementById("timeofquiz").innerHTML;
    var startingminute = m;
    var time = startingminute * 60;
    var x = setInterval(updateCountdown, 1000);

    function updateCountdown()
    {
        var minutes = Math.floor(time / 60);
        var seconds = time % 60;
        if (seconds > 9)
        {
            document.getElementById('countdown').innerHTML = minutes + ":" + seconds;
        } else if (minutes >= 0 && seconds > 0)
        {
            document.getElementById('countdown').innerHTML = minutes + ":0" + seconds;
        } else if (minutes === 0 && seconds === 0)
        {
            clearInterval(x);
            document.getElementById('countdown').innerHTML = "";
            window.alert("HẾT THỜI GIAN LÀM BÀI!!!");
            document.getElementById('submit').click();
        }
        time--;
    }
});





   