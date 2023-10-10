<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>공통코드관리</title>
  <link rel="stylesheet" type="text/css" href="/css/code/RIS0101E00.css"/>
</head>
<body>
<main class="main__container">
  <!-- 검색 -->
  <section class="search__container">
    <p class="filter__keyword">검색어 입력 :</p>
    <input type="text" name="searchWord" maxlength="30" />
    &nbsp; &nbsp;<button class="all__btn img__btn search__btn" onclick="jsSearch();">검색</button>
  </section>

  <form id="lrgc_listForm" name="lrgc_listForm" action="/RIS0101E01.do" method="post" onsubmit="return false">
    <input type="hidden" name="checkLMS" id="checkLMS" value="L" />
    <input type="hidden" name="hspt_id" id="hspt_id" value="" />
    <input type="hidden" name="lrgc_cd" id="lrgc_cd" value="" />
  </form>
  <div class="grid__container main__container-twoGrid">
    <div class="twoGrid__container">
      <!-- 그리드 타이틀 -->
      <div class="grid__title">
        <p>대분류 코드</p>
        <button class="all__btn img__btn img__btn detail__btn" id="lrgcDetail">상세</button>

        <!-- 버튼 컨테이너 -->
        <div class="btn__container">
          <button class="all__btn img__btn insert__btn" id="lrgcReg">입력</button>
        </div>
      </div>
      <!-- 그리드 -->
      <div class="twoGrid__box">
        <section class="grid__box">
          <!-- 그리드 -->
          <table id="list1" class="grid1"></table>
        </section>
      </div>
    </div>

    <div class="threeGrid__container">
      <div class="twoGrid__container threeGrid__container-subcontainer">
        <!-- 그리드 타이틀 -->
        <div class="grid__title">
          <p>중분류 코드</p>
        </div>
        <!-- 그리드 -->
        <div class="twoGrid__box threeGrid__box">
          <section class="grid__box">
            <!-- 그리드 -->
            <table id="list2" class="grid1"></table>
          </section>
        </div>
      </div>

      <div class="twoGrid__container threeGrid__container-subcontainer">
        <!-- 그리드 타이틀 -->
        <div class="grid__title">
          <p>소분류 코드</p>
        </div>
        <!-- 그리드 -->
        <div class="twoGrid__box threeGrid__box">
          <section class="grid__box">
            <!-- 그리드 -->
            <table id="list3" class="grid1"></table>
          </section>
        </div>
      </div>
    </div>
  </div>
</main>

