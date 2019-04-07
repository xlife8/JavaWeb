package com.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tools.CompressTool;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class EmployeeController {

	@RequestMapping("/downloadFile")
	public String downloadFile( String fileName ,String filePath, HttpServletRequest request, HttpServletResponse response){
		 
//		response.setContentType("text/html;charset=utf-8");
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
				
		java.io.BufferedInputStream bis = null;
		java.io.BufferedOutputStream bos = null;
	
		String downLoadPath = filePath + File.separator + fileName;
		
		try {
			long fileLength = new File(downLoadPath).length();
			response.setContentType("application/x-msdownload;");
			response.setHeader("Content-disposition", "attachment; filename=" + new String(fileName.getBytes("utf-8"), "ISO8859-1"));
			response.setHeader("Content-Length", String.valueOf(fileLength));
			bis = new BufferedInputStream(new FileInputStream(downLoadPath));
			bos = new BufferedOutputStream(response.getOutputStream());
			byte[] buff = new byte[2048];
			int bytesRead;
			while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
				bos.write(buff, 0, bytesRead);
			}
			bos.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (bis != null)
				try {
					bis.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			if (bos != null)
				try {
					bos.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}
		return null;	
	}
	
	@RequestMapping("/downloadDirectory")
	public String downloadDirectory( String fileName ,String filePath, HttpServletRequest request, HttpServletResponse response){
		 
//		response.setContentType("text/html;charset=utf-8");
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
				
		java.io.BufferedInputStream bis = null;
		java.io.BufferedOutputStream bos = null;
	
		String downLoadPath = filePath + File.separator + fileName;
		String downLoadPathZip = downLoadPath + ".zip";
		if(!CompressTool.compress(downLoadPath, downLoadPathZip)) {
			return "error";
		}
		File tempFile = new File(downLoadPathZip);
		try {
			long fileLength = tempFile.length();
			response.setContentType("application/x-msdownload;");
			fileName += ".zip";
			response.setHeader("Content-disposition", "attachment; filename=" + new String(fileName.getBytes("utf-8"), "ISO8859-1"));
			response.setHeader("Content-Length", String.valueOf(fileLength));
			bis = new BufferedInputStream(new FileInputStream(downLoadPathZip));
			bos = new BufferedOutputStream(response.getOutputStream());
			byte[] buff = new byte[2048];
			int bytesRead;
			while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
				bos.write(buff, 0, bytesRead);
			}
			bos.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (bis != null)
				try {
					bis.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			if (bos != null)
				try {
					bos.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			tempFile.delete();
		}
		return null;
	}
	
	@RequestMapping("/folderManager")
	public void partListBoss(String currentPath,String oldFolder,String newFolder,HttpServletResponse response) {
		JSONObject retValue = new JSONObject();
		response.setCharacterEncoding("utf-8");
		if(oldFolder.equals("") && newFolder.equals("")) {
			retValue.put("success", false);
		} else if(oldFolder.equals("")) {
			String path = currentPath + File.separator + newFolder;
			File newDirectory = new File(path);
			if(newDirectory.exists()) {
				retValue.put("success", false);
			} else {
				if(newDirectory.mkdir()) {
					retValue.put("success", true);
				} else {
					retValue.put("success", false);
				}
			}
		} else if(newFolder.equals("")) {
			String path = currentPath + File.separator + oldFolder;
			File oldDirectory = new File(path);
			if(oldDirectory.exists()) {
				File[] files = oldDirectory.listFiles();
				if(files.length==0 && oldDirectory.delete()) {
					retValue.put("success", true);
				} else {
					retValue.put("success", false);
				}
			} else {
				retValue.put("success", false);
			}
		} else {
			String path = currentPath + File.separator + oldFolder;
			File oldDirectory = new File(path);
			if(oldDirectory.exists()) {
				path = currentPath + File.separator + newFolder;
				oldDirectory.renameTo(new File(path));
				retValue.put("success", true);
			} else {
				retValue.put("success", false);
			}
		}
		
		try {
			response.getWriter().print(retValue);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
