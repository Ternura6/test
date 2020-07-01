window.onload =function () {

    function numberL() {
        var phone = $("#phone").val();
        okphone = /^1[3456789]\d{9}$/;
        if (phone.test(np)) {
            var npyz = document.getElementById("NewPhoneSpan");
            npyz.style.display = "none";
        } else {
            var er = document.getElementById("NewPhoneSpan");
            er.style.display = "block";
            $("#NewPhoneSpan").val(" ");
        }

    }

    function sinc() {
        var lphone = $("#phone").val();
        $.ajax({
            type: "get",
            async: false,//同步
            cache: false,//不缓存
            url: "http://127.0.0.1:8083/sms/Loginbyphone",
            data: {
                "phone": lphone,
            },

            success: function (datas) {
                if (datas == 1 || datas == 2) {
                    return true;

                } else {
                    return false;
                }
            },
            error: function (datas) {
            }
        });

    }

    function Ilogin() {
        var yp = $("#phone").val();
        var yc = $("#LCode").val();
        $.ajax({
            type: "get",
            async: false,//同步
            cache: false,//不缓存
            url: "http://127.0.0.1:8083/sms/indexoginyz",
            data: {
                "phone": yp,
                "code": yc,
            },

            success: function (datas) {

                if (datas == null) {
                    alert("登陆失败");
                } else {

                    $("#beforeL").attr("style", "display:none;");
                    $("#afterL").attr("style", "display:block;");

                    $("#afterL").html(datas.userName);
                    var date = new Date().getTime();
                    localStorage.setItem("tokenuser", datas.userId, date + 43200000);


                }
            },
            error: function (datas) {
            }
        });

    }

    function out() {
        alert("确认退出");
        localStorage.removeItem('tokenuser');

        top.location.reload();
    }
}