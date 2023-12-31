package egovframework.com.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ibatis.common.logging.Log;

import egovframework.appn.model.Ris0213DTO;
import egovframework.com.model.RisUserDTO;
import egovframework.com.service.ComService;


@Controller
public class RISUSERQ00Controller {
	
	@Resource(name="ComService")
	private ComService comService;
	
	
	@RequestMapping(value = "/RISUSERQ00.do")
	public String user(Model model) throws Exception {
		System.out.print("=====123123123==");
		return ".main/com/RISUSERQ00";
	}
	
	@RequestMapping(value = "/pwPopup.do")
	public String pwpopup(Model model) throws Exception {
		System.out.print("=====123123123==");
		return ".popup/pwPopup";
	}
	
	// 그리드 불러오기
	@RequestMapping(value = "/RISUSERQ00.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject RISUSERQ00(@RequestParam String type, HttpSession session, HttpServletRequest request,
        HttpServletResponse response, Model model) throws Exception {
		
		System.out.println("/RISUSERQ00.do POST!!!!");
		JSONObject json = new JSONObject(); 
		List<RisUserDTO> data =comService.RisUserList(); 
		for(RisUserDTO dto : data) {
			System.out.println(dto.getLoginId());
		}
		  
		JSONArray rowsArray = new JSONArray(); 
		JSONObject row = new JSONObject(); 
		  
		json.put("rows", data);

		return json;
	}
	
	// 저장
	@RequestMapping(value = "/risuserSavaData.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject saveBtn(@RequestBody List<RisUserDTO> dtos, HttpSession session, HttpServletRequest request,
	                           HttpServletResponse response, Model model) throws Exception {
		
	    JSONObject json = new JSONObject();
	    for (RisUserDTO dto : dtos) {
	        String flag = dto.getFlag();
	        System.out.println("-----------------------");
	        System.out.println(flag);
	        int result = 0;
	        switch (flag) {
	            case "U":
	                result = comService.updateData(dto);
	                break;
	            case "I":
	                result = comService.addUserData(dto);
	                break;
                default:
                	continue;
	        }
	        if (result < 1) {
	            json.put("result", "error");
	            return json;
	        }
	    }
	    json.put("result", "success");
	    return json;
	}
	
	
	 // 팝업 비밀번호 초기화
	 @RequestMapping(value = "/risuserResetData.do", method = RequestMethod.POST)
	 @ResponseBody public JSONObject risuserResetData(@RequestBody RisUserDTO dtos, HttpSession session, HttpServletRequest request,
			 HttpServletResponse response, Model model) throws Exception { 

		  JSONObject json = new JSONObject();
		  int result = comService.pwReset(dtos);
		  System.out.println(result);
		  json.put("result", result);
		  return json;
	  }

	
}

