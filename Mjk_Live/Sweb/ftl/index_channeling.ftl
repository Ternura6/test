<!DOCTYPE html>
<html lang="en">
<head>
    <title>直播......</title>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
    <meta charset="UTF-8">


    <style>

        #example {

            width: 100%;
            height: 100%;
            position: absolute;
            left: 0px;
            margin-top: 0px;
            overflow: hidden;
        }

    </style>
    <link rel="stylesheet" type="text/css" href="css/index_channeling.css" />
    <link rel="stylesheet" href="font-awesome-4.7.0/css/font-awesome.min.css">
    <link href="bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="js/video-js.css" rel="stylesheet">

</head>
<script src="js/vendor/modernizr-3.7.1.min.js"></script>
<script src="js/vendor/jquery-3.4.1.min.js"></script>
<script src="js/plugins.js"></script>
<script src="js/main.js"></script>
<script src="js/vendor/jquery.cookie.js"></script>
<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="build/three.js"></script>
<script src="js/renderers/CanvasRenderer.js"></script>
<script src="js/renderers/Projector.js"></script>
<script src="build/mxreality.js"></script>
<script src="build/ptools.js"></script>

<script src="js/video.js"></script>
<script src="js/videojs-contrib-hls.js"></script>

<script>
    window.onload=function () {

        first();
        vingC();
        livetime();
        ncount();
        showCode();
		danmuCZ();
        vd();
        atc();
        epass();

    }
    function closemm() {
        $("#passyz").hide();
        $("#inputpass").val("");
        $("#psyz").hide();
        window.close();
    }
    function channpassyz() {
        var inputpass=$("#inputpass").val();
        var cpass =$("#cpass").val();

        if (inputpass!=cpass){
            $("#psyz").show();

            $("#psyz").text("密码错误")

        }else if (inputpass==cpass){
            $("#psyz").hide();
        }

    }
    function intocing() {

        var inpass=  $("#inputpass").val();
        var cpass =$("#cpass").val();
        if (inpass==null||inpass==""){
            $("#psyz").show();
            $("#psyz").text("输入密码后进入")
        } else {
        if (inpass==cpass){
            $("#passyz").hide();
            window.sessionStorage["mm"]=cpass;
        }else {
            $("#passyz").show();

            alert("密码错误，无法进入");
        }
        }
    }

    function epass() {
            var cpass =$("#cpass").val();
            var  epass= window.sessionStorage.getItem("mm");
        if (epass==undefined||epass==null||epass!=cpass||epass==""){
            if (cpass==null||cpass==""){
                $("#passyz").hide();
            }else {
                $("#passyz").show();
            }
        }
    }
    //是否展示聊天记录页面
    function vd() {
        $.ajax({
            type:"post",
            url:"http://192.168.3.252:8084/live/SelectvD",
            data:{
                "id":${channel.channelId},
            },
            success: function (datas) {
                if (datas==1){
                    $("#speak").children(".sping").show();
                } else if (datas==0)
                    $("#speak").children(".sping").hide();
            },
            error: function (datas) {
            }
        })
    }
    //是否开启禁言
    function atc() {
        $.ajax({
            type:"post",
            url:"http://192.168.3.252:8084/live/selectvallowtc",
            data:{
                "id":${channel.channelId},
            },
            success: function (datas) {
                 if (datas==1){
                     $("#Button1").attr("disabled", false);
                     $("#Button1").val("发送");
                 } else if (datas==0){
                     $("#Button1").attr("disabled", true);
                     $("#Button1").val("禁言");
                 }
            },
            error: function (datas) {
            }
        })
    }
    //  在线人数
    function ncount() {
        setTimeout(function(){ ncount();},1000);
        $.ajax({
            type:"get",
            url:"http://192.168.3.252:8084/admin/selectVisitTimes",
            data:{
                "id":${channel.channelId},
            },
            success: function (datas) {

                $("#ncount").text(datas);
            },
            error: function (datas) {
            }

        })
    }

    function livetime() {
        var date = new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        var hour = date.getHours();
        var minute = date.getMinutes();
        var second = date.getSeconds();
        //当前时间
        var Ntime =year+'-'+getzf(month)+'-'+getzf(day)+' '+getzf(hour)+':'+getzf(minute)+':'+getzf(second)
        //查出直播时间
        var Etime = "${channel.channelBtime}";
        $("#Et").text(Etime);
        timeto(Ntime,Etime);
    }

    //判断是否到达直播时间

    function timeto(Ntime,Eime) {

        if (Ntime<Eime){
            $("#timeout").css("display","block");
            var date = new Date();
            var year = date.getFullYear();
            var month = date.getMonth() + 1;
            var day = date.getDate();
            var hour = date.getHours();
            var minute = date.getMinutes();
            var second = date.getSeconds();
            //当前时间
            Ntime = year + '-' + getzf(month) + '-' + getzf(day) + ' ' + getzf(hour) + ':' + getzf(minute) + ':' + getzf(second)


            //查出直播时间
            Eime = $("#Et").text();

            setTimeout(function (){timeto(Ntime,Eime) }, 1000);

        }else    {
            //到直播时间时
            $("#timeout").css("display", "none");

        }

    }

    //补0操作
    function getzf(num){
        if(parseInt(num) < 10){
            num = '0'+num;
        }
        return num;
    }
    function vingC() {
        var lj= $("#spanbt1").val();
        var ty =$("#ctype").val();
        if (ty==2){
            $("#pt").css('display','none');
            $("#example").css('display','block');
            init(lj);
        }else if (ty==1){
            $("#example").css('display','none');
            $("#pt").css('display','block');
            ptving(lj);
        }
    }
    //普通播放器
    function ptving(surl) {
        var src="";
        if (surl==null){
            src =$("#spanbt1").val();

        }else {
            src =surl;
        }
        $("#ptce").attr("src",src);


    }

    function first() {

        var ad =localStorage.getItem("admin");
        var token = localStorage.getItem("${uid}tokenuser");//获取本地存储的token值
        if (ad==${uid}) {
            $("#Button1").attr("disabled", false);
            $("#noLo").hide();
            $("#Button1").css({
                "background-color":"rgb(87, 185, 255)",
                "border":"1px solid #a7def9",
            })
            $('#name').attr("value", "管理员");
            $('#userid').attr("value",${user.userId});
            $("#beforeL").attr("style","display:none;");
            $("#afterL").attr("style","display:block;");
            $("#afterLsp").html("管理员");

        }
       else if (token==null&&ad==null){
            var r ="        ";
            $("#noLo").show();
            var l = $("#noLt").html();
            $("#SpeakInput").attr("placeholder", r+ l);
            $("#afterL").attr("style","display:none;");
            $("#Button1").attr("background-color","#ddd");;
            $("#Button1").attr("disabled", true);
            $("#Button1").css({
                "background-color":"#ddd",
                "border":"1px solid #ccc",
            })
        }else {
            $("#Button1").attr("disabled", false);
            $("#noLo").hide();
            $("#Button1").css({
                "background-color":"rgb(87, 185, 255)",
                "border":"1px solid #a7def9",
            })
            $('#name').attr("value", "${user.userName}");
            $('#userid').attr("value",${user.userId});
            $("#beforeL").attr("style","display:none;");
            $("#afterL").attr("style","display:block;");
            $("#afterLsp").html("${user.userName}");



        }
        $("#speak").scrollTop($("#speak")[0].scrollHeight);
    }
    function init(spurl) {
        var HtPurl="";
        //播放器

        if (spurl==null){
            HtPurl =$("#spanbt1").val();
        }else {
            HtPurl =spurl;
        }
        var scene, renderer;
        var container;
        //renderer = new THREE.WebGLRenderer();
        AVR.debug = true;
        if (!AVR.Broswer.isIE() && AVR.Broswer.webglAvailable()) {
            renderer = new THREE.WebGLRenderer();
        } else {
            renderer = new THREE.CanvasRenderer();
        }
        renderer.setPixelRatio(window.devicePixelRatio);
        container = document.getElementById('example');
        container.appendChild(renderer.domElement);


        scene = new THREE.Scene();

        // fov 选项可调整初始视频远近
        var vr = new VR(scene, renderer, container, {"fov": 50});

        // vr.playText="<img src='img/play90.png' width='40' height='40'/>";
        vr.vrbox.radius = 600;
        if (AVR.isCrossScreen()) {
            // 调整vr视窗偏移量
            vr.effect.separation = 1.2;
        }
        vr.loadProgressManager.onLoad = function () {
            // 视频静音
            vr.video.muted = true;
            vr.VRObject.getObjectByName("__mxrealityDefault").visible = true;
        }
        AVR.useGyroscope=false;
        vr.init(function () {

        });

        vr.playPanorama(HtPurl , vr.resType.sliceVideo);
        vr.video.setAttribute("loop", "loop");
        vr.video.crossOrigin = "Anonymous";

        vr.video.onended = function () {
        }
    }
    function numberL() {
        var phone =$("#phone").val();
        okphone = /^1[3456789]\d{9}$/;
        if(phone.test(okphone)){
            var npyz =document.getElementById("NewPhoneSpan");
            npyz.style.display="none";
        }else {
            var er =document.getElementById("NewPhoneSpan");
            er.style.display="block";
            $("#NewPhoneSpan").val(" ");
        }

    }
    function sinc() {
        var lphone =$("#phone").val();
        $.ajax({
            type : "get",
            async: false,//同步
            cache: false,//不缓存
            url : "http://192.168.3.252:8083/sms/Loginbyphone",
            data :{
                "phone":lphone,
            },

            success : function(datas) {
                if (datas==1 || datas==2){
                    return true;

                }else {
                    return false;
                }
            },
            error: function (datas) {
            }
        });

    }
    function Ilogin() {
        var yp =$("#phone").val();
        var yc =$("#LCode").val();
        if ((yp==""||yp==null)||(yc==""||yc==null)){

            alert("手机号和验证码不可为空");
            return false;
        }
        $.ajax({
            type : "get",
            async: false,//同步
            cache: false,//不缓存
            url : "http://192.168.3.252:8083/sms/indexoginyz",
            data :{
                "phone":yp,
                "code":yc,
            },

            success : function(datas) {

                if (datas==null){
                    alert("登录失败");
                }else {

                    $("#beforeL").attr("style","display:none;");
                    $("#afterL").attr("style","display:block;");
                    if (datas.userCompany!=null&&datas.userId==${uid}){
                        $("#afterLsp").html("管理员");
                        var date = new Date().getTime();
                        $("#or").show();
                        localStorage.setItem("admin", datas.userId, date + 43200000);
                    }
                    else {
                        $("#afterLsp").html(datas.userName);
                        var date = new Date().getTime();
                        $("#or").hide();
                        localStorage.setItem("${uid}tokenuser", datas.userId, date + 43200000);
                    }
                }
               location.reload();
            },
            error: function (datas) {
            }
        });

    }
    function out(){
        alert("确认退出")
        localStorage.removeItem('${uid}tokenuser');
        localStorage.removeItem('admin');
        top.location.reload();
    }

    function toH() {

        window.open("http://192.168.3.252:8088/Sweb/index"+${uid} +".html");
    }
    function userad() {

        location.href="http://192.168.3.252:8088/channel_personal.html";
    }
    //  机位
    function chan(cs){
        $("#"+cs).css({
            "background-color": "#57b9ff",
            "border": "#bad1dc",
        });
        $("#"+cs).siblings().css('background-color', '#f6f6f6');

        var ppp= $('#span'+cs).val();

        var jitp =$('#span'+cs).prop("class");
        if (jitp==2){
            $("#example").empty()
            $("#pt").css('display','none');
            $("#example").css('display','block');
            init(ppp);
        }else if (jitp==1){
            $("#pt").empty();
            $("#example").css('display','none');
            $("#pt").css('display','block');
            ptving(ppp);
        }

    }
    function showCode() {



        var img = "http://192.168.3.252:8084/createCommonQRCode?id="+ ${channel.channelId};
        var b =document.getElementById("erwm");
        $("#er").attr('src',img);

        var integrityurl = window.location.href;
        $("#indexurl").val(integrityurl);
    }

    //  手机观看 移入移出事件
    function phonin() {
        $("#erwm").show();
    }
    function phonout() {
        $("#erwm").hide();
    }
    //  分享链接 移入移出事件
    function fxin() {
        $("#fx").show();
    }
    function fxout() {
        $("#fx").hide();
    }
    function danmuCZ() {


        $.ajax({
            type : "get",
            async: false,//同步
            cache: false,//不缓存
            url : "http://192.168.3.252:8084/live/selectBarrageById",
            data :{
                "id":${channel.channelId}
            },
            success : function(datas) {
                if (datas==null){
                    alert("用户信息加载失败")

                }else {
                    ///清空节点
                    $("#speak").empty();
                    //取出后端传过来的list值
                    var chargeRuleLogs = datas;
                    //对list值进行便利
                    var maxH =$("#example").height();

                    var randomTop=Math.floor(Math.random()*maxH);
                    $.each(chargeRuleLogs, function (index, n) {
                        var unixTimestamp = new Date(n.channelBtime);
                        Date.prototype.toLocaleString = function () {
                            return this.getFullYear() + "-" + (this.getMonth() + 1) + "-" + this.getDate() + " " + this.getHours() + ":" + this.getMinutes();
                        };
                        commonTime = unixTimestamp.toLocaleString();

                        var rowTr = document.createElement('tr');
                        //找到html的tr节点


                        var child;
                        rowTr.className = "tr_node";
                        var gl ="管理员"
                        if (n.userName=="管理员"){
                            child =    $(" <div class=\"sping\" id=\"sping\"> " +
                                " <img class=\"spimg\" src=\"img/per.png\">  " +
                                "<span class=\"rsp\" id=\"rsp\">" +
                                "<p>" + gl  + "</p>" +
                                "<div class=\"gf\">官方</div>"+
                                "<span class=\"hdnr\">" + n.content + "</span>" +
                                "</span>" +
                                "<div class=\"ctime\">" +n.createTime+"</div>"+
                                "</div>");

                        }else {

                            child =    $(" <div class=\"sping\" id=\"sping\"> " +
                                " <img class=\"spimg\" src=\"img/per.png\">  " +
                                "<span class=\"rsp\" id=\"rsp\">" +
                                "<p>" + n.userName+ "</p>" +
                                "<span class=\"hdnr\">" + n.content  + "</span>" +
                                "</span>" +
                                "<div class=\"ctime\">" +n.createTime+"</div>"+
                                "</div>");
                        }
                        //将信息追加
                        $("#speak").append(child);
                        $("#speak").scrollTop($("#speak")[0].scrollHeight);
                        var danmu ='<span class="spring">'+n.content + '</span>'

                        $(".spring").css({
                            "color":getRandomColor(),
                            "top":randomTop,
                        });
                        $("#dmk").append(danmu);

                        $(".spring").animate({left:'-10px'},10000,function(){
                            //移除元素
                            $(this).remove();

                        });

                        $("#SpeakInput").val("");

                    })


                }
            },
            error: function (datas) {
            }

        });
    }
	  function getRandomColor(){
    var colorArr = ['1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'];
    var color = "";
    for(var i = 0; i < 6; i++){
      color += colorArr[Math.floor(Math.random()*16)];
    }
    return "#"+color;
  }
  $(function () {
    $("#Button1").click(function () {


      $("#text").animate({left:'100px'});

    })

  })
