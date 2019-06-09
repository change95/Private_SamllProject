package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.adminDao;
import dao.gradeDao;
import dao.studentDao;
import dao.teacherDao;
import daoimp.adminImp;
import daoimp.gradeImp;
import daoimp.studentImp;
import daoimp.teacherImp;
import entity.grade;
import util.JdbcUtil;


@WebServlet("/BaseServlet")
public class BaseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public BaseServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//获取 method参数  
		String met=request.getParameter("method");
		//判断是  登陆还是注册...分别跳转不同功能
		if(met.equals("login")) {
			//跳转登陆功能
			login(request,response);
		}else if(met.equals("loginOut")) {
			
			//判断flag参数是 管理员 老师  学生
			System.out.println("判断身份:"+request.getParameter("flag"));
			if(request.getParameter("flag").equals("admin")) {
				//调用接口实现退出功能
				adminDao ad =new adminImp();
				ad.loginOut(request, response);
			}else if(request.getParameter("flag").equals("teacher")) {
				//调用接口实现退出功能
				teacherDao ad =new teacherImp();
				ad.loginOut(request, response);
			}else if(request.getParameter("flag").equals("student")) {
				//调用接口实现退出功能
				studentDao ad =new studentImp();
				ad.loginOut(request, response);
			}
	
		}else if(met.equals("amendgrade")) {
			//申请重修
			amendgrade(request,response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	protected void amendgrade(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/**
		 * 申请成绩   修改成绩
		 */
		System.out.println("申请重修");
		
		String sno=request.getParameter("sno");
		String curriculum=request.getParameter("curriculum");
		String grade=request.getParameter("grade");
		String status="已申请重修";
		grade g=new grade(sno,curriculum,grade,status);
		System.out.println("sno:"+sno+"curriculum:"+curriculum+"grade:"+grade+" "+status);
		gradeDao gradeDao=new gradeImp();
		 if(gradeDao.graModify(g)) {
			//申请成功
				request.getSession().setAttribute("msg", g.getSno()+"--修改成绩成功!");
				System.out.println("请求页面是:"+request.getHeader("Referer"));
				request.getSession().setAttribute("referer", request.getHeader("Referer"));
				response.sendRedirect("msg.jsp");
		 }else  {
			//申请失败
				request.getSession().setAttribute("msg", g.getSno()+"--修改成绩失败!");
				System.out.println("请求页面是:"+request.getHeader("Referer"));
				request.getSession().setAttribute("referer", request.getHeader("Referer"));
				response.sendRedirect("msg.jsp");
		 }		
	}
	/**
	 *   登陆模块实现   识别 学生  教师  管理员 三种身份 分别跳转不同页面
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	protected void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("登陆识别");
		//获取输入框  值(参数)
		String username= request.getParameter("username");//用户名
		String password= request.getParameter("password");//密码
		String type= new String(request.getParameter("type").getBytes("ISO8859-1"),"UTF-8");//类别
		System.out.println("参数输出: type:"+type+" username:"+username+" password:"+password);
		if (type.equals("管理员")) {
			 //调用 adimp 接口
			 adminDao ad=new adminImp();
			 if(ad.login(username, password)) {
				 System.out.println("登陆成功!跳转");
				 request.getSession().setAttribute("user", username);
				 System.out.println("请求页面是:"+request.getHeader("Referer"));
					request.getSession().setAttribute("referer", request.getHeader("Referer"));
				 response.sendRedirect("admin.jsp");
			 }else {
				 System.out.println("登陆失败!跳转");
				 request.getSession().setAttribute("msg", "管理员-用户名,密码错误或用户身份选择错误!");
				 System.out.println("请求页面是:"+request.getHeader("Referer"));
				 request.getSession().setAttribute("referer", request.getHeader("Referer"));
				 response.sendRedirect("msg.jsp");
			};
			
		}else if(type.equals("教师")){
			 //调用 teacherimp 接口
			 teacherDao te=new teacherImp();
			 if(te.login(username, password)) {
				 System.out.println("老师登陆成功!跳转");
				 request.getSession().setAttribute("user", username);
				 System.out.println("请求页面是:"+request.getHeader("Referer"));
					request.getSession().setAttribute("referer", request.getHeader("Referer"));
				 response.sendRedirect("teacherSelfe.jsp");
			 }else {
				 System.out.println("老师登陆失败!跳转");
				 request.getSession().setAttribute("msg", "老师-用户名,密码错误或用户身份选择错误!");
				 System.out.println("请求页面是:"+request.getHeader("Referer"));
				 request.getSession().setAttribute("referer", request.getHeader("Referer"));
				 response.sendRedirect("msg.jsp");
			 }
		}else if(type.equals("学生")) {
			 //调用studentimp 接口
		    	studentDao te=new studentImp();
			 if(te.login(username, password)) {
				 System.out.println("学生登陆成功!跳转");
				 request.getSession().setAttribute("user", username);
				 System.out.println("请求页面是:"+request.getHeader("Referer"));
				 request.getSession().setAttribute("referer", request.getHeader("Referer"));
				 response.sendRedirect("studentSelfe.jsp");
			 }else {
				 System.out.println("学生登陆失败!跳转");
				 request.getSession().setAttribute("msg", "学生-用户名,密码错误或用户身份选择错误!");
				 System.out.println("请求页面是:"+request.getHeader("Referer"));
					request.getSession().setAttribute("referer", request.getHeader("Referer"));
				 response.sendRedirect("msg.jsp");
			 }
		}else {
			System.out.println("type选择错误!");
		}
		
	}
}
