package entity;

public class message {
	private String id;//id
	private String informObj;//通知对象
	private String content;//内容
	private String time;//时间
	
	public message(String id, String informObj, String content, String time) {
		super();
		this.id = id;
		this.informObj = informObj;
		this.content = content;
		this.time = time;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getInformObj() {
		return informObj;
	}
	public void setInformObj(String informObj) {
		this.informObj = informObj;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	
}
