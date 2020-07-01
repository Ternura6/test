<!DOCTYPE html>
<html lang="en">
<head>
    <title>测试视频</title>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">

    <style>

        #example {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
        }

    </style>

    <link rel="stylesheet" type="text/css" href="css/index_channeling.css" />
    <link rel="stylesheet" href="font-awesome-4.7.0/css/font-awesome.min.css">
    <link href="bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div id="example"></div>
<script src="build/three.js"></script>
<script src="js/renderers/CanvasRenderer.js"></script>
<script src="js/renderers/Projector.js"></script>
<script src="build/mxreality.js"></script>
<script src="build/ptools.js"></script>
<script src="js/vendor/modernizr-3.7.1.min.js"></script>
<script src="js/vendor/jquery-3.4.1.min.js"></script>
<script src="js/plugins.js"></script>
<script src="js/main.js"></script>
<script src="js/vendor/jquery.cookie.js"></script>
<script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script>


    window.onload=function () {
        init();
    }
    //var vr=new VR(scene,renderer,container);
    function init() {
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

        vr.playPanorama('http://jingcai.cdn-vipkkyun.com/20190827/1295_6bddbad0/index.m3u8?sign=1a71f26fca4c9680c93d10010a165d1a',vr.resType.sliceVideo);
        vr.video.setAttribute("loop","loop");
        vr.video.crossOrigin="Anonymous";



        vr.video.onended=function () {
        }

    }


</script>
</body>
</html>
