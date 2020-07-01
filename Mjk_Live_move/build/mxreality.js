var VR = function (e, t, i, r, o) {
  this.scene = e, this.renderer = t, this.container = i, AVR.initDomStyle(i), AVR.setCameraPara(this, r, o), this.vrbox = {
    radius: 2,
    widthSegments: 180,
    heightSegments: 180,
    width: 2,
    height: 2,
    depth: 2
  }, this.destoryed = !1, this.video = null, this.audio = null, this.toolBar = null, this.clock = new THREE.Clock, this.VRObject = new THREE.Object3D, this.defaultAutoHideLeftTime = 3, this.defaultVoiceHideLeftTime = 2, this.defaultVolume = .3, this.sliceSegment = 0, this._controlTarget = new THREE.Vector3(0, 0, 1e-4), this._cubeCameraTimes = .96, this.resType = {
    video: "video",
    box: "box",
    slice: "slice",
    sliceVideo: "sliceVideo",
    flvVideo: "flvVIdeo"
  }, this.videoPlayHook = function () {
    console.log("video play")
  }, this.videoPauseHook = function () {
    console.log("video pause")
  }, this.asteroidConfig = {
    enable: !1,
    asteroidFPS: 10,
    asteroidFov: 135,
    asteroidForwardTime: 2600,
    asteroidWaitTime: 2e3,
    asteroidDepressionRate: .5,
    asteroidTop: 1,
    cubeResolution: 2048,
    rotationAngleOfZ: 0
  }, this.VRhint = "请取消屏幕翻转锁定后装入VR盒子中", this.camera = new THREE.PerspectiveCamera(this.cameraPara.fov, this.cameraPara.aspect, this.cameraPara.near, this.cameraPara.far), this.camera.lookAt(this._controlTarget), this.cameraEvt = {
    controlGroup: function () {
    }, updatePosition: function () {
    }, hover: function () {
    }, leave: function () {
    }
  }, this._takeScreenShot = !1, this.timerList = {}, this.camera.position.set(this.cameraPosition.x, this.cameraPosition.y, this.cameraPosition.z), this.loadProgressManager = new THREE.LoadingManager(function (e) {
    console.log("loaded")
  }, function (e, t, i) {
    console.log("item=", e, "loaded", t, "total=", i)
  }, function (e, t) {
    console.log(e, t)
  }), this.scene.add(this.camera), this.scene.add(this.VRObject), this.effect = AVR.stereoEffect(this.renderer), AVR.bindOrientationEnevt(this, this._controlTarget)
};
VR.prototype.destory = function () {
  that.video && (that.video.pause(), that.video = null), that.audio && (that.audio.pause(), that.audio = null);
  for (var e in that.timerList) clearInterval(that.timerList[e]);
  that.destoryed = !0
}, VR.prototype.init = function (e) {
  function t() {
    v.controls && v.controls.reset()
  }

  function i(e) {
    T.isMouseDown = !0;
    var t = e.clientX || e.changedTouches[0].clientX, i = e.clientY || e.changedTouches[0].clientY;
    f.set(t, i), p.set(t, i), v.autoHideLeftTime = v.defaultAutoHideLeftTime, T.isActive = !0
  }

  function r(e) {
    T.isMouseDown = !1
  }

  function o(e) {
    if (e.preventDefault(), v.autoHideLeftTime = v.defaultAutoHideLeftTime, v.toolBar.isActive = !0, T.isMouseDown) {
      var t = e.clientX || e.changedTouches[0].clientX, i = e.clientY || e.changedTouches[0].clientY, r = p.y - i;
      r >= 5 && a(6), r <= -5 && a(-10), p.set(t, i)
    }
  }

  function n(e) {
    if (void 0 === v.controls.defaultDampingFactor && (v.controls.defaultDampingFactor = v.controls.dampingFactor), void 0 === v.controls.object.defaultFov && (v.controls.object.defaultFov = v.controls.object.fov), e) {
      var t = 0, i = [];
      [].forEach.call(e, function (e) {
        var r = b[e.identifier];
        if (r && (r.y = e.pageY, r.x = e.pageX, i.push(e.identifier)), t++, t >= 2) {
          var o = b[i[0]], n = b[i[1]], a = Math.sqrt(Math.pow(o.x - n.x, 2) + Math.pow(o.y - n.y, 2)), s = (a - y) / 4;
          return v.controls.object.fov - s < 140 && v.controls.object.fov - s > 10 && y && (v.controls.enable = !1, v.controls.object.fov -= s, v.controls.dampingFactor = v.controls.defaultDampingFactor * v.controls.object.defaultFov / v.controls.object.fov), y = a, void (t = 0)
        }
      })
    }
  }

  function a(e) {
    clearInterval(v.timerList.slideBarAniateTimer), v.timerList.slideBarAniateTimer = animateTimer = setInterval(function () {
      var t = T.toolbar.clientHeight + e;
      t >= T.defaultHeight && t <= T.defaultMaxHeight ? (T.toolbar.style.height = t + "px", T.isActive = !0) : (clearInterval(animateTimer), e > 0 ? (T.isActive = !0, T.moreBtn.style.transform = "rotate(-180deg)", T.moreBtn.style.webkitTransform = "rotate(-180deg)", T.toolbar.style.height = T.defaultMaxHeight + "px", T.about.style.display = "block") : (T.isActive = !1, T.moreBtn.style.transform = "rotate(0deg)", T.moreBtn.style.webkitTransform = "rotate(0deg)", T.toolbar.style.height = T.defaultHeight + "px", T.about.style.display = "none")), v.autoHideLeftTime = v.defaultAutoHideLeftTime
    }, 1)
  }

  function s(e) {
    v.autoHideLeftTime = v.defaultAutoHideLeftTime, T.isActive = !0;
    var t = e.clientX || e.changedTouches[0].clientX, i = e.clientY || e.changedTouches[0].clientY;
    T.isMouseDown && (T.moreList.scrollLeft += 2.5 * (p.x - t)), p.set(t, i)
  }

  function c(e) {
    v.camera.fov += .05 * e, v.camera.updateProjectionMatrix()
  }

  function l(e) {
    if (e.style.borderColor = "green", e.style.color = "green", v.cameraEvt.controlGroup.length) {
      var t = v.cameraEvt.controlGroup.getObjectByName("__focus");
      t.visible = !0
    }
  }

  function d(e) {
    if (e.style.borderColor = "white", e.style.color = "white", v.cameraEvt.controlGroup.length) {
      var t = v.cameraEvt.controlGroup.getObjectByName("__focus");
      t.visible = !1
    }
  }

  function u() {
    var e = v.video || v.audio;
    if (e) {
      var t = AVR.getBoundingClientRect(v.container);
      T.voice_bar.style.display = "block";
      var i, r = T.voice_bar, o = r.firstChild, n = o.firstChild, a = (n.firstChild, !1), s = 0, c = 0;
      e.volume = v.defaultVolume;
      var l = T.voice_bar.clientHeight, d = (v.container.clientHeight - l) / 2, u = l + d;
      n.style.height = e.volume * l + "px", r.addEventListener("mousedown", function (e) {
        r.style.opacity = 1
      }, !1), o.addEventListener("click", function (i) {
        var r = (i.clientY || i.changedTouches[0].clientY) - t.top;
        v.voiceHideLeftTime = v.defaultVoiceHideLeftTime;
        var o = u - r;
        o / l <= 1 && (n.style.height = o + "px", e.volume = o / l)
      }, !1), r.addEventListener("mouseout", function (e) {
        a = !1
      }, !1), r.addEventListener("mousedown", function (e) {
        a = !0
      }, !1), r.addEventListener("mouseup", function (e) {
        a = !1
      }, !1), r.addEventListener("mousemove", function (i) {
        var r = (i.clientY || i.changedTouches[0].clientY) - t.top;
        if (v.voiceHideLeftTime = v.defaultVoiceHideLeftTime, a) {
          var o = u - r;
          n.style.height = o + "px", o / l <= 1 && (e.volume = o / l)
        }
      }, !1), r.addEventListener("touchstart", function (e) {
        e.preventDefault(), v.voiceHideLeftTime = v.defaultVoiceHideLeftTime, i = n.clientHeight, s = e.touches[0].pageY, r.style.opacity = 1
      }, !1), r.addEventListener("touchmove", function (t) {
        t.preventDefault(), v.voiceHideLeftTime = v.defaultVoiceHideLeftTime, c = t.touches[0].pageY;
        var r = i + (s - c);
        r / l <= 1 && (n.style.height = r + "px", e.volume = r / l)
      }, !1), r.addEventListener("touchend", function (e) {
        i = 0
      }, !1), clearInterval(v.timerList.voiceBarActiveTimer), v.timerList.voiceBarActiveTimer = setInterval(function () {
        v.voiceHideLeftTime <= 0 ? r.style.opacity = 0 : v.toolBar.isActive ? null : v.voiceHideLeftTime--
      }, 1e3)
    }
  }

  function m() {
    if (!v.destoryed) {
      var t = v.container.offsetWidth, i = v.container.offsetHeight;
      if (v.camera.aspect = t / i, AVR.isMobileDevice() && AVR.isCrossScreen() ? (v.cameraEvt.updatePosition(), v.effect.setSize(t, i), v.effect.render(v.scene, v.camera)) : (v.renderer.setSize(t, i), v.renderer.setClearColor(new THREE.Color(16777215)), v.renderer.render(v.scene, v.camera)), v._takeScreenShot) {
        v._takeScreenShot = !1;
        var r = v.renderer.domElement.toDataURL("image/jpeg");
        v._takeScreenShotCallback(r)
      }
      v.camera.updateProjectionMatrix(), v.controls && v.controls.update(), e()
    }
  }

  function h() {
    m(), requestAnimationFrame(h)
  }

  var v = this, f = new THREE.Vector2, p = new THREE.Vector2;
  v.toolBar = AVR.toolBar(v.container);
  var g, E, T = v.toolBar, b = {}, y = 0;
  //播放器图标栏
  T.defaultHeight = T.toolbar.clientHeight, T.defaultMaxHeight = 5 * T.defaultHeight, T.isMouseDown = !1,

    v.container.addEventListener("click", function () {
    v.autoHideLeftTime = v.defaultAutoHideLeftTime, T.toolbar.style.display = "block"
      // if(v.container.style="transform: rotate(90deg);"){
      //   v.autoHideLeftTime = v.defaultAutoHideLeftTime, T.toolbar.style  = "transform: rotate(90deg);"
      // }
  }), T.gyroBtn.addEventListener("click", function () {
    v.gyroBtnClick()
  }, !1), T.vrBtn.addEventListener("click", function () {
    v.vrBtnClick()
  }, !1), T.moreBtn.addEventListener("click", function () {
    v.moreBtnClick()
  }, !1), v.container.addEventListener("touchstart", function (e) {
    v.touchStart(e)
  }, !1), v.container.addEventListener("touchmove", function (e) {
    v.touchMove(e)
  }, !1), v.container.addEventListener("touchend", function (e) {
    v.touchEnd(e)
  }, !1), T.gyroResetBtn.addEventListener("click", t, !1), T.toolbar.addEventListener("mousedown", i, !1), T.toolbar.addEventListener("touchstart", i, !1), T.toolbar.addEventListener("mousemove", o, !1), T.toolbar.addEventListener("touchmove", o, !1), T.toolbar.addEventListener("mouseup", r, !1), T.toolbar.addEventListener("touchend", r, !1), T.toolbar.addEventListener("mouseout", function (e) {
    v.autoHideLeftTime = v.defaultAutoHideLeftTime, T.isActive = !1
  }, !1), v.renderer.domElement.addEventListener("wheel", function (e) {
    var t = e.deltaY > 0 ? 15 : -15;
    v.camera.fov + .05 * t >= 10 && v.camera.fov + .05 * t <= 120 && c(t)
  }, !1), T.moreList.addEventListener("mousemove", s, !1), T.moreList.addEventListener("touchmove", s, !1), v.moreBtnClick = function (e) {
    a(T.toolbar.clientHeight > T.defaultHeight ? -10 : 6)
  }, v.vrBtnClick = function (e) {
    var t = v.toolBar.vrBtn;
    AVR.isMobileDevice() ? AVR.OS.isWeixin() && !AVR.OS.isiOS() ? "landscape" == v.video.getAttribute("x5-video-orientation") ? (v.video.setAttribute("x5-video-orientation", "portraint"), d(t)) : (v.video.setAttribute("x5-video-orientation", "landscape"), l(t)) : AVR.isCrossScreen() ? (l(t), AVR.fullscreen(v.container)) : (d(t), AVR.msgBox(v.VRhint, 5, v.container)) : (t.getAttribute("fullscreen") ? (d(t), t.removeAttribute("fullscreen")) : (l(t), t.setAttribute("fullscreen", "true")), AVR.fullscreen(v.container))
  }, v.gyroBtnClick = function (e) {
    var t = v.toolBar.gyroBtn;
    "active" == t.getAttribute("active") ? (v.controls.gyroFreeze(), d(t), d(T.circle1), d(T.circle2), t.removeAttribute("active")) : (v.controls.gyroUnfreeze(), t.setAttribute("active", "active"), l(t), l(T.circle1), l(T.circle2))
  }, v.touchStart = function (e) {
    e.targetTouches && ([].forEach.call(e.targetTouches, function (e) {
      b[e.identifier] || (b[e.identifier] = new THREE.Vector2(0, 0))
    }), clearInterval(v.timerList.renderTouchersRimer), v.timerList.renderTouchersRimer = setInterval(function () {
      n(g)
    }, 1))
  }, v.touchEnd = function (e) {
    e.targetTouches && ([].forEach.call(e.changedTouches, function (e) {
      var t = b[e.identifier];
      t && delete b[e.identifier]
    }), 0 === e.targetTouches.length && (y = 0, v.controls.enable = !0, clearInterval(E)))
  }, v.touchMove = function (e) {
    g = e.touches
  }, v.windowResize = function () {
    AVR.isFullscreen() ? AVR.isMobileDevice() ? AVR.isCrossScreen() ? l(v.toolBar.vrBtn) : d(v.toolBar.vrBtn) : l(v.toolBar.vrBtn) : AVR.OS.isWeixin() && !AVR.OS.isiOS() ? ("landscape" == v.video.getAttribute("x5-video-orientation") ? l(v.toolBar.vrBtn) : d(v.toolBar.vrBtn), AVR.isCrossScreen() ? l(v.toolBar.vrBtn) : d(v.toolBar.vrBtn)) : (AVR.isCrossScreen() ? l(v.toolBar.vrBtn) : d(v.toolBar.vrBtn), d(v.toolBar.vrBtn))
  }, window.addEventListener("resize", function () {
    u()
  }, !1), v._play = function () {
    T.btn.style.border = "none", T.btn.style.fontWeight = 800, T.btn.innerHTML = "<b>||</b>"
  }, v._pause = function () {
    T.btn.innerText = "", T.btn.style.borderTop = "0.6rem solid transparent", T.btn.style.borderLeft = "1rem solid white", T.btn.style.borderBottom = "0.6rem solid transparent"
  }, v.bindVolumeBar = u, h(), clearInterval(v.timerList.toolBarAutoHideTimer), v.timerList.toolBarAutoHideTimer = setInterval(function () {
    T.isActive || (v.autoHideLeftTime < 0 ? (T.toolbar.style.display = "none", v.autoHideLeftTime = v.defaultAutoHideLeftTime, T.isActive = !1) : v.autoHideLeftTime--), v.windowResize()
  }, 1e3)
}, VR.prototype.takeScreenShot = function (e) {
  this._takeScreenShot = !0, this._takeScreenShotCallback = e
}, VR.prototype.playPanorama = function (e, t) {
  function i(e) {
    x.paused ? (d._play(), x.play(), d.videoPlayHook()) : (d._pause(), x.pause(), d.videoPauseHook())
  }

  function r(e) {
    rect = AVR.getBoundingClientRect(d.container);
    var t = (e.clientX || e.changedTouches[0].clientX) - rect.left;
    x.currentTime = x.duration * (t / this.clientWidth)
  }

  function o(e) {
    d.video.buffTimer || (clearInterval(d.timerList.videoBuffTimer), d.timerList.videoBuffTimer = d.video.buffTimer = setInterval(function (e) {
      var t = 0;
      0 != x.buffered.length && (t += x.buffered.end(0)), t >= x.duration && clearInterval(d.video.buffTimer), u.loadedProgress.style.width = t / x.duration * 100 + "%"
    }, 500))
  }

  function n(e, t) {
    t = t || !1, material = new THREE.MeshBasicMaterial({overdraw: !0, map: e});
    var i = d.VRObject.getObjectByName("__mxrealityDefault");
    if (i) i.material = material; else {
      var r = -Math.PI / 2,
        o = new THREE.SphereBufferGeometry(d.vrbox.radius, d.vrbox.widthSegments, d.vrbox.heightSegments, r);
      o.scale(-1, 1, 1), mesh = new THREE.Mesh(o, material), mesh.visible = !1, mesh.name = "__mxrealityDefault", t && (mesh.matrixAutoUpdate = !1, mesh.updateMatrix(), d.toolBar.timeInfo.style.display = "none"), d.VRObject.add(mesh)
    }
    d.asteroidConfig.enable && (d.asteroidForward = function (e) {
      a(e)
    })
  }

  function a(e) {
    d.controls && (d.controls.reset(), d.controls.enable = !1);
    var t = d.asteroidConfig, i = d.camera.fov, r = d._containerRadius * (.9 * d._cubeCameraTimes);
    d.camera.position.y = r * t.asteroidTop, d.camera.rotation.x = THREE.Math.degToRad(-90), d.camera.fov = t.asteroidFov;
    var o = t.asteroidForwardTime * t.asteroidFPS / 300, n = r / o, a = d.camera.fov - i, s = a / o,
      c = (Math.PI / 2 / o, !1), l = !1,
      u = new THREE.Vector3(d._controlTarget.x, d._controlTarget.y, d._controlTarget.z);
    setTimeout(function () {
      d.timerList.asteroidForwardTimer = asteroidForwardTimer = setInterval(function () {
        t.asteroidTop * d.camera.position.y - n >= 0 ? (d.camera.position.y -= n * t.asteroidTop, d.camera.lookAt(u), u.z *= 1.25) : c = !0, d.camera.fov - s >= i ? d.camera.fov -= s : l = !0, c && l && (clearInterval(asteroidForwardTimer), d.controls.enable = !0, d.camera.position.y = 0, d.camera.fov = i, void 0 !== e && e())
      }, t.asteroidFPS)
    }, t.asteroidWaitTime)
  }

  var s = ["__mxrealitySkybox", "__mxrealitySlice", "__mxrealityDefault"];
  for (var c in s) {
    var l = this.VRObject.getObjectByName(s[c]);
    l && (l.visible = !1), this.cubeCameraSphere && (this.cubeCameraSphere.visible = !1)
  }
  var d = this, u = d.toolBar;
  if (d._containerRadius = d.resType.box == t || d.resType.slice == t ? d.vrbox.width / 2 : d.vrbox.radius, d.autoHideLeftTime = d.defaultAutoHideLeftTime, d.voiceHideLeftTime = d.defaultVoiceHideLeftTime, d.resType.box == t) {
    d.toolBar.timeInfo.style.display = "none";
    var m = [], h = [], v = new Image;
    v.crossOrigin = "Anonymous", v.src = e, v.onload = function () {
      for (var e, t, i = v.height, r = 0; r < 6; r++) m[r] = new THREE.Texture, e = document.createElement("canvas"), t = e.getContext("2d"), e.height = i, e.width = i, t.drawImage(v, i * r, 0, i, i, 0, 0, i, i), m[r].image = e, m[r].needsUpdate = !0, h.push(new THREE.MeshBasicMaterial({map: m[r]}));
      var o = d.VRObject.getObjectByName("__mxrealitySkybox");
      if (o) o.material = h; else {
        var o = new THREE.Mesh(new THREE.CubeGeometry(d.vrbox.width, d.vrbox.height, d.vrbox.depth), new THREE.MultiMaterial(h));
        o.applyMatrix((new THREE.Matrix4).makeScale(1, 1, -1)), o.visible = !1, o.name = "__mxrealitySkybox", o.matrixAutoUpdate = !1, o.updateMatrix(), d.VRObject.add(o), u.btn.addEventListener("click", function (e) {
          d.controls.autoRotate ? d._pause() : d._play(), d.controls.autoRotate = !d.controls.autoRotate
        })
      }
      d.loadProgressManager.onLoad()
    }
  } else if (d.resType.slice == t) {
    d.toolBar.timeInfo.style.display = "none";
    var f = new THREE.TextureLoader(d.loadProgressManager);
    f.mapping = THREE.UVMapping;
    for (var h = [], c = 0; c < e.length; c++) {
      var p = f.load(e[c]);
      h.push(new THREE.MeshBasicMaterial({map: p}))
    }
    for (var g = new THREE.CubeGeometry(d.vrbox.width, d.vrbox.height, d.vrbox.depth, d.sliceSegment, d.sliceSegment, d.sliceSegment), E = 0, T = [new THREE.Vector2(0, 0), new THREE.Vector2(1, 0), new THREE.Vector2(1, 1), new THREE.Vector2(0, 1)], c = 0, b = g.faces.length; c < b; c += 2) g.faces[c].materialIndex = E, g.faces[c + 1].materialIndex = E, g.faceVertexUvs[0][c] = [T[3], T[0], T[2]], g.faceVertexUvs[0][c + 1] = [T[0], T[1], T[2]], E++;
    var l = d.VRObject.getObjectByName("__mxrealitySlice");
    if (l) l.material = h, l.geometry = g, l.updateMatrix(); else {
      var y = new THREE.Mesh(g, h);
      y.applyMatrix((new THREE.Matrix4).makeScale(1, 1, -1)), y.name = "__mxrealitySlice", y.visible = !1, y.matrixAutoUpdate = !1, y.updateMatrix(), d.VRObject.add(y), d.cubeCamera = new THREE.CubeCamera(d._containerRadius, d.cameraPara.far, d.asteroidConfig.cubeResolution);
      var w = d.cubeCamera.renderTarget.texture;
      w.minFilter = THREE.LinearMipMapLinearFilter, d.VRObject.add(d.cubeCamera), material = new THREE.MeshBasicMaterial({
        envMap: d.cubeCamera.renderTarget.texture,
        side: THREE.BackSide
      }), d.cubeCameraSphere = new THREE.Mesh(new THREE.SphereGeometry(d._containerRadius * d._cubeCameraTimes, 180, 180), material), d.cubeCameraSphere.position.set(0, 0, 0), d.cubeCameraSphere.name = "__mxrealitySlice", d.cubeCameraSphere.visible = !1, d.cubeCameraSphere.matrixAutoUpdate = !1, d.cubeCameraSphere.updateMatrix(), d.VRObject.add(d.cubeCameraSphere), u.btn.addEventListener("click", function (e) {
        d.controls.autoRotate ? d._pause() : d._play(), d.controls.autoRotate = !d.controls.autoRotate
      })
    }
    d.asteroidConfig.enable ? (d.cubeCameraSphere.visible = !0, d.asteroidForward = function (e) {
      d.cubeCamera.update(d.renderer, d.scene), a(e)
    }) : d.cubeCameraSphere.visible = !1
  } else {
    var R = [d.resType.video, d.resType.sliceVideo, d.resType.flvVideo];
    if (R.indexOf(t) >= 0) {
      if (d.video) for (var x = d.video, A = 0; A < x.childNodes.length; A++) x.removeChild(x.childNodes[A]); else var x = d.video = AVR.createTag("video", {
        "webkit-playsinline": !0,
        playsinline: !0,
        preload: "auto",
        "x-webkit-airplay": "allow",
        "x5-playsinline": !0,
        "x5-video-player-type": "h5",
        "x5-video-player-fullscreen": !0,
        "x5-video-orientation": "portrait",
        style: "object-fit: fill",
        loop: "loop"
      }, {allowsInlineMediaPlayback: !0, crossOrigin: "Anonymous"});
      if (d.resType.sliceVideo == t) if (AVR.OS.isAndroid() && AVR.OS.isWeixin()) {
        var H = AVR.createTag("source", {src: e, type: "application/x-mpegURL"}, null);
        x.appendChild(H)
      } else if (Hls.isSupported()) d.hls = new Hls, d.hls.attachMedia(x), d.hls.loadSource(e), d.hls.on(Hls.Events.MANIFEST_PARSED, function () {
        x.play()
      }); else {
        var H = AVR.createTag("source", {src: e, type: "application/x-mpegURL"}, null);
        x.appendChild(H)
      } else if (d.resType.flvVideo == t) {
        if (!flvjs.isSupported()) return void console.error("Your browser does not support flvjs");
        var S = flvjs.createPlayer({type: "flv", url: e});
        S.attachMediaElement(x), S.load(), S.play()
      } else x.canPlayType("application/vnd.apple.mpegurl") ? x.src = e : x.src = e;
      x.removeEventListener("canplaythrough", o), u.progressBar.removeEventListener("click", r), u.btn.removeEventListener("click", i), x.addEventListener("canplaythrough", o, !1), u.progressBar.addEventListener("click", r, !1), u.btn.addEventListener("click", i, !1), x.load(), x.play(), d.video.buffTimer = null;
      var p = new THREE.VideoTexture(x);
      p.generateMipmaps = !1, p.minFilter = THREE.LinearFilter, p.magFilter = THREE.LinearFilter, p.format = THREE.RGBAFormat, n(p), clearInterval(d.timerList.videoProgressTimer), d.timerList.videoProgressTimer = d.video.progressTimer = setInterval(function (e) {
        u.playProgress.style.width = x.currentTime / x.duration * 100 + "%", u.curTime.innerText = AVR.formatSeconds(x.currentTime), u.totalTime.innerText = AVR.formatSeconds(x.duration), d.autoHideLeftTime < 0 && !x.paused ? u.toolbar.style.display = "none" : d.autoHideLeftTime--
      }, 1e3), d.loadProgressManager.onLoad()
    } else new THREE.TextureLoader(d.loadProgressManager).load(e, function (e) {
      n(e, !0)
    })
  }
}, VR.prototype.sphere2BoxPano = function (e, t, i, r) {
  function o(e, t, i, r) {
    var o = e.createTexture();
    if (!o) return console.log("Failed to create the texture object!"), !1;
    var a = e.getUniformLocation(t, "u_Sampler");
    return n(e, i, o, a, r), !0
  }

  function n(e, t, i, o, n) {
    m.asteroidConfig.enable && e.pixelStorei(e.UNPACK_FLIP_Y_WEBGL, -1), e.activeTexture(e.TEXTURE0), e.bindTexture(e.TEXTURE_2D, i), e.texParameteri(e.TEXTURE_2D, e.TEXTURE_MIN_FILTER, e.LINEAR), e.texParameteri(e.TEXTURE_2D, e.TEXTURE_WRAP_S, e.CLAMP_TO_EDGE), e.texParameteri(e.TEXTURE_2D, e.TEXTURE_WRAP_T, e.CLAMP_TO_EDGE), e.texImage2D(e.TEXTURE_2D, 0, e.RGB, e.RGB, e.UNSIGNED_BYTE, n), e.uniform1i(o, 0), e.clear(e.COLOR_BUFFER_BIT), e.drawArrays(e.TRIANGLE_STRIP, 0, t), f < 5 ? f++ : r(u())
  }

  function a(e, t) {
    var i = new Float32Array([-1, 1, 0, 1, -1, -1, 0, 0, 1, 1, 1, 1, 1, -1, 1, 0]), r = 4, o = e.createBuffer();
    if (!o) return console.log("Failed to create the buffer object!"), -1;
    e.bindBuffer(e.ARRAY_BUFFER, o), e.bufferData(e.ARRAY_BUFFER, i, e.STATIC_DRAW);
    var n = i.BYTES_PER_ELEMENT, a = e.getAttribLocation(t, "a_Position");
    e.vertexAttribPointer(a, 2, e.FLOAT, !1, 4 * n, 0), e.enableVertexAttribArray(a);
    var s = e.getAttribLocation(t, "a_TexCoord");
    return e.vertexAttribPointer(s, 2, e.FLOAT, !1, 4 * n, 2 * n), e.enableVertexAttribArray(s), r
  }

  function s(e, t) {
    var i, r = c(e, t), o = c(e);
    return i = e.createProgram(), e.attachShader(i, o), e.attachShader(i, r), e.linkProgram(i), e.getProgramParameter(i, e.LINK_STATUS) ? (e.useProgram(i), e.enableVertexAttribArray(i.vertexPositionAttribute), i.vertexColorAttribute = e.getAttribLocation(i, "aVertexColor"), i.pMatrixUniform = e.getUniformLocation(i, "uPMatrix"), i.mvMatrixUniform = e.getUniformLocation(i, "uMVMatrix"), i) : null
  }

  function c(e, t) {
    var i, r;
    if (t) {
      if (i = l(t), !i) return null;
      r = e.createShader(e.FRAGMENT_SHADER)
    } else i = d(), r = e.createShader(e.VERTEX_SHADER);
    return e.shaderSource(r, i), e.compileShader(r), e.getShaderParameter(r, e.COMPILE_STATUS) ? r : (console.log(e.getShaderInfoLog(r)), null)
  }

  function l(e) {
    var t = "",
      i = "\n        precision mediump float;\n        varying vec2 v_TexCoord;\n        uniform sampler2D u_Sampler;\n        uniform float PI;\n",
      r = "\n        if(abs(theta)>PI){\n            if(theta>PI){\n                theta -= 2.0*PI;\n            }else{\n                theta += 2.0*PI;\n            }\n        }\n        if(abs(phi)>PI/2.0){\n            if(phi>PI/2.0){\n                phi -= PI;\n            }else{                phi += PI;\n            }\n        }\n        float x = theta/PI*0.5 + 0.5;\n        float y = phi/PI*2.0*0.5 + 0.5;\n        gl_FragColor = texture2D(u_Sampler, vec2(x,y));\n";
    return "z" == e ? t = i + "\n\t\t\tvoid main() {\n\t\t\t\tfloat r = 0.5;\n\t\t\t\tvec2 orig = vec2(0.5-v_TexCoord.x,v_TexCoord.y-0.5);\n\t\t\t\tfloat theta = atan(orig.x,r);\n\t\t\t\tfloat phi = atan(orig.y*cos(theta),r);" + r + "\n\t\t\t}\n" : "nz" == e ? t = i + "\n\t\t\tvoid main() {\n\t\t\t\tfloat r = 0.5;\n\t\t\t\tvec2 orig = vec2(0.5-v_TexCoord.x,v_TexCoord.y-0.5);\n\t\t\t\tfloat theta = atan(orig.x,r);\n\t\t\t\tfloat phi = atan(orig.y*cos(theta),r);\n        \t\ttheta = theta+PI;\n" + r + "\n\t\t\t}\n" : "x" == e ? t = i + "\n\t\t\tvoid main() {\n\t\t\t\tfloat r = 0.5;\n\t\t\t\tvec2 orig = vec2(v_TexCoord.x-0.5,v_TexCoord.y-0.5);\n\t\t\t\tfloat theta = atan(r,orig.x);\n\t\t\t\tfloat phi = atan(orig.y*sin(theta),r);" + r + "\n\t\t\t}\n" : "nx" == e ? t = i + "\n\t\t\tvoid main() {\n\t\t\t\tfloat r = 0.5;\n\t\t\t\tvec2 orig = vec2(v_TexCoord.x-0.5,v_TexCoord.y-0.5);\n\t\t\t\tfloat theta = atan(r,orig.x);\n\t\t\t\tfloat phi = atan(orig.y*sin(theta),r);\n        \t\ttheta = theta+PI;" + r + "\n\t\t\t}\n" : "y" == e ? t = i + "\n\t\t\tvoid main() {\n\t\t\t\tfloat r = 0.5;\n\t\t\t\tvec2 orig = vec2(0.5-v_TexCoord.x,0.5-v_TexCoord.y);\n        \t\tfloat theta = atan(orig.x,orig.y);\n        \t\tfloat phi = atan(r*sin(theta),orig.x);" + r + "\n\t\t\t}\n" : "ny" == e ? t = i + "\n\t\t\tvoid main() {\n\t\t\t\tfloat r = 0.5;\n\t\t\t\tvec2 orig = vec2(0.5-v_TexCoord.x,v_TexCoord.y-0.5);\n\t\t\t\tfloat theta = atan(orig.x,orig.y);\n\t\t\t\tfloat phi = atan(r*sin(theta),orig.x);\n\t\t\t\tphi = -phi;" + r + "\n\t\t\t}\n" : console.error("shader fragment type error!"), t
  }

  function d() {
    var e = "\n        attribute vec4 a_Position;\n        attribute vec2 a_TexCoord;\n        varying vec2 v_TexCoord;\n        void main() {\n            gl_Position= a_Position;\n            v_TexCoord = a_TexCoord;\n        }\n";
    return e
  }

  function u() {
    var e = document.createElement("canvas"), r = e.getContext("2d");
    e.width = 6 * t, e.height = i;
    var o = document.createElement("canvas"), n = o.getContext("2d");
    o.width = t, o.height = i;
    var a = 180 * Math.PI / 180;
    if (n.rotate(a), m.sliceSegment) {
      var s = [], c = document.createElement("canvas");
      c.width = i / m.sliceSegment, c.height = i / m.sliceSegment;
      var l = c.getContext("2d");
      for (var d in v) {
        n.drawImage(v[d], 0, 0, -t, -i);
        for (var u = 0; u < m.sliceSegment; u++) for (var h = 0; h < m.sliceSegment; h++) l.putImageData(n.getImageData(h * (i / m.sliceSegment), u * (i / m.sliceSegment), i * (h + 1) / m.sliceSegment, i * (u + 1) / m.sliceSegment), 0, 0), s.push(c.toDataURL("image/jpeg"))
      }
      return s
    }
    for (var d in v) n.drawImage(v[d], 0, 0, -t, -i), r.drawImage(o, t * d, 0, t, i);
    return e.toDataURL("image/jpeg")
  }

  var m = this, h = {x: "x", nx: "nx", ny: "ny", y: "y", z: "z", nz: "nz"}, v = [], f = 0, p = 0, g = new Image;
  g.crossOrigin = "Anonymous", g.src = e, g.onload = function () {
    for (var e in h) {
      var r = document.createElement("canvas");
      r.width = t, r.height = i, r.id = "face_" + e, v[p] = r;
      var n = r.getContext("webgl", {preserveDrawingBuffer: !0}), c = s(n, e), l = a(n, c),
        d = n.getUniformLocation(c, "PI");
      n.uniform1f(d, Math.PI), n.clearColor(0, 0, 0, 1), o(n, c, l, g) || console.log("Failed to intialize the texture."), p++
    }
  }
};
var AR = function (e, t, i, r, o) {
  var n = this;
  this.scene = e, this.renderer = t, this.container = i, AVR.setCameraPara(n, r, o), this.constraints = {}, this.video = null, this.openAudio = !1, this.cameraIndex = 1, this._controlTarget = new THREE.Vector3(1e-4, 0, 0), this.camera = new THREE.PerspectiveCamera(this.cameraPara.fov, this.cameraPara.aspect, this.cameraPara.near, this.cameraPara.far), this.camera.position.set(this.cameraPosition.x, this.cameraPosition.y, this.cameraPosition.z), this.cameraReady = !1, this.scene.add(this.camera), this.clock = new THREE.Clock, this.tempCanvas = document.createElement("canvas"), this.effect = AVR.stereoEffect(this.renderer), this._takeScreenShot = !1
};
AR.prototype.init = function () {
  function e(e) {
    i.video.srcObject = e
  }

  function t(e) {
    alert(e)
  }

  var i = this;
  if (AVR.bindOrientationEnevt(i, i._controlTarget), this.video = AVR.createTag("video", {
    "webkit-playsinline": !0,
    playsinline: !0,
    preload: "auto",
    "x-webkit-airplay": "allow",
    "x5-playsinline": !0,
    "x5-video-player-type": "h5",
    "x5-video-player-fullscreen": !0,
    "x5-video-orientation": "portrait",
    style: "object-fit: fill",
    autoplay: "autoplay"
  }, {allowsInlineMediaPlayback: !0}), this.video.style.zIndex = "-99999", this.video.style.position = "absolute", this.video.style.left = "0px", this.video.style.top = "0px", this.video.style.width = "2px", this.video.style.height = "2px", document.body.appendChild(this.video), this.video.oncanplaythrough = function () {
    i.cameraReady = !0, i.video.readyState === i.video.HAVE_ENOUGH_DATA && (i.cameraTexture = new THREE.VideoTexture(i.video), i.cameraTexture.generateMipmaps = !1, i.cameraTexture.format = THREE.RGBAFormat, i.cameraTexture.maxFilter = THREE.NearestFilter, i.cameraTexture.minFilter = THREE.NearestFilter, i.scene.background = i.cameraTexture, i.cameraTexture.needsUpdate = !0)
  }, navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia, window.URL = window.URL || window.webkitURL || window.mozURL || window.msURL, navigator.getUserMedia) {
    var r = {audio: i.openAudio, video: {facingMode: {exact: i.cameraIndex ? "environment" : "user"}}};
    navigator.getUserMedia(r, e, t)
  } else alert("Native device meadia streaming(getUserMdeia) not supported in this browser.")
}, AR.prototype.takeCameraPhoto = function () {
  var e = this.tempCanvas.getContext("2d");
  return e.clearRect(0, 0, window.innerWidth, window.innerHeight), e.drawImage(this.video, 0, 0, window.innerWidth, window.innerHeight), e.toDataURL("image/jpeg")
}, AR.prototype.takeScreenShot = function (e) {
  this._takeScreenShot = !0, this._takeScreenShotCallback = e
}, AR.prototype.play = function () {
  function e() {
    if (i._takeScreenShot) {
      i._takeScreenShot = !1;
      var e = i.renderer.domElement.toDataURL("image/jpeg");
      i._takeScreenShotCallback(e)
    }
    if (i.cameraReady) {
      var t = window.innerWidth, r = window.innerHeight;
      i.camera.aspect = t / r, i.cameraTexture.repeat.y = r / i.video.videoHeight, i.cameraTexture.offset.x = 0, i.cameraTexture.offset.y = 0, AVR.isMobileDevice() && AVR.isCrossScreen() ? (i.cameraTexture.repeat.x = t / (2 * i.video.videoWidth), i.effect.setSize(t, r), i.effect.render(i.scene, i.camera)) : (i.cameraTexture.repeat.x = t / i.video.videoWidth, i.renderer.setSize(t, r), i.renderer.setClearColor(new THREE.Color(16777215)), i.renderer.render(i.scene, i.camera)), i.camera.updateProjectionMatrix()
    }
    i.controls && i.controls.update(i.clock.getDelta())
  }

  function t() {
    requestAnimationFrame(t), e()
  }

  var i = this;
  t()
};
var AVR = {
  debug: !1,
  startGyro: function (e) {
    function t(t) {
      e(t)
    }

    window.addEventListener("deviceorientation", t, !1)
  },
  stereoEffect: function (e) {
    this.separation = 1, this.focalLength = 15;
    var t, i, r, o, n, a, s, c, l, d, u, m, h = new THREE.Vector3, v = new THREE.Quaternion, f = new THREE.Vector3,
      p = new THREE.PerspectiveCamera, g = new THREE.PerspectiveCamera;
    return e.autoClear = !1, this.setSize = function (r, o) {
      t = r / 2, i = o, e.setSize(r, o)
    }, this.render = function (E, T) {
      E.updateMatrixWorld(), void 0 === T.parent && T.updateMatrixWorld(), T.matrixWorld.decompose(h, v, f), r = THREE.Math.radToDeg(2 * Math.atan(Math.tan(.5 * THREE.Math.degToRad(T.fov)))), c = T.near / this.focalLength, d = Math.tan(.5 * THREE.Math.degToRad(r)) * this.focalLength, l = .5 * d * T.aspect, a = d * c, s = -a, u = (l + this.separation / 2) / (2 * l), m = 1 - u, o = 2 * l * c * m, n = 2 * l * c * u, p.projectionMatrix.makePerspective(-o, n, a, s, T.near, T.far), p.position.copy(h), p.quaternion.copy(v), p.translateX(-this.separation / 2), g.projectionMatrix.makePerspective(-n, o, a, s, T.near, T.far), g.position.copy(h), g.quaternion.copy(v), g.translateX(this.separation / 2), e.setViewport(0, 0, 2 * t, i), e.setViewport(0, 0, t, i), e.render(E, p), e.setViewport(t, 0, t, i), e.render(E, g)
    }, this
  },
  orbitControls: function (e, t) {
    var i = function (e, t) {
      function i() {
        return 2 * Math.PI / 60 / 60 * p.autoRotateSpeed
      }

      function r(e) {
        p.defaultDirectionOfRotation ? p.usingGyro ? b.theta -= e : b.theta += e : b.theta -= e
      }

      function o(e) {
        p.defaultDirectionOfRotation ? p.usingGyro ? b.phi -= e : b.phi += e : b.phi -= e
      }

      function n(e, t, i, r) {
        var o, n, a, s = e * t + i * r;
        if (s > .499) {
          a = 2 * Math.atan2(e, r), o = Math.PI / 2, n = 0;
          var c = new THREE.Vector3(o, n, a);
          return c
        }
        if (s < -.499) {
          a = -2 * Math.atan2(e, r), o = -Math.PI / 2, n = 0;
          var c = new THREE.Vector3(o, n, a);
          return c
        }
        var l = e * e, d = t * t, u = i * i;
        a = Math.atan2(2 * t * r - 2 * e * i, 1 - 2 * d - 2 * u), o = Math.asin(2 * s), n = Math.atan2(2 * e * r - 2 * t * i, 1 - 2 * l - 2 * u);
        var c = new THREE.Vector3(o, n, a);
        return c
      }

      function a(e, t) {
        return 2 * Math.PI * e / t * p.rotateSpeed
      }

      function s(e, t) {
        return 2 * Math.PI * e / t * p.rotateSpeed
      }

      function c(e) {
        _ = !0;
        var t = e.clientX || e.changedTouches[0].clientX, i = e.clientY || e.changedTouches[0].clientY;
        y.set(t, i)
      }

      function l(e) {
        var t = e.clientX || e.changedTouches[0].clientX, i = e.clientY || e.changedTouches[0].clientY;
        w.set(t, i), R.subVectors(w, y);
        var n = void 0 !== p.domElement.clientWidth ? p.domElement.clientWidth : window.innerWidth;
        r(a(R.x, n));
        var c = void 0 !== p.domElement.clientHeight ? p.domElement.clientHeight : window.innerHeight;
        o(s(R.y, c)), y.copy(w)
      }

      function d(e) {
        _ = !1
      }

      function u(e) {
        _ = !0, y.set(e.touches[0].pageX, e.touches[0].pageY), p.usingGyro = !1
      }

      function m(e) {
        e.preventDefault(), w.set(e.touches[0].pageX, e.touches[0].pageY), R.subVectors(w, y);
        var t = void 0 != p.domElement.clientWidth ? p.domElement.clientWidth : window.innerWidth;
        r(a(R.x, t));
        var i = void 0 !== p.domElement.clientHeight ? p.domElement.clientHeight : window.innerHeight;
        o(s(R.y, i)), y.copy(w), x.x += a(R.x, t) + s(R.y, i), p.usingGyro = !1
      }

      function h(e) {
        p.usingGyro = !!AVR.OS.isMobile(), _ = !1
      }

      function v(e) {
        p.deviceOrientation = e, void 0 === p.beginAlpha && (p.beginAlpha = p.deviceOrientation.alpha)
      }

      function f(e) {
        p.screenOrientation = window.orientation || 0
      }

      this.domElement = void 0 !== t ? t : document, this.object = e, this.object.rotation.reorder("YXZ"), this.enable = !0, this.target = new THREE.Vector3, this.minPolarAngle = 0, this.maxPolarAngle = Math.PI, this.minAzimuthAngle = -(1 / 0), this.maxAzimuthAngle = 1 / 0, this.enableDamping = !1, this.dampingFactor = .05, this.rotateSpeed = .25, this.autoRotate = !1, this.autoRotateSpeed = 1, this.deviceOrientation = {}, this.screenOrientation = 0;
      var p = this;
      p.defaultDirectionOfRotation = !0, p.gyroEnable = !1, p.usingGyro = !!AVR.OS.isMobile(), p._defaultTargetY = p.target.y, p._defaultCameraFov = p.object.fov, p._defaultCameraY = p.object.position.y;
      var g = {type: "change"}, E = 1e-6, T = new THREE.Spherical, b = new THREE.Spherical, y = new THREE.Vector2,
        w = new THREE.Vector2, R = new THREE.Vector2, x = new THREE.Vector3(0, 0, 0), A = 0, H = 0, S = 0, C = 0, L = 0;
      this.target0 = this.target.clone(), this.position0 = this.object.position.clone(), this.rotation0 = this.object.rotation.clone(), this.zoom0 = this.object.zoom, this.getPolarAngle = function () {
        return T.phi
      }, this.getAzimuthalAngle = function () {
        return T.theta
      }, this.saveState = function () {
        p.target0.copy(p.target), p.position0.copy(p.object.position), p.rotation0.copy(p.object.rotation), p.zoom0 = p.object.zoom
      }, this.reset = function (e) {
        this.resetVar(), p.dispatchEvent(g), e && e.target0 ? p.target.copy(e.target0) : p.target.copy(p.target0), e && e.position0 ? p.object.position.copy(e.position0) : p.object.position.copy(p.position0), e && e.rotation0 ? p.object.rotation.copy(e.rotation0) : p.object.rotation.copy(p.rotation0), e && e.zoom0 ? p.zoom = zoom0 : p.zoom0
      }, this.resetVar = function () {
        S = 0, C = 0, L = 0, A = 0, H = 0
      };
      var V = function () {
        var e = new THREE.Vector3(0, 0, 1), t = new THREE.Euler, i = new THREE.Quaternion,
          r = new THREE.Quaternion((-Math.sqrt(.5)), 0, 0, Math.sqrt(.5));
        return function (o, n, a, s, c) {
          t.set(a, n, -s, "YXZ"), o.setFromEuler(t), o.multiply(r), o.multiply(i.setFromAxisAngle(e, -c))
        }
      }();
      this.update = function () {
        var t = new THREE.Vector3, o = (new THREE.Quaternion).setFromUnitVectors(e.up, new THREE.Vector3(0, 1, 0)),
          a = o.clone().inverse(), s = new THREE.Vector3, c = new THREE.Quaternion;
        return function (e) {
          if (p.enable) {
            e = e || {};
            var l = p.deviceOrientation.alpha ? THREE.Math.degToRad(void 0 === p.beginAlpha ? p.deviceOrientation.alpha : p.deviceOrientation.alpha - p.beginAlpha) : 0,
              d = p.deviceOrientation.beta ? THREE.Math.degToRad(p.deviceOrientation.beta) : 0,
              u = p.deviceOrientation.gamma ? THREE.Math.degToRad(p.deviceOrientation.gamma) : 0,
              m = p.screenOrientation ? THREE.Math.degToRad(p.screenOrientation) : 0;
            p.gyroEnable ? (S = l, C = d, L = u) : (l = S, d = C, u = L);
            var h = (new THREE.Quaternion).copy(p.object.quaternion);
            V(h, l, d, u, m);
            var v = n(h.x, h.y, h.z, h.w);
            e.init || r(A - v.z),
              H = v.y, A = v.z;
            var f = p.object.position;
            return t.copy(f).sub(p.target), t.applyQuaternion(o), T.setFromVector3(t), p.autoRotate && r(i()), T.theta += b.theta, T.phi += b.phi, T.theta = Math.max(p.minAzimuthAngle, Math.min(p.maxAzimuthAngle, T.theta)), T.phi = Math.max(p.minPolarAngle, Math.min(p.maxPolarAngle, T.phi)), T.makeSafe(), t.setFromSpherical(T), t.applyQuaternion(a), f.copy(p.target).add(t), p.deviceOrientation && p.gyroEnable ? V(p.object.quaternion, l + Math.PI + x.x, d + x.y, u + x.z, m) : p.object.lookAt(p.target), p.enableDamping && !p.gyroEnable ? (b.theta *= 1 - p.dampingFactor, b.phi *= 1 - p.dampingFactor) : b.set(0, 0, 0), (s.distanceToSquared(p.object.position) > E || 8 * (1 - c.dot(p.object.quaternion)) > E) && (p.dispatchEvent(g), s.copy(p.object.position), c.copy(p.object.quaternion), !0)
          }
        }
      }();
      var _ = !1;
      window.addEventListener("orientationchange", f, !1), window.addEventListener("deviceorientation", v, !1), this.gyroFreeze = function () {
        p.gyroEnable = !1
      }, this.gyroUnfreeze = function () {
        p.gyroEnable = !0
      }, this.rotationLeft = r, this.rotationUp = o, this.domElement.addEventListener("mousedown", c, !1), this.domElement.addEventListener("mousemove", function (e) {
        p.enable && _ && l(e)
      }, !1), this.domElement.addEventListener("mouseup", d, !1), this.domElement.addEventListener("touchstart", u, !1), this.domElement.addEventListener("touchend", h, !1), this.domElement.addEventListener("touchmove", m, !1);
      var M = void 0 !== this.domElement.clientWidth ? this.domElement.clientWidth : window.innerWidth,
        P = void 0 !== this.domElement.clientHeight ? this.domElement.clientHeight : window.innerHeight;
      return y.set(M / 2, P / 2), setTimeout(function () {
        p.update({init: !0}), p.saveState()
      }, 10), this
    };
    return i.prototype = Object.create(THREE.EventDispatcher.prototype), i.prototype.constructor = i, new i(e, t)
  },
  setCameraPara: function (e, t, i) {
    if (e.cameraPara = {
      fov: 90,
      aspect: e.container.innerWidth / e.container.innerHeight,
      near: .001,
      far: 1e3
    }, e.cameraPosition = {x: 0, y: 0, z: 0}, t) for (var r in t) e.cameraPara[r] = t[r];
    if (i) for (var r in i) e.cameraPosition[r] = i[r]
  },
  formatSeconds: function (e) {
    var t = parseInt(e);
    if (!t) return "00:00";
    var i = 0, r = 0;
    t > 60 && (i = parseInt(t / 60), t = parseInt(t % 60), i > 60 && (r = parseInt(i / 60), i = parseInt(i % 60)));
    var o = "" + (parseInt(t) < 10 ? "0" + parseInt(t) : parseInt(t));
    return o = i >= 0 && r > 0 ? (parseInt(r) < 10 ? "0" + parseInt(r) : parseInt(r)) + ":" + (parseInt(i) < 10 ? "0" + parseInt(i) : parseInt(i)) + ":" + o : i > 0 && 0 == r ? 60 == i ? "01:00:" + o : (parseInt(i) < 10 ? "0" + parseInt(i) : parseInt(i)) + ":" + o : 60 == t ? "01:00" : "00:" + o
  },
  cameraVector: function (e, t) {
    var i = new THREE.Vector3(0, 0, (-1)), r = i.applyQuaternion(e.quaternion), o = r.clone(), n = new THREE.Vector3;
    return t && (n.x = r.x * t, n.y = r.y * t, n.z = r.z * t), {vector: o, timesVector: n}
  },
  bindRaycaster: function (e, t, i) {
    var r = AVR.screenPosTo3DCoordinate(e, t.container, t.camera),
      o = new THREE.Raycaster(t.camera.position, r.sub(t.camera.position).normalize()),
      n = o.intersectObjects(t.scene.children, !0);
    n.length ? i.success(n) : i.empty()
  },
  bindCameraEvent: function (e, t) {
    t = t || {
      trigger: function (e) {
      }, empty: function (e) {
      }, move: function (e) {
      }
    };
    var i = this, r = t.scale || .022, o = t.vectorRadius, n = o * r, a = o * (r / 6), s = 2,
      c = t.tubularSegments || 60, l = t.speed || 36, d = new THREE.Group;
    d.name = "__controlHandle";
    for (var u = new THREE.TorusGeometry(n, a, s, c, 2 * Math.PI), m = [], h = 0; h < u.faces.length / 2; h++) m[h] = new THREE.MeshBasicMaterial({
      color: 15194842,
      depthTest: !1
    });
    for (var v = 0, f = [new THREE.Vector2(0, 0), new THREE.Vector2(1, 0), new THREE.Vector2(1, 1), new THREE.Vector2(0, 1)], h = 0, p = u.faces.length; h < p; h += 2) u.faces[h].materialIndex = v, u.faces[h + 1].materialIndex = v, u.faceVertexUvs[0][h] = [f[3], f[0], f[2]], u.faceVertexUvs[0][h + 1] = [f[0], f[1], f[2]], v++;
    var g = new THREE.Mesh(u, m);
    g.name = "__wait", g.visible = !1, d.add(g);
    var E = new THREE.Mesh(new THREE.CircleGeometry(a, 4), new THREE.MeshBasicMaterial({
      color: 15194842,
      wireframe: !0,
      depthTest: !1
    }));
    E.lookAt(e.camera.position), E.name = "__focus", E.material.depthTest = !1, E.visible = !1, d.add(E), d.position.set(0, 0, .1);
    var T = (new THREE.Vector3, function () {
      d.lookAt(0, 0, 0), g.lookAt(0, 0, 0);
      var r = i.cameraVector(e.camera, o);
      E.visible = !0, d.position.set(r.timesVector.x, r.timesVector.y, r.timesVector.z);
      var n = new THREE.Raycaster(e.camera.position, r.vector), a = n.intersectObjects(e.scene.children, !0);
      a.length ? t.move(a) : t.empty(a)
    }), b = null, y = function (e) {
      g.visible = !0;
      var i = 0, r = 0;
      b || (b = setInterval(function () {
        r < u.faces.length / 4 ? (m[r].color = new THREE.Color(14710133), u.needsUpdate = !0, u.faces[i].materialIndex = r, u.faces[i + 1].materialIndex = r, u.faceVertexUvs[0][i] = [f[3], f[0], f[2]], u.faceVertexUvs[0][i + 1] = [f[0], f[1], f[2]], i += 2) : (clearInterval(b), b = null, t.trigger(e)), r++
      }, l))
    }, w = function (e) {
      clearInterval(b), b = null, v = 0;
      for (var t = 0, i = u.faces.length; t < i; t += 2) m[v].color = new THREE.Color(15194842), u.needsUpdate = !0, u.faces[t].materialIndex = v, u.faces[t + 1].materialIndex = v, u.faceVertexUvs[0][t] = [f[3], f[0], f[2]], u.faceVertexUvs[0][t + 1] = [f[0], f[1], f[2]], v++;
      g.visible = !1
    };
    e.VRObject.add(d), e.cameraEvt.controlGroup = d, e.cameraEvt.updatePosition = T, e.cameraEvt.hover = y, e.cameraEvt.leave = w
  },
  screenPosTo3DCoordinate: function (e, t, i) {
    var r = e.clientX || (e.touches ? e.touches[0].clientX : 0),
      o = e.clientY || (e.touches ? e.touches[0].clientY : 0);
    rect = AVR.getBoundingClientRect(t), x = r - rect.left, y = o - rect.top;
    var n = t.clientWidth, a = t.clientHeight, s = new THREE.Vector2;
    s.x = 2 * x / n - 1, s.y = 1 - 2 * y / a;
    var c = new THREE.Vector3(s.x, s.y, 0).unproject(i);
    return c.sub(i.position).normalize()
  },
  objectPosToScreenPos: function (e, t, i) {
    var r = new THREE.Vector3;
    r.setFromMatrixPosition(e.matrixWorld).project(i);
    var o = r.x, n = r.y, a = t.clientWidth, s = t.clientHeight, c = new THREE.Vector2;
    return c.x = a / 2 * (o + 1), c.y = s / 2 * (1 - n), c
  },
  fullscreen: function (e) {
    var t = document.fullScreen || document.mozFullScreen || document.webkitIsFullScreen || !1;
    t ? document.exitFullscreen ? document.exitFullscreen() : document.mozCancelFullScreen ? document.mozCancelFullScreen() : document.webkitExitFullscreen ? document.webkitExitFullscreen() : "" : e.requestFullscreen && e.requestFullscreen() || e.mozRequestFullScreen && e.mozRequestFullScreen() || e.webkitRequestFullscreen && e.webkitRequestFullscreen() || e.msRequestFullscreen && e.msRequestFullscreen()
  },
  isFullscreen: function () {
    return document.fullscreenElement || document.msFullscreenElement || document.mozFullScreenElement || document.webkitFullscreenElement || !1
  },
  toolBar: function (e) {
    function t(e) {
      for (var t = e.match(/&#(\d+);/g), i = "", r = 0; r < t.length; r++) i += String.fromCharCode(t[r].replace(/[&#;]/g, ""));
      return i
    }
    //播放器图标栏样式
    var i = "_toolBar",

      r = this.createTag("div", {
      style: "-moz-user-select:block;-webkit-user-select:none;user-select:block;position:absolute;background:rgba(0,0,0,.2);width:100%;height:2.2rem;bottom:0rem",
      "class": i + "Area"
    }), o = this.createTag("div", {
      //播放开始图标
      style: "position:inherit;border-top:0.6rem solid transparent;border-left:1rem solid white;border-bottom:0.6rem solid transparent;bottom:0.25rem;left:1rem;color:#fff;font-weight:800;cursor:pointer",
      "class": i + "Btn"
    });
    r.appendChild(o);
    //播放器计时图片样式
    var n = this.createTag("div", {style: "position:inherit;bottom:0.25rem;left:2.8rem;color:#fff;font-size:0.75rem"}),
      a = this.createTag("span", null, {innerText: "00:00"});
    n.appendChild(a);
    var s = this.createTag("span", null, {innerText: "/"});
    n.appendChild(s);
    var c = this.createTag("span", null, {innerText: "00:00"});
    n.appendChild(c), r.appendChild(n);
    var l = document.styleSheets[0];
    l.insertRule("@keyframes moreTip{from {top:0.75rem;} to{top:1rem}}", 0), AVR.Broswer.isIE() || l.insertRule("@-webkit-keyframes moreTip{from {top:0.75rem;} to{top:1rem}}", 0);
    var d = this.createTag("span", {style: "width:2.2rem;height:2.2rem;position:inherit;left:50%;margin-left:-1.1rem;margin-top:-0.75rem;color:#fff;font-size:1.5rem;cursor:pointer;margin-top:1rem;border:0.0625rem dotted #ccc;height:0.0625rem;"}, {innerHTML: ""}),
      u = this.createTag("div", {style: "width:100%;height:auto;position:inherit;background:rgba(0,0,0,0);top:2.4rem;bottom:1.8rem;overflow: hidden;"}, null),
      m = this.createTag("ul", {style: "display:flex;display: -webkit-flex;display: -webkit-box;display: -moz-box;display: -ms-flexbox;margin:0;padding:0;list-style:none;height:100%;"}, null);
    u.appendChild(m), r.appendChild(d), r.appendChild(u);
    var h = this.createTag("div", {
      style: "width:2.2rem;height:2.2rem;position:inherit;right:1rem;margin-left:-1.1rem;margin-top:0.6rem;color:#fff;font-size:1.2rem;cursor:pointer;display:none",
      copy: "&#67;&#111;&#112;&#121;&#114;&#105;&#103;&#104;&#116;&#32;&#169;&#32;&#50;&#48;&#49;&#56;&#32;&#87;&#87;&#87;&#46;&#77;&#88;&#82;&#69;&#65;&#76;&#73;&#84;&#89;&#46;&#67;&#78;&#46;&#32;&#65;&#108;&#108;&#32;&#114;&#105;&#103;&#104;&#116;&#115;&#32;&#114;&#101;&#115;&#101;&#114;&#118;&#101;&#100;&#46;"
    }, {innerText: "？"});
    h.addEventListener("click", function () {
      var e = this.getAttribute("copy");
      alert(t(e))
    }, !1), h.addEventListener("mouseover", function () {
      var e = this.getAttribute("copy");
      this.setAttribute("title", t(e))
    }, !1), r.appendChild(h);
    //播放器图标栏右下角
    var v = this.createTag("div", {style: "border:0.125rem solid white;border-radius:1rem;width:1rem;height:1rem;position:inherit;right:5.8rem;line-height:1rem;bottom:0.25rem;cursor:pointer"}),
      f = this.createTag("div", {style: "border:0.08rem solid white;border-radius:8rem;background:rgba(240,240,240,0.6);width:0.3rem;left:0.26rem;top:0.26rem;height:0.3rem;position:inherit;line-height:0.3rem;cursor:pointer"});
    v.appendChild(f), r.appendChild(v);
    var p = this.createTag("div", {style: "border:0.125rem solid white;border-radius:1rem;width:1.4rem;height:1rem;position:inherit;right:3.5rem;line-height:1rem;bottom:0.25rem;cursor:pointer"}),
      g = this.createTag("div", {style: "position:inherit;width:1.235rem;height:0.4rem;line-height:0.4rem;border:0.0625rem solid white;border-radius:0.6rem/0.2rem;margin-top:0.25rem;margin-left:0.055rem;"});
    p.appendChild(g);
    var E = this.createTag("div", {style: "position:inherit;width:1rem;height:0.4rem;line-height:0.4rem;border:0.0625rem solid white;border-radius:0.6rem/0.2rem;margin-top:0.25rem;margin-left:0.175rem;transform:rotate(90deg)"});
    p.appendChild(E), r.appendChild(p);
    var T = this.createTag("div", {style: "position:inherit;right:1rem;width:1.4rem;height:1rem;line-height:1rem;border:0.125rem solid white;border-radius:0.125rem;bottom:0.25rem;text-align:center;font-weight:800;color:#fff;font-size:0.75rem;cursor:pointer"}, {innerText: "VR"});
    r.appendChild(T);
    var b = this.createTag("div", {style: "position:inherit;top:0rem;width:100%;height:0.1rem;background:rgba(255,255,255,.3);cursor:pointer"}),
      y = this.createTag("div", {style: "position:inherit;width:0%;height:0.1rem;background:rgba(255,255,255,.3)"});
    b.appendChild(y);
    var w = this.createTag("div", {style: "position:inherit;width:0%;height:0.1rem;background:rgba(28, 175, 252,.6)"});
    b.appendChild(w), r.appendChild(b), e.appendChild(r);
    var R = this.createTag("div", {style: "-moz-user-select:none;-webkit-user-select:none;user-select:none;position:absolute;width:2rem;height:60%;background:rgba(0,0,0,0);left:0rem;top:20%;text-align:center;display:none;border-radius:1rem;"}),
      x = this.createTag("div", {style: "position:inherit;width:0.25rem;background:rgba(255,255,255,.1);height:100%;left:0.875rem;cursor:pointer;border-radius:1rem;"});
    R.appendChild(x);
    var A = this.createTag("div", {style: "position:inherit;width:100%;background:rgba(255, 255, 255,.6);bottom:0rem;;border-radius:1rem;"});
    return x.appendChild(A), e.appendChild(R), {
      toolbar: r,
      btn: o,
      timeInfo: n,
      curTime: a,
      splitTime: s,
      totalTime: c,
      moreBtn: d,
      moreList: u,
      moreListUl: m,
      vrBtn: T,
      progressBar: b,
      loadedProgress: y,
      playProgress: w,
      gyroResetBtn: v,
      gyroBtn: p,
      circle1: g,
      circle2: E,
      voice_bar: R,
      about: h
    }
  },
  msgBox: function (e, t, i) {
    if (e) {
      var r = this.createTag("div", {style: "position:absolute;bottom:50%;width:100%;padding:0.25rem;background:rgba(0,0,0,.6);color:#fff;text-align:center;"}, {innerHTML: e});
      i.appendChild(r), setTimeout(function () {
        r.remove()
      }, 1e3 * t)
    }
  },
  isMobileDevice: function (e) {
    var t = navigator.userAgent.toLowerCase();
    if (e) return t.match(/ipad/i) || t.match(/iphone os/i) || t.match(/midp/i) || t.match(/rv:1.2.3.4/i) || t.match(/ucweb/i) || t.match(/android/i) || t.match(/windows ce/i) || t.match(/windows mobile/i);
    var i = "ipad" == t.match(/ipad/i), r = "iphone os" == t.match(/iphone os/i), o = "midp" == t.match(/midp/i),
      n = "rv:1.2.3.4" == t.match(/rv:1.2.3.4/i), a = "ucweb" == t.match(/ucweb/i),
      s = "android" == t.match(/android/i), c = "windows ce" == t.match(/windows ce/i),
      l = "windows mobile" == t.match(/windows mobile/i);
    return !!(i || r || o || n || a || s || c || l)
  },
  bindOrientationEnevt: function (e) {
    void 0 === e.controls && (e.controls = AVR.orbitControls(e.camera, e.renderer.domElement), e.controls.target = e._controlTarget.clone())
  },
  isCrossScreen: function (e) {
    return 180 != window.orientation && 0 != window.orientation && (90 == window.orientation || window.orientation == -90 || void 0)
  },
  initDomStyle: function (e) {
    function t(e) {
      e.preventDefault()
    }

    document.body.style.overflow = "hidden", document.body.style.margin = 0, document.body.style.padding = 0, e.style.position = "absolute", e.style.width = "100%", e.style.height = "100%", e.style.left = "0px", e.style.top = "0px", e.style.overflow = "hidden";
    var i = document.createElement("style");
    document.getElementsByTagName("head")[0].appendChild(i), document.body.addEventListener("touchmove", t), document.oncontextmenu = function () {
      return !1
    }, document.onkeydown = function () {
      if (!this.debug && window.event && 123 == window.event.keyCode) return event.keyCode = 0, event.returnValue = !1, !1
    }
  },
  createTag: function (e, t, i) {
    var r = document.createElement(e);
    if (t && "object" == typeof t) for (var o in t) r.setAttribute(o, t[o]);
    if (i && "object" == typeof i) for (var o in i) r[o] = i[o];
    return r
  },
  OS: {
    weixin: navigator.userAgent.indexOf("MicroMessenger") > -1,
    android: /android/i.test(navigator.userAgent.toLowerCase()),
    ios: /(iphone|ipad|ipod|ios)/i.test(navigator.userAgent.toLowerCase()),
    googlePixel: navigator.userAgent.match(/;\sPixel\sBuild\//),
    MiOS: navigator.userAgent.match(/;\sMI\s\d\sBuild\//),
    samsungOS: navigator.userAgent.match(/;\sSM\-\w+\sBuild\//),
    isGooglePixel: function () {
      return null != this.googlePixel
    },
    isMiOS: function () {
      return null != this.MiOS
    },
    isSamsung: function () {
      return null != this.samsungOS
    },
    isMobile: function () {
      return this.android || this.ios
    },
    isAndroid: function () {
      return this.android
    },
    isiOS: function () {
      return this.ios
    },
    isWeixin: function () {
      return this.weixin
    }
  },
  Broswer: {
    win: window,
    nav: window.navigator,
    REG_APPLE: /^Apple/,
    ie: navigator.userAgent.match(/MSIE\s([\d.]+)/) || navigator.userAgent.match(/Trident\/[\d](?=[^\?]+).*rv:([0-9.].)/),
    edge: navigator.userAgent.match(/Edge\/([\d.]+)/),
    chrome: navigator.userAgent.match(/Chrome\/([\d.]+)/) || navigator.userAgent.match(/CriOS\/([\d.]+)/),
    webview: !this.chrome && navigator.userAgent.match(/(iPhone|iPod|iPad).*AppleWebKit(?!.*Safari)/),
    safari: this.webview || navigator.userAgent.match(/Version\/([\d.]+)([^S](Safari)|[^M]*(Mobile)[^S]*(Safari))/),
    chromiumType: null,
    _getChromiumType: function () {
      if (null != this.chromiumType) return this.chromiumType;
      var e = this.win;
      return this.isIE() || void 0 === e.scrollMaxX || this.REG_APPLE.test(this.nav.vendor || "") ? "" : this._testExternal(/^sogou/i, 0) ? "sogou" : this._testExternal(/^liebao/i, 0) ? "liebao" : this.nav.mimeTypes[30] || !this.nav.mimeTypes.length ? "360" : e.clientInformation && e.clientInformation.permissions ? "chrome" : ""
    },
    _testExternal: function (e, t) {
      var i = this.win.external || {};
      for (var r in i) if (e.test(t ? i[r] : r)) return !0;
      return !1
    },
    isIE: function () {
      return null != this.ie
    },
    ieVersion: function () {
      return null != this.ie && parseInt(this.ie[1])
    },
    isEdge: function () {
      return null != this.edge
    },
    isSafari: function () {
      return null != this.safari
    },
    is360: function () {
      return this.chromiumType = this._getChromiumType(), "360" === this.chromiumType
    },
    isSogou: function () {
      return this.chromiumType = this._getChromiumType(), "sogou" === this.chromiumType
    },
    isChromium: function () {
      return "chrome" === this._getChromiumType()
    },
    webglAvailable: function () {
      try {
        var e = document.createElement("canvas");
        return !(!window.WebGLRenderingContext || !e.getContext("webgl") && !e.getContext("experimental-webgl"))
      } catch (t) {
        return !1
      }
    }
  },
  getBoundingClientRect: function (e) {
    var t = e.getBoundingClientRect(),
      i = t.top - document.documentElement.clientTop + document.documentElement.scrollTop, r = t.bottom,
      o = t.left - document.documentElement.clientLeft + document.documentElement.scrollLeft, n = t.right,
      a = t.width || n - o, s = t.height || r - i;
    return {top: i, right: n, bottom: r, left: o, width: a, height: s}
  }
}, head = document.getElementsByTagName("head")[0];
head.appendChild(AVR.createTag("meta", {
  name: "viewport",
  content: "width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0,minimal-ui,user-scalable=no"
})), head.appendChild(AVR.createTag("meta", {
  name: "google",
  content: "notranslate"
})), head.appendChild(AVR.createTag("meta", {
  name: "full-screen",
  content: "yes"
})), AVR.debug && (window.onerror = function (e, t, i) {
  var r = "There was an error on this page.\n\n";
  return r += "Error: " + e + "\n", r += "URL: " + t + "\n", r += "Line: " + i + "\n\n", AVR.msgBox(r, 36, document.body), !0
});
