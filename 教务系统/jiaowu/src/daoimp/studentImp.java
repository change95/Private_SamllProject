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
import dao.studentDao;
import entity.student;

public class studentImp implements studentDao {
	private Connection con=null;
	private PreparedStatement psta=null;
	private ResultSet re=null;
	
	/**
	 * 添加学生    2 是存在   1 是成功   0  是失败
	 */
	@Override
	public int sturegist(student test) {
		System.out.println("注册时查询学号是否存在:"+test.getSno()+"--"+stuDection(test.getSno()));
		if(stuDection(test.getSno())) {
			System.out.println("检测学号存在!");
			return 2;
		}
		String sql = "INSERT INTO student VALUES (?,?,?,?,?,?)";
		try {
			con=JdbcUtil.getConnection();
			psta=con.prepareStatement(sql);
			psta.setString(1,test.getSno());
			psta.setString(2,test.getSpassword());
			psta.setString(3,test.getName());
			psta.setString(4,test.getSex());
			psta.setString(5,test.getBirth());
			psta.setString(6,test.getClassnum());

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
	 * 修改学生
	 */
	
	@Override
	public boolean stuModify(student test) {
		System.out.println("修改学号:"+test.getSno());
		
		String sql="UPDATE student SET  pasword=?,name=?,sex=?,birth=?,class=? WHERE sno = ?";
		
		try {
			con=JdbcUtil.getConnection();
			psta=con.prepareStatement(sql);
			psta.setString(1,test.getSpassword());
			psta.setString(2,test.getName());
			psta.setString(3,test.getSex());
			psta.setString(4,test.getBirth());
			psta.setString(5,test.getClassnum());
			psta.setString(6,test.getSno());
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
	* 删除学生
	* DELETE FROM 表名称 WHERE 列名称 = 值
	*/
	@Override
	public boolean stuDelete(String sno) {
		System.out.println("删除学号:"+sno);
		
		String sql="DELETE FROM student WHERE sno = ?";//设置sql语句
		try {
			con=JdbcUtil.getConnection();//获取数据库连接
			psta=con.prepareStatement(sql);
			psta.setString(1,sno);
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
	public boolean stuDection(String sno) {
		String sql = "SELECT COUNT(*) FROM student WHERE sno=?";
		 try {
			 con = JdbcUtil.getConnection();
			 psta = con.prepareStatement(sql);
			 psta.setString(1, sno);
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
		@Override
		public boolean login(String studentsno, String studentpasword) {
			String sql = "SELECT * FROM student  WHERE sno=? AND pasword =?";
			try {
				con=JdbcUtil.getConnection();
				psta=con.prepareStatement(sql);
				psta.setString(1, studentsno);
				psta.setString(2, studentpasword);
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

		
}
