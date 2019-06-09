package dao;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.message;

public interface messageDao {
	/**
	 * 这是信息的添加功能
	 * @param test 信息对象
	 * @return 1为添加成功 0为添加失败 2为课程号已存在 
	 */
	public abstract int mesregist(message test);
	/**
	 * 这是信息检测是否存在
	 * @param message   课程
	 * @return 返回true则存在
	 */
	public abstract boolean mesDection(String message);
	/**
	 * 这是信息修改功能
	 * @param test   课程对象
	 * @return 返回true则修改成功
	 */
	public abstract boolean mesModify(message test);
	/**
	 * 这是信息删除功能
	 * @param test   信息
	 * @return 返回true则删除成功
	 */
	public abstract boolean mesDelete(String message);
			
}
