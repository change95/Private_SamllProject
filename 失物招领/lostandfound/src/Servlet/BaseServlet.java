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
import dao.formDao;
import dao.imp.UserDaoImp;
import dao.imp.formDaoImp;
import entity.User;
import entity.form;;
/**
 * Servlet implementation class BaseServlet
 */
@WebServlet("/BaseServlet")
public class BaseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public BaseServlet() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String method=request.getParameter("method");//获取参数method的值
		//根据method进行功能判断(是注册还是登陆等等)
		if(method.equals("adduser")) {
			//注册
			adduser(request,response);
		}else if(method.equals("login")) {
			//登陆
			login(request, response);
		}else if(method.equals("loginout")) {
			//登出
			loginout(request, response);
		}else if(method.equals("lost")) {
			//lost表
			lost(request, response);
		}else if(method.equals("found")) {
			//found表
			found(request, response);
		}else if(method.equals("lookform")) {
			//弹出查看表
			lookform(request, response);
		}else if(method.equals("deleform")) {
			//删除表
			deleform(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	protected void deleform(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//删除表
		System.out.println("删除表");
		String id=request.getParameter("id");
		System.out.println("删除获取id:"+id);
		
		formDaoImp formdele = new formDaoImp();
		if(formdele.deleteform(id)) {
			//存储提示页面msg数据信息
			 request.getSession().setAttribute("msg", id+"--删除成功!");
			 System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
			 response.sendRedirect("msg.jsp");
		}else {
			//存储提示页面msg数据信息
			 request.getSession().setAttribute("msg", id+"--删除失败!");
			 System.out.println("请求页面是:"+request.getHeader("Referer"));
				request.getSession().setAttribute("referer", request.getHeader("Referer"));
			 response.sendRedirect("msg.jsp");
		}
		
	}
	/**
	 * 注册功能实现
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public void adduser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		 User user1=new User(); //创建用户实体
		 user1.setUsername(request.getParameter("username"));//赋值
		 user1.setPassword(request.getParameter("password"));//赋值
		 System.out.println("用户名:"+user1.getUsername()+"密码"+user1.getPassword());
		 UserDao u =new UserDaoImp();//调用注册接口,进行判断注册返回值
		 HttpSession session=request.getSession();
		 if(u.regist(user1)==1) { 
			 //存储提示页面msg数据信息
			 session.setAttribute("msg", user1.getUsername()+"--注册成功!");
			 System.out.println("请求页面是:"+request.getHeader("Referer"));
				request.getSession().setAttribute("referer", request.getHeader("Referer"));
			 response.sendRedirect("msg.jsp");
		 }else if(u.regist(user1)==0) {
			//存储提示页面msg数据信息
			 session.setAttribute("msg", user1.getUsername()+"--注册失败!");
			 System.out.println("请求页面是:"+request.getHeader("Referer"));
				request.getSession().setAttribute("referer", request.getHeader("Referer"));
			 response.sendRedirect("msg.jsp");
		 }else if (u.regist(user1)==2) {
			//存储提示页面msg数据信息
			 session.setAttribute("msg", user1.getUsername()+"--用户名已存在!");
			 System.out.println("请求页面是:"+request.getHeader("Referer"));
				request.getSession().setAttribute("referer", request.getHeader("Referer"));
			 response.sendRedirect("msg.jsp");
		};

	}
	/**
	 * 登陆功能实现
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user1 = new User();
		user1.setUsername(request.getParameter("username"));
		user1.setPassword(request.getParameter("password"));
		//调用登陆接口userDao.loginl函数
		UserDao userDao=new UserDaoImp();
		HttpSession session= request.getSession();
		if(userDao.login(user1.getUsername(), user1.getPassword())) {
			//登陆成功 设置提示信息,用户信息  并且跳转提示页面
			session.setAttribute("msg", "登陆成功!");
			//把用户名存储session中
			session.setAttribute("user", user1.getUsername());
			 System.out.println("请求页面是:"+request.getHeader("Referer"));
				request.getSession().setAttribute("referer", request.getHeader("Referer"));
			response.sendRedirect("msg.jsp");
		}else {
			//登陆失败 设置提示信息,并且跳转提示页面
			session.setAttribute("msg", "登陆失败,用户名或者密码错误!");
			System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
			response.sendRedirect("msg.jsp");
		}
		
	}
	/**
	 * 登出功能
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public void loginout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 //设置提示语句
		 request.getSession().setAttribute("msg", "退出成功!即将跳转首页");
		 System.out.println("请求页面是:"+request.getHeader("Referer"));
			request.getSession().setAttribute("referer", request.getHeader("Referer"));
		 //跳转提示页面
		 request.getRequestDispatcher("/msg.jsp").forward(request, response);;
		 //销毁session对象
		 request.getSession().invalidate();
		 //重定向到首页
		 response.sendRedirect("main.jsp");
	}
	/**
	 * 上传丢失表照片
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public void lost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=UTF-8");	
        
        //创建用户实体
		form form1=new form(); 
		
		 HttpSession session= request.getSession();
		//设置表id
		 form1.setId(request.getParameter("id")); 

		 
		 System.out.println("-----------输出---------------");
		 System.out.println("request.getParameter(\'id\'):"+request.getParameter("id"));
		//设置表title 
		String title=new String(request.getParameter("title").getBytes("ISO8859-1"),"UTF-8");
		form1.setTitle(title); 
		System.out.println("request.getParameter(\'title\'):"+title);
		
		 //设置表username
		 String user=(String)session.getAttribute("user");
		 String username=new String(user.getBytes("ISO8859-1"),"UTF-8");
		 form1.setUsername(username);
		 System.out.println("session.getAttribute(\'user\')"+username);
		 
		//设置表kind
		 	String kind=new String(request.getParameter("kind").getBytes("ISO8859-1"),"UTF-8");
			form1.setKind(kind);
			System.out.println("request.getParameter(\'kind\'):"+kind);
		//设置表time
			String time=new String(request.getParameter("time").getBytes("ISO8859-1"),"UTF-8");
			form1.setTime(time); 
			System.out.println("request.getParameter(\'time\'):"+time);
		//设置表phone
			String phone=new String(request.getParameter("phone").getBytes("ISO8859-1"),"UTF-8");
			form1.setPhone(phone); 
			System.out.println("request.getParameter(\'phone\'):"+phone);
		//设置表name
			String name=new String(request.getParameter("name").getBytes("ISO8859-1"),"UTF-8");
			form1.setName(name);
			System.out.println("request.getParameter(\'name\'):"+name);
		//设置表content
			String content=new String(request.getParameter("content").getBytes("ISO8859-1"),"UTF-8");
			form1.setContent(content);; 
			System.out.println("request.getParameter(\'content\'):"+content);
		//设置表place
			String place=new String(request.getParameter("place").getBytes("ISO8859-1"),"UTF-8");
			form1.setPlace(place);
			System.out.println("request.getParameter(\'place\'):"+place);
		//设置表type
			String type=new String(request.getParameter("type").getBytes("ISO8859-1"),"UTF-8");
			form1.setType(type);
			System.out.println("request.getParameter(\'type\'):"+type);
		 System.out.println("-----------结束---------------");
		 //调用addform 插入数据库
		 formDao fo = new formDaoImp();
		  if(fo.addform(form1)) {
			  //成功 跳转 上传图片页面  并保存 当前lost表的id   后续存储照片
			  session.setAttribute("lostpic", form1.getId());
			  request.getRequestDispatcher("uploadPic.jsp").forward(request,response);
		  }else {
			  //失败跳提示页面
			    session.setAttribute("msg", "提交错误,请将内容添写全!");
			    System.out.println("请求页面是:"+request.getHeader("Referer"));
				request.getSession().setAttribute("referer", request.getHeader("Referer"));
				response.sendRedirect("msg.jsp");
		  }
	}
	
	/**
	 * 上传招领表图片
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public void found(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=UTF-8");	
        
        //创建用户实体
		form form1=new form(); 
		
		 HttpSession session= request.getSession();
		//设置表id
		 form1.setId(request.getParameter("id")); 

		 
		 System.out.println("-----------输出---------------");
		 System.out.println("request.getParameter(\'id\'):"+request.getParameter("id"));
		//设置表title 
		String title=new String(request.getParameter("title").getBytes("ISO8859-1"),"UTF-8");
		form1.setTitle(title); 
		System.out.println("request.getParameter(\'title\'):"+title);
		
		 //设置表username
		 String user=(String)session.getAttribute("user");
		 String username=new String(user.getBytes("ISO8859-1"),"UTF-8");
		 form1.setUsername(username);
		 System.out.println("session.getAttribute(\'user\')"+username);
		 
		//设置表kind
		 	String kind=new String(request.getParameter("kind").getBytes("ISO8859-1"),"UTF-8");
			form1.setKind(kind);
			System.out.println("request.getParameter(\'kind\'):"+kind);
		//设置表time
			String time=new String(request.getParameter("time").getBytes("ISO8859-1"),"UTF-8");
			form1.setTime(time); 
			System.out.println("request.getParameter(\'time\'):"+time);
		//设置表phone
			String phone=new String(request.getParameter("phone").getBytes("ISO8859-1"),"UTF-8");
			form1.setPhone(phone); 
			System.out.println("request.getParameter(\'phone\'):"+phone);
		//设置表name
			String name=new String(request.getParameter("name").getBytes("ISO8859-1"),"UTF-8");
			form1.setName(name);
			System.out.println("request.getParameter(\'name\'):"+name);
		//设置表content
			String content=new String(request.getParameter("content").getBytes("ISO8859-1"),"UTF-8");
			form1.setContent(content);; 
			System.out.println("request.getParameter(\'content\'):"+content);
		//设置表place
			String place=new String(request.getParameter("place").getBytes("ISO8859-1"),"UTF-8");
			form1.setPlace(place);
			System.out.println("request.getParameter(\'place\'):"+place);
		//设置表type
			String type=new String(request.getParameter("type").getBytes("ISO8859-1"),"UTF-8");
			form1.setType(type);
			System.out.println("request.getParameter(\'type\'):"+type);
		 System.out.println("-----------结束---------------");
		 //调用addform 插入数据库
		 formDao fo = new formDaoImp();
		  if(fo.addform(form1)) {
			  //成功 跳转 上传图片页面  并保存 当前lost表的id   后续存储照片
			  session.setAttribute("foundpic", form1.getId());
			  request.getRequestDispatcher("uppicfound.jsp").forward(request,response);
		  }else {
			  //失败跳提示页面
			    session.setAttribute("msg", "提交错误,请将内容添写全!");
			    System.out.println("请求页面是:"+request.getHeader("Referer"));
				request.getSession().setAttribute("referer", request.getHeader("Referer"));
				response.sendRedirect("msg.jsp");
		  }
	}
	public void lookform(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//获取参数名为id的数值
		String id=request.getParameter("id");
		System.out.println("id:"+id);
		//调用lookform(id)方法
		formDao f = new formDaoImp();
		form b=f.lookform(id);
		String picpath[]= f.lookpic(id);
		System.out.println("显示图片地址:"+picpath);
		//request.getSession().setAttribute("form", b);
		//设置服务端输出编码方式
		response.setCharacterEncoding("utf-8");
		PrintWriter out= response.getWriter();
		out.print("<html>\r\n" + 
				"<head>\r\n" + 
				"<meta charset=\"UTF-8\">\r\n" + 
				"<title>信息-失物招领</title>\r\n" + 
				"</head>\r\n" + 
				"<body>");
		out.print("<center><h1>失物招领-信息表</h1>");
		out.print("<table border=\"1\" algn=\"center\">");
		//表格内容
		out.print("<tr>"+"<td width=\"110\">ID:</td><td>"+id+"</td></tr>");
		out.print("<tr>"+"<td width=\"110\">标题:</td><td>"+b.getTitle()+"</td></tr>");
		out.print("<tr>"+"<td width=\"110\">用户名:</td><td>"+b.getUsername()+"</td></tr>");
		out.print("<tr>"+"<td width=\"110\">种类:</td><td>"+b.getKind()+"</td></tr>");
		out.print("<tr>"+"<td width=\"110\">时间:</td><td>"+b.getTime()+"</td></tr>");
		out.print("<tr>"+"<td width=\"110\">电话:</td><td>"+b.getPhone()+"</td></tr>");
		out.print("<tr>"+"<td width=\"110\">姓名:</td><td>"+b.getName()+"</td></tr>");
		out.print("<tr>"+"<td width=\"110\">内容:</td><td>"+b.getContent()+"</td></tr>");
		out.print("<tr>"+"<td width=\"110\">地点:</td><td>"+b.getPlace()+"</td></tr>");
		out.print("<tr>"+"<td width=\"110\">图片:</td><td><img width=\"300px\" src=\""+"/upload/pic/"+picpath[0]+"/"+picpath[1]+"\">"+"</td></tr>");
		out.print("<tr>"+"<td width=\"110\">操作:</td><td><a href=\"/lostandfound/BaseServlet?method=deleform&id="+id+"\">已找到</a>"+"</td></tr>");
		
		
		out.print("</table> </center>");
		out.print("</body>\r\n" + 
				"</html>");
		
		
	}
}
