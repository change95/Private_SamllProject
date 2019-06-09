package daoimp;
	import java.sql.Connection;
	import java.sql.PreparedStatement;
	import java.sql.ResultSet;

	import util.JdbcUtil;
	import dao.curriculumDao;
	import entity.curriculum;

public class curriculumImp implements curriculumDao {
		private Connection con=null;
		private PreparedStatement psta=null;
		private ResultSet re=null;
		
		/**
		 * 添加课程    2 是存在   1 是成功   0  是失败
		 */
		@Override
		public int curregist(curriculum test) {
			System.out.println("注册时查询课程号是否存在:"+test.getCurriculum()+"--"+curDection(test.getCurriculum()));
			if(curDection(test.getCurriculum())) {
				System.out.println("检测课程号存在!");
				return 2;
			}
			String sql = "INSERT INTO curriculum VALUES (?,?,?,?)";
			try {
				con=JdbcUtil.getConnection();
				psta=con.prepareStatement(sql);
				psta.setString(1,test.getCurriculum());
				psta.setString(2,test.getCurriculumname());
				psta.setString(3,test.getTno());
				psta.setString(4,test.getClassnum());
				
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
		 * 修改课程
		 */
		
		@Override
		public boolean curModify(curriculum test) {
			System.out.println("修改课程号:"+test.getCurriculum());
			String sql="UPDATE curriculum SET  curriculumname=?,tno=?,classnum=? WHERE curriculum=?";
			
			try {
				con=JdbcUtil.getConnection();
				psta=con.prepareStatement(sql);
				
				psta.setString(1,test.getCurriculumname());
				psta.setString(2,test.getTno());
				psta.setString(3,test.getClassnum());
				psta.setString(4,test.getCurriculum());
				
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
		* 删除课程
		* DELETE FROM 表名称 WHERE 列名称 = 值
		*/
		@Override
		public boolean curDelete(String curriculum) {
			System.out.println("删除课程号:"+curriculum);
			
			String sql="DELETE FROM curriculum WHERE curriculum = ?";//设置sql语句
			try {
				con=JdbcUtil.getConnection();//获取数据库连接
				psta=con.prepareStatement(sql);
				psta.setString(1,curriculum);
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
			 * 检测课程号是否存在
			 */
		@Override
		public boolean curDection(String curriculum) {
			String sql = "SELECT COUNT(*) FROM curriculum WHERE curriculum=?";
			 try {
				 con = JdbcUtil.getConnection();
				 psta = con.prepareStatement(sql);
				 psta.setString(1, curriculum);
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
