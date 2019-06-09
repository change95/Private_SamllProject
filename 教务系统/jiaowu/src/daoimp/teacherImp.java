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
import dao.teacherDao;
import entity.teacher;;

public class teacherImp implements teacherDao {
	/**
	 * 登陆功能
	 */
	@Override
	public boolean login(String teachertno, String teacherpass) {
		String sql = "SELECT * FROM teacher WHERE tno=? AND password =?";
		try {
			con=JdbcUtil.getConnection();
			psta=con.prepareStatement(sql);
			psta.setString(1, teachertno);
			psta.setString(2, teacherpass);
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
	/**
	 * 登出功能
	 */
	@Override
	public void loginOut(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//设置提示语句
		 //request.getSession().setAttribute("msg", "退出成功!即将跳转首页");
		 //跳转提示页面
		// request.getRequestDispatcher("/msg.jsp").forward(request, response);;
		 //销毁session对象
		 request.getSession().invalidate();
		 //重定向到首页
		 response.sendRedirect("main.jsp");
		
	}
	
	
	
	
	private Connection con=null;
	private PreparedStatement psta=null;
	private ResultSet re=null;
	
	/**
	 * 添加教师    2 是存在   1 是成功   0  是失败
	 */
	@Override
	public int tearegist(teacher test) {
		System.out.println("注册时查询教师号是否存在:"+test.getTno()+"--"+teaDection(test.getTno()));
		if(teaDection(test.getTno())) {
			System.out.println("检测教师号存在!");
			return 2;
		}
		String sql = "INSERT INTO teacher VALUES (?,?,?,?,?,?)";
		try {
			con=JdbcUtil.getConnection();
			psta=con.prepareStatement(sql);
			psta.setString(1,test.getTno());
			psta.setString(2,test.getPassword());
			psta.setString(3,test.getName());
			psta.setString(4,test.getSex());
			psta.setString(5,test.getEducation());
			psta.setString(6,test.getCollege());

			psta.executeUpdate();
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(con, psta, re);
		}
		return 0;
	}
	/**
	 * 修改教师
	 */
	
	@Override
	public boolean teaModify(teacher test) {
		System.out.println("修改教师号:"+test.getTno());
		
		String sql="UPDATE teacher SET  password=?,name=?,sex=?,education=?,college=? WHERE tno = ?";
		
		try {
			con=JdbcUtil.getConnection();
			psta=con.prepareStatement(sql);
			psta.setString(1,test.getPassword());
			psta.setString(2,test.getName());
			psta.setString(3,test.getSex());
			psta.setString(4,test.getEducation());
			psta.setString(5,test.getCollege());
			psta.setString(6,test.getTno());
			psta.executeUpdate();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(con, psta, re);
		}
		return false;
	}
	/**
	* 删除教师
	* DELETE FROM 表名称 WHERE 列名称 = 值
	*/
	@Override
	public boolean teaDelete(String tno) {
		System.out.println("删除学号:"+tno);
		
		String sql="DELETE teacher,curriculum FROM teacher,curriculum WHERE teacher.tno=curriculum.tno AND teacher.tno = ?";//设置sql语句
		try {
			con=JdbcUtil.getConnection();//获取数据库连接
			psta=con.prepareStatement(sql);
			psta.setString(1,tno);
			psta.executeUpdate();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(con, psta, re);
		}
		return false;
	}
		/**
		 * 检测学号是否存在
		 */
	@Override
	public boolean teaDection(String tno) {
		String sql = "SELECT COUNT(*) FROM teacher WHERE tno=?";
		 try {
			 con = JdbcUtil.getConnection();
			 psta = con.prepareStatement(sql);
			 psta.setString(1, tno);
		     re = psta.executeQuery();
			 if(re.next()) {
				 System.out.println("count(*):"+re.getInt("COUNT(*)"));
				 if(re.getInt("COUNT(*)")!=0)
					 return true; 
			}
			return false;
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}finally {
			JdbcUtil.close(con, psta, re);
		}
	}


		
}
