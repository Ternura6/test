<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>首页</title>
    <link rel="stylesheet" type="text/css" href="css/index.css" />
    <link rel="stylesheet" href="font-awesome-4.7.0/css/font-awesome.min.css">
    <link href="bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
</head>
    <script src="js/vendor/modernizr-3.7.1.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jquery-3.4.1.min.js"><\/script>')</script>
        <script src="js/plugins.js"></script>
        <script src="js/main.js"></script>
        <script src="js/vendor/jquery.cookie.js"></script>
        <script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script language="JavaScript" type="text/javascript">
    window.onload=function () {
        inde();
        ncount();
    }
      function inde() {

          var adm =$.cookie("admin");
          if (adm!= null){
              var date = new Date().getTime();

              localStorage.setItem("admin", adm, date + 3*24*3600*1000 );
          }
        var ad =localStorage.getItem("admin");
          var token = localStorage.getItem("${uid}tokenuser");//获取本地存储的token值

          if (ad==${uid}){
              $("#beforeL").attr("style", "display:none;");
              $("#afterL").attr("style", "display:block;");

              $("#afterLsp").html("管理员");
          } if ((token==null||token=="")&&(ad==null||ad=="")){
              $("#beforeL").attr("style", "display:block;");
              $("#afterL").attr("style","display:none;");


          }
         else if(token!=null){

             $.ajax({
                 type: "get",
                 async: false,//同步
                 cache: false,//不缓存
                 url: "http://192.168.3.252:8083/login/indexselectByUid",
                 data: {},
                 beforeSend: function (request) {
                     request.setRequestHeader("token", localStorage.getItem("${uid}tokenuser"));
                 },
                 success: function (datas) {

                     if (datas == null) {
                         alert("用户信息加载失败")

                     } else {

                         $("#beforeL").attr("style", "display:none;");
                         $("#afterL").attr("style", "display:block;");

                         $("#afterLsp").html(datas.userName);

                         // var ifr = document.all("iframe_id");
                         // window.result.location.href=ifr.src +"?username=" +datas.userName+ "&usercompany=" +datas.userCompany +"&userphone=" +datas.userPhone;
                     }
                 },
                 error: function (datas) {
                 }
             });



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
                    setTimeout("alert('验证码已发送，注意查收')",3000);
                    return true;

                }else {
                    setTimeout("alert('发送失败')",3000);
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
            url: "http://192.168.3.252:8083/sms/indexoginyz",
            data: {
                "phone": yp,
                "code": yc,
            },

            success: function (datas) {

                if (datas == null) {
                    alert("登录失败");
                } else {


                    $("#beforeL").attr("style","display:none;");
                    $("#afterL").attr("style","display:block;");
                    if (datas.userCompany!=null&&datas.userId==${uid}){
                        $("#afterLsp").html("管理员");
                        $("#or").show();
                        var date = new Date().getTime();
                        localStorage.setItem("admin", datas.userId, date + 43200000);
                    }
                    else {
                        $("#afterL").html(datas.userName);
                        var date = new Date().getTime();
                        $("#or").hide();
                        localStorage.setItem("${uid}tokenuser", datas.userId, date + 43200000);
                    }


                }
            },
            error: function (datas) {
            }
        });
    }

    function out(){
        alert("确认退出");
        localStorage.removeItem('${uid}tokenuser');

        top.location.reload();
    }

    function toH() {

        window.open("http://192.168.3.252:8088/Sweb/index${uid}.html");
    }
    function userad() {

        location.href="http://192.168.3.252:8088/channel_personal.html";
    }
    //频道密码
    function tocinglist() {

        location.href="http://192.168.3.252:8088/index_lielist.html?id=${uid}";
    }
    function tovinglist() {

        location.href="http://192.168.3.252:8088/index_vlist.html?id=${uid}";
    }

    function ncount() {
        setTimeout(function(){ ncount();},1000);


       var idds=$("#ids").val();

        $.ajax({
            type:"get",
            url:"http://192.168.3.252:8084/admin/selectVisitTimesall",
            data:{
                "ids":idds,
            },
            success: function (datas) {
                $("#i1").text(datas[0]);
                $("#i2").text(datas[1]);
                $("#i3").text(datas[2]);
                $("#i4").text(datas[3]);
                $("#i5").text(datas[4]);
                $("#i6").text(datas[5]);
                $("#i7").text(datas[6]);
                $("#i8").text(datas[7]);
            },
            error: function (datas) {
            }

        })
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
<body style="background-color: #f1f1f1;">
<div class="ttop">
    <!--  logo-->
    <div class="t1">

    </div>
    <!--  type-->
    <div class="t2">
        <div id="sy">
            <a href="http://192.168.3.252:8088//Sweb/index${uid}.html" id="syto">
                首页
            </a>
        </div>
        <div id="zb">
            <a href="http://192.168.3.252:8088/index_lielist.html?uid=${uid}"} id="zbto">
                直播
            </a>
        </div>
        <div id="sp">
            <a href="http://192.168.3.252:8088/index_vlist.html?uid=${uid}" id="spto">
                视频
            </a>
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
<div class="bnbj">
</div>
<div class="banner container-fluid">
    <div id="imgs" data-interval="2000" data-ride="carousel" class="carousel slide" >
        <div class="carousel-inner" >
            <!--            img1-->
            <div class="item active">
                <img src="img/BANNER-1.png" class="bannimg" style=" width: 1200px;
    height: 450px;" >
            </div>
            <!--            img2-->
            <div class="item">
                <img src="img/BANNER-2.png" style=" width: 1200px;
    height: 450px;">
            </div>
            <!--             img3-->
            <div class="item">
                <img src="img/BANNER-3.png" style=" width: 1200px;
    height: 450px;">
            </div>
            <!--            img4-->
            <div class="item">
                <img src="img/BANNER-4.png" style=" width: 1200px;
    height: 450px;">
            </div>
            <!--            img5-->
            <div class="item">
                <img src="img/BANNER-5.png" style="width: 1200px;
    height: 450px;">
            </div>

            <ul class="carousel-indicators">
                <li data-target="#imgs" data-slide-to="0" class="active"></li>
                <li data-target="#imgs" data-slide-to="1"></li>
                <li data-target="#imgs" data-slide-to="2"></li>
                <li data-target="#imgs" data-slide-to="3"></li>
                <li data-target="#imgs" data-slide-to="4"></li>
            </ul>

        </div>
        <a href="#imgs" data-slide="prev" class="carousel-control left" >
            <span class="glyphicon glyphicon-chevron-left"></span>
            <span class="sr-only">Previous</span></a>
        <a href="#imgs" data-slide="next" class="carousel-control right" >
            <span class="glyphicon glyphicon-chevron-right"></span>
            <span class="sr-only">Next</span></a>

    </div>