</script>
<script type="text/javascript">
    var admin =localStorage.getItem("admin");
    var ws;
    function ToggleConnectionClicked() {
        try {
            <#--ws = new WebSocket("ws://192.168.3.252:8084/chatroom/"+${channel.channelId});//连接服务器-->
            <#--ws.onopen = function(event){-->
                <#--alert("已经与服务器建立了连接rn当前连接状态："+this.readyState);-->
            <#--};-->
            ws.onmessage = function(event){
                //返回值
                // alert("接收到服务器发送的数据：rn"+event.data);
                var name = $("#name").val();
                var date = new Date();
                var year = date.getFullYear();
                var month = date.getMonth() + 1;
                var day = date.getDate();
                var hour = date.getHours();
                var minute = date.getMinutes();
                var second = date.getSeconds();
                //当前时间
                var Ntime = year + '-' + getzf(month) + '-' + getzf(day) + ' ' + getzf(hour) + ':' + getzf(minute) + ':' + getzf(second);

                var name ="";
                var ul_li;
                if (admin!=null){

                    name ="管理员";
                    ul_li = $(" <div class=\"sping\" id=\"sping\">" +
                        "  <img class=\"spimg\" src=\"img/per.png\"> " +
                        " <span class=\"rsp\" id=\"rsp\">" +
                        "<p>" + name + "</p>" +
                        " <div class=\"gf\">官方</div>"+
                        "<span class=\"hdnr\">" + event.data + "</span>" +
                        "</span>" +
                        "<div class=\"ctime\">" +Ntime +"</div>"+
                        "</div>");
                }else  {
                    var name =$("#afterL").html();
                    ul_li = $(" <div class=\"sping\" id=\"sping\">" +
                        "  <img class=\"spimg\" src=\"img/per.png\"> " +
                        " <span class=\"rsp\" id=\"rsp\">" +
                        "<p>" + name + "</p>" +
                        "<span class=\"hdnr\">" + event.data + "</span>" +
                        "</span>" +
                        "<div class=\"ctime\">" +Ntime +"</div>"+
                        "</div>");
                }

                //将信息追加
                var b = $("#speak");
                b.append(ul_li);
                $("#speak").scrollTop($("#speak")[0].scrollHeight);
                $("#SpeakInput").val("");
            };
            ws.onclose = function(event){
                //alert("已经与服务器断开连接rn当前连接状态："+this.readyState);
            };
            ws.onerror = function(event){
               // alert("WebSocket异常！");
            };
        } catch (ex) {
            alert(ex.message);
        }
    };

    function SendData() {
        var font =$("#SpeakInput").val();
        var ad =localStorage.getItem("admin");
        var token = localStorage.getItem(${channel.userId}+"tokenuser");//获取本地存储的token值

        if ((ad==null||ad=="")&&(token==null||token=="")){
            $("#Button1").attr("disabled", true);
            return ;
        }
        else {
            $("#Button1").attr("disabled", false);

            var font =$("#SpeakInput").val();

            try{
                ws.send(font);
            }catch(ex){
                alert(ex.message);
            }
        }
    };

    function seestate(){
        alert(ws.readyState);
    }

    var lockReconnect = false;  //避免ws重复连接
    var ws = null;          // 判断当前浏览器是否支持WebSocket
    var wsUrl ="ws://192.168.3.252:8084/chatroom/"+${channel.channelId};//连接服务器 "ws://192.168.3.252:8084/chatroom/" + str ;
    createWebSocket(wsUrl);   //连接ws

    function createWebSocket(url) {
        try{
            if('WebSocket' in window){
                ws = new WebSocket(url);
            }
            ToggleConnectionClicked();
        }catch(e){
            reconnect(url);
            console.log(e);
        }
    }


    // 监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
    window.onbeforeunload = function() {
        ws.close();
    }

    function reconnect(url) {
        if(lockReconnect) return;
        lockReconnect = true;
        setTimeout(function () {     //没连接上会一直重连，设置延迟避免请求过多
            createWebSocket(url);
            lockReconnect = false;
        }, 2000);
    }

    //心跳检测
    var heartCheck = {
        timeout: 1000,        //1分钟发一次心跳
        timeoutObj: null,
        serverTimeoutObj: null,
        reset: function(){
            clearTimeout(this.timeoutObj);
            clearTimeout(this.serverTimeoutObj);
            return this;
        },
        start: function(){
            var self = this;
            this.timeoutObj = setTimeout(function(){
                //这里发送一个心跳，后端收到后，返回一个心跳消息，
                //onmessage拿到返回的心跳就说明连接正常
                ws.send("ping!");
                console.log("ping!")
                self.serverTimeoutObj = setTimeout(function(){//如果超过一定时间还没重置，说明后端主动断开了
                    ws.close();     //如果onclose会执行reconnect，我们执行ws.close()就行了.如果直接执行reconnect 会触发onclose导致重连两次
                }, self.timeout)
            }, this.timeout)
        }
    }

