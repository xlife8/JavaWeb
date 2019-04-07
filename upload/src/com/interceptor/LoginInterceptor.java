package com.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginInterceptor implements HandlerInterceptor{
	
	private List<String> allowPass;

	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler) throws Exception {
		Object number = request.getSession().getAttribute("stuNum");
		if(number!=null)
			return true;
		String url = request.getRequestURL().toString();
		for(String temp:allowPass) {
			if(url.endsWith(temp))
				return true;
		}
		request.getRequestDispatcher("/error").forward(request, response);
		return false;
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

	public List<String> getAllowPass() {
		return allowPass;
	}

	public void setAllowPass(List<String> allowPass) {
		this.allowPass = allowPass;
	}

}
