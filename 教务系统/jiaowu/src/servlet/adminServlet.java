package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.jasper.tagplugins.jstl.core.Out;

import dao.teacherDao;
import dao.studentDao;
import dao.curriculumDao;
import dao.messageDao;
import daoimp.studentImp;
import daoimp.teacherImp;
import daoimp.curriculumImp;
import daoimp.messageImp;
import entity.teacher;
import entity.student;
import entity.curriculum;
import entity.message;


/**
 * Servlet implementation class adminServlet
 */
@WebServlet("/adminServlet")
public class adminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public adminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//获取 method参数  
				String met=request.getParameter("method");
				//判断是  登陆还是注册...分别跳转不同功能
				if(met.equals("addstu")) {
					//添加学生功能
					addstu(request,response);
				}else if(met.equals("amend")) {
					//修改学生功能
					amend(request,response);
				}else if(met.equals("delestu")) {
					//删除学生功能
					delestu(request,response);
				}else if(met.equals("addtea")) {
					//增加教师
					addtea(request,response);
				}else if(met.equals("amendtea")) {
					//修改教师
					amendtea(request,response);
				}else if(met.equals("deletea")) {
					//删除教师
					deletea(request,response);
				}else if(met.equals("addcur")) {
					//添加课程功能
					addcur(request,response);
				}else if(met.equals("amendcur")) {
					//修改课程功能
					amendcur(request,response);
				}else if(met.equals("delecur")) {
					//删除课程功能
					delecur(request,response);
				}else if(met.equals("addmes")) {
					//添加 信息
					addmes(request,response);
				}else if(met.equals("amendmes")) {
					//修改 信息
					amendmes(request,response);
				}else if(met.equals("delemes")) {
					//删除 信息
					delemes(request,response);
				}
				
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	protected void delemes(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("删除信息功能");
		String id= request.getParameter("id");
		messageDao sDao= new messageImp();
		if(sDao.mesDelete(id)) {
			//修改成功
			request.getSession().setAttribute("msg", id+"--删除成功!");
			System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
			response.sendRedirect("msg.jsp");
		}else {
			//修改失败
			request.getSession().setAttribute("msg", id+"--删除失败!");
			System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
			response.sendRedirect("msg.jsp");
		}
	}
	protected void amendmes(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("修改信息功能");
		request.setCharacterEncoding("utf-8");
		//获取输入框参数值
				String id=request.getParameter("id");//id
				String informObj=new String(request.getParameter("informObj").getBytes("ISO-8859-1"),"UTF-8");//通知对象
				String content=new String(request.getParameter("content").getBytes("ISO-8859-1"),"UTF-8");//内容
				String time=new String(request.getParameter("time").getBytes("ISO-8859-1"),"UTF-8");//时间
		
				//新建对象存放信息
				message stu= new message(id,informObj,content,time);
				//调用修改信息方法
				messageDao sDao= new messageImp();
				if(sDao.mesModify(stu)) {
					//修改成功
					request.getSession().setAttribute("msg", stu.getId()+"--修改成功!");
					System.out.println("请求页面是:"+request.getHeader("Referer"));
					request.getSession().setAttribute("referer", request.getHeader("Referer"));
					response.sendRedirect("msg.jsp");
				}else {
					//修改失败
					request.getSession().setAttribute("msg", stu.getId()+"--修改失败!");
					System.out.println("请求页面是:"+request.getHeader("Referer"));
					request.getSession().setAttribute("referer", request.getHeader("Referer"));
					response.sendRedirect("msg.jsp");
				}
	}
	protected void addmes(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("添加信息");
		request.setCharacterEncoding("utf-8");
		//获取输入框参数值
		String id=request.getParameter("id");//id号
		String informObj =new String(request.getParameter("informObj").getBytes("ISO-8859-1"),"utf-8");//通知对象
		String content =new String(request.getParameter("content").getBytes("ISO-8859-1"),"utf-8");//内容
		
		System.out.println("信息的时间:"+request.getParameter("time"));
		String time =new String(request.getParameter("time").getBytes("ISO-8859-1"),"utf-8");//时间
		
		message tea= new message(id,informObj,content,time);
		messageDao sDao= new messageImp();
		if(sDao.mesregist(tea)==1) {
				request.getSession().setAttribute("msg", tea.getId()+"--添加成功!");
				System.out.println("请求页面是:"+request.getHeader("Referer"));
				request.getSession().setAttribute("referer", request.getHeader("Referer"));
				response.sendRedirect("msg.jsp");
			
		}else if(sDao.mesregist(tea)==2) {
			request.getSession().setAttribute("msg", tea.getId()+"--ID已存在!请重新添加.");
			System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
			response.sendRedirect("msg.jsp");
		}else if(sDao.mesregist(tea)==0) {
			request.getSession().setAttribute("msg", tea.getId()+"--添加失败!");
			System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
			response.sendRedirect("msg.jsp");
		}
	}
	protected void delecur(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("删除课程功能");
		String curriculum= request.getParameter("curriculum");
		curriculumDao sDao= new curriculumImp();
		if(sDao.curDelete(curriculum)) {
			//修改成功
			request.getSession().setAttribute("msg", curriculum+"--删除成功!");
			System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
			response.sendRedirect("msg.jsp");
		}else {
			//修改失败
			request.getSession().setAttribute("msg", curriculum+"--删除失败!");
			System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
			response.sendRedirect("msg.jsp");
		}
	}
	protected void amendcur(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("修改课程功能");
		request.setCharacterEncoding("utf-8");
		//获取输入框参数值
				String curriculum=request.getParameter("curriculum");//课程号
				String curriculumname=new String(request.getParameter("curriculumname").getBytes("ISO-8859-1"),"utf-8");//课程名
				String tno=request.getParameter("tno");//教师号
				String classnum=request.getParameter("classnum");//教师号
				System.out.println("课程号:"+curriculum+"课程名:"+curriculumname+"tno:"+tno+" classnum:"+classnum);
				//新建对象存放信息
				curriculum stu= new curriculum(curriculum,curriculumname,tno,classnum);
				//调用修改课程方法
				curriculumDao sDao= new curriculumImp();
				if(sDao.curModify(stu)) {
					//修改成功
					request.getSession().setAttribute("msg", stu.getCurriculum()+"--修改成功!");
					System.out.println("请求页面是:"+request.getHeader("Referer"));
					request.getSession().setAttribute("referer", request.getHeader("Referer"));
					response.sendRedirect("msg.jsp");
				}else {
					//修改失败
					request.getSession().setAttribute("msg", stu.getCurriculum()+"--修改失败!");
					System.out.println("请求页面是:"+request.getHeader("Referer"));
					request.getSession().setAttribute("referer", request.getHeader("Referer"));
					response.sendRedirect("msg.jsp");
				}
	}
	protected void addcur(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("添加课程功能");
		request.setCharacterEncoding("utf-8");
		//获取输入框参数值
		String curriculum=request.getParameter("curriculum");//课程号
		String curriculumname =new String(request.getParameter("curriculumname").getBytes("ISO-8859-1"),"utf-8");//课程名
		String tno=request.getParameter("tno");//教师号
		String classnum=request.getParameter("classnum");//教师号
		
		curriculum tea= new curriculum(curriculum,curriculumname,tno,classnum);
		curriculumDao sDao= new curriculumImp();
		if(sDao.curregist(tea)==1) {
				request.getSession().setAttribute("msg", tea.getTno()+"--添加成功!");
				System.out.println("请求页面是:"+request.getHeader("Referer"));
				request.getSession().setAttribute("referer", request.getHeader("Referer"));
				response.sendRedirect("msg.jsp");
			
		}else if(sDao.curregist(tea)==2) {
			request.getSession().setAttribute("msg", tea.getTno()+"--课程号已存在!请重新添加.");
			System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
			response.sendRedirect("msg.jsp");
		}else if(sDao.curregist(tea)==0) {
			request.getSession().setAttribute("msg", tea.getTno()+"--添加失败!");
			System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
			response.sendRedirect("msg.jsp");
		}
	}
	protected void deletea(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("删除教师功能");
		String tno= request.getParameter("tno");
		teacherDao sDao= new teacherImp();
		if(sDao.teaDelete(tno)) {
			//修改成功
			request.getSession().setAttribute("msg", tno+"--删除成功!");
			System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
			response.sendRedirect("msg.jsp");
		}else {
			//修改失败
			request.getSession().setAttribute("msg", tno+"--删除失败!");
			System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
			response.sendRedirect("msg.jsp");
		}
	}
	protected void amendtea(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("修改教师功能");
		request.setCharacterEncoding("utf-8");
		//获取输入框参数值
				String tno=request.getParameter("tno");//学号
				String pas=request.getParameter("pas");//密码
				String name=new String(request.getParameter("name").getBytes("ISO-8859-1"),"utf-8");//姓名
				String sex=new String(request.getParameter("sex").getBytes("ISO-8859-1"),"utf-8");//性别
				String education=new String(request.getParameter("education").getBytes("ISO-8859-1"),"utf-8");//学历
				String college=new String(request.getParameter("college").getBytes("ISO-8859-1"),"utf-8");//班级号 
				//输出
				System.out.println(" tno:"+tno+" pas:"+pas+" name:"+name+" sex:"+sex+" education:"+education+" college:"+college);
				//新建对象存放信息
				teacher stu= new teacher(tno,pas,name,sex,education,college);
				//调用修改教师方法
				teacherDao sDao= new teacherImp();
				if(sDao.teaModify(stu)) {
					//修改成功
					request.getSession().setAttribute("msg", stu.getTno()+"--修改成功!");
					System.out.println("请求页面是:"+request.getHeader("Referer"));
					request.getSession().setAttribute("referer", request.getHeader("Referer"));
					response.sendRedirect("msg.jsp");
				}else {
					//修改失败
					request.getSession().setAttribute("msg", stu.getTno()+"--修改失败!");
					System.out.println("请求页面是:"+request.getHeader("Referer"));
					request.getSession().setAttribute("referer", request.getHeader("Referer"));
					response.sendRedirect("msg.jsp");
				}
	}
	protected void addtea(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("增加教师功能");
		request.setCharacterEncoding("utf-8");
		//获取输入框参数值
		String tno=request.getParameter("tno");//教师号
		String pas=request.getParameter("password");//密码
		String name=new String(request.getParameter("name").getBytes("ISO-8859-1"),"utf-8");//姓名
		String sex=new String(request.getParameter("sex").getBytes("ISO-8859-1"),"utf-8");//性别
		String education=new String(request.getParameter("education").getBytes("ISO-8859-1"),"utf-8");//学历
		String college=new String(request.getParameter("college").getBytes("ISO-8859-1"),"utf-8");//所属学历
		System.out.println(" tno:"+tno+" pas:"+pas+" name:"+name+" sex:"+sex+" education:"+education+" college:"+college);
		teacher tea= new teacher(tno,pas,name,sex,education,college);
		teacherDao sDao= new teacherImp();
		if(sDao.tearegist(tea)==1) {
				request.getSession().setAttribute("msg", tea.getTno()+"--注册成功!");
				System.out.println("请求页面是:"+request.getHeader("Referer"));
				request.getSession().setAttribute("referer", request.getHeader("Referer"));
				response.sendRedirect("msg.jsp");
			
		}else if(sDao.tearegist(tea)==2) {
			request.getSession().setAttribute("msg", tea.getTno()+"--教师号已存在!请重新添加.");
			System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
			response.sendRedirect("msg.jsp");
		}else if(sDao.tearegist(tea)==0) {
			request.getSession().setAttribute("msg", tea.getTno()+"--注册失败!");
			System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
			response.sendRedirect("msg.jsp");
		}
		
	}
	protected void delestu(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("删除学生功能");
		String sno= request.getParameter("sno");
		studentDao sDao= new studentImp();
		if(sDao.stuDelete(sno)) {
			//修改成功
			request.getSession().setAttribute("msg", sno+"--删除成功!");
			System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
			response.sendRedirect("msg.jsp");
		}else {
			//修改失败
			request.getSession().setAttribute("msg", sno+"--删除失败!");
			System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
			response.sendRedirect("msg.jsp");
		}
	}
	protected void amend(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("修改学生功能");
		request.setCharacterEncoding("utf-8");
		//获取输入框参数值
				String sno=request.getParameter("sno");//学号
				String pas=request.getParameter("pas");//密码
				String name=new String(request.getParameter("name").getBytes("ISO-8859-1"),"utf-8");//姓名
				String sex=new String(request.getParameter("sex").getBytes("ISO-8859-1"),"utf-8");//性别
				String date=request.getParameter("date");//出生年月
				System.out.println("修改学生日期:"+date);
				String classnum=request.getParameter("classnum");//班级号 
				//输出
				System.out.println(" sno:"+sno+" pas:"+pas+" name:"+name+" sex:"+sex+" classnum:"+classnum);
				//新建对象存放信息
				student stu= new student(sno,pas,name,sex,date,classnum);
				//调用修改学生方法
				studentDao sDao= new studentImp();
				if(sDao.stuModify(stu)) {
					//修改成功
					request.getSession().setAttribute("msg", stu.getSno()+"--修改成功!");
					System.out.println("请求页面是:"+request.getHeader("Referer"));
					request.getSession().setAttribute("referer", request.getHeader("Referer"));
					response.sendRedirect("msg.jsp");
				}else {
					//修改失败
					request.getSession().setAttribute("msg", stu.getSno()+"--修改失败!");
					System.out.println("请求页面是:"+request.getHeader("Referer"));
					request.getSession().setAttribute("referer", request.getHeader("Referer"));
					response.sendRedirect("msg.jsp");
				}

	}
	protected void addstu(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("添加学生功能");
		request.setCharacterEncoding("utf-8");
		//获取输入框参数值
		String sno=request.getParameter("sno");//学号
		String pas=request.getParameter("pas");//密码
		String name=new String(request.getParameter("name").getBytes("ISO-8859-1"),"utf-8");//姓名
		String sex=new String(request.getParameter("sex").getBytes("ISO-8859-1"),"utf-8");//性别
		String date=request.getParameter("date");//出生年月
		String classnum=request.getParameter("classnum");//班级号 
		System.out.println(" sno:"+sno+" pas:"+pas+" name:"+name+" sex:"+sex+" date:"+date+" classnum:"+classnum);
		student stu= new student(sno,pas,name,sex,date,classnum);
		studentDao sDao= new studentImp();
		if(sDao.sturegist(stu)==1) {
				request.getSession().setAttribute("msg", stu.getSno()+"--注册成功!");
				System.out.println("请求页面是:"+request.getHeader("Referer"));
				request.getSession().setAttribute("referer", request.getHeader("Referer"));
				response.sendRedirect("msg.jsp");
			
		}else if(sDao.sturegist(stu)==2) {
			request.getSession().setAttribute("msg", stu.getSno()+"--学号已存在!请重新添加.");
			System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
			response.sendRedirect("msg.jsp");
		}else if(sDao.sturegist(stu)==0) {
			request.getSession().setAttribute("msg", stu.getSno()+"--注册失败!");
			System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
			response.sendRedirect("msg.jsp");
		}
		
	}

}
