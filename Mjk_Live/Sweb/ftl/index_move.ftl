<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>首页</title>
    <link rel="stylesheet" type="text/css" href="css/index_move.css" />
    <link rel="stylesheet" href="font-awesome-4.7.0/css/font-awesome.min.css">
    <link href="bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<script src="js/vendor/modernizr-3.7.1.min.js"></script>
<script>window.jQuery || document.write('<script src="js/vendor/jquery-3.4.1.min.js"><\/script>')</script>
<script src="js/plugins.js"></script>
<script src="js/main.js"></script>
<script src="js/vendor/jquery.cookie.js"></script>
<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script>
    window.onload=function () {
        //观看者
        var  token =localStorage.getItem("tokenuser");
        if (token == null) {
        } else {

            $.ajax({
                type: "get",
                async: false,//同步
                cache: false,//不缓存
                url: "http://192.168.3.252:8083/login/indexselectByUid",
                data: {},
                beforeSend: function (request) {
                    request.setRequestHeader("token", localStorage.getItem("tokenuser"));
                },
                success: function (datas) {
                    if (datas == null) {
                        alert("用户信息加载失败")
                    } else {
                        $("#nothing").attr("style", "display:none;");
                        $("#logn_user").attr("style", "display:block;");
                        $("#logn_user").css("color","#e8851e");
                        $("#logn_user").html(datas.userName);

                    }
                },
                error: function (datas) {
                }


            });

        }
        //发布者id


        $("#tolist").attr('href', 'http://192.168.3.252:8087/index_livelist.html?id=' + ${uid});
        //发布者


 ncount();
    }

    //频道密码
    function mm(id) {
        $("#passyz").css("display","block");
        $("#Channelid").val(id);
        $.ajax({
            type : "get",
            async: false,//同步
            cache: false,//不缓存
            url : "http://192.168.3.252:8084/live/selectPassByCid",
            data :{
                "channelId":id,

            },
            success : function(datas) {
                $("#Channelpass").val(datas.channelPassword);

            },
            error: function (datas) {
            }

        });
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

    // 退出登录
    function out(){
        alert("确认退出");
        localStorage.removeItem('tokenuser');

        top.location.reload();
    }
    //list列表页

    function tolist(){
        location.href="http://192.168.3.252:8088/Mjk_Live_move/index_livelist.html?id=${uid}"
    }
    function tovlidet() {
        location.href="http://192.168.3.252:8088/Mjk_Live_move/index_videolist.html?id=${uid}"
    }
</script>
<script>
    $(function(){
        $('#logn_user').click(function(){//点击a标签
            if($('#LiDl').is(':hidden')){//如果当前隐藏
                $('#LiDl').show();//那么就显示div
            }else{//否则
                $('#LiDl').hide();//就隐藏div
            }
        })

        //  未登录点击事件
        $("#nothing").click(function () {
            location.href="http://192.168.3.252:8088/Mjk_Live_move/login.html"
        })
    })
</script>
<body>
<div class="cen">
    <!--  头部-->
    <div class="top">
        <img src="img/logo.png">
        <span id="nothing">未登录</span>
        <span id="logn_user" style="display: none"></span>
        <div id="LiDl"  class="LiDl">
            <ul>
                <li onclick="out()">退出登录</li>
            </ul>
        </div>
    </div>
    <!--  banner图-->
    <div class="banner">
        <div id="imgs" data-interval="2000" data-ride="carousel" class="carousel slide" style=" height: 100%;" >
            <div class="carousel-inner" style=" height: 100%;" >
                <!--            img1-->
                <div class="item active">
                    <img src="img/BANNER-1.png" class="bannimg" style=" height: 100%;">
                </div>
                <!--            img2-->
                <div class="item">
                    <img src="img/BANNER-2.png" style=" height: 100%;">
                </div>
                <!--             img3-->
                <div class="item">
                    <img src="img/BANNER-3.png"  style=" height: 100%;">
                </div>
                <!--            img4-->
                <div class="item">
                    <img src="img/BANNER-4.png" style=" height: 100%;" >
                </div>
                <!--            img5-->
                <div class="item">
                    <img src="img/BANNER-5.png"  style=" height: 100%;">
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
    <!--  直播视频列表内容-->
    <div class="container-fluid">
        <!--    直播模块-->
        <div class="live" id="live">
            <!--      直播标题-->
            <div class="live-title">
                <!--        标题左侧-->
                <div class="tleft">
                    <img src="img/t-logo.png">
                    <div class="ft1">
                        <span>直播列表</span>
                    </div>
                </div>
                <!--        标题右侧-->
                <div class="tright" onclick="tolist()">

                        <img src="img/more.png">
                        <img src="img/toR.png">

                </div>

            </div>
            <!--      直播列表-->
            <div class="live-list" id="live-list">
                <#assign iSum=0>
                <#assign ids="" >

                <#list clist as iteam>

                    <div class="limode">
                        <div class="fm">
                            <#if iteam.channelStatus = 1>
                                <img src= "img/liveing.png" class="bq">
                            </#if>
                            <#if iteam.channelStatus = 2>
                                <img src= "img/liveing.png" class="bq">
                            </#if>

                                <a href="http://192.168.3.252:8088/Sweb/index_channeling_move${iteam.channelId}.html" id=${iteam.channelId}>
                                    <img src="${iteam.channelCover}" class="tp">
                                </a>

                        </div>
                        <div class="l-inifo">
                            <span>${iteam.channelName}</span>
                            <div class="watch">
                                <img src="img/utp.png">
                                <div class="count" id="i${iSum}">0</div>

                            </div>
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
        <!--    视频模块-->
        <div class="video" id="video">
            <!--      视频标题-->
            <div class="live-title">
                <div class="tleft">
                    <img src="img/t-logo.png">
                    <div class="ft1">
                        <span>视频列表</span>
                    </div>
                </div>
                <div class="tright" onclick="tovlidet()">
                    <img src="img/more.png">
                    <img src="img/toR.png">
                </div>

            </div>
            <!--      视频列表-->
            <div class="live-list">


                <#list vlist as iteam>

                    <div class="limode">
                        <div class="fm">

                            <a href="http://192.168.3.252:8088/Sweb/index_videoing.html?id=${iteam.videoId}" id=${iteam.videoId}>
                                    <img src="${iteam.videoCover}" class="tp">
                                </a>
                        </div>
                        <div class="l-inifo">
                            <span>${iteam.videoName}</span>
                            <div class="watch">
                                <img src="img/utp.png">
                                <div class="count"  >${iteam.playAuth}</div>
                            </div>
                        </div>
                    </div>


                </#list>

            </div>
        </div>
    </div>
</div>

</body>
</html>
