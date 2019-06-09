package entity;

public class teacher {
	private String tno;//教师号
	private String password;//密码
	private String name;//姓名
	private String sex; //性别
	private String education;//学历
	private String college;//所属学院
	
	

	
	public teacher(String tno, String password, String name, String sex, String education, String college) {
		super();
		this.tno = tno;
		this.password = password;
		this.name = name;
		this.sex = sex;
		this.education = education;
		this.college = college;
	}
	public String getTno() {
		return tno;
	}
	public void setTno(String tno) {
		this.tno = tno;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getEducation() {
		return education;
	}
	public void setEducation(String education) {
		this.education = education;
	}
	public String getCollege() {
		return college;
	}
	public void setCollege(String college) {
		this.college = college;
	}
	
	
	
	
}
