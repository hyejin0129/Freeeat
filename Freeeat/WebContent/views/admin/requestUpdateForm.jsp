<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, com.freeeat.place.model.vo.Place, com.freeeat.place.model.vo.PlaceMenu, 
com.freeeat.place.model.vo.PlacePhoto, com.freeeat.place.model.vo.Request" %>
<% 
    Place place = (Place)request.getAttribute("place"); 
    ArrayList<PlaceMenu> list = (ArrayList<PlaceMenu>)request.getAttribute("list");
    PlacePhoto photo = (PlacePhoto)request.getAttribute("photo");
    
    Request r = (Request)request.getAttribute("r");
%>
<!DOCTYPE html>
<html>

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>수정 요청</title>
    <style>
        * {
            box-sizing: border-box;
        }

        .wrap {
            margin-left: 250px;
            padding: 50px;
        }

        .inner-wrap {
            width: 90%;
            border: 1px solid silver;
            border-radius: 10px;
            padding: 20px;
            margin: auto;
        }

        #mainContent {
            width: 90%;
            margin-top: 30px;
            margin: auto;
        }

        /*header 영역(첫번째 div)*/
        #header {
            width: 100%;
            display: flex;
            margin-top: 40px;
        }

        #header-left {

            width: 55px;
            height: 55px;
            margin-left: 20px;
            padding-top: 5px;
        }

        #header-center {
            width: 23%;
            font-size: 45px;
            margin-left: 15px;
        }

        #header-right {
            width: 450px;
            margin-top: 25px;
            margin-left: 665px;
        }

        .place-btn {
            width: 90px;
            height: 35px;
            border: 2px solid #ddd;
            margin-left : 170px;
            cursor: pointer;
        }

        .place-btn:hover,
        #back:hover {
            background-color: rgb(205, 205, 205);
        }

        #placeTable,
        #request-table {
            border-collapse: collapse;
            width: 100%;
            border: 1px solid #ddd;
            font-size: 18px;
            margin-top: 50px;
        }

        #request-table2 {
            border-collapse: collapse;
            width: 100%;
            border-left: 1px solid #ddd;
            border-right: 1px solid #ddd;
            border-bottom: 1px solid #ddd;
            font-size: 18px;
        }

        #placeTable th,
        #request-table th,
        #request-table2 th {
            text-align: center;
            padding: 12px;
        }

        #request-table2 th {
            text-align: center;
            padding-top: 12px;
            padding-left: 5px;
            padding-right: 12px;
            padding-bottom: 12px;
        }

        #placeTable td,
        #request-table td,
        #request-table2 td {
            text-align: left;
            padding: 17px 10px 17px 75px;

        }

        #placeTable input {
            text-align: left;
            font-size: 11pt;
            padding: 3px;
            margin-left: 3px;
        }

        .longInput {
            width: 90%;
            height: 40px;
        }

        #placeTable tr,
        #request-table tr,
        #request-table2 tr {
            border-bottom: 1px solid #ddd;
        }

        .textarea {
            width: 90%;
            height: 6.25em;
            resize: none;
        }

        #back {
            	margin-top: 10px;
                margin-left: 575px;
                width: 70px;
                height: 40px ;
                border-style: none;
            }
    </style>
</head>