</script>
<script>

    $(function(){
        $('#span_fa').click(function(){//点击a标签
            if($('#li').is(':hidden')){//如果当前隐藏
                $('#li').show();//那么就显示div
            }else{//否则
                $('#li').hide();//就隐藏div
            }
        })
    })
    $(function () {
        $(document).click(function(){
            $('#li').hide();
        });
        $('#span_fa').click(function(event){
            event.stopPropagation();
        });
        $('#li').click(function(event){
            event.stopPropagation();
        });
    })
    $(function () {
        $('#btn').click(function () {
            var count = 60;
            var countdown = setInterval(CountDown, 1000);
            function CountDown() {
                $("#btn").attr("disabled", true);
                $("#btn").val("请" + count + "秒后再试");
                if (count == 0) {
                    $("#btn").val("发送验证码").removeAttr("disabled");
                    clearInterval(countdown);
                }
                count--;
            }
        })
    });

    $(function () {
        $("#DM").click(function (){
            var dm = $('#DM')[0].src

            var index = dm.lastIndexOf("\/")
            var addrLast = decodeURI(dm.substring(index + 1, dm.length));

            if (addrLast=="dmOpen.png"){
                $("#DM").attr("src","img/dmClose.png")
            }else {
                $("#DM").attr("src","img/dmOpen.png")
            }

        })

    })
    $(function () {
        $(document).click(function(){
            $('#erji').hide();

        });
        $('#span_fa').click(function(event){
            $('#erji').hide();
        });
        $('#percen').click(function(event){
            event.stopPropagation();
        });
        $('#erji').click(function(event){
            event.stopPropagation();
        });
    })