</div>

<!--list-->
<div class="AllList">
    <!--直播列表-->
    <div class="channel-list">
        <!--直播列表标签-->
        <div class="ctitle">
            <div class="C_t1">
                <img src="img/libutton.png">
                直播列表
            </div>
            <div class="C_t2">
                <span>当前直播</span><i id="count" style="color: #62bfff;">${count}</i>

                    <span onclick="tocinglist()" style="cursor: pointer;"> | 更多></span>

            </div>
        </div>
        <!--      live_list-->


        <div class="live_list" id="live_list">
            <#assign iSum=0>
            <#assign ids="" >
            <#list clist as iteam>

                <#assign iSum=iSum+1>
            <div class="video">
                <div class="live_title">
                    <div class="lab">
                        <span class="stutas">
                            <#if iteam.channelStatus = 1>直播</#if>
                            <#if iteam.channelStatus = 2>预告</#if>
                            <#if iteam.channelStatus = 3>结束</#if>

                        </span>
                    </div>
                    <div class="type">
                        <span class="kind">
                             <#if iteam.channelType =1>VR</#if>
                             <#if iteam.channelType =2>普通</#if>
                        </span>
                    </div>
                </div>
                    <a href="http://192.168.3.252:8088/Sweb/index_channeling${iteam.channelId}.html" id=${iteam.channelId}>
                        <img src="${iteam.channelCover}" class="live_img">
                    </a>
                <span class="span-name">${iteam.channelName}</span>
                <div class="count">
                    <div class="live_timespan">
                        <span class="span-date">${iteam.channelBtime}</span>
                    </div>
                    <i class="fa fa-user-circle-o fa-1x" id="i${iSum}">0</i>
                </div>
            </div>

                <#if ids?length gt 2>
                       <#assign ids=ids+","+iteam.channelId>
                    <#else >
                       <#assign ids=iteam.channelId>
                </#if>

            </#list>
             <input id="ids" style="display: none" value="${ids}">
        </div>


    </div>

    <!--视频列表-->
    <div class="video-list">
        <div class="ctitle">
            <div class="V_t1">
                <img src="img/libutton.png">
                视频列表
            </div>
            <div class="V_t2">
                <span>当前视频</span><i style="color: #62bfff;">${vcount} </i>

                    <span onclick="tovinglist()" style="cursor: pointer;"> | 更多></span>

            </div>
        </div>
        <!--      live_list-->
        <div class="video_list" id="video_list">


            <#list vlist as iteam>
                <div class="video">
                    <a href="http://192.168.3.252:8088/index_living.html?id=${iteam.video_id}" id=${iteam.video_id}>
                    <img src="${iteam.video_cover}" class="live_img">
                    </a>
                    <span class="span-name">${iteam.video_name}</span>
                    <div class="count">
                        <div class="live_timespan">
                            <span class="span-date">${iteam.video_btime}</span>
                        </div>
                        <i class="fa fa-user-circle-o fa-1x">1100</i>
                    </div>
                </div>


            </#list>
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

</body>
</html> 
