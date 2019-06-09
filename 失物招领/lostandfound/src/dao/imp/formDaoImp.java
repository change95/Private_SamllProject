package dao.imp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.websocket.Session;

import dao.formDao;
import entity.form;
import Util.JdbcUtil;

public class formDaoImp implements formDao {
	private Connection con=null;
	private PreparedStatement psta=null;
	private ResultSet re=null;
	
	
	//DELETE FROM 表名称 WHERE 列名称 = 值
	public boolean deleteform(String id) {
		String sql="DELETE form,pic FROM form,pic  WHERE form.id = pic.ID AND form.id=?";
		try {
			con=JdbcUtil.getConnection();
			psta=con.prepareStatement(sql);
			psta.setString(1, id);
			psta.executeUpdate();
			return true;
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, psta, re);
		}
		   return false;
	}

	@Override
	/**
	 * 添加表实现
	 */
	public boolean addform(form f) {
		
		String sql = "INSERT INTO form VALUES (?,?,?,?,?,?,?,?,?,?)";
		/*
		 * id (20)随机id
			title (20)标题
			username (10)用户名
			kind (20)种类
			time (20)时间
			phone (15)电话
			name (15)姓名
			content (50)内容
			place (20)地点
		 */
		try {
			con=JdbcUtil.getConnection();
			psta=con.prepareStatement(sql);
			psta.setString(1, f.getId());
			psta.setString(2,f.getTitle());
			psta.setString(3,f.getUsername());
			psta.setString(4,f.getKind());
			psta.setString(5,f.getTime());
			psta.setString(6,f.getPhone());
			psta.setString(7,f.getName());
			psta.setString(8,f.getContent());
			psta.setString(9,f.getPlace());
			psta.setString(10,f.getType());
			psta.executeUpdate();
			return true;
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, psta, re);
		}
		   return false;
	}

	@Override
	/**
	 * 查询表根据id
	 */
	public form lookform(String id) {
		String sql="SELECT * FROM form WHERE id=?";
		form f = new form();
		 try {
			 con = JdbcUtil.getConnection();
			 psta = con.prepareStatement(sql);
			 psta.setString(1, id);
		     re = psta.executeQuery();
			 if(re.next()) {
				 f.setTitle(re.getString("title"));
				 f.setUsername(re.getString("username"));
				 f.setKind(re.getString("kind"));
				 f.setTime(re.getString("time"));
				 f.setPhone(re.getString("phone"));
				 f.setName(re.getString("name"));
				 f.setContent(re.getString("content"));
				 f.setPlace(re.getString("place"));
			}
			 return f;
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}finally {
			JdbcUtil.close(con, psta, re);
		}
		 
	}

	@Override
	/**
	 * 根据id查图片
	 */
	public String[] lookpic(String id) {
		String tt="";
		String[] sz= {"-1","-1"};
		String sql="SELECT path FROM pic WHERE id=?";
		 try {
			 con = JdbcUtil.getConnection();
			 psta = con.prepareStatement(sql);
			 psta.setString(1, id);
		     re = psta.executeQuery();
			 if(re.next()) {
				tt=re.getString("path");
				System.out.println("tt:"+tt);
				int sta=tt.lastIndexOf("\\pic")+5;
				System.out.println("tt.lastIndexOf:"+tt.lastIndexOf("\\pic"));
				System.out.println(sta);
				String temp=tt.substring(sta);
				System.out.println(temp);
				sz=temp.split("\\\\");
				System.out.println(sz[0]);
				System.out.println(sz[1]);
				
			}
			 return sz;
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}finally {
			JdbcUtil.close(con, psta, re);
		}
		
	}

	@Override
	public boolean amendform(form f) {
		//更新语句
		String sql = "UPDATE form SET title=?,username=?,kind=?,time=?,phone=?,name=?,content=?,place=?,type=? WHERE id=?";
		try {
			con=JdbcUtil.getConnection();
			psta=con.prepareStatement(sql);	
			psta.setString(1,f.getTitle());
			psta.setString(2,f.getUsername());
			psta.setString(3,f.getKind());
			psta.setString(4,f.getTime());
			psta.setString(5,f.getPhone());
			psta.setString(6,f.getName());
			psta.setString(7,f.getContent());
			psta.setString(8,f.getPlace());
			psta.setString(9,f.getType());
			psta.setString(10, f.getId());
			psta.executeUpdate();
			return true;
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, psta, re);
		}
		   return false;
	}
		
}
