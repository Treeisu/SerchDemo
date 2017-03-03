<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<style type="text/css">
#mydiv {
	position: absolute;
	left: 50%;
	top: 50%;
	margin-left: -200px;
	margin-top: -50px;
}

.mouseOver {
	background: #708090;
	color: #ffafa;
}

.mouseOut {
	background: #ffafa;
	color: #000000;
}
</style>

</head>

<body>
	<div id="mydiv">
		<input type="text" size="50" id="keyword" onkeyup="getMoreContents()" />
		<input type="button" value="百度一下" width="50px" onclick="baidu()" />
		<div id="popDiv">
			<table id="content_table" bgcolor="#ffafa" border="0" cellpadding="0"
				cellspacing="0">
				<tbody id="content_table_body">

				</tbody>
			</table>
		</div>
	</div>






	<script type="text/javascript">
		var xmlHttp;
		//创建一个xml对象
		function creatXMLHttp() {
			var xmlHttp;
			if (window.XMLHttpRequest) {
				xmlHttp = new XMLHttpRequest();
			}
			if (window.ActiveXObject) {
				xmlHttp = new ActiveXObject("Mycrosoft.XMLHTTP");
				if (!xmlHttp) {
					xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
				}
			}
			return xmlHttp;
		}
		//前端keyup事件触发这个函数
		function getMoreContents() {
			var content = document.getElementById("keyword");
			if (content.value == "") {
				//如果查到了数据是空那也需要清空一下查询结果，比如回车键按下就得清空重新查询
				clearContent();
				return;
			} else {
				xmlHttp = creatXMLHttp();
				var url = "search?keyword=" + escape(content.value);
				xmlHttp.open("GET", url, true);
				xmlHttp.onreadystatechange = callback;//调用回调函数，返回数据
				xmlHttp.send(null);

			}
		}
		//后台返回数据给js，js做个判断返回给页面	
		function callback() {
			if (xmlHttp.readyState == 4) {
				if (xmlHttp.status == 200) {
					var result = xmlHttp.responseText;
					var json = eval("(" + result + ")");
					setContent(json);//调用了数据解析，经过处理返回给页面
				}
			}
		}
		//设置查询内容的函，得到数据之后怎么去返回给前端
		function setContent(contents) {
			clearContent();//调用清空结果函数
			setLocation();//调用设置位置函数
			var size = contents.length;
			for (var i = 0; i < size; i++) {
				var nextNode = contents[i];
				var tr = document.createElement("tr");
				var td = document.createElement("td");
				td.setAttribute("border", "0");
				td.setAttribute("bgcolor", "#FFFAFA");
				td.onmouseover = function() {
					this.className = 'mouseOver';
				}
				td.onmouseout = function() {
					this.className = 'mouseOut';
				}
				td.onclick = selectserch;//补全搜索框信息

				var text = document.createTextNode(nextNode);
				td.appendChild(text);
				tr.appendChild(td);
				document.getElementById("content_table_body").appendChild(tr);
			}

		}
		//清空查询结果，也就是删除创建的节点
		function clearContent() {
			var contentTableBody = document
					.getElementById("content_table_body");
			var size = document.getElementById("content_table_body").childNodes.length;
			for (var i = size - 1; i >= 0; i--) {
				contentTableBody.removeChild(contentTableBody.childNodes[i]);
			}
			document.getElementById("popDiv").style.border = "none";
		}
		//点击鼠标就输入框就补全按信息
		function selectserch() {
			var vvv = this.innerHTML;
			document.getElementById("keyword").value = vvv;
		}
		function setLocation() {

			var content = document.getElementById("keyword");
			var width = content.offsetWidth;
			var left = content["offsetLeft"];
			var top = content["offsetTop"] + content.offsetHeight;
			var popDiv = document.getElementById("popDiv");
			popDiv.style.border = "black 1px solid";
			popDiv.style.left = left + "px";
			popDiv.style.top = top + "px";
			popDiv.style.width = width + "px";
			document.getElementById("content_table").style.width = width + "px";
		}

		function baidu() {
			alert("baidu");
		}
	</script>
</body>
</html>