<script>
  var i18n = JSON.parse('{"text_371":"","text_370":"","text_131":"건진","text_373":"","text_130":"입원","text_372":"","text_133":"예외구분","text_375":"","text_132":"예약 변동내역","text_374":"","text_124":"촬영실별","text_366":"","text_123":"촬영부위별","text_365":"","text_126":"예약기준 적용","text_368":"","text_125":"예약일자","text_367":"","text_128":"요일설정","text_127":"예약기준 삭제","text_369":"","text_129":"외래","text_360":"","text_120":"입원예약가능 ","text_362":"","text_361":"","text_122":"선택진료여부 ","text_364":"","text_121":"외래예약가능 ","text_363":"","text_113":"촬영부위","text_355":"","text_112":"촬영구분","text_354":"","text_115":"촬영방향","text_357":"","text_114":"통계부위","text_356":"","text_117":"입원촬영실","text_359":"","text_116":"처방코드  ","text_358":"","text_119":"이동촬영가능","text_118":"안내장서식","text_391":"","text_390":"","text_151":"희망시간","text_393":"","text_150":"희망일","text_392":"","text_153":"예약시간","text_395":"","text_152":"예약일","text_394":"","text_155":"처방참고내용","text_397":"","text_154":"처방을 선택하세요","text_396":"","text_146":"처방일","text_388":"","text_145":"환자명","text_387":"","text_148":"진료과","text_147":"처방명","text_389":"","text_149":"처방의사","text_380":"","text_140":"휴일 일자","text_382":"","text_381":"","text_142":"환자정보검색","text_384":"","text_141":"휴일 내용","text_383":"","text_144":"수납","text_386":"","text_143":"예약","text_385":"","text_135":"시작","text_377":"","text_134":"변동사유","text_376":"","text_137":"예외일자","text_379":"","text_136":"종료","text_378":"","text_139":"휴일 목록","text_138":"예외사유","text_171":"처방일","text_170":"처방상태","text_173":"접수시간","text_172":"접수일자","text_175":"수납","text_174":"응급","text_177":"검사예약현황","text_176":"DC","text_168":"참고내용","text_167":"국가","text_169":"영문명","text_160":"가예약여부","text_162":"미예약","text_161":"전체","text_164":"성별","text_163":"등록번호","text_166":"생년월일","text_165":"나이","text_157":"총 인원","text_399":"","text_156":"예약참고내용","text_398":"","text_159":"환자ID","text_158":"내원구분","text_191":"촬영구분","text_190":"정형문 코드","text_193":"공용코드","text_192":"판독약어명","text_195":"환자정보 ","text_194":"촬영일자 ","text_197":"판독시간","text_196":"판독일자","text_199":"음성판독여부","text_198":"판독의사","text_189":"의사ID","text_180":"방사선사","text_182":"병동","text_181":"영상 CD접수 관리","text_184":"재촬영","text_183":"병실","text_186":"처방 목록","text_185":"이동촬영","text_188":"처방 정보 상세","text_187":"환자 기본정보","text_179":"이동촬영접수 관리","text_178":"환자목록","message_199":"불용 처리할 정보를 선택해주세요.","message_198":"수정할 코드를 선택해주세요","message_191":"등록/수정중인 정보가 있습니다.저장 완료 후 다시 시도해주세요.","message_190":"프로그램 유형을 선택해주세요!","message_193":"대분류 코드를 입력해주세요.","message_192":"소분류 코드를 선택해주세요.","message_195":"대분류 코드 중복확인을 해주세요.","message_194":"불용일자는 적용일자보다 낮을 수 없습니다.","message_197":"중분류 자릿수를 입력해주세요","message_196":"중분류 한글 명을 입력해주세요","message_188":"해당 메뉴그룹 ID 정보가 등록되어 있습니다.","message_187":"숫자가 아닙니다.","message_189":"다른 정보를 먼저 저장해주세요.","message_180":"[구 분] 항목에서 판독을 선택 후다시 시도해주세요.","message_182":"저장 안 된정보가 있습니다. 저장하시겠습니까?","message_181":"자료 조회중입니다. 잠시만 기다리세요...","message_184":"메뉴 그룹ID 정보를 먼저 선택하세요!","message_183":"메뉴정보를 먼저 저장해주세요!","message_186":"이미 등록된 정보는 삭제가 불가합니다.","message_185":"이미 등록된 정보입니다.","message_177":"판독중인 내용이 아닙니다.","message_176":"입력하신 정보가 저장되지 않았습니다.다시 시도해주세요.","message_179":"이미 판독이 완료 되었습니다.","message_178":"판독 취소가 완료되었습니다.","message_171":"[구분] 항목에서 미판독/판독을 선택 후 다시 시도해주세요.","message_170":"의사ID를 선택해주세요","message_173":"판독이 완료된 내용은 판독의사만 수정이 가능합니다.","message_172":"이미 판독이 완료된 환자입니다.","message_175":"음성파일 또는 판독내용을 입력해주세요.","message_174":"수정버튼을 눌러주세요.","message_166":"사용자 등급이 낮아 수정할 수 없습니다.","message_165":"정형문 코드가 존재하지않습니다.","message_168":"사용자 등급이 낮아 수정할 수 없습니다.","message_167":"수정할 정보가 존재하지 않습니다.","message_169":"X번 행에 Y코드는 중복되는 코드입니다. 다른 코드를 사용해주세요.","message_160":"의사정보를 입력하세요!","message_162":"정상 저장되었습니다.","message_161":"같은날짜에 중복된 환자의 처방 정보가 있습니다. 확인해주세요.","message_164":"처방일자가 현재일자보다 과거날짜입니다.","message_163":"환자정보가 없습니다. 먼저 환자를 등록하세요.","message_155":"처방일자이 현재일자보다 과거날짜입니다.","message_154":"수정할 처방 정보를 선택해주세요.","message_157":"내원정보를 입력하세요!","message_156":"환자정보를 입력하세요!","message_159":"진료과정보를 입력하세요!","message_158":"처방일자를 입력하세요!","message_151":"처방 등록된 환자 정보가 존재하지않습니다.","message_150":"의사정보","message_153":"입력중엔 수정할 수 없습니다.","message_152":"환자정보를 먼저 입력하세요!","message_144":"처방 취소는 하지 못합니다.","message_143":"처리할 접수내역이 없습니다.","message_146":"예약할 검사정보가 존재하지 않습니다.","message_145":"처리할 취소내역이 없습니다.","message_148":"접수 처리 하시겠습니까?","message_147":"검색구분이 전체 접수/취소 할 수 없습니다.","message_149":"자료가 존재하지 않습니다.","message_140":"조회일자를 확인하세요.","message_142":"접수 처리 하시겠습니까?","message_141":"처방상태가 처방인 경우에만 접수처리할 수 있습니다.","message_133":"환자 등록 번호를 입력하세요","message_132":"환자 명을 입력하세요","message_135":"사용가능한 환자 등록 번호 입니다.","message_134":"중복된 환자 등록 번호 입니다.","message_137":"이미 등록된 환자입니다.","message_136":"생년월일을 입력하세요","message_139":"DC처리된 검사입니다!","message_138":"미수납된 검사입니다!","message_131":"성별을 선택해주세요","message_130":"중복확인을 다시 해주세요.","message_129":"중복된 번호 입니다.","message_122":"취소할 예약을 선택해주세요","message_121":"예약을 변경했습니다.","message_124":"예약을 정말 취소하시겠습니까?","message_123":"예약이 안된 처방입니다.","message_126":"예약 가능 수를 초과하여 예약 할 수 없습니다.","message_125":"예약이 취소되었습니다.","message_128":"사용 가능한 번호 입니다.","message_127":"등록된 환자 정보가 존재하지않습니다.","message_120":"예약되었습니다","message_119":"예약일이 처방일보다 먼저입니다. 다른 날짜를 선택해주세요","message_118":"이미 예약이 생성된 처방입니다. 예약을 변경하시겠습니까?","message_111":"저장 완료 후 삭제해주세요.","message_110":"조회 종료일은 조회 시작일 보다 높을 수 없습니다. 다시 선택해주세요.","message_113":"총 X 건중 Y 건이 처리되었습니다.","message_112":"X 행의 중복된 정보가 있습니다.","message_115":"환자 정보 조회","message_114":"환자 ID 또는 성명을 입력 후 검색하세요.","message_117":"예약할 시간을 선택해주세요","message_116":"예약할 처방을 선택해주세요","message_108":"해당 기간의 예약시간을 삭제하시겠습니까?","message_107":"해당 기간의 예약시간을 적용하시겠습니까?","message_109":"예외 정보가 존재하지않습니다.","message_100":"X 행의 시작시간이 Y 행의 스케쥴과 겹칩니다.","message_102":"기존의 예약기준과 겹쳐 생성할 수 없습니다.","message_101":"X 행의 정보 저장시 오류가 발생하였습니다.","message_104":"시간 입력이 잘못되었습니다.","message_103":"이미 적용된 예약기준이 있습니다. 필요시 삭제후 적용하시기 바랍니다.","message_106":"오류발생!","message_105":"유효하지 않은 간격입니다.","button_022":"다운로드","button_021":"음성듣기","button_020":"복사","button_026":"임시저장","button_025":"비우기","button_024":"판독취소","button_023":"판독완료","button_029":"일시정지","button_028":"녹음","button_027":"음성파일 업로드","button_011":"상세","button_010":"하위메뉴","message_310":"","button_015":"중복확인","button_014":"새로고침","button_013":"불용","button_012":"목록","button_019":"붙여넣기","button_018":"처방추가","button_017":"예약","button_016":"접수","message_306":"","message_305":"","message_308":"","message_307":"","message_309":"","message_300":"","message_302":"","button_004":"취소","message_301":"","button_003":"변경","message_304":"","button_002":"비밀번호 변경","message_303":"","button_001":"로그인","button_008":"저장","button_007":"입력","button_006":"삭제","button_005":"수정","button_009":"초기화","colname_005":"시작일","colname_004":"권한","colname_007":"오류횟수","colname_006":"종료일","text_401":"","text_400":"","text_403":"","text_402":"","text_405":"","text_404":"","text_407":"","text_406":"","text_409":"","text_408":"","text_430":"","text_421":"","text_420":"","text_423":"","text_422":"","text_425":"","text_424":"","text_427":"","text_426":"","text_429":"","text_428":"","text_410":"","text_412":"","text_411":"","text_414":"","text_413":"","text_416":"","text_415":"","text_418":"","text_417":"","text_419":"","text_210":"종료시간","text_201":"판독내용","text_200":"방사선사","text_203":"보류","text_202":"판독이력","text_205":"판독임시저장","text_204":"취소","text_207":"내용","text_206":"판독완료","text_209":"시작시간","text_208":"미판독","text_432":"","text_431":"","text_433":"","text_230":"로그아웃","text_232":"환자검색","text_231":"사용자","text_223":"소분류 코드 명","text_222":"중분류 코드 명","text_225":"소분류 영어 명","text_224":"중분류 영어 명","text_227":"소분류 약어 명","text_226":"중분류 약어 명","text_229":"메뉴재생성","text_228":"업무메뉴","text_221":"메뉴권한","text_220":"메뉴그룹ID","text_212":"예약 예외 목록","text_211":"조회일자","text_214":"수정","text_213":"입력","text_216":"메뉴ID","text_215":"삭제","text_218":"메뉴명","text_217":"순서","text_219":"입력된 값","text_250":"적용 영문명","text_010":"기준정보입력관리","text_252":"요일","text_251":"필수입력","text_012":"촬영실장비관리","text_254":"월","text_011":"촬영실관리","text_253":"년","text_003":"변경 비밀번호","text_245":"엑셀 다운로드","text_002":"현재 비밀번호","text_244":"엑셀 업로드","text_005":"업무메뉴","text_247":"촬영실","text_004":"변경 비밀번호 확인","text_246":"복사","text_007":"로그아웃","text_249":"적용명","text_006":"메뉴 재생성","text_248":"컬럼 명","text_009":"공통코드관리","text_008":"기준정보관리","text_241":"영문 명","text_240":"관리","text_001":"비밀번호 변경","text_243":"불용","text_242":"촬영코드","text_234":"워크리스트","text_233":"영상 실시 관리","text_236":"메뉴정보 관리","text_235":"촬영실별 통계","text_238":"코드","text_237":"코드등록","text_239":"코드 명","text_270":"일","text_030":"영상 판독문구 관리","text_272":"예약 상세정보","text_271":"예약 여부","text_032":"각종통계현황","text_274":"노트","text_031":"영상 판독관리","text_273":"예약 취소","text_034":"판독의별 통계","text_276":"처방","text_033":"장비별 통계","text_275":"사용자 ID","text_025":"영상 접수 관리","text_267":"목","text_024":"환자 정보 관리","text_266":"수","text_027":"이동촬영 접수","text_269":"토","text_026":"CD 접수 관리","text_268":"금","text_029":"판독관리","text_028":"처방 정보 관리","text_261":"휴게시간","text_260":"간격","text_021":"휴일 기준 관리","text_263":"월 ~ 금 일괄적용","text_020":"예외 기준 관리","text_262":"분","text_023":"환자 관리","text_265":"화","text_022":"예약 관리","text_264":"월","text_014":"관리자메뉴","text_256":"생성구분","text_013":"촬영코드관리","text_255":"시간 설정","text_016":"프로그램 정보 관리","text_258":"추가 생성","text_015":"사용자관리","text_257":"새로 생성","text_018":"예약 스케쥴 관리","text_017":"사용자별 메뉴 관리","text_259":"기준 생성","text_019":"예약 기준 관리","text_290":"전년","text_050":"진단검사","text_292":"총 합계","text_291":"소 계","text_052":"메뉴","text_294":"조회년도","text_051":"선택","text_293":"월별 합계","text_054":"조회","text_296":"프로그램 정보","text_053":"등록","text_295":"장비 명","text_056":"배치","text_298":"닫기","text_055":"출력","text_297":"검색어 입력","text_047":"사용","text_289":"합계","text_046":"호출방식","text_288":"접수일자 조회","text_049":"영상의학","text_048":"완료","text_281":"검색구분","text_280":"접수자","text_041":"시스템ID","text_283":"촬영자","text_040":"검색조건 입력","text_282":"촬영시간","text_043":"프로그램명","text_285":"예약 및 접수","text_042":"프로그램ID","text_284":"인쇄","text_045":"화면유형","text_287":"예약일자 조회","text_044":"프로그램 URL","text_286":"처방일자 조회","text_036":"사용자 현황","text_278":"실시","text_035":"사용자 명","text_277":"접수","text_038":"비밀번호 초기화","text_037":"비밀번호 초기화","text_279":"판독","text_039":"프로그램 등록 현황","text_070":"슈퍼관리자","text_072":"의사","text_071":"관리자","text_074":"메뉴그룹 현황","text_073":"방사선사","text_076":"구분","text_075":"메뉴 그룹 정보","text_078":"즐겨찾기 목록","text_077":"프로그램 등록현황","text_069":"먼저 사용자 정보를 선택하세요!","text_068":"정렬순서","message_099":"X 행의 값이 잘못 입력되었습니다.","message_092":"적용날자 입력이 잘못되었습니다","text_061":"메뉴 목록","message_091":"불용일자 입력이 잘못되었습니다","text_060":"검색어 입력","message_094":"입력 또는 수정 버튼을 눌러주세요!","text_063":"메뉴그룹명","message_093":"정상적으로 입력되었습니다.","text_062":"해당 프로그램 목록","message_096":"조회된 정보가 없습니다.","text_065":"사용자 정보 목록","message_095":"중복된 촬영코드입니다","text_064":"상위메뉴","message_098":"수정할 정보가 존재하지 않습니다.","text_067":"유효여부","message_097":"삭제할 행이 없습니다.","text_066":"메뉴 정보 목록","text_058":"팝업화면","text_057":"메인화면","text_299":"코드 명 검색","text_059":"메뉴헤더","message_090":"일자 입력이 잘못되었습니다","message_089":"촬영코드를 선택해 주세요.","message_088":"코드를 입력해주세요.","text_090":"문자값","text_092":"입력명","text_091":"숫자값","message_081":"소분류 한글 명을 입력하세요!","text_094":"선택대분류코드","message_080":"대분류 코드 추가 입력하시겠습니까?","text_093":"입력값","message_083":"등록된 정보가 존재하지않습니다.","text_096":"촬영실 코드 관리","message_082":"수정한 정보를 저장하시겠습니까?","text_095":"컬럼적용구분","message_085":"N행 [적용명]을 입력해주세요.","text_098":"상세정보","message_084":"기존에 저장된 정보가 손상될 수 있습니다. 정말 수정 하시겠습니까?","text_097":"촬영실 한글 명","message_087":"N행 [입력명1], [입력값1]을 입력해주세요.","message_086":"N행 [선택대분류코드]를 선택해주세요.","text_099":"촬영실 영문 명","colname_001":"사용자ID","colname_003":"비밀번호","colname_002":"사용자명","message_078":"불용일자를 입력하세요!","message_077":"적용일자를 입력하세요!","message_079":"아이디가 변경되었습니다.중복확인을 다시해주세요.","text_081":"중분류 코드","text_080":"소분류 코드","message_070":"사용 가능한 코드 입니다","text_083":"자릿수","text_082":"대분류 한글 명","message_072":"날짜는 yyyy-mm-dd 형식으로 입력해주세요","text_085":"적용일자","message_071":"이미 사용중인 코드 입니다.다른 코드를 사용해주세요.","text_084":"출력순","message_074":"대분류 한글 명을 입력하세요!","text_087":"대분류 한글 명","message_073":"대분류 코드를 입력하세요!","text_086":"불용일자","message_076":"출력 순서를 입력하세요!","text_089":"대분류 약어 명","message_075":"대분류 자릿수를 입력하세요!","text_088":"대분류 영어 명","text_079":"대분류 코드","message_067":"삭제가 완료 되었습니다.","message_066":"정말 삭제하시겠습니까?","message_069":"등록/수정중인 정보가 있습니다. 무시하고 이동하시겠습니까?","message_068":"하위코드가 존재합니다. 하위코드 삭제 후 다시 시도해주세요.","message_061":"불용 처리가 완료 되었습니다.","message_060":"정말 불용 처리 하시겠습니까?","message_063":"X 번 행에 미 입력/오류 사항이 있습니다 다시 입력해주세요.","message_062":"X 번 행에 Y 코드는 중복되는 코드입니다. 다른 코드를 사용해주세요.","message_065":"변경할 정보가 없습니다.","message_064":"X 번 행에 불용일자는 적용일자보다 낮을 수 없습니다.","message_056":"검색","message_298":"","message_055":"소분류 코드 항목을 선택해주세요.","message_297":"","button_032":"임시저장","message_058":"중분류 코드 등록/수정중인 정보가 있습니다. 저장 후 다시 시도해주세요.","button_031":"완료","message_057":"소분류 코드 등록/수정중인 정보가 있습니다. 저장 후 다시 시도해주세요.","message_299":"","button_030":"일시정지 해제","message_059":"이 코드의 추가적인 하위코드를 입력할 수 없습니다.","message_290":"","message_050":"중분류 코드를 선택해주세요.","message_292":"","message_291":"","message_052":"소분류 코드가 존재하지않습니다.","message_294":"","message_051":"중분류 코드가 존재하지않습니다.","message_293":"","message_054":"중분류 코드 항목을 선택해주세요.","message_296":"","message_053":"대분류 코드 항목을 선택해주세요.","message_295":"","message_045":"[전산오류]처리시 오류가 발생하였습니다. 전산실에 문의하세요!","message_287":"","message_044":"메뉴 권한정보을 입력하세요!","message_286":"","message_047":"이미 즐겨찾기 정보에 등록되었습니다!","message_289":"","message_046":"N 행의 순서를 입력해주세요!","message_288":"","message_049":"대분류 코드를 선택해주세요.","message_048":"대분류 코드가 존재하지않습니다.","message_281":"","message_280":"","message_041":"메뉴 그룹ID을 입력하세요!","message_283":"","message_040":"행의 메뉴그룹ID 를 선택해 주세요!","message_282":"","message_043":"메뉴 ID명을 입력하세요!","message_285":"","message_042":"메뉴 ID을 입력하세요!","message_284":"","message_034":"메뉴ID을 입력하세요!","message_276":"","message_033":"자료가 존재하지않습니다.","message_275":"","message_036":"X행의 정보 저장시 오류가 발생하였습니다.","message_278":"","message_035":"메뉴명을 입력하세요!","message_277":"","message_038":"선택한 정보가 존재하지 않습니다.","message_037":"프로그램ID을 입력하세요!","message_279":"","message_039":"행의 메뉴그룹ID가 중복되었습니다!","message_270":"","message_030":"저장할 정보가 존재하지 않습니다.","message_272":"","message_271":"","message_032":"메뉴 그룹명을 입력하세요!","message_274":"","message_031":"메뉴 그룹ID을 입력하세요!","message_273":"","message_023":"삭제시 메뉴도 같이 삭제됩니다. 해당 프로그램 정보를 삭제하시겠습니까?","message_265":"","message_022":"비밀번호가 초기화되었습니다.","message_264":"","message_025":"총 X 건이 처리되었습니다.","message_267":"","message_024":"해당 프로그램 ID 정보가 등록되어 있습니다!","message_266":"","message_027":"프로그램ID를 입력하세요!","message_269":"","message_026":"시스템정보를 선택하세요!","message_268":"","message_029":"프로그램 URL을 입력하세요!","message_028":"프로그램명을 입력하세요!","message_261":"","message_260":"","message_021":"사용자 정보를 확인하세요!","message_263":"","message_020":"비밀번호를 초기화하시겠습니까?","message_262":"","message_019":"수정할 정보가 존재하지 않습니다.","message_012":"로그인 후 이용해 주세요!","message_254":"","message_011":"변경할 비밀번호가 상이합니다. 확인 후 다시 입력하세요!","message_253":"","message_014":"삭제할 수 없는 정보입니다.","message_256":"","message_013":"X행 미입력 사항이 있습니다.","message_255":"","message_016":"저장할 정보가 없습니다.","message_258":"","message_015":"자료조회중입니다. 잠시만 기다려주세요","message_257":"","message_018":"처리구분을 확인하세요!","message_017":"삭제할 정보가 존재하지 않습니다.","message_259":"","message_250":"","message_010":"이전 비밀번호를 입력하세요!","message_252":"","message_251":"","message_009":"사용자 번호를 확인해주세요!","message_008":"비밀번호를 변경하시겠습니까?","message_001":"사용자 ID를 입력하세요!","message_243":"","message_242":"","message_003":"입력한 사용자 비밀번호가 다릅니다! 비밀번호 확인 후 다시 입력하세요.","message_245":"","message_002":"비밀번호를 입력하세요!","message_244":"","message_005":"사용 종료된 ID 입니다.","message_247":"","message_004":"비밀번호 5회 이상 잘못 입력하였습니다. 관리자에게 문의하시길 바랍니다!","message_246":"","message_007":"정상 처리되었습니다. 다시 로그인하세요!","message_249":"","message_006":"사용자 ID 정보가 존재하지 않습니다.","message_248":"","message_241":"프로그램을 먼저 선택해주세요.","message_240":"하위 프로그램을 먼저 삭제해주세요","message_239":"이미 메뉴그룹 정보에 등록되었습니다.","message_232":"엑셀 파일만 업로드 가능합니다.","message_231":"엑셀 파일을 선택해 주세요.","message_234":"엑셀 업로드 후 저장 해 주세요.","message_233":"업로드 하시겠습니까?","message_236":"적용기간 내 동일한 촬영코드가  중복됩니다. 적용기간을 수정해주세요","message_235":"정보 변경은 촬영 코드 관리화면에서만 가능합니다.","message_238":"오류가 발생했습니다. 다시 시도해 주세요.","message_237":"엑셀 파일 양식이 올바르지 않습니다.","message_230":"엑셀 파일을 업로드 해 주세요","message_229":"검색어를 입력해주세요.","message_228":"처방 정보를 선택해주세요.","message_221":"통계 자료가 존재하지않습니다.","message_220":"접수 취소는 하지 못합니다.","message_223":"수정할 정보를 선택해주세요.","message_222":"\u0027-\u0027를 제외하고 입력해주세요.","message_225":"삭제할 행을 선택해주세요","message_224":"환자ID를 입력해주세요","message_227":"[구 분] 항목에서 미판독을 선택 후 다시 시도해주세요.","message_226":"정말 취소하시겠습니까?","message_218":"실시 처리 하시겠습니까?","message_217":"처방상태가 접수인 경우에만 실시처리할 수 있습니다.","message_219":"처리할 실시내역이 없습니다.","message_210":"유효하지 않은 날자입니다.","message_212":"해당 작업의 실행권한이 없습니다!","message_211":"환자정보가 없습니다!","message_214":"검색구분을 접수, 취소 중 하나를 선택해주세요.","message_213":"취소 처리 하시겠습니까?","message_216":"이미 실시된 처방입니다.","message_215":"췰영명을 입력해주세요.","message_207":"불용일자가 적용일보다 더 커서 불용처리 할 수 없습니다.","message_206":"이미 불용처리된 촬영코드입니다","message_209":"삭제되었습니다.","message_208":"X 입력이 필요합니다.","message_201":"삭제할 코드를 선택해주세요","message_200":"코드를 불용 처리 하시겠습니까?","message_203":"X 을(를) 선택해주세요.","message_202":"코드를 삭제 처리 하시겠습니까?","message_205":"중복확인을 해주세요!","message_204":"X 을(를) 입력하세요!","text_300":"음성녹음","text_302":"환자정보 목록","text_301":"업로드","text_304":"전화번호","text_303":"환자 상세정보","text_306":"여","text_305":"남","text_308":"판독임시저장","text_307":"음성판독","text_309":"보류","text_331":"사용자 목록","text_330":"초기화 후 저장","text_322":"선택진료","text_321":"입원 예약","text_324":"비고","text_323":"이동촬영","text_326":"중복","text_325":"신규","text_328":"양식 다운로드","text_327":"엑셀 파일 선택","text_329":"신규 코드 추가","text_320":"외래 예약","text_311":"구분","text_310":"취소","text_313":"판독정형문","text_312":"PACS 뷰어 조회","text_315":"부위코드","text_314":"촬영코드 검색","text_317":"통계 코드","text_316":"촬영실 코드","text_319":"서식 코드","text_318":"방향 코드","text_351":"","text_350":"","text_111":"촬영약어명","text_353":"","text_110":"촬영명","text_352":"","text_102":"촬영실 장비","text_344":"","text_101":"촬영실 정보","text_343":"","text_104":"촬영실","text_346":"","text_103":"촬영실 장비 코드 관리","text_345":"","text_106":"장비영문명","text_348":"","text_105":"장비한글명","text_347":"","text_108":"촬영횟수 ","text_107":"사용여부","text_349":"","text_109":"촬영영어명","text_340":"기준정보 입력관리","text_100":"촬영실 촬영구분","text_342":"","text_341":"","text_333":"기간","text_332":"출력일","text_335":"출력 건수","text_334":"출력자","text_337":"예외","text_336":"휴일","text_339":"기능 명","text_338":"프로그램 기능 권한 관리"}');
  if(i18n == null){
    document.chkfrm.action = "/index.do";
    document.chkfrm.submit();
  }
  $(document).ready(function () {
    var jsonData = ${data};

    /* 대분류 코드(그리드) __________________________________________________________________________________________________________________*/
    $("#list1").jqGrid({
      datatype: "local",
      url : "/risCodeList1Search.do", // 대분류 리스트 조회
      data: jsonData,
      colNames: ["HSPT_ID", "대분류코드", "대분류 한글명", "자릿수", "출력순", "적용일자", "불용일자"],
      colModel: [
        { name: "hsptId", index: "hsptId", width: 50, align: "center" },
        { name: "lrgcCd", index: "lrgcCd", width: 150, align: "center" },
        { name: "lrgcKrNm", index: "lrgcKrNm", width: 100, align: "center" },
        { name: "lrgcAcph", index: "lrgcAcph", width: 60,align: "center"},
        { name: "otptSqnc", index: "otptSqnc", width: 60, align: "center" },
        { name: "applDate", index: "applDate", width: 80, align: "center" },
        { name: "exprDate", index: "exprDate", width: 80, align: "center" },
      ],
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
      }, // loadComplete END
      
      onSelectRow: function (rowid) {
        var params = {};//빈 객체 생성 -> 이후 그리드를 새로고침하거나 데이터를 필터링할 때 사용
        var rowObject = $("#list1").jqGrid('getRowData',rowid);//선택한 행의 데이터를 가져와 rowObject 변수에 저장, getRowData 함수를 사용해 선택한 행의 데이터를 얻음
        jQuery('#list2').jqGrid('clearGridData'); // 그리드2 데이터 삭제 및 초기화
        jQuery('#list3').jqGrid('clearGridData'); // 그리드3 데이터 삭제 및 초기화
        params.hsptId = rowObject.hsptId;//선택한 행의 hsptId 값을 저장
        params.lrgcCd = rowObject.lrgcCd;//선택한 행의 lrgcCd 값을 저장

        
        $("#list2").setGridParam({
          datatype : "json",
          postData : params ,
          url : "/risCodeList2.do", // 중분류 리스트 조회
          mtype    : 'POST', // 전송 타입 */
          loadComplete:  //그리드2 데이터 로딩 완료후 실행되는 함수(빈 상태)
            function(postData){
            }
        }).trigger("reloadGrid");//reloadGrid 이벤트를 트리거하여 그리드를 다시 불러옴
      },
      
      // 그리드 Frozen Column에 정렬 화살표 표시 안되는 버그 수정
      onSortCol: function (index, idxcol, sortorder) {     
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
    //_______________________________________________________________________________________________________________________________
    
    
	/* 중분류 코드(그리드) __________________________________________________________________________________________________________________*/
    $("#list2").jqGrid({
      datatype: "local",
      url : "/risCodeList2.do", // 중분류 리스트 조회
      reordercolNames: true, //컬럼명을 드래그하여 재정렬할 수 있는 기능을 활성화
      postData: {
        type     : "DCList2", //그리드 데이터를 요청할때 함께 보낼 파라미터 설정
        isSearch : "false", // 화면 처음 로딩 시 검색여부 boolean 값(=false)
      }, // 보낼 파라미터
      mtype    : 'POST', // 전송 타입
      colNames: ["HSPT_ID", "대분류코드", "중분류코드", "중분류 한글명", "자릿수", "출력순", "적용일자", "불용일자"],
      colModel: [
        { name: "hsptId", index: "hsptId", width: 90, align: "center" },
        { name: "lrgcCd", index: "lrgcCd", width: 150, align: "center" },
        { name: "mddlCd", index: "mddlCd", width: 90, align: "center" },
        { name: "mddlKrNm", index: "mddlKrNm", width: 100, align: "center" },
        { name: "mddlAcph", index: "mddlAcph", width: 150,align: "center"},
        { name: "otptSqnc", index: "otptSqnc", width: 80, align: "center" },
        { name: "applDate", index: "applDate", width: 80, align: "center" },
        { name: "exprDate", index: "exprDate", width: 80, align: "center" },
      ],
      guiStyle: "bootstrap",
      autowidth: true,
      height: "85%",
      rownumbers: true,
      //multiselect: true,
      sortname: "id",
      sortorder: "asc",
      rownumbers: true,
      gridview: true, // 선표시 true/false
      viewsortcols: [true, "vertical", true],
      
      loadComplete: function (data) {
      }, // loadComplete END
      
      onSelectRow: function (rowid) {
        var params = {};
        var rowObject = $("#list2").jqGrid('getRowData',rowid);
        jQuery('#list3').jqGrid('clearGridData'); // 그리드2 데이터 삭제
        params.hsptId = rowObject.hsptId;
        params.lrgcCd = rowObject.lrgcCd;
        params.mddlCd = rowObject.mddlCd;

        $("#list3").setGridParam({
          datatype : "json",
          postData : params ,
          url : "/risCodeList3.do", // 중분류 리스트 조회
          mtype    : 'POST', // 전송 타입 */
          loadComplete:  //그리드2 데이터 로딩 완료후 실행되는 함수(빈 상태)
            function(postData){
            }
        }).trigger("reloadGrid");
      },
      
 	  // 그리드 Frozen Column에 정렬 화살표 표시 안되는 버그 수정
      onSortCol: function (index, idxcol, sortorder) {       
        // (화살표 css 변경하기 전 Frozen을 풀어주고)
        $("#list1").jqGrid("destroyFrozenColumns");
        var $icons = $(this.grid.headers[idxcol].el).find(">div.ui-jqgrid-sortable>span.s-ico");
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
 	//__________________________________________________________________________________________________________________
    

 	/* 소분류 코드(그리드) __________________________________________________________________________________________________________________*/
    $("#list3").jqGrid({
      datatype: "local",
      url : "/risCodeList3.do", // 중분류 리스트 조회
      reordercolNames: true, //컬럼명을 드래그하여 재정렬할 수 있는 기능을 활성화
      postData: {
        type     : "DCList2", //그리드 데이터를 요청할때 함께 보낼 파라미터 설정
        isSearch : "false", // 화면 처음 로딩 시 검색여부 boolean 값(=false)
      }, // 보낼 파라미터
      mtype    : 'POST', // 전송 타입
      colNames: ["소분류 코드", "소분류 한글명", "출력순", "적용일자", "불용일자"],
      colModel: [
        { name: "smllCd", index: "smllCd", width: 90, align: "center" },
        { name: "smllKrNm", index: "smllKrNm", width: 100, align: "center" },
        { name: "otptSqnc", index: "otptSqnc", width: 80, align: "center" },
        { name: "applDate", index: "applDate", width: 80, align: "center" },
        { name: "exprDate", index: "exprDate", width: 80, align: "center" },
      ],
      guiStyle: "bootstrap",
      autowidth: true,
      height: "85%",
      rownumbers: true,
//             multiselect: true,
      sortname: "id",
      sortorder: "asc",
      rownumbers: true,
      gridview: true, // 선표시 true/false
      viewsortcols: [true, "vertical", true],
      loadComplete: function (data) {
      }, // loadComplete END
      onSelectRow: function (rowid) {
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
  });
  //___________________________________________________________________________________________________________________________
  

  // 대분류 상세 버튼 클릭 시
  $('#lrgcDetail').click(function(){
    var rowid = $("#list1").getGridParam("selrow");
    var rowObject = $("#list1").jqGrid('getRowData',rowid);
    var hsptId = rowObject.hsptId;
    var lrgcCd = rowObject.lrgcCd;
    if(rowid < 1 ){
      alert(i18n.message_053) //"대분류 코드 항목을 선택해주세요."
      return
    }

    location.href = "/RIS0101E01.do?"+"hsptId="+hsptId+"&lrgcCd="+lrgcCd;
  });

  // 대분류 입력 버튼 클릭 시
  $('#lrgcReg').click(function(){
    location.href = "/RIS0101E02.do";
  });


  function jsSearch(){
    jQuery('#list1').jqGrid('clearGridData'); // 그리드1 데이터 삭제
    jQuery('#list2').jqGrid('clearGridData'); // 그리드2 데이터 삭제
    jQuery('#list3').jqGrid('clearGridData'); // 그리드3 데이터 삭제
    $("#list1").setGridParam({
      datatype : "json",
      postData : {"searchWord" : $("[name='searchWord']").val()} , 
      url : "/risCodeList1Search.do", // 중분류 리스트 조회
      mtype    : 'POST', // 전송 타입 */
      loadComplete:  //그리드2 데이터 로딩 완료후 실행되는 함수(빈 상태)
        function(postData){
        }
    }).trigger("reloadGrid");
  }
</script>
</body>
</html>