package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.gradeDao;
import dao.messageDao;
import daoimp.gradeImp;
import daoimp.messageImp;
import entity.grade;
import entity.message;

/**
 * Servlet implementation class teacherServlet
 */
@WebServlet("/teacherServlet")
public class teacherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//获取 method参数  
				String met=request.getParameter("method");
				//判断是  登陆还是注册...分别跳转不同功能
				if(met.equals("addgra")) {
					//添加 成绩
					addgra(request,response);
				}else if(met.equals("amendgra")) {
					//修改学生功能
					amendgra(request,response);
				}else if(met.equals("delegra")) {
					//删除 信息
					delegra(request,response);
				}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	protected void delegra(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("删除成绩");
		String sno= request.getParameter("sno");
		String curriculum= request.getParameter("curriculum");
		gradeDao sDao= new gradeImp();
		if(sDao.graDelete(sno,curriculum)) {
			//修改成功
			request.getSession().setAttribute("msg", sno+"--删除成绩成功!");
			System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
			response.sendRedirect("msg.jsp");
		}else {
			//修改失败
			request.getSession().setAttribute("msg", sno+"--删除成绩失败!");
			System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
			response.sendRedirect("msg.jsp");
		}
	}
	protected void amendgra(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("修改成绩功能");
		request.setCharacterEncoding("utf-8");
		//获取输入框参数值
				String sno=request.getParameter("sno");//id
				String curriculum=request.getParameter("curriculum");//curriculum
				String grade=new String(request.getParameter("grade").getBytes("ISO-8859-1"),"UTF-8");//通知对象
				String status=new String(request.getParameter("status").getBytes("ISO-8859-1"),"UTF-8");//内容
		
				//新建对象存放信息
				grade stu= new grade(sno,curriculum,grade,status);
				//调用修改信息方法
				gradeDao sDao= new gradeImp();
				if(sDao.graModify(stu)) {
					//修改成功
					request.getSession().setAttribute("msg", stu.getSno()+"--修改成绩成功!");
					System.out.println("请求页面是:"+request.getHeader("Referer"));
					request.getSession().setAttribute("referer", request.getHeader("Referer"));
					response.sendRedirect("msg.jsp");
				}else {
					//修改失败
					request.getSession().setAttribute("msg", stu.getSno()+"--修改成绩失败!");
					System.out.println("请求页面是:"+request.getHeader("Referer"));
					request.getSession().setAttribute("referer", request.getHeader("Referer"));
					response.sendRedirect("msg.jsp");
				}
	}
	protected void addgra(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("添加成绩");
		request.setCharacterEncoding("utf-8");
		//获取输入框参数值
		String sno=request.getParameter("sno");//id号
		String curriculum=request.getParameter("curriculum");//课程号
		String grade =new String(request.getParameter("grade").getBytes("ISO-8859-1"),"utf-8");//成绩
		String status =new String(request.getParameter("status").getBytes("ISO-8859-1"),"utf-8");//状态
		System.out.println("sno:"+sno+"curriculum:"+curriculum+"grade:"+grade+"status:"+status);
		grade tea= new grade(sno,curriculum,grade,status);
		gradeDao sDao= new gradeImp();
		if(sDao.graregist(tea)==1) {
				request.getSession().setAttribute("msg", tea.getSno()+"--添加成绩成功!");
				System.out.println("请求页面是:"+request.getHeader("Referer"));
				request.getSession().setAttribute("referer", request.getHeader("Referer"));
				response.sendRedirect("msg.jsp");
			
		}else if(sDao.graregist(tea)==2) {
			request.getSession().setAttribute("msg", tea.getSno()+"---请重新添加"+"<br><br>"+"原因:(学号,课程号不存在,或者成绩已存在!)");
			System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
			response.sendRedirect("msg.jsp");
		}else if(sDao.graregist(tea)==0) {
			request.getSession().setAttribute("msg", tea.getSno()+"--添加成绩失败!");
			System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
			response.sendRedirect("msg.jsp");
		}
	}

}
