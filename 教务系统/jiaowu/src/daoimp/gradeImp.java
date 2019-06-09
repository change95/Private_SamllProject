package daoimp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dao.gradeDao;
import entity.grade;
import util.JdbcUtil;

public class gradeImp implements gradeDao {
	private Connection con=null;
	private PreparedStatement psta=null;
	private ResultSet re=null;

	/***
	 * 成绩添加   2 是存在   1 是成功   0  是失败
	 */
	@Override
	public int graregist(grade test) {
		System.out.println("添加成绩时查询成绩是否存在:"+test.getCurriculum()+"--"+graDection(test.getSno(),test.getCurriculum()));
		if(graDection(test.getSno(),test.getCurriculum())) {
			System.out.println("检测成绩存在!");
			return 2;
		}
		String sql = "INSERT INTO grade VALUES (?,?,?,?)";
		try {
			con=JdbcUtil.getConnection();
			psta=con.prepareStatement(sql);
			psta.setString(1,test.getSno());
			psta.setString(2,test.getCurriculum());
			psta.setString(3,test.getGrade());
			psta.setString(4,test.getStatus());
			
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
	 * 修改成绩
	 */
	@Override
	public boolean graModify(grade test) {
		System.out.println("修改成绩");
		
		String sql="UPDATE grade SET  grade=?,status=? WHERE sno=? and curriculum=?";
		
		try {
			con=JdbcUtil.getConnection();
			psta=con.prepareStatement(sql);
			
			psta.setString(1,test.getGrade());
			psta.setString(2,test.getStatus());
			psta.setString(3,test.getSno());
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
	 * 删除成绩
	 */
	@Override
	public boolean graDelete(String sno, String curriculum) {
		System.out.println("删除成绩");
		
		String sql="DELETE FROM grade WHERE sno = ? and curriculum = ?";//设置sql语句
		try {
			con=JdbcUtil.getConnection();//获取数据库连接
			psta=con.prepareStatement(sql);
			psta.setString(1,sno);
			psta.setString(2,curriculum);
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
	 * 检测成绩是否存在
	 */
	@Override
	public boolean graDection(String sno, String curriculum) {
		String sql = "SELECT COUNT(*) FROM grade WHERE sno=? and curriculum=?";
		 try {
			 con = JdbcUtil.getConnection();
			 psta = con.prepareStatement(sql);
			 psta.setString(1,sno);
			 psta.setString(2,curriculum);
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
