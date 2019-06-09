package dao;
import entity.User;;
public interface UserDao {
	/**
	 * 用户修改功能实现
	 * @param username 用户名
	 * @param password	用户密码
	 * @return true为登陆成功
	 */
	public abstract boolean amenduser(String username,String password);
	/**
	 * 用户登陆功能实现
	 * @param username 用户名
	 * @param password	用户密码
	 * @return true为登陆成功
	 */
	public abstract boolean login(String username,String password);
	/**
	 * 这是用户的注册功能
	 * @param test 用户对象
	 * @return 1为注册成功 0为注册失败 2为用户名已存在 
	 */
	public abstract int regist(User test);
	/**
	 * 这是用户的删除功能
	 * @param 用户名  username
	 * @return  true
	 */
	public abstract boolean deleuser(String username);
	/**
	 * 这是用户名检测是否存在
	 * @param username   用户名
	 * @return 返回true则存在
	 */
	public abstract boolean UserDection(String username);
}
