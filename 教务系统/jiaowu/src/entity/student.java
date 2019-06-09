package entity;

public class student {
	private String sno;//学号
	private String spassword;//密码
	private String name;//姓名
	private String sex; //性别
	private String birth;//出生年月
	private String classnum;//班级号
	
	public student(String sno, String spassword, String name, String sex, String birth, String classnum) {
		super();
		this.sno = sno;
		this.spassword = spassword;
		this.name = name;
		this.sex = sex;
		this.birth = birth;
		this.classnum = classnum;
	}
	public student() {}
	public String getSno() {
		return sno;
	}
	public void setSno(String sno) {
		this.sno = sno;
	}
	public String getSpassword() {
		return spassword;
	}
	public void setSpassword(String spassword) {
		this.spassword = spassword;
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
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getClassnum() {
		return classnum;
	}
	public void setClassnum(String classnum) {
		this.classnum = classnum;
	}
	
	
}
