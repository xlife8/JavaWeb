package com.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.entity.Student;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class EmployeeDAO {
	
	private SessionFactory sessionFactory;
	
	public void saveStudents(Student stu) throws Exception {
		
		Session session = sessionFactory.openSession();
		Transaction tx = (Transaction) session.beginTransaction();
		try {
			session.save(stu);
			tx.commit();
		} catch(Exception ex) {
			throw ex;
		} finally {
			session.close();
		}
	}
	
	public List<Student> getStudents() {
		Session session = sessionFactory.openSession();
		List<Student> students = session.createQuery("from Student").list();
		session.flush();
		session.close();
		return students;
	}
	
	public void setStuAlter(Student stu) throws Exception{
		Session session = sessionFactory.openSession();
		Transaction tx = (Transaction) session.beginTransaction();
		try {
			List<Student> temp = session.createQuery("from Student where stuNum=:stunum")
					.setParameter("stunum", stu.getStuNum()).list();
			temp.get(0).setMail(stu.getMail());
			temp.get(0).setPwd(stu.getPwd());
			temp.get(0).setQQNum(stu.getQQNum());
			temp.get(0).setStuPhone(stu.getStuPhone());
			session.update(temp.get(0));
			tx.commit();
		} catch(Exception ex) {
			tx.rollback();
			throw ex;
		} finally {
			session.close();
		}
	}
	
	public JSONObject getStuInfo(String stuNum) {
		Session session = sessionFactory.openSession();
		List<Student> student = session.createQuery("from Student where stuNum=:stunum")
				.setParameter("stunum", stuNum).list();
		Student stu = student.get(0);
		session.flush();
		session.close();
		JSONObject retValue = new JSONObject();
		retValue.put("stuNum", stu.getStuNum());
		retValue.put("stuName", stu.getStuName());
		retValue.put("stuPhone", stu.getStuPhone());
		retValue.put("QQNum", stu.getQQNum());
		retValue.put("Mail", stu.getMail());
		retValue.put("pwd", stu.getPwd());
		retValue.put("success", true);
		return retValue;
	}
	
	public JSONArray getStuList() {
		Session session = sessionFactory.openSession();
		List<Student> students = session.createQuery("from Student").list();
		session.flush();
		session.close();
		JSONArray retValue = new JSONArray();
		for(Student stu:students) {
			JSONObject stuSec = new JSONObject();
			stuSec.put("stuNum", stu.getStuNum());
			stuSec.put("stuName", stu.getStuName());
			stuSec.put("stuPhone", stu.getStuPhone());
			stuSec.put("QQNum", stu.getQQNum());
			stuSec.put("Mail", stu.getMail());
			retValue.add(stuSec);
		}
		return retValue;
	}
	
	public List<Student> getStuXlsxList() {
		Session session = sessionFactory.openSession();
		List<Student> students = session.createQuery("from Student").list();
		session.flush();
		session.close();
		return students;
	}
	
	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
}
