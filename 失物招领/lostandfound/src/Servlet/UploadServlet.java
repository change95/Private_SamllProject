package Servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import Util.upImgUtil;

/**
 * Servlet implementation class UploadServlet
 */
@WebServlet("/UploadServlet")
public class UploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String String = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UploadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");	
		String method=request.getParameter("way");//获取参数method的值
		//根据method进行功能判断(是注册还是登陆等等)
		if(method.equals("lost")) {
			//lost
			uplostpic(request,response);
		}else if(method.equals("found")) {
			//found
			upfoundpic(request,response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	public void uplostpic(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//设置编码方式为utf-8
		request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
	   
        //获取照片名字
        String filename=(String)request.getSession().getAttribute("lostpic");
        //上传图片到 pic/lost/下  名字叫filename变量   并 存储数据库   
		upImgUtil.keepFile(request,"lost",filename);
		response.sendRedirect("msg.jsp");
        

	}
	protected void upfoundpic(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        //获取照片名字
        String filename=(String)request.getSession().getAttribute("foundpic");
        System.out.println("------------------------------");
        System.out.println("upfoundpic----filename"+filename);
        System.out.println("------------------------------");
        //上传图片到 pic/found/下  名字叫filename变量   并 存储数据库
		upImgUtil.keepFile(request,"found",filename);
		response.sendRedirect("msg.jsp");

	}

}
