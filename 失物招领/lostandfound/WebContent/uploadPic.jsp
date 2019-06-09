<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>上传图片-失物招领</title>
<link href="css/top_nav.css" rel="stylesheet" type="text/css" /> 

<link href="css/content.css" rel="stylesheet" type="text/css" /> 
<script>
//获取首页星期几
	function showTopTime(){
	
			var time = new Date();
			var week=["星期日","星期一","星期二","星期三","星期四","星期五","星期六"];
			document.getElementById('top_time').innerHTML=time.getFullYear()+'年'+ time.getMonth()+'月'+ time.getDate()+'日            '+ week[time.getDay()];	
			}
setTimeout(showTopTime,1000);

//设置登陆之后删除登陆输入框等  并 设置退出按钮和显示用户名
	function loginafter(){
			var username=<%=session.getAttribute("user")%>;
			if(null!=username){
				//删除登陆等节点
				console.log("用户名"+username);
				var el = document.getElementById('userlogin'); 
				var childs = el.childNodes; 
				for(var i = childs .length - 1; i >= 0; i--) {
				  el.removeChild(childs[i]);
				}

				//添加节点  用户名  退出
				document.getElementById("usermsg").innerHTML="欢迎您尊敬的会员&nbsp;&nbsp;"+username+"&nbsp;&nbsp;<a href='/lostandfound/BaseServlet?method=loginout'>退出</a>";
			}
}
//加测上传图片是否为图片
function imgPreview(fileDom) {
		//创建FileReader 若不支持FileReader 则无法使用上传图片预览
		var reader = new FileReader();
		//获取文件
		var file = fileDom.files[0];
		//使用正则判断是否是照片
        var imageType = /^image\//;
        //是否是图片
        if (!imageType.test(file.type)) {
            alert("请选择图片！");
            return;
        }
        //读入文件,设置img的图片地址
		reader.onload =function(e){
			var img=document.getElementById("imgpre");
			img.src = e.target.result;	
		}
        //FileReader对象的readAsDataURL方法可以将读取到的文件编码成Data URL.
		reader.readAsDataURL(file);
	}
setTimeout(loginafter,800);
</script>
</head>
<body>
<!--top导航-->
<div class="top_nav">
	<!--小导航-->
	<div class="top_login">
    	<div class="top_content">
        	<form action="/lostandfound/BaseServlet?method=login" method="post">
  			您好 欢迎来到校园失物招领网 &nbsp;&nbsp; <span id="top_time"></span>
  			<span id="userlogin">
  			&nbsp;&nbsp;用户名:
            <input id="username" name="username" type="text" style="width:80px; height:20px; " />
            &nbsp;&nbsp; 密码:
            <input id="password" name="password" type="password" style=" width:80px; height:20px;" />
            &nbsp;&nbsp;
            <input type="submit" id="login" value="登陆" style="color: #222;cursor: pointer;width: 51px;height: 24px;line-height: 24px;"/>
            &nbsp;&nbsp;
            <input type="button" id="register" value="注册" onclick="window.location.href='register.html'" style="color: #222;cursor: pointer;width: 51px;height: 24px;line-height: 24px;" />
            </span>
           <span id="usermsg" style="float:right;"></span>
            </form>
            
		</div> 
    </div>
    <!--搜索+logo-->
    <div class="top_search">
    	 <div style=" width:1000px; margin:0 auto;height:103px; ">
    	 <div class="logo"> <img src="img/logo.jpg" width="250px" height="90px" style=" margin-top:6px;"></div>
               <div class="search">
                <form>
                    <input type="text" placeholder="请输入您要搜索的内容..." />
                    <button type="submit" ></button>
                </form>
                <center><font color="#FF0000">热搜词</font><font style="color: #000;font-family: "Microsoft YaHei";font-size: 12px;">：手机、钱包、钥匙、身份证、ipad、杯子</font></center>
              </div>
         </div>                                                      
    </div>
</div>
<!-- 大导航-->
<div class="nav">
	<div class="nav_content">
    	<ul>
        	<li style="background-color: #F90"><a href="main.jsp">首页</a></li>
            <li><a href="lost.jsp">发布招领</a></li>
            <li><a href="found.jsp">发布失物</a></li>
        </ul>
    </div>
</div>
<!-- 上传图片 -->
<div style=" height: 400px" >
		<div style=" margin: 0 auto; height: 400px; width: 1000px;text-align: center;">
		<h1>上传失物照片</h1>
			<hr>
			<div style="margin: 0 auto; height: 400px ; width: 400px;  text-align: left: ;  ">
				<!-- 表单必须使用 enctype="multipart/form-data" 将文件转化成二进制数据流进行传输 -->
				<br><b>流程:填写丢失信息表  -->  上传图片 -->  完成</b><br><br><br>
				照片ID号:<%=(String)session.getAttribute("lostpic") %><br><br>
				当前上传图片:
				<form action="/lostandfound/UploadServlet?way=lost" enctype="multipart/form-data" method="post">
				<input type="file" onchange="imgPreview(this)" name="file">
				<br>
				<img id="imgpre" alt="" src="img/nopic.jpg" style="width: 250px; height: 250px;" >
				<br>
				<input type="submit" value="提交">
				<input type="reset" value="清除">
				</form>
			</div>
		</div>
</div>
<!--foot-->
<div style=" position:fixed ;bottom:0px; left:0px; height:80px; background-color:#dddddd; margin-top:5px;text-align:center; width:100%;"> 
	<div style="height:20px;">| 免责声明 | 关于我们 | 网站合作 | 联系我们 |</div>
	<div style="">2018 失物认领网  <br/>
				失物认领网 版权所有<br/></div>
</div>
</body>
</html>