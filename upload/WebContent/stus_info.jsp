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
  <title>学生信息列表</title>
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
  <%@ include file = "./navigator.jsp"%>
  <div class="content-wrapper">
    <div class="container-fluid">
      <!-- Breadcrumbs-->
      
      <!-- Example DataTables Card-->
      <div class="card mb-3">
        <div class="card-header">
          <i class="fa fa-table"></i>学生信息列表</div>
        <div class="card-body">
          <div class="table-responsive">
            
              <form id="uploadForm" action="#" enctype="multipart/form-data">
	              <div class="form-row">
		            <div class="col-md-2">
		                <h5>导出成.xlsx文件</h5>
		            </div>
					<div class="col-md-8">
	                  <input class="form-control" type="text" id="filename" name="fileName" value="Students_Info.xlsx" readonly="true">
	                </div>
	                <div class="col-md-2">
	                  <a class="btn btn-primary btn-block" id="download">下载</a>
	                </div>
	               </div>
			   </form>
            
            <table id="table" width="100%" cellspacing="0"
            data-toggle="table" 
            data-sort-name="stuNum"
            data-pagination="true"
            data-pagination-loop="true"
            data-only-info-pagination="false"
            data-side-pagination="client"
            data-smart-display="true"
            data-search="true">
              <thead>
                <tr>
                  <th data-field="stuNum" data-sortable="true">学号</th>
                  <th data-field="stuName" data-sortable="true">姓名</th>
                  <th data-field="stuPhone">电话</th>
                  <th data-field="QQNum">QQ</th>
                  <th data-field="Mail">邮箱</th>
                </tr>
              </thead>
            </table>
          </div>
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
    <script src="vendor/datatables/jquery.dataTables.js"></script>
    <script src="vendor/datatables/dataTables.bootstrap4.js"></script>
    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin.min.js"></script>
    <!-- Custom scripts for this page-->
    <script src="js/sb-admin-datatables.min.js"></script>
        <!-- bootstrap-table resource -->
    <script src="dist/bootstrap-table.js"></script>
    <link href="dist/bootstrap-table.min.css" rel="stylesheet" />
    <script src="dist/locale/bootstrap-table-zh-CN.js"></script>
    <!-- layer.js -->
    <script src="layer/layer.js"></script>
    <link href="layui/css/layui.css" />
    <script src="layui/layui.js"></script>
    <script>
    var path;
    var oldpath;
	$(document).ready(function(){
		$.get("studentList",function(data,status){
			var JSONdata = JSON.parse(data);
			if(JSONdata["success"]) {
				$('#table').bootstrapTable('load', JSONdata["data"]);
			} else {
				layer.alert('请登录！', {
				    skin: 'layui-layer-lan'
				    ,closeBtn: 0
				    ,anim: 4 //动画类型
				  });
				window.location.replace("login.jsp");
			}
		});
		$('#download').click(function(){
	    	var downloadPath = window.location.href;
	    	downloadPath = downloadPath.substr(0,downloadPath.lastIndexOf("/"));
	    	downloadPath += "/downLoadXlsx?";
	    	downloadPath = downloadPath + "fileName=" + $('#filename').val();
	    	window.open(downloadPath);
		});
	});
  </script>
  </div>
</body>

</html>
