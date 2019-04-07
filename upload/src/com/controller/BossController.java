package com.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.tools.FilePropertiesManager;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class BossController {
	
	@RequestMapping("/initList")
	public void initList(HttpServletResponse response) {
		JSONObject retValue = new JSONObject();
		JSONArray dataArr = new JSONArray();
		String path = "/home/mrxie/stuIDs";
		File file = new File(path);
		File[] files = file.listFiles();
		for(File fileSec:files) {
			JSONObject listSec = new JSONObject();
			listSec.put("fileName", fileSec.getName());
			if(fileSec.isDirectory()) {
				listSec.put("uploadTime", "---");
				listSec.put("fileSize", "---");
			} else {
				listSec.put("uploadTime", FilePropertiesManager.timeFormat(fileSec.lastModified()));
				listSec.put("fileSize", FilePropertiesManager.byteToKMG(fileSec.length()));
			}
			dataArr.add(listSec);
		}
		response.setCharacterEncoding("utf-8");
		retValue.put("success", true);
		retValue.put("path", path);
		retValue.put("data", dataArr);
		try {
			response.getWriter().print(retValue);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/getList")
	public void getList(String path,HttpServletResponse response) {
		JSONObject retValue = new JSONObject();
		JSONArray dataArr = new JSONArray();
		File file = new File(path);
		File[] files = file.listFiles();
		for(File fileSec:files) {
			JSONObject listSec = new JSONObject();
			listSec.put("fileName", fileSec.getName());
			if(fileSec.isDirectory()) {
				listSec.put("uploadTime", "---");
				listSec.put("fileSize", "---");
			} else {
				listSec.put("uploadTime", FilePropertiesManager.timeFormat(fileSec.lastModified()));
				listSec.put("fileSize", FilePropertiesManager.byteToKMG(fileSec.length()));
			}
			dataArr.add(listSec);
		}
		response.setCharacterEncoding("utf-8");
		retValue.put("success", true);
		retValue.put("path", path);
		retValue.put("data", dataArr);
		try {
			response.getWriter().print(retValue);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/fileUpload")
	public void fileUpload(HttpServletRequest request,HttpServletResponse response) {
		String savePath = null,fileName = null;
		JSONObject retValue = new JSONObject();
		response.setCharacterEncoding("utf-8");
		retValue.put("success", true);
		//直接new一个CommonsMultipartResolver
        CommonsMultipartResolver cmr = new CommonsMultipartResolver(request.getSession().getServletContext());
        if (cmr.isMultipart(request)) {
            MultipartHttpServletRequest multipartRequest = cmr.resolveMultipart(request);
            savePath = multipartRequest.getParameter("path") + File.separator; //除文件外其它参数需要这样获取
            fileName = multipartRequest.getParameter("filename");
            MultipartFile file = multipartRequest.getFile("filestream");
            File saveFile = new File(savePath+fileName);// 上传后的文件保存目录及名字
            if(saveFile.exists()) {
            	saveFile.delete();
            	saveFile = null;
            	saveFile = new File(savePath+fileName);
            }
            try {
				file.transferTo(saveFile); //将上传文件保存到相应位置
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				retValue.put("success", false);
				e.printStackTrace();
			}
        }
		try {
			response.getWriter().print(retValue);
		} catch (IOException e) {
			e.printStackTrace();
		}		
	}
}