</script>
<script>
    $(function () {

        $("#Button1").click(function () {

            //获取昵称
            // $("#sping").style.display="block";
            var name = $("#name").val();
            var uid = $("#userid").val();
            //获取内容
            var SpeakInput = $("#SpeakInput").val();
            $.ajax({
                type: "post",
                async: false,//同步
                cache: false,//不缓存
                url: "http://192.168.3.252:8084/live/addBarrage",
                data: {
                    "channelId": ${channel.channelId},
                    "userId": uid,
                    "userName": name,
                    "content": SpeakInput
                },
                success: function (datas) {

                    if (datas == 1) {
                    } else if (datas == 2) {
                    }
                },
                error: function (datas) {
                    alert("error")
                }

            });

        });
    });
    function copyUrls() {
        var pageUrl = document.getElementById("indexurl");
        pageUrl.select();
        document.execCommand("Copy"); // 执行浏览器复制命令
    }
</script>
<body>
<input id="cpass" style="display: none" value="${channel.channelPassword}"  >
<input id="cid" style="display: none" value="${channel.channelId}"  >
<input id="ctype" style="display: none" value="${channel.channelType}"  >
<div class="ttop">
    <!--  logo-->
    <div class="t1">

    </div>
    <!--  type-->
    <div class="t2">
        <div class="ctitle">
            <div class="tl1">
                <div class="tl1-1" id="vname">
                    ${channel.channelName}
                </div>
                <div class="tl1-2">
                    <img  id="DM" src="img/dmOpen.png">
                </div>
            </div>
            <div class="tl2">
                <span id="auid" style="display: none"></span>
                <div class="tl2-1" id="vautor">
                    ${user.userName}
                </div>
                <div class="tl2-2" id="tl2-2" onmousemove="phonin()" onmouseout="phonout()">
                    <img src="img/smioc.png">
                    <i id="pher">手机观看</i>
                    <div class="erwm" id="erwm">
                        <img src="" id="er">
                    </div>

                </div>


                <div class="tl2-3" onmousemove="fxin()" onmouseout="fxout()" >
                    <img src="img/fx.png">
                    <i>分享</i>
                    <div class="fx" id="fx">
                        <div id="tefxb" class="tefxb">
                            <input type="text" id="indexurl" style="float:left;width: 344px;" class="form-control whatch"  value="" readonly="readonly">
                            <button type="button" id="info" style="margin-bottom: 10px;" class="btn btn-info" onclick="copyUrls()"> 复制</button>
                        </div>
                    </div>
                </div>


                <div class="tl2-4">
                    <img src="img/utx.png">
                    <i id="ncount">0</i>
                </div>
            </div>
        </div>
    </div>
    <!--  login-->
    <div class="t3">

        <div class="dl"   id="beforeL" data-toggle="modal" data-target="#indexLohin" >
            未登录
        </div>
        <div id="afterL" >
            <span id="afterLsp"></span>
            <i class="fa fa-sort-desc" id="span_fa"></i>
        </div>
        <div id="li">
            <div>

                <div aria-hidden="true" class="li1 fa fa-sign-out" id="percen" onclick="userad()">个人中心</div>

                <div  aria-hidden="true" class="li1 fa fa-university" onclick="toH()">我的主页</div>

                <div aria-hidden="true" class="li1 fa fa-cog" onclick="out()">退出登录</div>
            </div>

        </div>

    </div>




