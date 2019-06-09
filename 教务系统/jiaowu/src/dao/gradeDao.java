package dao;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.grade;

public interface gradeDao {
	/**
	 * 这是成绩的添加功能
	 * @param test 成绩对象
	 * @return 1为添加成功 0为添加失败 
	 */
	public abstract int graregist(grade test);
	/**
	 * 这是课程号检测是否存在
	 * @param curriculum   课程号
	 * @return 返回true则存在
	 */
	public abstract boolean graDection(String sno,String curriculum);
	/**
	 * 这是成绩修改功能
	 * @param test   成绩对象
	 * @return 返回true则修改成功
	 */
	public abstract boolean graModify(grade test);
	/**
	 * 这是成绩删除功能
	 * @param 学号   课程号
	 * @return 返回true则删除成功
	 */
	public abstract boolean graDelete(String sno,String curriculum);
			
}
