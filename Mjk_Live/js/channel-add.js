<!--  直播名称-->
$(function () {
  var text=$('#cname').val();
  var len =text.length;
  $('#cname').next().find('span').html(len)
  $('input').keyup(function () {
    var text = $(this).val();
    len = text.length;
    if (len > 7) {
      alert("直播名称过长")

    }
    $(this).next().find('span').html(len);
  })

});

<!--  直播简介-->
$(function () {
  var text=$('#jianjie').val();
  var len =text.length;
  $('#jianjie').next().find('span').html(len)
  $('textarea').keyup(function () {
    var text = $(this).val();
    len = text.length;
    if (len > 300) {
      return false;
    }
    $(this).next().find('span').html(len);
  })

});
function  ToCreate() {
  $.ajax({
    url: "http://192.168.3.234:8084/live/insertChannel",
    type: 'post',
    data: $("#addForm").serialize(),
    success: function () {
      location.href = "channellist.html?";
    },
    error: function () {
      alert("添加失败！");
    }
  })
}
