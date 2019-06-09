package dao;


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.student;

public interface studentDao {
	/**
	 * 学生登陆  
	 * @param username   用户名
	 * @param password   密码
	 * @return
	 */
	public abstract boolean login(String teachertno,String teacherpass);
	/**
	 * 登出功能
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public abstract void loginOut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
	/**
	 * 这是学生的注册功能
	 * @param test 用户对象
	 * @return 1为注册成功 0为注册失败 2为用户名已存在 
	 */
	public abstract int sturegist(student test);
	/**
	 * 这是学号检测是否存在
	 * @param sno   学号
	 * @return 返回true则存在
	 */
	public abstract boolean stuDection(String sno);
	/**
	 * 这是学生修改功能
	 * @param test   学生对象
	 * @return 返回true则修改成功
	 */
	public abstract boolean stuModify(student test);
	/**
	 * 这是学生删除功能
	 * @param sno   学号
	 * @return 返回true则删除成功
	 */
	public abstract boolean stuDelete(String sno);

}
