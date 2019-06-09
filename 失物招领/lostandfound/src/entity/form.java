package entity;
/**
 * 表实体
 * @author czh
 *
 */
public class form {
	private String id;//id
	private String title ;//标题
	private String username ;//用户名
	private String kind ;//种类
	private String time ;//时间
	private String phone ;//电话
	private String name ;//姓名
	private String content ;//内容
	private String place ;//地点
	private String type ;//类型 found  lost

	public form() {
		super();
	}

	
	public form(String id, String title, String username, String kind, String time, String phone, String name,
			String content, String place, String type) {
		super();
		this.id = id;
		this.title = title;
		this.username = username;
		this.kind = kind;
		this.time = time;
		this.phone = phone;
		this.name = name;
		this.content = content;
		this.place = place;
		this.type = type;
	}


	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	

	
}
