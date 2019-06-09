package dao.imp;

import Util.JdbcUtil;
import dao.adminDao;
import java.sql.*;



public class adminDaoImp implements adminDao {
	private Connection con=null;
	private PreparedStatement psta=null;
	private ResultSet re=null;

	@Override
	public boolean adminlogin(String adusername, String adpass) {
		String sql = "SELECT * FROM admin WHERE adminname=? AND adminpassword =?";
		try {
			con=JdbcUtil.getConnection();//连接数据库
			psta=con.prepareStatement(sql);//执行sql语句
			psta.setString(1, adusername);
			psta.setString(2, adpass);
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


}
