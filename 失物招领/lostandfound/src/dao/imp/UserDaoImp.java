package dao.imp;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import dao.UserDao;
import entity.User;
import Util.JdbcUtil;

public class UserDaoImp implements UserDao {
	private Connection con=null;
	private PreparedStatement psta=null;
	private ResultSet re=null;
	
	/**
	 * 登陆实现
	 */
	@Override
	public boolean login(String username, String password) {
		String sql = "SELECT * FROM user WHERE username=? AND password =?";
		try {
			con=JdbcUtil.getConnection();
			psta=con.prepareStatement(sql);
			psta.setString(1, username);
			psta.setString(2, password);
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
	 * 用户名注册功能实现
	 */
	@Override
	public int regist(User test) {
		System.out.println("注册时查询用户名是否存在:"+test.getUsername()+"--"+UserDection(test.getUsername()));
		if(UserDection(test.getUsername())) {
			System.out.println("检测用户名存在!");
			return 2;
		}
		String sql = "INSERT INTO user VALUES (?,?)";
		try {
			con=JdbcUtil.getConnection();
			psta=con.prepareStatement(sql);
			psta.setString(1,test.getUsername());
			psta.setString(2,test.getPassword());
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
	 * 用户名注册检测是否存在功能实现
	 * 返回true 则存在
	 */
	@Override
	public boolean UserDection(String username) {
		String sql = "SELECT COUNT(*) FROM user WHERE username=?";
		 try {
			 con = JdbcUtil.getConnection();
			 psta = con.prepareStatement(sql);
			 psta.setString(1, username);
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
	/*
	 * 删除用户
	 * @see dao.UserDao#deleuser(java.lang.String)
	 */
	@Override
	public boolean deleuser(String username) {
		String sql = "DELETE FROM user WHERE username=?";
		try {
			con=JdbcUtil.getConnection();
			psta=con.prepareStatement(sql);
			psta.setString(1, username);
			psta.executeUpdate();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, psta, re);
		}
		return false;
	}
	
	/**
	 * UPDATE 表名称 SET 列名称 = 新值 WHERE 列名称 = 某值
	 */
	@Override
	public boolean amenduser(String username, String password) {
		String sql = "UPDATE user SET password=?  WHERE username=?";
		try {
			con=JdbcUtil.getConnection();
			psta=con.prepareStatement(sql);
			psta.setString(1, password);
			psta.setString(2, username);
			psta.executeUpdate();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, psta, re);
		}
		return false;
	}
		
}
