<%@ page language="java" pageEncoding="utf-8" %>
<%@ page contentType ="text/html; charset=utf-8" session="true" %>
<!DOCTYPE html>
<html lang="zh-cn">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>16级网工班文件管理系统</title>
  <!-- Bootstrap core CSS-->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!-- Custom fonts for this template-->
  <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
  <!-- Custom styles for this template-->
  <link href="css/sb-admin.css" rel="stylesheet">
</head>

<body class="bg-dark">
  <div class="container">
    <div class="card card-login mx-auto mt-5">
      <div class="card-header">16级网工班文件管理系统</div>
      <div class="card-body">
        <form>
          <div class="form-group">
            <label for="exampleInputEmail1">学号</label>
            <input class="form-control" id="InputNumber" aria-describedby="emailHelp" placeholder="请输入学号">
          </div>
          <div class="form-group">
            <label for="exampleInputPassword1">密码</label>
            <input class="form-control" id="InputPassword" type="password" placeholder="请输入密码">
          </div>
          <div class="form-group">
            <div class="form-check">
              <label class="form-check-label">
                <input class="form-check-input" type="checkbox">记住密码</label>
            </div>
          </div>
          <a class="btn btn-primary btn-block" id="login">登录</a>
        </form>
      </div>
    </div>
  </div>
  <!-- Bootstrap core JavaScript-->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <!-- Core plugin JavaScript-->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
      <!-- layer.js -->
    <script src="layer/layer.js"></script>
  <script>
	$(document).ready(function(){
		$("#login").click(function(){
			var number = $("#InputNumber").val();
			var pwd = $("#InputPassword").val();
			$.post("login",{stuNum:number,pwd:pwd},function(data,status){
				var JSONdata = JSON.parse(data);
				for(key in JSONdata) {
					if(key==1) {
						window.location.replace("index_boss.jsp");
					} else if(key==0){
						window.location.replace("index.jsp");
					} else {
						layer.alert(JSONdata[key], {
						    skin: 'layui-layer-lan'
						    ,closeBtn: 0
						    ,anim: 4 //动画类型
						  });
					}
				}
		    });
		});
	});
  </script>
</body>

</html>
