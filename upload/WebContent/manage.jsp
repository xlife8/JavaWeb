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
  <title>文件操作列表</title>
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
	<form id="folderManage" style="display:none;">
		<div class="form-group col-md-12">
		<p><span style="color:red;"> * </span>新建文件夹：原文件夹名称留空；</p>
		</div>
		<div class="form-group col-md-12">
		<p><span style="color:red;"> * </span>删除文件夹：新文件夹名称留空；</p>
		</div>
		<div class="form-group col-md-12">
		<p><span style="color:red;"> * </span>重命名文件夹：常规操作；</p>
		</div>
		<div class="form-group col-md-12">
		  <label>原文件夹名称</label>
		  <input type="text" class="form-control" id="oldFolder" placeholder="" name="oldFolder">
		</div>
		<div class="form-group col-md-12">
		  <label>新文件夹名称</label>
		  <input type="text" class="form-control" id="newFolder" placeholder="" name="newFolder">
		</div>
		<input type="hidden" id="currentpath" name="currentPath"></input>
	</form>
  <!-- Navigation-->
  <%@ include file = "./navigator_boss.jsp"%>
  <div class="content-wrapper">
    <div class="container-fluid">
      <!-- Example DataTables Card-->
      <div class="card mb-3">
        <div class="card-header">
          <i class="fa fa-table"></i>文件列表</div>
        <div class="card-body" id="card-body">
          <div class="table-responsive">
            
              <form id="uploadForm" action="#" enctype="multipart/form-data">
	              <div class="form-row">
					<div class="col-md-7">
	                  <input class="form-control" type="file" id="filestream" name="filestream">
	                </div>
	                <div class="col-md-1">
	                  <a class="btn btn-primary btn-block" id="upLoad">上传</a>
	                </div>
	                <div class="col-md-2">
	                  <a class="btn btn-primary btn-block" id="retreat">返回上一级</a>
	                </div>
	                <div class="col-md-2">
	                  <a class="btn btn-primary btn-block" id="doFolder">文件夹管理</a>
	                </div>
	               </div>
			   </form>
            
            <table id="table" width="100%" cellspacing="0"
            data-toggle="table" 
            data-sort-name="fileName"
            data-pagination="true"
            data-pagination-loop="true"
            data-only-info-pagination="false"
            data-side-pagination="client"
            data-smart-display="true"
            data-search="true">
              <thead>
                <tr>
                  <th data-field="fileName" data-sortable="true">文件/文件夹</th>
                  <th data-field="uploadTime" data-sortable="true">提交时间</th>
                  <th data-field="fileSize" data-sortable="true">文件大小</th>
                  <th data-field="download">操作</th>
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
    <link href="layui/css/layui.css" />
    <script src="layer/layer.js"></script>
    <script src="layui/layui.js"></script>
    <script>
    var path;
    var oldpath;
    var layerindex;
	$(document).ready(function(){
		$.get("initList",function(data,status){
			var JSONdata = JSON.parse(data);
			if(JSONdata["success"]) {
				for(var i in JSONdata["data"]){
					JSONdata["data"][i].download = "下载";
				}
				$('#table').bootstrapTable('load', JSONdata["data"]);
				path = JSONdata["path"];
				oldpath = JSONdata["path"];
			} else {
				layer.alert('请登录！', {
				    skin: 'layui-layer-lan'
				    ,closeBtn: 0
				    ,anim: 4 //动画类型
				  });
				window.location.replace("login.jsp");
			}
		});
		
		$('#table').on('click-cell.bs.table', function (event,field,value,row) {
			if(field == "fileName") {
				if(row.fileSize == "---") {
			    	path = path + "/" + value;
			    	postList();
			    } else {
			    	layer.alert('请选择文件夹', {
					    skin: 'layui-layer-lan'
					    ,closeBtn: 0
					    ,anim: 4 //动画类型
					  });
			    }
		    } else if(field == "download") {
		    	if(row.fileSize == "---") {
		    		var filename = row.fileName;
		    		var downloadPath = window.location.href;
		    		downloadPath = downloadPath.substr(0,downloadPath.lastIndexOf("/"));
		    		downloadPath += "/downloadDirectory?";
		    		downloadPath = downloadPath + "fileName=" + filename + "&filePath=" + path;
		    		//使用window.open会导致session丢失使得手机无法下载
		    		//window.open(downloadPath);
		    		window.location.href = downloadPath;
		    	} else {
		    		var filename = row.fileName;
		    		var downloadPath = window.location.href;
		    		downloadPath = downloadPath.substr(0,downloadPath.lastIndexOf("/"));
		    		downloadPath += "/downloadFile?";
		    		downloadPath = downloadPath + "fileName=" + filename + "&filePath=" + path;
		    		//使用window.open会导致session丢失使得手机无法下载
		    		//window.open(downloadPath);
		    		window.location.href = downloadPath;
		    	}
		    }
		});
		$('#retreat').click(function(){
			path = path.substr(0,path.lastIndexOf("/"));
			if(path.indexOf(oldpath)>=0) {
				postList();
			} else {
				path = oldpath;
				layer.alert('已到达根目录', {
				    skin: 'layui-layer-lan'
				    ,closeBtn: 0
				    ,anim: 4 //动画类型
				  });
			}
		});
		$('#upLoad').click(function() {
			var flag = false;
			var fileName = $('#filestream').get(0).files[0].name;
			$.post("getList",{path:path},function(data,status){
				var JSONdata = JSON.parse(data);
				for(var i in JSONdata["data"]){
					if(fileName == JSONdata["data"][i].fileName) {
						layui.use('layer', function(){
							var layer = layui.layer;
							layer.open({
								type:1,
								content:"同名文件已存在，是否覆盖？",
								btn: ['确定', '取消'],
				  				yes: function(index, layero){
				    				//按钮【按钮一】的回调
									layerindex = layer.msg('文件上传中', {
										  icon: 16
										  ,shade: 0.01
										  ,time: 0
										});
									submitFile(fileName);
									layer.close(index);
				  				},
								btn2: function(index, layero){
				    				//按钮【按钮二】的回调
									//removeMarker(marker);
				  				}
							})
							});
						flag = true;
						break;
					}
				}
				if(!flag) {
					layerindex = layer.msg('文件上传中', {
						  icon: 16
						  ,shade: 0.01
						  ,time: 0
						});
					submitFile(fileName);
				}
			});
		});
		$('#doFolder').click(function() {
			$('#currentpath').val(path);
			layui.use('layer', function(){
			var layer = layui.layer;
			layer.open({
				type:1,
				content:$("#folderManage"),
				btn: ['确定', '取消'],
  				yes: function(index, layero){
    				//按钮【按钮一】的回调
					layer.close(index);
					submit();
  				},
				btn2: function(index, layero){
    				//按钮【按钮二】的回调
					//removeMarker(marker);
  				}
			})
			}); 
		});
	});
	
	function postList() {
		$.post("getList",{path:path},function(data,status){
			var JSONdata = JSON.parse(data);
			if(JSONdata["success"]) {
				for(var i in JSONdata["data"]){
					JSONdata["data"][i].download = "下载";
				}
				$('#table').bootstrapTable('load', JSONdata["data"]);
				path = JSONdata["path"];
			}else {
				layer.alert('请登录！', {
				    skin: 'layui-layer-lan'
				    ,closeBtn: 0
				    ,anim: 4 //动画类型
				  });
				window.location.replace("login.jsp");
			}
		});
	}
	
	function submit(){
		  $.ajax({
			    url:"folderManager",
			    type:"POST",
			    data:$('#folderManage').serialize(),
			    success: function(e) {
			    	data=$.parseJSON(e);
					if(data.success){
						layui.use('layer', function(){
						  var layer = layui.layer;
						  layer.msg('提交成功！');
						});
						postList();
					}
					else{
						layui.use('layer', function(){
							var layer = layui.layer;
							layer.msg('提交失败！');
						});   
					}
			    },
			    complete: function(xhr, textStatus) {
			        if(xhr.status==400) {
			        	layui.use('layer', function(){
							var layer = layui.layer;
							layer.msg('提交失败！');
						});
			        }
			        $("#folderManage")[0].reset();
			    } 
			});
	  }
	
	function submitFile(fileName) {
		var upLoadFile = $('#filestream').get(0).files[0];
		var formData = new FormData();
		formData.append("filestream",upLoadFile);
		formData.append("path",path);
		formData.append("filename",fileName);
		$.ajax({
            type: "POST",
            url: "fileUpload",
            data: formData,
//            async: false,  
            cache: false,  
            contentType: false,  
            processData: false,
            success:function(data,status){
				var JSONdata = JSON.parse(data);
				layer.close(layerindex);
				if(JSONdata["success"]) {
					layui.use('layer', function(){
						  var layer = layui.layer;
						  layer.msg('上传成功！');
						});
					postList();
				} else {
					layui.use('layer', function(){
						  var layer = layui.layer;
						  layer.msg('上传失败，请联系网站管理员！',{time: 6000});
						});
				}
			}
        });
	}
	
  </script>
  </div>
</body>

</html>
