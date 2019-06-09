package daoimp;
	import java.sql.Connection;
	import java.sql.PreparedStatement;
	import java.sql.ResultSet;

	import util.JdbcUtil;
	import dao.messageDao;
	import entity.message;

public class messageImp implements messageDao {
		private Connection con=null;
		private PreparedStatement psta=null;
		private ResultSet re=null;
		
		/**
		 * 添加信息    2 是存在   1 是成功   0  是失败
		 */
		@Override
		public int mesregist(message test) {
			System.out.println("注册时查询信息id是否存在:"+test.getId()+"--"+mesDection(test.getId()));
			if(mesDection(test.getId())) {
				System.out.println("检测id存在!");
				return 2;
			}
			String sql = "INSERT INTO message VALUES (?,?,?,?)";
			try {
				con=JdbcUtil.getConnection();
				psta=con.prepareStatement(sql);
				psta.setString(1,test.getId());
				psta.setString(2,test.getInformObj());
				psta.setString(3,test.getContent());
				psta.setString(4,test.getTime());
				
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
		 * 修改信息
		 */
		
		@Override
		public boolean mesModify(message test) {
			System.out.println("修改信息:"+test.getId());
			
			String sql="UPDATE message SET  informObj=?,content=? WHERE id=?";
			
			try {
				con=JdbcUtil.getConnection();
				psta=con.prepareStatement(sql);
				psta.setString(1,test.getInformObj());
				psta.setString(2,test.getContent());
				psta.setString(3,test.getId());
				
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
		* 删除信息
		* DELETE FROM 表名称 WHERE 列名称 = 值
		*/
		@Override
		public boolean mesDelete(String id) {
			System.out.println("删除信息:"+id);
			
			String sql="DELETE FROM message WHERE ID = ?";//设置sql语句
			try {
				con=JdbcUtil.getConnection();//获取数据库连接
				psta=con.prepareStatement(sql);
				psta.setString(1,id);
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
			 * 检测id是否存在
			 */
		@Override
		public boolean mesDection(String id) {
			String sql = "SELECT COUNT(*) FROM message WHERE id=?";
			 try {
				 con = JdbcUtil.getConnection();
				 psta = con.prepareStatement(sql);
				 psta.setString(1, id);
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
