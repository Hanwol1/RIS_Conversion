<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>사용자별 메뉴 관리</title>
    <link rel="stylesheet" type="text/css" href="/css/com/com.css" />
  </head>
  <body>
    <main class="main__container">
      <!-- 검색 -->
      <section class="search__container">
        <p class="filter__keyword">검색어 입력 :</p>
        <input type="text" class="filter__options" id="search" placeholder="Enter text to search..."></input>
        <button class="all__btn img__btn fontawesome__btn search__icon">검색</button>
      </section>

      <div class="grid__container main__container-twoGrid">
        <div class="leftGrid__container">
          <!-- 그리드 타이틀 -->
          <div class="grid__title">
            <p>사용자 정보 목록</p>
          </div>
          <!-- 그리드 박스 -->
          <div class="twoGrid__box">
            <section class="grid__box">
              <!-- 그리드 -->
              <table id="list1" class="grid1"></table>
            </section>
          </div>
        </div>

        <div class="rightGrid__container">
          <!-- 그리드 타이틀 -->
          <div class="grid__title">
            <p>해당 프로그램 목록</p>

            <!-- 버튼 컨테이너 -->
            <div class="btn__container">
             	<button class="all__btn img__btn fontawesome__btn update__icon" id="update-row__btn">수정</button>
        		<button class="all__btn img__btn fontawesome__btn insert__icon" id="add-row__btn">입력</button>
		    	<button class="all__btn img__btn fontawesome__btn delete__icon" id="delete-row__btn">삭제</button>
    			<button class="all__btn img__btn fontawesome__btn save__icon" id="save__btn">저장</button>
            </div>
          </div>
          <!-- 그리드 박스 -->
          <div class="twoGrid__box">
            <section class="grid__box">
              <!-- 그리드 -->
              <table id="list2" class="grid1"></table>
            </section>
          </div>
        </div>
      </div>
    </main>

    <script>
      	$(document).ready(function () {
      		var hsptId = "${hspt_id}";
    	  	$("#list1").jqGrid("GridUnload");
      		$("#list1").jqGrid({
	        	url: "/RISUSERMENU.do",   // 서버주소 
	            reordercolNames:true,
	            postData : { hsptId: hsptId }, // 보낼 파라미터
	            mtype:'POST',   // 전송 타입
	            datatype: "json",
	          	colNames: ["hsptId", "사용자ID", "사용자명", "권한", "유효여부"],
	          	colModel: [
	          		{ name: "hsptId", index: "hsptId", hidden: true },
		            { name: "loginId", index: "loginId", width: 135, align: "center" },
		            { name: "loginNm", index: "loginNm", width: 135, align: "center" },
		            { name: "mddlKrNm", index: "mddlKrNm", width: 135, align: "center" },
		            { name: "useYn", index: "useYn", width: 80, align: "center" }
	          	],
	          	jsonReader: 
			  	{
				  	repeatitems: false, //서버에서 받은 data와 Grid 상의 column 순서를 맞출것인지?
				  	root:'rows', //서버의 결과 내용에서 데이터를 읽어오는 기준점
				  	records:'records'  // 보여지는 데이터 갯수(레코드) totalRecord 
			  	},
          		guiStyle: "bootstrap",
          		autowidth: true,
          		height: "93%",
          		rownumbers: true,
          		sortname: "id",
          		sortorder: "asc",
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
	   			onCellSelect: function(rowid, iCol, cellcontent, e) {
	                $('#list1').jqGrid('setSelection',rowid);
	                Grid2(); // Grid3 함수 호출
	            }
        	});

      		
      		
      		
      		function Grid2(){
    			$('#list1').getRowData(rowid);
    	        var rowid, menuGroupId, hsptId;
    	        rowid  = $("#list1").jqGrid('getGridParam', 'selrow' );  // 선택한 열의 아이디값 */
    	        loginId = $("#list1").jqGrid('getRowData', rowid).loginId;
    	        hsptId = $("#list1").jqGrid('getRowData', rowid).hsptId;
    	        $("#list2").jqGrid("GridUnload"); // 첫 번째 조회했던 그 값으로만 조회될 때 초기화
    			$("#list2").jqGrid({
    	        	url: "/RISUSERMENU2.do",   // 서버주소 
    	            reordercolNames:true,
    	            postData : 
    	            { 
    	            	type: loginId,
    	            	type2: hsptId
    	            }, // 보낼 파라미터
    	            mtype:'POST',   // 전송 타입
    	            datatype: "json",
    	            colNames: ["flag", "메뉴그룹ID", "메뉴그룹명", "메뉴ID", "메뉴명", "메뉴권한", "사용여부", "정렬순서"],
    	            colModel: [
    	            	{ name: 'flag', index: 'flag', hidden: true },
    	            	{
    	            	    name: "menuGroupId",
    	            	    index: "menuGroupId",
    	            	    width: 100,
    	            	    align: "center"
    	            	},
    	              	{ name: "menuGroupName", index: "menuGroupName", width: 150, align: "center" },
    	              	{ name: "menuId", index: "menuId", width: 100, align: "center" },
    	              	{ name: "menuName", index: "menuName", width: 150, align: "center" },
    	              	{ 
    	            	  	name: "menuGrade",
    	            	  	index: "menuGrade", 
    	            	  	width: 80,
    	            	  	align: "center",
   	            		  	editable: true,
			    	 		edittype: 'select',
			    	 		editoptions: { value: "W:등록; V: 조회" },
    	              	},
    	              	{ 
    	              		name: "useYn",
    	              		index: "useYn",
    	              		width: 50,
    	              		align: "center",
   	              			editable: true,
   	    	                edittype: 'checkbox', // 체크박스로 설정
   	    	                editoptions: { value: 'Y:N' } // 체크 시 'Y', 언체크 시 'N' 값으로 저장
    	              	},
    	              	{ name: "otptSqnc", index: "otptSqnc", width: 50, align: "center" }
    	            ],
    	          	jsonReader: 
    			  	{
    				  	repeatitems: false, //서버에서 받은 data와 Grid 상의 column 순서를 맞출것인지?
    				  	root:'rows', //서버의 결과 내용에서 데이터를 읽어오는 기준점
    				  	records:'records'  // 보여지는 데이터 갯수(레코드) totalRecord 
    			  	},
    	          	guiStyle: "bootstrap",
    	          	autowidth: true,
    	          	height: "93%",
    	          	rownumbers: true,
    	          	gridview: true, // 선표시 true/false
    	          	loadComplete: function (data) {
    	            	console.log(data);
    	          	}, // loadComplete END
    	          	onSelectRow: function (rowid) {
    	            	console.log(rowid);
    	          	}
    	        });
      		};
      	});
      	

      	
	    // 그리드2 행 수정
	    $("#update-row__btn").on("click", function(){
	    	var selectedRowId = $("#list2").jqGrid("getGridParam", "selrow");
	        if (selectedRowId) {    	  	  	
	        	// 선택한 행이 있는 경우 편집 모드로 진입
	            var grid = $("#list2");
	            var rowData = grid.jqGrid('getRowData', selectedRowId);
			    rowData.flag = 'U';
			    grid.jqGrid('setRowData', selectedRowId, rowData);
			    console.log("list2 데이터 : ", rowData);
	            // 모든 컬럼을 가져옵니다.
	            var allColumns = grid.jqGrid('getGridParam', 'colModel');
	            
	            // 모든 컬럼을 편집 모드에서 제외
	            allColumns.forEach(function (column) {
	                grid.jqGrid('setColProp', column.name, { editable: false });
	            });
	            
	            // 선택한 컬럼만 편집 모드로 진입
	            var selectedColumns = ['menuName', 'menuGrade', 'useYn', 'otptSqnc']; // 편집 가능한 컬럼 이름들로 대체
	            selectedColumns.forEach(function (columnName) {
	                grid.jqGrid('setColProp', columnName, { editable: true });
	            });
	            
	            // 선택한 행을 편집 모드로 진입
	            grid.jqGrid('editRow', selectedRowId, {
	                keys: true, // 엔터 키를 누를 때 저장되도록 설정
	                focusField: 1 // 수정을 시작할 필드의 인덱스를 설정
	            });
	        } else {
	            alert("편집할 행을 먼저 선택하세요.");
	        }
		})
      	
      	
     	// 그리드 입력
  		$("#add-row__btn").on("click", function () {
        	var newRowData = {};
        	var grid = $("#list2");
        	var selectedRowId = $("#list1").jqGrid("getGridParam", "selrow");
    	    var rowData = grid.jqGrid('getRowData', selectedRowId);
    	    var newRowId = grid.jqGrid("getGridParam", "reccount") + 1;
    	    newRowData.flag = 'I';
    	    
    	    grid.jqGrid("addRowData", newRowId, newRowData, "first");
    	    
    	 	// 모든 컬럼을 가져옵니다.
    	    var allColumns = grid.jqGrid('getGridParam', 'colModel');
    	    
    	    // errorCnt 컬럼을 제외하고 모든 컬럼을 편집 가능하게 설정합니다.
    	    allColumns.forEach(function (column) {
    	            grid.jqGrid('setColProp', column.name, { editable: true });
    	    });
    	    
    	    // 선택한 행을 편집 모드로 진입합니다.
    	    grid.jqGrid("editRow", newRowId, {
    	        keys: true,  // 엔터 키를 누를 때 저장되도록 설정합니다.
    	    });
    	    
    	    grid.jqGrid('setRowData', newRowId, { "menuGroupId": '<button class="all__btn fontawesome__btn list__icon" onclick="openPopup()"></button>'});
        });
	    
	 	// 팝업 열기
	    function openPopup() {
	        // 팝업 창에 표시할 URL
	        var url = "/RISUSERMENU_POP.do";

	        // 팝업 창의 크기와 위치 설정
	        var width = 800;
	        var height = 400;
	        var left = (window.innerWidth - width) / 2;
	        var top = (window.innerHeight - height) / 2;

	        // 팝업 창을 열기
	        var popup = window.open(url, "팝업 창", "width=" + width + ",height=" + height + ",left=" + left + ",top=" + top);

	        // 팝업 창이 차단되었을 때 처리
	        if (!popup || popup.closed || typeof popup.closed == 'undefined') {
	            alert("팝업 차단이 감지되었습니다. 팝업 차단을 해제해주세요.");
	        }
	    }
	 	
	 	// 부모 창에서 정의된 함수
	    function ReturnSelValue(menuGroupId, menuName) {		
	        // 함수 내에서 선택한 데이터를 처리하고 원하는 작업을 수행합니다.
	        console.log("선택한 메뉴 그룹 ID:", menuGroupId);
	        console.log("선택한 메뉴 그룹명:", menuName);
	        
	        var grid = $("#list2");
        	var selectedRowId = grid.jqGrid("getGridParam", "selrow");
    	    var rowData = grid.jqGrid('getRowData', selectedRowId);

    	    rowData.menuGroupId = menuGroupId;
    	    rowData.menuGroupName = menuName;

    	    grid.jqGrid('setRowData', selectedRowId, rowData);
	    }
	    
	    // 삭제
        $("#delete-row__btn").on("click", function () {
        	var grid = $("#list2");
    	    var selectedRowId = grid.jqGrid('getGridParam', 'selrow');
    	    if (selectedRowId) { 
    	    	alert('삭제할 수 없는 데이터입니다.');
    	    } else { 
    	    	alert('Please select a row to delete.');
    	    }
        });
	    
     	// 저장
        $("#save__btn").click(function () { 
        	console.log('저장 버튼 눌림');
    	    var totalRows = $("#list2").jqGrid('getGridParam', 'records');
    	    for (var i = 1; i <= totalRows; i++) {
    	    	let data1 = $("#list2").jqGrid("getRowData", i);
				console.log(data1);    	    	
    	        $("#list2").jqGrid('saveRow', i, false, 'clientArray');
    	        let data = $("#list2").jqGrid("getRowData", i);
    	        console.log(data); 
    	        if (data.flag === 'U' || data.flag === 'I') {
    	            if (data.menuGroupId === '' || data.menuGroupName === '' || data.menuId === ''
    	                || data.menuName === '' || data.menuGrade === '') {
    	                alert('미입력 사항이 있습니다.');
    	                return;
    	            }
    	        }
    	    }
			
    	    var list1Data = $("#list1").getRowData();
    	    console.log(list1Data);
        })
	    
	    
      	
     	// 검색 기능
    	const searchGrid = function(value, grid) {
    		// searchGrid 함수는 검색어(value)와 데이터 그리드(grid)의 ID를 인수로 받고,
    		// 데이터 그리드를 검색어로 필터링하고 새로 고침하는 역할을 한다.			
    		$("#" + grid).jqGrid("setGridParam", {
    			datatype: "json", 
    			page: 1
    		}).trigger("reloadGrid");
    		// 파라미터를 설정하고, 새로고침하여 페이지를 1로 설정하고, 데이터 타입을 JSON으로 변경한다.
    		
    		$("#" + grid).jqGrid("setGridParam", {
    			// beforeProcessing 은 데이터를 처리하기 전에 호출되며, 데이터 그리드를 필터링한다.
    			beforeProcessing: function(data) {
    				if (value === "") {
    					return;
    				}
    				var filteredData = [];
    				for (var i = 0; i < data.rows.length; i++) {
    					var rowData = data.rows[i];
    					var matched = false;
    					for (var key in rowData) {
    						var cellValue = rowData[key];
    						if (cellValue && cellValue.toString().replace(/\s+/g, "").toLowerCase().includes(value)) {
    							matched = true;
    							break;
    						}
    					}
    					if (matched) {
    						filteredData.push(rowData);
    					}
    				}
    				data.rows = filteredData;
    			}
    		});	
    	};

    	// list1 검색
    	$("#search").on("input", function() {
    		var inputValue = $(this).val().replace(/\s+/g, "").toLowerCase();
    		
    		searchGrid(inputValue, "list1");
    	});
    	
    	
    	
    </script>
  </body>
</html>
