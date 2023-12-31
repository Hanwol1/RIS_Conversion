package egovframework.pandok.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import egovframework.pandok.mapper.PandokMapper;
import egovframework.pandok.service.PandokService;
import egovframework.pandok.model.Ris0102DTO;
import egovframework.pandok.model.Ris0601DTO;
import egovframework.pandok.model.Ris1101DTO;
import egovframework.pandok.model.Ris1201DTO;
import egovframework.pandok.model.Ris1301DTO;
import egovframework.pandok.model.RisUserDTO;

@Service("PandokService")
public class PandokServiceImpl implements PandokService {
	@Resource(name="PandokMapper")
	private PandokMapper pandokMapper;
	
	@Override
	public List<Ris0601DTO> getRis0601List(Map<String, String> param) {
		return pandokMapper.getRis0601List(param);
	}

	@Override
	public List<Ris0102DTO> getRis0102List(String hsptId) {
		return pandokMapper.getRis0102List(hsptId);
	}

	@Override
	public List<RisUserDTO> getRisUserList(String hsptId) {
		return pandokMapper.getRisUserList(hsptId);
	}

	@Override
	public List<Ris1301DTO> getRis1301List(Map<String, String> param) {
		return pandokMapper.getRis1301List(param);
	}

	@Override
	public List<Ris1101DTO> getRis1101List() {
		return pandokMapper.getRis1101List();
	}

	@Override
	public int duplicateCheck(Ris0601DTO dto) {
		return pandokMapper.duplicateCheck(dto);
	}

	@Override
	public int saveRis0601List(Ris0601DTO dto) {
		return pandokMapper.saveRis0601List(dto);
	}

	@Override
	public int saveTempRis1301List(Ris1301DTO dto) {
		return pandokMapper.saveTempRis1301List(dto);
	}

	@Override
	public int saveTempRis1201List(Ris1201DTO dto) {
		return pandokMapper.saveTempRis1201List(dto);
	}
	
	@Override
	public int voiceRis1201List(Ris1201DTO dto) {
		return pandokMapper.voiceRis1201List(dto);
	}
	
	@Override
	public Map<String, String> voiceDownload(Ris1301DTO dto) {
		return pandokMapper.voiceDownload(dto);
	}

	@Override
	public int finishRis1301List(Ris1301DTO dto) {
		return pandokMapper.finishRis1301List(dto);
	}

	@Override
	public int finishRis1201List(Ris1201DTO dto) {
		return pandokMapper.finishRis1201List(dto);
	}

	@Override
	public int deleteRis1301List(Ris1301DTO dto) {
		return pandokMapper.deleteRis1301List(dto);
	}

	@Override
	public int deleteRis1201List(Ris1201DTO dto) {
		return pandokMapper.deleteRis1201List(dto);
	}
}