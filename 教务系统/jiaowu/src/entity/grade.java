package entity;

public class grade {
	private String sno;//学号
	private String curriculum;//课程号
	private String grade;//成绩
	private String status;//状态
	
	
	public grade(String sno, String curriculum, String grade, String status) {
		super();
		this.sno = sno;
		this.curriculum = curriculum;
		this.grade = grade;
		this.status = status;
	}
	public String getSno() {
		return sno;
	}
	public void setSno(String sno) {
		this.sno = sno;
	}
	public String getCurriculum() {
		return curriculum;
	}
	public void setCurriculum(String curriculum) {
		this.curriculum = curriculum;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}
