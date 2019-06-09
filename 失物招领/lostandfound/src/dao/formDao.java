package dao;
import entity.form;

public interface formDao {
	/**
	 * 修改表信息
	 * @param f 表信息
	 * @return
	 */
	public abstract boolean amendform(form f);
	/**
	 * 删除表信息
	 * @param f 表信息
	 * @return
	 */
	public abstract boolean deleteform(String id);
	/**
	 * 添加表信息
	 * @param f 表信息
	 * @return
	 */
	public abstract boolean addform(form f);
	
	/**
	 * 根据id查询表
	 * @param id
	 * @return
	 */
	public abstract form lookform(String id);
	/**
	 * 根据id查询图片
	 * @param id
	 * @return
	 */
	public abstract String[] lookpic(String id);
}
