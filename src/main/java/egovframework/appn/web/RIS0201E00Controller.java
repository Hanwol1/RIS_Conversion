package egovframework.appn.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.validation.Valid;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.appn.model.ImagingDTO;
import egovframework.appn.model.RIS0210RequestDTO;
import egovframework.appn.model.RIS0211DateRequestDTO;
import egovframework.appn.model.RIS0211RequestDTO;
import egovframework.appn.model.RISAppnCalDTO;
import egovframework.appn.model.RISAppnCalRequestDTO;
import egovframework.appn.model.RISAppnChangeDTO;
import egovframework.appn.model.RISAppnChangeRequestDTO;
import egovframework.appn.model.Ris0210DTO;
import egovframework.appn.model.Ris0210FormDTO;
import egovframework.appn.model.Ris0211DTO;
import egovframework.appn.model.Ris0212DTO;
import egovframework.appn.model.Ris0212RequestDTO;
import egovframework.appn.service.RIS0201E00Service;
import egovframework.appn.service.RISAppnCommonService;

// 예약 기준 관리
@Controller
@RequestMapping("/appn")
public class RIS0201E00Controller {
	
	@Resource(name="RIS0201E00Service")
	private RIS0201E00Service service;
	
	@Resource(name="RISAppnCommonService")
	private RISAppnCommonService risAppnCommonService;
	
	
	/*
	 * 예약 기준 관리 - Controller
	 * GET		/appn/risappn/RIS0201E00.do	
	*/
	@GetMapping("/RIS0201E00.do")
	public String risappnGetMapping(Model model) {
		System.out.println("/RIS0201E00.do Get Request!!!");
		List<ImagingDTO> imagingList = risAppnCommonService.imagingSelect();
		List<String> yearList = service.ris0211YearSelect(RIS0211RequestDTO
								.builder()
								.hsptId("A001")
								.build());
		model.addAttribute("yearList", yearList);
		model.addAttribute("imagingList", imagingList);
		return ".main/appn/RIS0201E00";
	} 
	 
	
	 /*
	 * 예약 기준 관리 - RESTController
	 * GET		/appn/RIS0201E00/ris0210.do	ris0210 조건에 맞는 조회
	 * POST									ris0210 새로운 Data 저장
	 * POST 	/appn/RIS0201E00/risChangeSelect.do   예약변동내역 조회
	 */
	
	
	@PostMapping("/RIS0201E00/risChangeSelect.do")
	@ResponseBody
	public ResponseEntity<?> risChangeSelectRestGetMapping(@RequestBody RISAppnChangeRequestDTO dto){
		System.out.println("/appn/RIS0201E00/risChangeSelect.do POST Mapping!!!");
		System.out.println(dto.toString());
		List<RISAppnChangeDTO> list = service.risAppnChangeSelect(dto);
		return ResponseEntity.ok().body(list);
	}
	
	
	
	@PostMapping("/RIS0201E00/ris0210Search.do")
	@ResponseBody
	public ResponseEntity<?> risappnRestGetMapping(@RequestBody RIS0210RequestDTO dto) {
		System.out.println("/appn/RIS0201E00/ris0210Search.do	 POST Mapping!!!");
		dto.setHsptId("A001");
//		System.out.println("aaaaaaaaaaaaa");
//		for(String key : map.keySet()) {
//			//log.debug("{} key : {} ----------", key, map.get(key));
//			System.out.println(key);
//			System.out.println(map.get(key));
//		}	
//		RIS0210RequestDTO dto = RIS0210RequestDTO.builder()
//				.hsptId("A001")
//				.imgnRoomCd(String.valueOf(map.get("imgnRoomCd")))
//				.wkdy(String.valueOf(map.get("wkdy")))				
//				.build();
//		System.out.println(dto.toString());

		List<Ris0210DTO> rows = service.ris0210Select(dto);
//		for(Ris0210DTO dto2: rows) {
//			System.out.println(dto2.toString());
//		}
		
		
		return ResponseEntity.ok().body(rows);
	}
	
	
	@PostMapping("/RIS0201E00/ris0211Search.do")
	@ResponseBody
	public ResponseEntity<?> risappn0211RestGetMapping(@RequestBody RIS0211RequestDTO dto) {
		System.out.println("/appn/RIS0201E00/ris0211Search.do	 POST Mapping!!!");
		System.out.println(dto.toString());
		List<Ris0211DTO> rows = service.ris0211Select(dto);
		return ResponseEntity.ok().body(rows);
	}
	
	@PostMapping("/RIS0201E00/risappnCalSearch.do")
	@ResponseBody
	public ResponseEntity<?> risappnCalRestGetMapping(@RequestBody RISAppnCalRequestDTO dto) {
		System.out.println("/appn/RIS0201E00/risappnCalSearch.do	 POST Mapping!!!");
		List<RISAppnCalDTO> rows = service.risappnCalSelect(dto);
		System.out.println(dto.toString());
		System.out.println(rows.toString());
		return ResponseEntity.ok().body(rows);
	}
	
	
	@PostMapping("/RIS0201E00/ris0211DateApply.do")
	@ResponseBody
	public ResponseEntity<?> ris0211DateApplyRestPostMapping(@RequestBody RIS0211DateRequestDTO dto) {
		System.out.println("/appn/RIS0201E00/ris0211DateApply.do	 POST Mapping!!!");
		
		System.out.println(dto.toString());
		int result = service.ris0211DateApply(dto);
		
		
		
		return ResponseEntity.ok().body(result);
	}
	
	@PostMapping("/RIS0201E00/ris0210.do")
	@ResponseBody
	public ResponseEntity<?> ris0210ListPostMapping(@Valid @RequestBody List<Ris0210DTO> list){
		System.out.println("/appn/RIS0201E00/ris0210.do Post Mapping!!!");
		for(Ris0210DTO mo : list) {
			mo.setHsptId("A001");
			System.out.println(mo.toString());
		
		}
		int result = service.ris0210Process(list);
		return ResponseEntity.ok().body(result);
	}
	
	@PostMapping("/RIS0201E00/ris0211DeleteByDate.do")
	@ResponseBody
	public ResponseEntity<?> ris0211DeleteByDate(@RequestBody RIS0211RequestDTO dto){
		int result = service.ris0211DeleteByDate(dto);
		return ResponseEntity.ok().body(result);
	}
	
	
	@PostMapping("/RIS0201E00/form/ris0210.do")
	@ResponseBody
	public ResponseEntity<?> ris0210ListFormPostMapping(@Valid @RequestBody Ris0210FormDTO dto){
		System.out.println("/appn/RIS0201E00/form/ris0210.do Post Mapping!!!");
		System.out.println(dto.toString());
		String result =  service.ris0210FormProcess(dto);
		//int result = service.ris0210Process(list);
		return ResponseEntity.ok().body(result);
	}
	
	@PostMapping("/RIS0201E00/ris0211.do")
	@ResponseBody
	public ResponseEntity<?> ris0211ListPostMapping(@Valid @RequestBody List<Ris0211DTO> list){
		System.out.println("/appn/RIS0201E00/ris0211.do Post Mapping!!!");
		for(Ris0211DTO mo : list) {
			mo.setHsptId("A001");
			System.out.println(mo.toString());
		
		}
		int result = service.ris0211Process(list);
		return ResponseEntity.ok().body(result);
	}
	
	
}
