package dao;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.curriculum;

public interface curriculumDao {
	/**
	 * 这是课程的添加功能
	 * @param test 用户对象
	 * @return 1为添加成功 0为添加失败 2为课程号已存在 
	 */
	public abstract int curregist(curriculum test);
	/**
	 * 这是课程号检测是否存在
	 * @param curriculum   课程号
	 * @return 返回true则存在
	 */
	public abstract boolean curDection(String curriculum);
	/**
	 * 这是课程修改功能
	 * @param test   课程对象
	 * @return 返回true则修改成功
	 */
	public abstract boolean curModify(curriculum test);
	/**
	 * 这是课程删除功能
	 * @param curriculum   课程号
	 * @return 返回true则删除成功
	 */
	public abstract boolean curDelete(String curriculum);
			
}
