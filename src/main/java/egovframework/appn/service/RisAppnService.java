package egovframework.appn.service;
import java.util.List;

import egovframework.appn.model.Ris0212DTO;
import egovframework.appn.model.Ris0213DTO;


public interface RisAppnService {
	
	// 예약 예외 목록
	public List<Ris0213DTO> ris0213Select();
	public int ris0213Process(List<Ris0213DTO> list);

	// 예약 휴일 목록
	public List<Ris0212DTO> ris0212Select();
	public int ris0212Process(List<Ris0212DTO> list);
	
}
