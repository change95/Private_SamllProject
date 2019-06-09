package dao;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public interface adminDao{
	/**
	 * 管理员登陆
	 * @param test
	 * @return
	 */
	public abstract boolean adminlogin(String adname, String adpass); 
	
}
