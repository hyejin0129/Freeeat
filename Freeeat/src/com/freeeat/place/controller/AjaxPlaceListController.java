package com.freeeat.place.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.freeeat.place.model.dao.PlaceDao;
import com.freeeat.place.model.service.PlaceService;
import com.freeeat.place.model.vo.Place;
import com.google.gson.Gson;

/**
 * Servlet implementation class AjaxPlaceListController
 */
@WebServlet("/placelist.yk")
public class AjaxPlaceListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxPlaceListController() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sort = request.getParameter("sort");
        sort = sort.equals("all") ? "A" : sort.equals("wait") ? "W" : sort.equals("check") ? "Y','N" : "D";
        response.setContentType("application/json; charset=UTF-8");
        new Gson().toJson(new PlaceService().placeSelectList(sort), response.getWriter());
     }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