</div>
<div class="channeling">
    <div class="bfq" >
        <div class="cingL">

            <div id="ving"class="col-lg-12 ving" style=" padding: 0px;   height:100%;">
                <input id="hpurl" style="display: none" value="">
                <div class="col-xs-12 col-cinfo" style="padding: 0px;">
                    <div id="danmu">

                        <!-- 弹幕 高度在播放器高度内随机，从右到左，颜色随机，超出屏幕宽度消失，-->
                        <div id="example" style="width: 100%;
	          height: 100%;
	          position: absolute;
	          left: 0px;
	          margin-top: 0px;
	          overflow: hidden;
" class="video-ving">
                            <div id="dmk">
                                <!--           弹幕框不限高度，弹幕在播放器长宽内随机-->
                                <span id="test2" style="position: absolute; color:whitesmoke;float: left ">12121212</span>
                                <span id="test" style="position: absolute; color:whitesmoke;left: 200px">sdadasdds</span>
                            </div>
                        </div>
                        <#if (channel.channelType)==1>
                        <video id="pt" class="video-js vjs-default-skin" controls preload="auto" width="100%" height="100%"
                               data-setup='{}' >
                            <source src="${channel.httpPush}" type="application/x-mpegURL" id="ptce">
                        </video>
                        </#if>
                    </div>
                    <div id="timeout" style="display: none">
                        <img src="img/Vbm.png">
                        <div id="tm">
                            <h3>即将播放...</h3></br>
                            <h5 id="Et">2019-10-10 20:00</h5>
                        </div>
                    </div>

                </div>

            </div>
        </div>
        <div class=" toking">
            <div class=" top">
                <span class="toptitle" id="title">直播互动</span>
                <span id="uid" style="display: none"></span>

            </div>

            <div class=" speak " id="speak">
                <#if cont?? && (cont?size > 0)>
               <#list cont as cl >
                   <div class="sping" id="sping">
                       <img class="spimg" src="img/per.png">
                       <span class="rsp" id="rsp">
          <#if cl.userName=="管理员" >
               <p> ${cl.userName} </p>
               <div class="gf">官方</div>
            <#else>
               <p>${cl.userName}</p>
          </#if>
               <span class="hdnr">${cl.content}</span>
               </span>
               <div class="ctime">${cl.createTime}</div>
               </div>
               </#list>
                </#if>
            </div>
            <div class=" sent">
                <input id="userid" style="display: none" type="text" value="">
                <input id="name" style="display: none" type="text" value="">
                <textarea value="" rows=1 style="overflow:hidden; padding: 7px;"  onscroll="this.style.height=this.scrollHeight+4" id="SpeakInput" type="text" placeholder="可以发言啦"></textarea>

                <span id="nr" style="display: none">
     <i id="noLt">发送消息，与主播互动</i>

  </span>
                <i id="noLo" data-toggle="modal" data-target="#indexLohin">登录</i>
                <input id="Button1" type="button" value="发送" onclick="SendData()"/>

            </div>
        </div>
        <div class="butt" id="butt">
            <button class="bt" id="bt1" style="background-color: #57b9ff;" onclick="chan(this.id)">主机位</button>
            <#if (channel.httpPush)??>
                <input id="spanbt1"   style="display: none" value="${channel.httpPush}" class="${channel.channelType}">

            </#if>

            <#list jwlist as iteam>
                <#if iteam.setupType?? >
                    <button class="bt" id="${iteam.sid}" onclick="chan(this.id)">
                        <#if iteam.setupType == 1>${iteam.setupName}</#if>
                        <#if iteam.setupType == 0>${iteam.setupName}</#if>
                    </button>
                    <input id="span${iteam.sid}" class="${iteam.setupType}"  style="display: none" value="${iteam.setupHttp}">

                </#if>
            </#list>

        </div>
        <div class="cinfo">
            <p>直播简介</p>
            <div id="clive_info">
                ${channel.channelBrief}
            </div>
        </div>
    </div>


