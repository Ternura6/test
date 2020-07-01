<!DOCTYPE html>
<html lang="en">
<head>

    <title>直播信息</title>
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

    <link rel="stylesheet" type="text/css" href="css/index_livechanneling.css" />
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
<script src="build_move/three.js"></script>
<script src="js/renderers/CanvasRenderer.js"></script>
<script src="js/renderers/Projector.js"></script>
<script src="build_move/mxreality.js"></script>
<script src="build_move/ptools.js"></script>
<script src="js/video.js"></script>
<script src="js/videojs-contrib-hls.js"></script>

<script>
    window.onbeforeunload = function() {
        ws.close();
    }
    window.onload=function () {
        first();
        vingC();
        ncount();
        var  token =localStorage.getItem("tokenuser");
        epass();
        danmuCZ();

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

    function first() {
        //作者信息
        var  token =localStorage.getItem("tokenuser");
        var ad =localStorage.getItem("admin");
        if (token!=null||ad!=null){
            $("#settp1").hide();
            $("#taking").attr("placeholder","可以发言啦");
            $("#senttp2").attr("src","img/sent_ok.png");
        }

        $.ajax({
            type: "get",
            async: false,//同步
            cache: false,//不缓存
            url: "http://127.0.0.1:8083/login/seByUid",
            data: {
                "userId": ${uid},
            },
            success: function (datas) {
                $("#vautor").html(datas.userName);

            },
            error: function (datas) {
            }

        });

        $.ajax({
            type: "get",
            async: false,//同步
            cache: false,//不缓存
            url: "http://127.0.0.1:8083/login/indexselectByUid",
            data: {},
            beforeSend: function (request) {
                request.setRequestHeader("token", localStorage.getItem("tokenuser"));
            },
            success: function (datas) {
                $("#uname").val(datas.userName);
                $("#settp1").hide();
                $("#taking").attr("placeholder","可以发言啦");
                $("#senttp2").attr("src","img/sent_ok.png");
            },
            error: function (datas) {
            }
        });
    }
    function vingC() {
        var ty =$("#ctype").val();
        if (ty==2){
            $("#pt").css('display','none');
            $("#example").css('display','block');
            init();
        }else if (ty==1){
            $("#colchannel").css('display','none');
            $("#pt").css('display','block');
            ptving();
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


    //var vr=new VR(scene,renderer,container);
    //VR播放器
    function init(spurl) {
        var HtPurl="";

        if (spurl==null){
            HtPurl =$("#spanbt1").val();
        }else {
            HtPurl =spurl;
        }
        var  scene, renderer;
        var container;
        //renderer = new THREE.WebGLRenderer();
        AVR.debug=true;
        if( !AVR.Broswer.isIE() && AVR.Broswer.webglAvailable() ) {
            renderer = new THREE.WebGLRenderer();
        }else {
            renderer = new THREE.CanvasRenderer();
        }
        renderer.setPixelRatio( window.devicePixelRatio );
        container = document.getElementById('example');
        container.appendChild(renderer.domElement);
        scene = new THREE.Scene();

        // fov 选项可调整初始视频远近
        var vr=new VR(scene,renderer,container,{"fov":50});

        //vr.playText="<img src='img/play90.png' width='40' height='40'/>";
        vr.vrbox.radius=600;
        if(AVR.isCrossScreen()) {
            // 调整vr视窗偏移量
            vr.effect.separation=1.2;
        }
        vr.loadProgressManager.onLoad=function () {
            // 视频静音
            vr.video.muted=true;
            vr.VRObject.getObjectByName("__mxrealityDefault").visible = true;
        }
        //AVR.useGyroscope=false;
        vr.init(function () {

        });
        vr.playPanorama(HtPurl,vr.resType.sliceVideo);
        vr.video.setAttribute("loop","loop");
        vr.video.crossOrigin="Anonymous";
        vr.video.onended=function () {
        }

    }
    //  机位切换视频
    function chan(cs){
        $("#"+cs).css({
            "background-color": "#57b9ff",
            "border": "#bad1dc",
        });
        $("#"+cs).siblings().css({
            "background-color":"#eff3f5",
            "color":"#333"
        });

        var ppp= $('#span'+cs).val();

        var jitp =$('#span'+cs).prop("class");
        if (jitp==2){
            $("#example").empty()
            $("#pt").css('display','none');
            $("#example").css('display','block');
            init(ppp);
        }else if (jitp==1){
            $("#pt").empty();
            $("#colchannel").css('display','none');
            $("#pt").css('display','block');
            ptving(ppp);
        }

    }
    function danmuCZ() {


        $.ajax({
            type : "get",
            async: false,//同步
            cache: false,//不缓存
            url : "http://127.0.0.1:8084/live/selectBarrageById",
            data :{
                "id":${channel.channelId}
            },
            success : function(datas) {
                if (datas==null){
                    alert("用户信息加载失败")

                }else {
                    ///清空节点
                    $("#Ps_speak").empty();
                    //取出后端传过来的list值
                    var chargeRuleLogs = datas;
                    //对list值进行便利

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
                        var admin =localStorage.getItem("admin");

                        if (n.userName=="管理员"){
                            child =    $("<div class=\"kk\">  <img src=\"img/ad.png\"> <div class=\"kk_about\"><div class=\"uname\"> " +
                            " <span>管理员 </span> <div class=\"gf\">官方</div></div> <div class=\"Sptext\"><span class=\"hdnr\">" + n.content + "</span> </div>\n" +
                            "        </div>\n" +
                            "   <div class=\"ctime\">"+n.createTime+"</div>"+
                            "        </div>");

                        }else {

                            child =    $("<div class=\"kk\">  <img src=\"img/ad.png\"> <div class=\"kk_about\"><div class=\"uname\"> " +
                                " <span>" + n.userName + "</span> </div> <div class=\"Sptext\"><span class=\"hdnr\">" + n.content + "</span> </div>\n" +
                                "        </div>\n" +
                                "   <div class=\"ctime\">"+n.createTime+"</div>"+
                                "        </div>");
                        }
                        //将信息追加
                        $("#Ps_speak").append(child);
                        $("#Ps_speak").scrollTop($("#Ps_speak")[0].scrollHeight);


                        $("#taking").val("");

                    })


                }
            },
            error: function (datas) {
            }

        });
    }
    <!--返回上一页-->
    function goback() {
        location.href="http://192.168.3.252:8088//Sweb/index${uid}.html";
    }

</script>
<script>
    $(function () {
        $("#senttp2").click(function () {
            var  utoken =localStorage.getItem("tokenuser");

            //获取昵称
            // $("#sping").style.display="block";
            var  name = $("#uname").val();

            //获取内容
            var SpeakInput =  $("#taking").val();


            $("#taking").val("");


            $.ajax({
                type: "post",
                async: false,//同步
                cache: false,//不缓存
                url: "http://127.0.0.1:8084/live/addBarrage",
                data: {
                    "channelId": ${channel.channelId},
                    "userId": utoken,
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
</script>
<script type="text/javascript">

    var ws;
    var  utoken =localStorage.getItem("tokenuser");
    var admin =localStorage.getItem("admin");
    function ToggleConnectionClicked() {
        try {
            //ws = new WebSocket("ws://192.168.3.100:8084/chatroom/"+ );//连接服务器
          //  ws.onopen = function(event){
                //alert("已经与服务器建立了连接rn当前连接状态："+this.readyState);
            //    console.log("已经与服务器建立了连接rn当前连接状态："+this.readyState);
          //  };
            ws.onmessage = function(event){
                //返回值
                // alert("接收到服务器发送的数据：rn"+event.data);
                var date = new Date();
                var year = date.getFullYear();
                var month = date.getMonth()+1;
                var day = date.getDate();
                var hour = date.getHours();
                var minute = date.getMinutes();
                var second = date.getSeconds();
                //当前时间
                var Ntime =year+'-'+getzf(month)+'-'+getzf(day)+' '+getzf(hour)+':'+getzf(minute)+':'+getzf(second)
                var name ="";
                var ul_li="";
                if (utoken!=null){
                  name = $("#uname").val();
                    ul_li = $(" <div class=\"kk\">  <img src=\"img/ad.png\"> <div class=\"kk_about\"><div class=\"uname\">  <span>" + name + "</span>  </div> <div class=\"Sptext\"><span class=\"hdnr\">" + event.data + "</span> </div>\n" +
                        "        </div>\n" +
                        "   <div class=\"ctime\">" + Ntime + "</div>"+
                        "        </div>");
                }else if(admin!=null) {

                    name ="管理员";
                    ul_li = $(" <div class=\"kk\">  <img src=\"img/ad.png\"> <div class=\"kk_about\"><div class=\"uname\">  <span>" + name + "</span> <div class=\"gf\">官方</div></div> <div class=\"Sptext\"><span class=\"hdnr\">" + event.data + "</span> </div>\n" +
                        "        </div>\n" +
                        "   <div class=\"ctime\">" + Ntime + "</div>"+
                        "        </div>");

                }

                //将信息追加
                var b = $("#Ps_speak");
                b.append(ul_li);
                $("#Ps_speak").scrollTop($("#Ps_speak")[0].scrollHeight);
                $("#taking").val("");
            };
            ws.onclose = function(event){
              //  alert("已经与服务器断开连接rn当前连接状态："+this.readyState);
                console.log("已经与服务器断开连接rn当前连接状态："+this.readyState);
            };
            ws.onerror = function(event){
               // alert("WebSocket异常！");
                console.log("WebSocket异常！");
            };
        } catch (ex) {
            alert(ex.message);
        }
    };
    function getzf(num){
        if(parseInt(num) < 10){
            num = '0'+num;
        }
        return num;
    }
    function SendData() {
        if (utoken==null||utoken==""&&admin==null||admin==""){
            return ;
        }
        else {
            var font =$("#taking").val();

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
        },3000);
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
                ws.send("ping");
                console.log("ping!")
                self.serverTimeoutObj = setTimeout(function(){//如果超过一定时间还没重置，说明后端主动断开了
                    ws.close();     //如果onclose会执行reconnect，我们执行ws.close()就行了.如果直接执行reconnect 会触发onclose导致重连两次
                }, self.timeout)
            }, this.timeout)
        }
    }

</script>
<body>
<input id="cpass" style="display: none" value="${channel.channelPassword}"  >
<input id="uname" style="display: none" value=""  >
<#--存放机位类型-->
<input id="ctype" style="display: none" value="${channel.channelType}"  >
<div class="cen">
    <div class="top">
<#--页首-->
        <div class="t1">

            <img src="img/logo.png" class="t1im2">
        </div>
        <div class="title">
            <span id="cname">${channel.channelName}</span>
        </div>

    </div>

<#--播放器区域-->
    <div class="ving">


        <div class="col-lg-12" id="colchannel" style="     height: 100%;
    position: relative;
    top: 0px;">
            <div id="example" style="width: 100%;
	          height: 100%;
	          position: absolute;
	          left: 0px;
	          display: none;
	          /* top: 0px; */
	          overflow: hidden;">
            </div>
        </div>
        <#if (channel.channelType)==1>
            <video id="pt" class="video-js vjs-default-skin" controls preload="auto" width="100%" height="100%"
                   data-setup='{}' >
                <source src="${channel.httpPush}" type="application/x-mpegURL" id="ptce">
            </video>
        </#if>
    </div>
    <#--频道信息-->
    <div class="vabout">
        <div class="p1">
            <h4 id="cname1">${channel.channelName}</h4>
            <div class="tright">
                <img src="img/dmtp.png">
                <img src="img/dmtext.png">
                <span>|</span>
                <img src="img/person-count.png">
                <i id="ncount">0</i>
            </div>

        </div>
        <div class="p2">
            <div class="t_jw">
                <span>机位选择</span>
            </div>
            <div id="jwdiv">

                    <#if (channel.channelType) == 2>
                        <#if channel.httpPush??>
                        <input id="spanbt1"   style="display: none"  value="${channel.httpPush}" class="1">
                        </#if>
                    </#if>
                    <#if (channel.channelType) == 1>
                        <#if channel.httpPush??>
                        <input id="spanbt1"   style="display: none"  value="${channel.httpPush}"  class="0">
                        </#if>
                </#if>

                <button class="bt" id="bt1" style="  background-color: #57b9ff;  color: white;" onclick="chan(this.id)">主机位</button>

                <#list jwlist as iteam>
                    <#if iteam.setupType?? >

                        <button class="bt" id="${iteam.sid}"  onclick="chan(this.id)">
                            <#if iteam.setupType == 1>VR</#if>
                            <#if iteam.setupType == 0>普通</#if>

                        </button>
                        <input id="span${iteam.sid}" class="${iteam.setupType}"  style="display: none" value="${iteam.setupHttp}">

                    </#if>
                </#list>
            </div>
        </div>
    </div>

    <div class="vsomething">
        <ul class="nav nav-tabs" style="width: 50%;">
            <li class="active"><a href="#speak" data-toggle="tab">直播互动</a></li>
            <li><a href="#info" data-toggle="tab">直播简介</a></li>

        </ul>

        <div class="tab-content">
            <div class="tab-pane active" id="speak">
                <div class="PS_speak" id="Ps_speak">

                </div>

                <div class="tospeak">
                    <a href="http://192.168.3.252:8088/Mjk_Live_move/login.html">
                        <img src="img/Plg.png" class="sentp1" id="settp1">
                    </a>
       <textarea value="" rows=1 style="overflow:hidden; " onscroll="this.style.height=this.scrollHeight+4" class="taking" id="taking"type="text" name="taking" placeholder="我来说两句"></textarea>

                    <img src="img/sent_no.png" id="senttp2" class="senttp2" onclick="SendData()">
                </div>
            </div>
            <div class="tab-pane" id="info">
                <div class="infoByid">
                    <h6 id="cinfo">
                        ${channel.channelBrief}
                    </h6>
                </div>
            </div>

        </div>
    </div>
</div>


<#--频道密码验证-->
<div class="passyz" id="passyz" style=" display: none; width: 100%;height: 100%; background-color: rgba(0,0,0,.5); position: fixed; top: 0px;">
    <div class="pass" style=" width: 325px;height: 250px;background-color: white;top: 200px;position: relative; text-align: center; padding: 10px;">
        <img src="img/error.png" style="    position: absolute; right: 10px;" onclick="closemm()">
        <input id="Channelid" style="display: none" value="">
        <input id="Channelpass" style="display: none" value="">
        <h2>正在直播</h2>
        <img src="img/Re-passLockIOC.png" style="position: absolute;margin-top: 22px;width: 40px;left: 15px;">
        <input onblur="channpassyz()" type="text" name="setupName" id="inputpass"placeholder="输入密码" style=" width: 300px; height: 45px;margin-top: 20px;    padding-left: 50px;">
        <span style="color: red;display: none; position: inherit;  top: 0px;" id="psyz">密码错误</span>
        <div onclick="intocing()" style="margin-top: 10px;width: 300px;height: 35px;background-color: #4dbaf1;padding: 5px;color: white;border: 1px solid #6ea8da;">
            进入直播间
        </div>
    </div>
</div>

</body>
</html>
