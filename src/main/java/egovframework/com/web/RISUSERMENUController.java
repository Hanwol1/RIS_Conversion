package egovframework.com.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.model.RisGrmuDTO;
import egovframework.com.model.RisUrmnDTO;
import egovframework.com.model.RisUserDTO;
import egovframework.com.service.ComService;

@Controller
public class RISUSERMENUController {
	
	@Resource(name="ComService")
	private ComService comService;
	
	@RequestMapping(value = "/RISUSERMENU.do")
	public String menu(Model model) throws Exception {
		return ".main/com/RISUSERMENU";
	}
	
	// 그리드2 팝업창
	@RequestMapping(value = "/RISUSERMENU_POP.do")
	public String menupopup(Model model) throws Exception {
		return ".popup/RISUSERMENU_POP";
	}
	
	// 그리드1
	@RequestMapping(value = "/RISUSERMENU.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject RISUSERMENU(@RequestParam String hsptId, HttpSession session, HttpServletRequest request,
	        HttpServletResponse response, Model model) throws Exception {
		
		System.out.println("/RISUSERMENU.do POST!!!!");
		JSONObject json = new JSONObject(); 
		List<RisUserDTO> data =comService.RisUserMenuList(hsptId); 
		  
		JSONArray rowsArray = new JSONArray(); 
		JSONObject row = new JSONObject(); 
		  
		json.put("rows", data);

		return json;
	}
	
	//그리드2
	@RequestMapping(value = "/RISUSERMENU2.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject RISUSERMENU2(@RequestParam String type, String type2, HttpSession session, HttpServletRequest request,
	        HttpServletResponse response, Model model) throws Exception {
		
		System.out.println("/RISUSERMENU2.do POST!!!!");
		Map<String, String> params = new HashMap<>();
        params.put("type", type);
        params.put("type2", type2);
		JSONObject json = new JSONObject(); 
		List<RisUrmnDTO> data =comService.RisUserMenuList2(params); 
		  
		JSONArray rowsArray = new JSONArray(); 
		JSONObject row = new JSONObject(); 
		  
		json.put("rows", data);

		return json;
	}
	
	// 팝업
	@RequestMapping(value = "/RISUSERMENU_POP.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject RISUSERMENU_POP(@RequestParam String type, HttpSession session, HttpServletRequest request,
	        HttpServletResponse response, Model model) throws Exception {
		
		System.out.println("/RISUSERMENU_POP.do POST!!!!");
		JSONObject json = new JSONObject(); 
		List<RisUrmnDTO> data =comService.popupUrmnList(); 
		  
		JSONArray rowsArray = new JSONArray(); 
		JSONObject row = new JSONObject(); 
		  
		json.put("rows", data);

		return json;
	}
}

