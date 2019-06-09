package Util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;



/**
 * jdbc连接数据库工具类
 * @author czh
 *
 */

public class  JdbcUtil {
	private static String url="jdbc:mysql://localhost:3306/shiwu";//数据库地址
	private static String user="root";//数据库用户名
	private static String password="123456";//数据库密码
	static{
		//注册驱动程序
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("驱动程序注册出错");
		}
		
	}
	/**
	 * 获取连接
	 * @return
	 */
	public static Connection getConnection() {
		try {
			Connection con = DriverManager.getConnection(url, user, password);//连接数据库
			return con;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new RuntimeException(e);
		}

	}
	/**
	 * 释放资源（(connection，statement,connection)）
	 */
	public static void close(Connection con, PreparedStatement stmt, ResultSet re) {
		try {
			if(re!=null) re.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new RuntimeException(e);
		}
				
		try {
			if(stmt!=null)stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new RuntimeException(e);
		}
		try {
			if(con!=null)con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new RuntimeException(e);
		}
		
	}
			
	
}
