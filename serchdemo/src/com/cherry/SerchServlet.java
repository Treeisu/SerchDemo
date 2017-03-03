package com.cherry;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
public class SerchServlet extends HttpServlet{
	static List<String> datas=new ArrayList();
	static{
		datas.add("ajax");
		datas.add("ajax post");
		datas.add("cherry");
		datas.add("hello");
		datas.add("ajax get ");
	}
	@Override
	protected void doGet(HttpServletRequest req,HttpServletResponse resp)throws ServletException,IOException{
		req.setCharacterEncoding("utf-8");
		resp.setCharacterEncoding("utf-8");
		String keyword=req.getParameter("keyword");
		List<String> listData=getData(keyword);
		//∑µªÿjson∏Ò Ω
		JSONArray.fromObject(listData);
		resp.getWriter().write(JSONArray.fromObject(listData).toString());
		System.out.println(JSONArray.fromObject(listData));
		
	}
	
	public List<String> getData(String keyword){
		List<String> list=new ArrayList<String>();
		for(String data:datas){
			if(data.contains(keyword)){
				list.add(data);
			}
		}	
		return list;
		
	}
}
