package entity;
/**
 * 用户实体类
 * @author czh
 *
 */

public class User {
	private String username;//用户名
	private String password; //用户名密码
	public User() {}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
}
