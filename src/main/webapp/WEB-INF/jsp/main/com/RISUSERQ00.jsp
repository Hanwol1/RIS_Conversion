<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 초기화</title>
<link rel="stylesheet" type="text/css" href="/css/com/com.css" />
</head>
<body>
<main class="main__container">
      <!-- 검색 -->
      <section class="search__container">
        <p class="filter__keyword">사용자 명 :</p>
        <input type="text" class="filter__options" id="search" placeholder="Enter text to search..."></input>
        <button class="all__btn img__btn fontawesome__btn search__icon">검색</button>
      </section>

      <!-- 그리드 타이틀 -->
      <div class="grid__title">
        <p>사용자 현황</p>

        <!-- 버튼 컨테이너 -->
        <div class="btn__container">
        <button class="all__btn text__btn">비밀번호 초기화</button>
        	<button class="all__btn img__btn fontawesome__btn update__icon">수정</button>
        	<button class="all__btn img__btn fontawesome__btn insert__icon" id="add-row__btn">입력</button>
		    <button class="all__btn img__btn fontawesome__btn delete__icon" id="delete-row__btn">삭제</button>
    		<button class="all__btn img__btn fontawesome__btn save__icon">저장</button>
        </div>
      </div>
      <!-- 그리드 -->
      <div class="grid__container">
        <section class="grid__box">
          <!-- 그리드 -->
          <table id="list1" class="grid1"></table>
        </section>
      </div>
    </main>

    <script>
    $(document).ready(function () {
        $("#list1").jqGrid({
        	url: "/RISUSERQ00.do",   // 서버주소 
            reordercolNames:true,
            postData : { type: 'A' }, // 보낼 파라미터
            mtype:'POST',   // 전송 타입
            datatype: "json",
            colNames: ["flag", "사용자ID", "사용자명", "비밀번호", "권한", "시작일", "종료일", "오류횟수"],
            colModel: [
            	{ name: 'flag', index: 'flag', hidden: true },
                { name: "loginId", index: "loginId", width: 120, align: "center" },
                { name: "loginNm", index: "loginNm", width: 120, align: "center" },
                { name: "loginPwd", index: "loginPwd", width: 150, align: "center" },
                { name: "userGrade", index: "userGrade", width: 100, align: "center" },
                { name: "startDate", index: "startDate", width: 120, align: "center" },
                { name: "endDate", index: "endDate", width: 120, align: "center" },
                { name: "errorCnt", index: "errorCnt", width: 50, align: "center" }
            ],
            jsonReader: 
 		    {
 			    repeatitems: false, //서버에서 받은 data와 Grid 상의 column 순서를 맞출것인지?
 			    root:'rows', //서버의 결과 내용에서 데이터를 읽어오는 기준점
 			    records:'records'  // 보여지는 데이터 갯수(레코드) totalRecord 
 		    },
	        guiStyle: "bootstrap",
	        autowidth: true,
	        height: "94%",
	        rownumbers: true,
	        sortname: "id",
	        sortorder: "asc",
	        rownumbers: true,
	        gridview: true, // 선표시 true/false
	        viewsortcols: [true, "vertical", true],
	        loadComplete: function (data) {
	            console.log(data);
	        }, // loadComplete END
	        onSelectRow: function (rowid) {
	            console.log(rowid);
	        },
	        onSortCol: function (index, idxcol, sortorder) {
	            // 그리드 Frozen Column에 정렬 화살표 표시 안되는 버그 수정
	            // (화살표 css 변경하기 전 Frozen을 풀어주고)
	            $("#list1").jqGrid("destroyFrozenColumns");
	            var $icons = $(this.grid.headers[idxcol].el).find(
	                ">div.ui-jqgrid-sortable>span.s-ico"
	            );
	            if (this.p.sortorder === "asc") {
		            //$icons.find('>span.ui-icon-asc').show();
		            $icons.find(">span.ui-icon-asc")[0].style.display = "";
		            $icons.find(">span.ui-icon-asc")[0].style.marginTop = "1px";
		            $icons.find(">span.ui-icon-desc").hide();
	            } else {
		            //$icons.find('>span.ui-icon-desc').show();
		            $icons.find(">span.ui-icon-desc")[0].style.display = "";
		            $icons.find(">span.ui-icon-asc").hide();
		        }
		        // (화살표 css 변경 후 Frozen을 다시 설정)
		        $("#list1").jqGrid("setFrozenColumns");
		        //alert(index+'/'+idxcol+'/'+sortorder);
	        },
	   	});
        $("#add-row__btn").on("click", function () {
        	var newRowData = {};
        	var grid = $("#list1");
    	    var newRowId = grid.jqGrid("getGridParam", "reccount") + 1;
    	    grid.jqGrid("addRowData", newRowId, newRowData, "first");
    	    newRowData.flag = 'I';
        });
        $("#delete-row__btn").on("click", function () {
        	var grid = $("#list1");
    	    var selectedRowId = grid.jqGrid('getGridParam', 'selrow');
    	    if (selectedRowId) { grid.jqGrid('delRowData', selectedRowId);
    	    } else { alert('Please select a row to delete.'); }
        });
	});
    
    

    
    
    
    </script>
</body>
</html>