<body>

    <%@ include file="../common/adminMenubar.jsp" %>
        <div class="wrap">
            <div class="inner-wrap">
                <div id="mainContent">
                        <div id="header">
                            <div><img src="<%= contextPath %>/resources/image/update.png" id="header-left"></div>
                            <div id="header-center">수정요청</div>
                            <div id="header-right">
                                <button type="button" class="place-btn" id="update">수정하기</button>
                            </div>
                        </div>

                        <hr style="border: 1px solid #ddd">
                        <div>
                            <table id="request-table">
                                <colgroup>
                                    <col style="width: 15%;" />
                                    <col style="width: 35%;" />
                                    <col style="width: 15%;" />
                                    <col style="width: 35%;" />
                                </colgroup>

                                <tr>
                                    <th>No.</th>
                                    <td><%=r.getRequesetNo() %></td>
                                    <th>요청일자</th>
                                    <td><%=r.getRequestDate() %></td>
                                </tr>
                                <tr>
                                    <th>식당명</th>
                                    <td><%=r.getPlaceName() %></td>
                                    <th>요청자</th>
                                    <td><%=r.getMemId() %></td>
                                </tr>
                            </table>

                            <table id="request-table2">
                            	<colgroup>
                                    <col style="width: 16%;" />
                                    <col style="width: 34%;" />
                                    <col style="width: 15%;" />
                                    <col style="width: 35%;" />
                                </colgroup>
                                <tr>
                                    <th>요청내용</th>
                                    <td colspan="3"><%=r.getRequestContent() %></td>
                                </tr>
                            </table>
                        </div>
                        
                        <form action="" method="post">
                        	<input type="hidden" name = "reqNo" value="<%=r.getRequesetNo() %>">
                        	
	                        <div>
	                        	<table id="placeTable">
	                        		<tr>
	                                	<th>No.</th>
	                                    	<td id="pno" ><%=place.getPlaceNo() %></td>
	                                    	
	                                    <th>조회수</th>
	                                    	<td><%=place.getPlaceViews()%></td>
	                                </tr>
	                            	<tr>
	                                	<th>식당명</th>
	                                    	<td colspan="3"><%=place.getPlaceName() %></td>
	                                </tr>
	
	                                <tr>
	                                	<th>매장소개</th>
	                                    	<% if(place.getPlaceInfo() !=null){ %>
	                                        	<td colspan="3">
	                                        		<%=place.getPlaceInfo() %>
	                                            </td>
	                                        <% } else { %>
	                                        		<td colspan="3">
	                                        			정보 없음
	                                        		</td>
	                                        <% } %>
	                                </tr>
	
	                                <tr>
	                                	<th>주소</th>
	                                	<td colspan="3">
	                                		<%=place.getPlaceAddress() %>
	                                	</td>
	                                </tr>
	
	                                <tr>
	                                	<th>업종</th>
	                                    	<% if(place.getPlaceKind().equals("식당")) {%>
	                                        	<td colspan="1">
	                                            	<label for="kind1">
	                                            		<input type="radio" id="kind1" name="placeKind" value="식당"
	                                                    	checked="checked"> 식당
	                                                    </label>
	                                            </td>
	
	                                            <td colspan="2">
	                                            	<label for="kind2">
	                                            		<input type="radio" disabled> 카페
	                                                </label>
	                                            </td>
	                                        <% } else { %>
	                                        		<td colspan="1">
	                                                		<input type="radio" id="kind1"
	                                                        	name="placeKind" value="식당" disabled> 식당
	                                                </td>
	
	                                                <td colspan="2">
	                                                    	<input type="radio" id="kind2"
	                                                        	name="placeKind" value="카페" checked="checked"> 카페
	                                                </td>
	                                        <% } %>
	                                </tr>
	
	                                <tr>
	                                	<th>영업시간</th>
	                                	<td colspan="3">
	                                		<%=place.getPlaceTime() %>
	                                	</td>
	                                </tr>
	
	                                <tr>
	                                	<th>휴무일</th>
	                                    	<% if(place.getPlaceDayoff() != null){ %>
	                                        	<td colspan="3">
	                                        		<%=place.getPlaceDayoff() %>
	                                            </td>
	
	                                        <% } else { %>
	                                        	<td colspan="3">
	                                        		정보 없음
	                                            </td>
	                                        <% } %>
	                                </tr>
	
	                                <tr>
	                                	<th>주차</th>
	                                    	<% if(place.getPlaceParking().equals("N")) {%>
	                                        	<td colspan="1">
	                                            	<input type="radio" id="parking1"
	                                                                    name="placeParking" checked="checked"> 불가능
	                                            </td>
	
	                                            <td colspan="2">
	                                                            <label for="parking2"><input type="radio" id="parking2"
	                                                                    name="placeParking" value="Y" disabled> 가능</label>
	                                            </td>
	                                        <% } else { %>
	                                        		<td colspan="1">
	                                                	<input type="radio" disabled> 불가능</label>
	                                                </td>
	
	                                                <td colspan="2">
	                                                              <input type="radio" checked="checked"> 가능
	                                                </td>
	                                        <% } %>
	                                        
	                                        </tr>
	                                        
	                                        <tr>
	                                        	<th>연락처</th>
	                                            	<td colspan="3">
	                                            		<%=place.getPlacePhone()%>
	                                                </td>
	                                        </tr>
	
	                                        <% for(int i = 0; i < list.size(); i++) { %>
	                                        <tr>
	                                        	<%if(i == 0){%>
													<th rowspan="<%=list.size()%>">메뉴</th>
												<% } %>
												
		                                        	<td>타입 :<%=list.get(i).getMenuType()%></td>
		                                            <td>메뉴명 :<%=list.get(i).getMenuName()%></td>
		                                            <td>가격(원) : <%=list.get(i).getPrice()%></td>
	                                        </tr>
	                                        <% } %>
	
	                                        <tr>
	                                        	<th>사진</th>
	                                            	<% if(photo != null) { %>
	                                                	<td>
	                                                    	<img id="placeImg" 
	                                                        	src="<%=contextPath%>/<%= photo.getFilePath()  + photo.getChangeName() %>">
	                                                    </td>
	
	                                                <% } else { %>
	                                                	<td>
	                                                    	<img id="placeImg"
	                                                         	src="<%=contextPath%>/resources/image/noImg.png">
	                                                    </td>
	                                                <% } %>
	                                        </tr>
	                        	  </table>
	                          </div>
						  </form>
						  
                        <button id="back" class="udpateInfo-btn" onclick="history.back();">목록</button>

                </div>

            </div>
        </div>

        <script>
            function myFunction() {

            }
        </script>

</body>

</html>