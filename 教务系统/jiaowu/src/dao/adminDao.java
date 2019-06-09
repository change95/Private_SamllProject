package dao;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface adminDao {
	/**
	 * 管理登陆  
	 * @param username   用户名
	 * @param password   密码
	 * @return
	 */
	public abstract boolean login(String adminuser,String adminpass);
	/**
	 * 登出功能
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public abstract void loginOut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
	
			
}
