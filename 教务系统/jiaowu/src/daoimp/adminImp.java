package daoimp;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.JdbcUtil;
import dao.adminDao;

public class adminImp implements adminDao {
	private Connection con=null;
	private PreparedStatement psta=null;
	private ResultSet re=null;

	/**
	 * 登陆功能实现
	 */
	@Override
	public boolean login(String adminuser, String adminpass) {
		String sql = "SELECT * FROM admin WHERE adminuser=? AND adminpw =?";
		try {
			con=JdbcUtil.getConnection();
			psta=con.prepareStatement(sql);
			psta.setString(1, adminuser);
			psta.setString(2, adminpass);
			re=psta.executeQuery();
			if(re.next()) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, psta, re);
		}
		return false;
	}

	@Override
	public void loginOut(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		//设置提示语句
		 //request.getSession().setAttribute("msg", "退出成功!即将跳转首页");
		 //跳转提示页面
		// request.getRequestDispatcher("/msg.jsp").forward(request, response);;
		 //销毁session对象
		 request.getSession().invalidate();
		 //重定向到首页
		 response.sendRedirect("main.jsp");
	}



}
