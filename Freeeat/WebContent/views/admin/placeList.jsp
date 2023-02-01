<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList, com.freeeat.place.model.vo.Place" %>
<% 
    String alertMsg = (String)session.getAttribute("alertMsg");
%>
<!DOCTYPE html>
   <html>

      <head>
       <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>식당_목록</title>

        <style>
        * { box-sizing: border-box;}

            .wrap {
                margin-left: 250px;
                 padding: 50px;
            }

            .inner-wrap {
               width: 1430px;
               border: 1px solid silver;
               border-radius: 10px;
               padding: 20px;
               margin: auto;
           }
   
           #mainContent {
               width: 1287px;
               margin-top: 30px;
               margin: auto;
           }

            /*header 영역(첫번째 div)*/
            #header {
               width: 100%;
                display: flex;
                margin-top: 40px;
            }
            
         #placelogo {
               width: 55px;
               height: 55px;
               margin-left: 20px;
               padding-top: 5px;
            }
            #header-center {
               width: 200px;
                font-size: 45px;
                margin-left: 15px;
            }

            #header-right {
               width: 600px;
               margin-top: 7px;
               margin-left: 100px;
            }
            
            #searchInput {
                width: 500px;
                font-size: 16px;
                padding: 6px 0px 6px 40px;
                border: 1px solid #ddd;
                margin-bottom: 16px;
                margin-top: 7px;
            }

            #searchBtn {
                width: 88px;
                height: 40px;
                font-size: 16px;
                cursor: pointer;
                margin-top: 7px;
                border: none;    
           }
           
           #searchBtn:hover{
                 background-color: rgb(205, 205, 205);
           }

           /* 두번째 div */
           #content {
                  width: 100%;
                height: 40px;
                margin-top: 30px;
                display: flex;
           }

           #content div {
                width: 200px;
                display: flex;
          }

        #count{
              margin-top : 9px;
              margin-left : 15px;
        }
        
          .place-btn {
                width: 50px;
               height: 30px;
               margin-top: 6px;
               margin-right: 6px;
               border-style: none;
               cursor: pointer;
          }

          .place-btn:hover,
          .manage:hover {
                 background-color: rgb(205, 205, 205);
          }

          #sort {
               width: 100px;
               height: 30px;
               margin-left: 1010px;
               margin-top: 7px;
          }

          /* 세번째 div */
          #placeTable {
               border-collapse: collapse;
               width: 100%;
               font-size: 18px;
               margin-top: 5px;
          }

          #placeTable th,
          #placeTable td {
               text-align: left;
               padding: 12px;
               text-align: center;
          }

          td img {
               width: 20px;
               height: 20px;
          }

          #placeTable tr {
               border-bottom: 1px solid #ddd;
          }

          .tHeader,
          .manage{
                  background-color: #f1f1f1;
          }
          
          .manage{
                border: none;
               font-size: 12pt;
               cursor: pointer;
          }

       </style>
    </head>

    <body>
       <%@ include file="../common/adminMenubar.jsp" %>
       
        </script>
          <div class="wrap">
             <div class="inner-wrap">
                <div id="mainContent">
                   <div id="header">
                      <div>
                         <img src="<%= contextPath %>/resources/image/place.png" id="placelogo">
                      </div>
                      <div id="header-center">식당</div>
                      <div id="header-right">
                         <input id="searchInput" type="text" placeholder="Search for 식당명..">
                         <button id="searchBtn" onclick="search()">검색</button>
                      </div>
                   </div>

                   <hr style="border: 1px solid #ddd">

                   <div id="content">
                      <div>
                         <button id="delete" class="place-btn">삭제</button>
                         <p id=count></p>
                      </div>

                      <select id="sort">
                         <option value="all">전체</option>
                         <option value="wait">대기중</option>
                         <option value="check">완료</option>
                         <option value="delete">삭제</option>
                      </select>

                   </div>

                   <table id="placeTable">
                      <thead>
                         <tr class="tHeader">
                            <th style="width: 5%;"></th>
                            <th style="width: 8%;">No.</th>
                            <th style="width: 12%;">업종</th>
                            <th style="width: 28%;">식당명</th>
                            <th style="width: 22%;">타입</th>
                            <th style="width: 15%;">관리</th>
                            <th style="width: 10%;">승인</th>
                         </tr>
                      </thead>

                      <tbody>

                      </tbody>
                   </table>

                   <br>

                </div>
             </div>
          </div>

          <script>
              
          $('#sort').change(function(){
              placeSelectList();
           });

           function placeSelectList() {
           
                    $.ajax({
                       url: 'placelist.yk', 
                       data :{sort: $('option:selected').val()},
                       success: function (list) {
                          placeList(list);
                       },
                       error: function () { // 통신 실패로 인해 에러페이지로 이동
                          alert("조회 실패");
                          location.href="<%=contextPath%>/views/common/errorPage.jsp";
                     }
                  });
                };
           
           $(function () {
               placeSelectList();
           });
           
           function placeList(list) {
           
              var result = '';
              var count = "<b>총 "+ list.length+ "건</b>";
                               
                 $('#count').html(count);
                  
                  if(list.length > 0) { 
                      
                     for (var i in list) {
                         
                        if(list[i].placeStatus == 'D'){
                             result += '<tr><td><input type="checkbox" disabled></td>'
                        }else{
                             result += '<tr><td><input type="checkbox"></td>'
                        } 
                           result += '<td>' + list[i].placeNo + '</td>' 
                                   + '<td>' + list[i].placeKind + '</td>'
                                  + '<td>' + list[i].placeName + '</td>'
                                  + '<td>' + (list[i].placeType).replace(/,/g, " ") + '</td>'
                                  + '<td><button class="manage" onclick="manage(this);">수정/삭제 </button></td>';
                          
                        if (list[i].placeStatus == 'W') {
                           result += "<td><img class='status' value='W' src=" + '<%= contextPath %>/resources/image/waiting.png' + "></td></tr>";
                        } else if (list[i].placeStatus == 'Y') {
                           result += "<td><img class='status' value='Y' src=" + '<%= contextPath %>/resources/image/check.png' + "></td></tr>";
                        } else if (list[i].placeStatus == 'N') {
                           result += "<td><img class='status' value='N' src=" + '<%= contextPath %>/resources/image/refuse.png' + "></td></tr>";
                        } else if (list[i].placeStatus == 'D') { 
                          result += "<td>삭제</td></tr>";
                          }
                      }
                     
                 } else {                  
                          result = "<tr><td colspan='6'>조회된 결과 없음</td></tr>";
                 } 
                
                  $('#placeTable tbody').html(result);  
            }
           
           // 수정/삭제 버튼 누르면 식당관리 페이지로 이동
             function manage(e) { 

                var pno = $(e).parent().siblings().eq(1).text();
              
                var status = $(e).parent().next().find($('.status')).attr('value'); //val() > input태그만

                location.href = "<%=contextPath%>/placeManageForm.yk?pno=" +pno;
             };
         
             // 키워드로 검색
             $("#searchInput").keyup(function (key) {
                $("#searchBtn").click();
             });
             
             // 입력 후, 버튼으로 키워드 검색
             function search() {  

                $.ajax({
                   url: 'placeSearch.yk',
                   data: { keyword: $('#searchInput').val() },
                   success: function (list) { placeList(list) },
                   error: function () { // 통신 실패로 인해 에러페이지로 이동   
                      location.href = "<%=contextPath%>/views/common.errorPage.jsp"
                   }
                });
             };
           
             // 삭제 버튼 눌렀을 떄, 
             $('#delete').click(function(){
                 var answer;
                var check = ""
                  
                    answer = confirm("데이터를 삭제하시겠습니까?");
                
                  if (answer == true) {
                     $('input:checked').each(function(){
                        
                          check += $(this).parent().next().text()+',';
                      });
                     
                  if(check.length>0){
                      
                      $.ajax({
                              url: 'placeCheckDelete.yk',
                              data: { 'check' : check},
                              type:'post',
                              success: function (result) { 
                                    
                                 if(result > 0) {placeSelectList();}
                                 else{
                                    alert('삭제 실패');
                                 }},
                                 error: function () {
                                    location.href = "<%=contextPath%>/views/common.errorPage.jsp"
                                 }
                       });
                     }
                  else{
                     alert("삭제할 식당을 체크하세요.");
                  } 
                 }    
             });

          </script>

   </body>
</html>