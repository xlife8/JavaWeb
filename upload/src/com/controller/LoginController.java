package com.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dao.EmployeeDAO;
import com.entity.Student;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class LoginController {
	
	@Autowired
	private EmployeeDAO employeeDAO;
	/*
	@RequestMapping("/saveStudents")
	public void saveStudents(HttpServletResponse response) {
		String[] stuNums = {
				"222015327012116"
				,"222015327012027"
				,"222016321072001"
				,"222015319210100"
				,"222015325052005"
				,"222016321072002"
				,"222016321072004"
				,"222016321072006"
				,"222016321072013"
				,"222015325012065"
				,"222016321072014"
				,"222016321072008"
				,"222016321072012"
				,"222016321072021"
				,"222016321072005"
				,"222015324012058"
				,"222016321072007"
				,"222016321072016"
				,"222015321210015"
				,"222016321072022"
				,"222016321072030"
				,"222016321072020"
				,"222016321072003"
				,"222016321072027"
				,"222016321072019"
				,"222016321072025"
				,"222016321072009"
				,"222016321072010"
				,"222016321072023"
				,"222016321072015"
				,"222016321072011"
				,"222016321072026"
				,"222015321210087"
				,"222016321072024"
				,"222015321210090"
				,"222016321072028"
				,"222016321072018"
				,"222016321072029"
				,"222014321062111"
		};
		String[] stuNames = {
				"刘牧潼"
				,"王孟珂"
				,"葛亚玲"
				,"谢桂起"
				,"吴明"
				,"付思雨"
				,"王美琳"
				,"雷常青"
				,"许浩"
				,"王睿敏"
				,"蔡天扬"
				,"朱兆雪"
				,"鄢翔"
				,"邢峻乾"
				,"丘磐"
				,"孙明轩"
				,"王雪滢"
				,"李敏"
				,"戴文贵"
				,"程飞天"
				,"陈阳"
				,"范耀阳"
				,"李岚"
				,"张胜林"
				,"陈明元"
				,"夏宇琦"
				,"秦志斌"
				,"杜芝豪"
				,"秦杰"
				,"吴国玺"
				,"朱硕鹏"
				,"赵流洋"
				,"胡晖"
				,"谢金能"
				,"李勇"
				,"向超"
				,"屈祯昊"
				,"姚聪"
				,"华科钦"
		};
		JSONObject retValue = new JSONObject();
			try {
				for(int i=0;i<stuNums.length;i++) {
					Student stu = new Student();
					stu.setStuNum(stuNums[i]);
					stu.setStuName(stuNames[i]);
					stu.setEtype(0);
					stu.setPwd(stuNums[i]);
					employeeDAO.saveStudents(stu);
				}
				retValue.put("success", true);
			} catch (Exception e) {
				retValue.put("success", false);
				e.printStackTrace();
			}
			finally {
				try {
					response.getWriter().print(retValue);
				} catch (IOException e) {
					e.printStackTrace();
				}
		}
	}
	*/
	@RequestMapping("/stuAlter")
	public void partAlter(Student stu,HttpServletResponse response) {
		JSONObject retValue = new JSONObject();
		try {
			employeeDAO.setStuAlter(stu);
			retValue.put("success", true);
		} catch (Exception e) {
			retValue.put("success", false);
			e.printStackTrace();
		}
		finally {
			try {
				response.getWriter().print(retValue);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}		
	}
	
	@RequestMapping("/stuInfo")
	public void stuInfo(HttpServletRequest request,HttpServletResponse response) {
		String stuNum = (String)request.getSession().getAttribute("stuNum");
		JSONObject retValue = employeeDAO.getStuInfo(stuNum);
		response.setCharacterEncoding("utf-8");
		try {
			response.getWriter().print(retValue);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/studentList")
	public void studentList(HttpServletResponse response) {
		JSONArray dataArr = null;
		dataArr = employeeDAO.getStuList();
		JSONObject retValue = new JSONObject();
		retValue.put("success", true);
		retValue.put("data", dataArr);
		response.setCharacterEncoding("utf-8");
		try {
			response.getWriter().print(retValue);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/downLoadXlsx")
	public void downLoadXlsx(String fileName,HttpServletRequest request,HttpServletResponse response) {
		// 第一步，创建一个webbook，对应一个Excel文件  
        HSSFWorkbook wb = new HSSFWorkbook();
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet  
        HSSFSheet sheet = wb.createSheet("学生信息");  
        // 第三步，在sheet中添加表头第0行
        HSSFRow row = sheet.createRow(0); 
        // 第四步，创建单元格，并设置值
        HSSFCell cell = row.createCell(0);  
        cell.setCellValue("学号");  
        cell = row.createCell(1);  
        cell.setCellValue("姓名");   
        cell = row.createCell(2);  
        cell.setCellValue("电话");  
        cell = row.createCell(3);  
        cell.setCellValue("QQ"); 
        cell = row.createCell(4);  
        cell.setCellValue("邮箱"); 
        List<Student> students = employeeDAO.getStuXlsxList();
        for(int i=0;i<students.size();i++) {
        	row = sheet.createRow(i+1);
        	row.createCell(0).setCellValue(students.get(i).getStuNum());  
            row.createCell(1).setCellValue(students.get(i).getStuName());  
            row.createCell(2).setCellValue(students.get(i).getStuPhone());  
            row.createCell(3).setCellValue(students.get(i).getQQNum());  
            row.createCell(4).setCellValue(students.get(i).getMail());  
        }
        
     // 第六步，将文件存到指定位置 
        String filePath = "/home/mrxie/stuIDs";
        File xlsxFile = new File(filePath + File.separator + fileName);       
        try{
        	FileOutputStream outStream = new FileOutputStream(xlsxFile);
            wb.write(outStream);  
            outStream.flush();
            outStream.close();
        }  
        catch (Exception e){  
            e.printStackTrace();  
        }
        new EmployeeController().downloadFile(fileName, filePath, request, response);
        xlsxFile.delete();
	}
	
	@RequestMapping("/login")
	public void login(Student user,HttpSession session,
			HttpServletResponse response) {
		List<Student> students = employeeDAO.getStudents();
		response.setCharacterEncoding("utf-8");
		JSONObject reValue = new JSONObject();
		for(Student e:students) {
			if(e.getStuNum().equals(user.getStuNum())) {
				if(e.getPwd().equals(user.getPwd())) {
					session.setAttribute("stuNum", e.getStuNum());
					session.setAttribute("etype", e.getEtype());
					reValue.put(e.getEtype(), "登录成功！");
				} else {
					reValue.put(2, "密码错误！");
				}
				try {
					response.getWriter().print(reValue);
				} catch (IOException e1) {
					e1.printStackTrace();
				}
				return;
			}
		}
		reValue.put(3, "学号有误！");
		try {
			response.getWriter().print(reValue);
		} catch (IOException e1) {
			e1.printStackTrace();
		}
	}
	
	@RequestMapping("/error")
	public void error(HttpServletResponse response) {
		response.setCharacterEncoding("utf-8");
		JSONObject reValue = new JSONObject();
		reValue.put("success", false);
		try {
			response.getWriter().print(reValue);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/logout")
	public void logout(HttpServletRequest request,HttpServletResponse response) {
		request.getSession().invalidate();
		response.setCharacterEncoding("utf-8");
		JSONObject reValue = new JSONObject();
		reValue.put("success", true);
		try {
			response.getWriter().print(reValue);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public EmployeeDAO getEmployeeDAO() {
		return employeeDAO;
	}

	public void setEmployeeDAO(EmployeeDAO employeeDAO) {
		this.employeeDAO = employeeDAO;
	}

}