</div>
<!--模态框-->
<!--         //首页登录-->
<!-- 模态框（Modal） -->
<div class="modal fade" id="indexLohin" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel4">登录美吉克直播</h4>
            </div>
            <div class="modal-body">
                <input type=text class="form-control" id="phone" name="phone" placeholder="账号" onblur="numberL()">
                <span style="display: none; color: red" id="NewPhoneSpan">邮箱格式错误</span>
                <!--        //确认密码-->
                <input type="text" class="form-control" id="LCode" name="IsPassWord" placeholder=" 请输入验证码" >
                <div id="SCode" onclick="sinc()">

                    <input type="button" id="btn" value="发送验证码" /></div>

            </div>

            <div class="buLogin">
                <button onclick="Ilogin()"  type="button" class="btn btn-default" data-dismiss="modal" id="loginB">登录</button>
            </div>

            <div class="modal-footer">


            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<#--频道密码验证-->
<div class="passyz" id="passyz" style=" display: none; width: 100%;height: 100%; background-color: rgba(0,0,0,.5); position: fixed; top: 0px;">
    <div class="pass" style=" width: 500px;height: 300px;background-color: white;top: 200px;position: relative; text-align: center; padding: 10px;">
        <img src="img/error.png" style="    position: absolute; right: 10px;" onclick="closemm()">
        <input id="Channelid" style="display: none" value="">
        <input id="Channelpass" style="display: none" value="">
        <h2>正在直播</h2>
        <img src="img/Re-passLockIOC.png" style="position: absolute;margin-top: 22px;width: 40px;left: 102px;">
        <input onblur="channpassyz()" type="text" name="setupName" id="inputpass"placeholder="输入密码" style=" width: 300px; height: 45px;margin-top: 20px;    padding-left: 50px;">
        <span style="color: red;display: none; position: absolute;  top: 100px;" id="psyz">密码错误</span>
        <div onclick="intocing()" style="margin-top: 10px;width: 300px;height: 35px;background-color: #4dbaf1;padding: 5px;color: white;border: 1px solid #6ea8da;">
            进入直播间
        </div>
    </div>
</div>

</body>
</html>
