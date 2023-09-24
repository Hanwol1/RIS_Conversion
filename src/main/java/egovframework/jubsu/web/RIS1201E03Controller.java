package egovframework.jubsu.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.jubsu.model.RIS1201E0301DTO;
import egovframework.jubsu.service.RIS1201E03Service;

@Controller
public class RIS1201E03Controller {
	
	@Resource(name="RIS1201E03Service")
	private RIS1201E03Service ris1201E03Service;
	
	// 처방 정보 관리 페이지
	@RequestMapping(value = "/jubsu/RIS1201E03.do")
	private String RIS1201E03(Model model) throws Exception {
		
		return ".main/jubsu/RIS1201E03";
	}
	
	
	// 처방 정보 관리 팝업 페이지
	@RequestMapping(value = "/popup/RIS1201E03_POP.do")
	private String RIS1201E03_POP(Model model) throws Exception {
		
		return ".popup/RIS1201E03_POP";
	}
	
	
	// 처방 정보 관리 페이지 - 처방 목록 데이터
	@RequestMapping(value = "/jubsu/RIS1201E03.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject RIS1201E03(@RequestParam String type, HttpSession session, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {
		
		JSONObject json = new JSONObject(); 
		
		List<RIS1201E0301DTO> ris1201E0301Data = ris1201E03Service.ris1201E0301Data();
		
		json.put("rows", ris1201E0301Data);
		
		return json;
	}
	
	// 처방 정보 관리 페이지 - 환자 리스트 데이터
	@RequestMapping(value = "/popup/RIS1201E03_POP.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject RIS1201E03_POP(@RequestParam String type, HttpSession session, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {
		
		JSONObject json = new JSONObject(); 
		
		List<RIS1201E0301DTO> ris1201E0301Data = ris1201E03Service.ris1201E0301Data();
		
		json.put("rows", ris1201E0301Data);
		
		return json;
	}
	
	
	
	
}