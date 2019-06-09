package Servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDao;
import dao.adminDao;
import dao.formDao;
import dao.imp.UserDaoImp;
import dao.imp.adminDaoImp;
import dao.imp.formDaoImp;
import entity.form;


/**
 * Servlet implementation class admin
 */
@WebServlet("/adminServlet")
public class adminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public adminServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//
		String  method=request.getParameter("method");
		System.out.println("method"+method);
		if(method.equals("adminlogin") ) {
			//登陆
			adminlogin(request, response);
		}else if(method.equals("loginOut")) {
			//登出
			loginOut(request, response);
		}else if(method.equals("deleuser")) {
			//删除用户
			deleuser(request, response);
		}else if(method.equals("amenduser")) {
			//修改用户
			amenduser(request, response);

		}else if(method.equals("amendform")) {
			//修改信息表
			amendform(request, response);

		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	protected void amendform(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 修改信息表
		System.out.println("修改信息表");
		String id=new String(request.getParameter("id2").getBytes("ISO-8859-1"),"utf-8");
		String title=new String(request.getParameter("title").getBytes("ISO-8859-1"),"utf-8");
	
		String username=new String(request.getParameter("username").getBytes("ISO-8859-1"),"utf-8");
		String kind=new String(request.getParameter("kind").getBytes("ISO-8859-1"),"utf-8");
		System.out.println(id+"--"+title+"--"+username+"--"+kind);
		
		form f=new form(id,title,username,kind,new String(request.getParameter("time").getBytes("ISO-8859-1"),"utf-8"),
				new String(request.getParameter("phone").getBytes("ISO-8859-1"),"utf-8"),new String(request.getParameter("name").getBytes("ISO-8859-1"),"utf-8"),new String(request.getParameter("content").getBytes("ISO-8859-1"),"utf-8"),
				new String(request.getParameter("place").getBytes("ISO-8859-1"),"utf-8"),new String(request.getParameter("type").getBytes("ISO-8859-1"),"utf-8"));
		formDao uDao=new formDaoImp();
		if(uDao.amendform(f)) {
			request.getSession().setAttribute("msg",request.getParameter("username")+"修改成功!");
			System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
			response.sendRedirect("msg.jsp");
		}else {
			request.getSession().setAttribute("msg",request.getParameter("username")+"修改失败!");
			System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
			response.sendRedirect("msg.jsp");
		}
	}
	protected void amenduser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 修改用户
		System.out.println("修改用户");
		
		UserDao uDao=new UserDaoImp();
		if(uDao.amenduser(request.getParameter("username"), request.getParameter("userpas"))) {
			request.getSession().setAttribute("msg",request.getParameter("username")+"修改成功!");
			System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
			response.sendRedirect("msg.jsp");
		}else {
			request.getSession().setAttribute("msg",request.getParameter("username")+"修改失败!");
			System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
			response.sendRedirect("msg.jsp");
		}
		
	}
	protected void loginOut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 登出
		System.out.println("登出");
		 //销毁session对象
		 request.getSession().invalidate();
		 //重定向到首页
		 response.sendRedirect("adminlogin.jsp");
		
	}
	protected void adminlogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 登陆
		System.out.println("登陆");
		String adname=request.getParameter("adname");
		String adpass=request.getParameter("adpass");
		//调用登陆接口adminDao.login函数
		adminDao adminDao=new adminDaoImp();
		HttpSession session= request.getSession();
		if(adminDao.adminlogin(adname, adpass)) {
			//登陆成功 admin存储session中
			System.out.println("登陆成功 !");
			session.setAttribute("admin", adname);
			response.sendRedirect("admin.jsp");
		}else {
			//登陆失败 设置提示信息,并且跳转提示页面
			System.out.println("登陆失败!");
			
			session.setAttribute("msg", "登陆失败!");
			System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
			response.sendRedirect("msg.jsp");
		}
		
	}
	protected void deleuser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//删除用户
		System.out.println("删除 用户"+request.getParameter("username"));
		UserDao ud=new UserDaoImp();
		
		if(ud.deleuser(request.getParameter("username"))) {
			request.getSession().setAttribute("msg", "删除成功!");
			System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
			response.sendRedirect("msg.jsp");
		}else {
			request.getSession().setAttribute("msg", "删除失败!");
			System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
			response.sendRedirect("msg.jsp");
		}
		
	}

}
