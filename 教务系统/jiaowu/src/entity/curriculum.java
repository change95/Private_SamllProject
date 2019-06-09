package entity;

public class curriculum{
	private String curriculum;//课程号
	private String curriculumname;//课程名
	private String tno;//教师号
	private String classnum;//教师号
	

	public curriculum(String curriculum, String curriculumname, String tno, String classnum) {
		super();
		this.curriculum = curriculum;
		this.curriculumname = curriculumname;
		this.tno = tno;
		this.classnum = classnum;
	}
	public String getClassnum() {
		return classnum;
	}
	public void setClassnum(String classnum) {
		this.classnum = classnum;
	}
	public curriculum(String curriculum, String curriculumname, String tno) {
		super();
		this.curriculum = curriculum;
		this.curriculumname = curriculumname;
		this.tno = tno;
	}
	public String getCurriculum() {
		return curriculum;
	}
	public void setCurriculum(String curriculum) {
		this.curriculum = curriculum;
	}
	public String getCurriculumname() {
		return curriculumname;
	}
	public void setCurriculumname(String curriculumname) {
		this.curriculumname = curriculumname;
	}
	public String getTno() {
		return tno;
	}
	public void setTno(String tno) {
		this.tno = tno;
	}

	
}
