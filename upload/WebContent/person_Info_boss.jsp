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
  <title>个人信息详情</title>
  <!-- Bootstrap core CSS-->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!-- Custom fonts for this template-->
  <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
  <!-- Page level plugin CSS-->
  <link href="vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
  <!-- Custom styles for this template-->
  <link href="css/sb-admin.css" rel="stylesheet">
</head>

<body class="fixed-nav sticky-footer bg-dark" id="page-top">
  <!-- Navigation-->
  <%@ include file = "./navigator_boss.jsp"%>

  <div class="content-wrapper">
 <!-- <div class="container"> -->
    <div class="card card-register mx-auto mt-5">
      <div class="card-header">个人信息</div>
      <div class="card-body">
        <form id="info">
         <div class="form-group">
            <label for="exampleInputEmail1">学号</label>
            <input class="form-control" type="text" readonly="readonly" id="stunum" name="stuNum">
          </div>
          <div class="form-group">
            <div class="form-row">
              <div class="col-md-6">
                <label for="exampleInputPassword1">姓名</label>
                <input class="form-control" type="text" readonly="readonly" id="stuname" name="stuName">
              </div>
              <div class="col-md-6">
                <label for="exampleConfirmPassword">电话</label>
                <input class="form-control" type="text" readonly="readonly" id="stuphone" name="stuPhone">
              </div>
            </div>
          </div>
          <div class="form-group">
            <div class="form-row">
              <div class="col-md-6">
                <label for="exampleInputName">QQ</label>
                <input class="form-control" type="text" readonly="readonly" id="QQnum" name="QQNum">
              </div>
              <div class="col-md-6">
                <label for="exampleInputLastName">邮箱</label>
                <input class="form-control" type="text" readonly="readonly" id="mail" name="Mail">
              </div>
            </div>
          </div>
          <div class="form-group">
            <label for="exampleInputEmail1">密码</label>
            <input class="form-control" type="text" readonly="readonly" id="pwd" name="pwd">
          </div>
          <div class="form-group">
            <div class="form-row">
		      <div class="col-md-6">
		        <a class="btn btn-primary btn-block" id="alter">修改</a>
		      </div>
		      <div class="col-md-6">
		        <a class="btn btn-primary btn-block" id="confirm">完成</a>
		      </div>
		   </div>
          </div>
        </form>
      </div>
    </div>
  </div>
    <!-- /.container-fluid-->
    <!-- /.content-wrapper-->
    <%@ include file = "./footer.jsp"%>
    <!-- Logout Modal-->
    <%@ include file = "./logout.jsp"%>
    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
    <!-- Page level plugin JavaScript-->
    <script src="vendor/chart.js/Chart.min.js"></script>
    <script src="vendor/datatables/jquery.dataTables.js"></script>
    <script src="vendor/datatables/dataTables.bootstrap4.js"></script>
    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin.min.js"></script>
    <!-- Custom scripts for this page-->
    <script src="js/sb-admin-datatables.min.js"></script>
    <script src="js/sb-admin-charts.min.js"></script>
    <!-- layer.js -->
    <link href="layui/css/layui.css" />
    <script src="layer/layer.js"></script>
    <script src="layui/layui.js"></script>
    <script>
	$(document).ready(function(){
		getInfo();
		$("#alter").click(function(){
			alter(false);
		});
		$("#confirm").click(function(){
			$.ajax({
			    url:"stuAlter",
			    type:"POST",
			    data:$('#info').serialize(),
			    success: function(e) {
			    	data=$.parseJSON(e);
					if(data.success){
						layui.use('layer', function(){
						  var layer = layui.layer;
						  layer.msg('修改成功！');
						});
					}else{
						layui.use('layer', function(){
							var layer = layui.layer;
							layer.msg('修改失败！');
						});   
					}
			    },
			    complete: function(xhr, textStatus) {
			        if(xhr.status==400) {
			        	layui.use('layer', function(){
							var layer = layui.layer;
							layer.msg('修改失败！');
						});
			        }
			        alter(true);
			    } 
			});
		});
	});
	function alter(flag) {
		$("#stuphone").attr("readonly",flag);
		$("#QQnum").attr("readonly",flag);
		$("#mail").attr("readonly",flag);
		$("#pwd").attr("readonly",flag);
	}
	
	function getInfo() {
		$.get("stuInfo",function(data,status){
			var JSONdata = JSON.parse(data);
			if(JSONdata["success"]) {
				$("#stunum").val(JSONdata["stuNum"]);
				$("#stuname").val(JSONdata["stuName"]);
				$("#stuphone").val(JSONdata["stuPhone"]);
				$("#QQnum").val(JSONdata["QQNum"]);
				$("#mail").val(JSONdata["Mail"]);
				$("#pwd").val(JSONdata["pwd"]);
			} else {
				layer.alert('请登录！', {
				    skin: 'layui-layer-lan'
				    ,closeBtn: 0
				    ,anim: 4 //动画类型
				  });
				window.location.replace("login.jsp");
			}
		});
	}
  </script>
<!-- </div> -->
</body>

</html>