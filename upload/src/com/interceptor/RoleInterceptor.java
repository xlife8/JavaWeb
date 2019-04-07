package com.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class RoleInterceptor implements HandlerInterceptor{
	
	private List<String> notAllowPass;

	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler) throws Exception {
		String url = request.getRequestURL().toString();
		for(String temp:notAllowPass) {
			if(url.endsWith(temp)) {
				int etype = (int)request.getSession().getAttribute("etype");
				if(etype == 0)
					return false;
				else
					return true;
			}
		}
		return true;
	}
	
	public List<String> getNotAllowPass() {
		return notAllowPass;
	}

	public void setNotAllowPass(List<String> notAllowPass) {
		this.notAllowPass = notAllowPass;
	}

	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

}
