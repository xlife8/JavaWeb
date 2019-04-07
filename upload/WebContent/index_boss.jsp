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
  <!-- Page level plugin CSS-->
  <link href="vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
  <!-- Custom styles for this template-->
  <link href="css/sb-admin.css" rel="stylesheet">
</head>

<body class="fixed-nav sticky-footer bg-dark" id="page-top">
  <!-- Navigation-->
  <%@ include file = "./navigator_boss.jsp"%>

  <div class="content-wrapper">
    <h1>&nbsp&nbsp欢迎使用16级网工班文件管理系统</h1>
    <h4>&nbsp&nbsp功能介绍：</h4>
	<p>&nbsp&nbsp1、用于相关科目实验报告的收集；</p>
	<p>&nbsp&nbsp2、用于班委进行材料的采集；</p>
	<p>&nbsp&nbsp3、用于班级材料的存档备份，以备不时之需；</p>
	<p>&nbsp&nbsp4、提供班级同学简要信息表格的下载，以备不时之需；</p>
	
	<h4>&nbsp&nbsp使用说明：</h4>
	<p>&nbsp&nbsp单击文件夹所在单元格即可进入文件夹，单击下载单元格即可下载文件或文件夹；</p>
	<p>&nbsp&nbsp下载的文件夹会被压缩成.zip的压缩包，若文件夹中文件存在中文名称，则只有windows系统可以正常显示，linux系统中文名称会显示乱码，但是内容不受影响；</p>
	<p>&nbsp&nbsp文件夹删除只允许删除空文件夹，文件夹重命名不受限制；</p>
	<p>&nbsp&nbsp本网站不提供删除功能，文件一旦上传，则只能由网站管理员才能删除；</p>
	
	<h4>&nbsp&nbsp普通用户：</h4>
	<p>&nbsp&nbsp1、进行实验报告或相关材料的上传，便于班委收集；</p>
	<p>&nbsp&nbsp普通用户只有上传权限，没有下载和删除权限，若上传文件错误，可上传同名文件将错误文件覆盖；</p>
	
	<h4>&nbsp&nbsp管理员：</h4>
	<p>&nbsp&nbsp1、同普通用户；</p>
	<p>&nbsp&nbsp2、可进行文件或文件夹的打包下载；</p>
	<p>&nbsp&nbsp3、可新建文件夹或重命名文件夹；</p>
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
  </div>
</body>

</html>
