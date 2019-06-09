package entity;

public class admin {
	private String adminname;//管理员用户名
	private String adminpassword; //管理员用户名密码
	public admin(String adminname, String adminpassword) {
		super();
		this.adminname = adminname;
		this.adminpassword = adminpassword;
	}
	public String getAdminname() {
		return adminname;
	}
	public void setAdminname(String adminname) {
		this.adminname = adminname;
	}
	public String getAdminpassword() {
		return adminpassword;
	}
	public void setAdminpassword(String adminpassword) {
		this.adminpassword = adminpassword;
	}
	
}
