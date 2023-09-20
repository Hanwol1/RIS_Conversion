package egovframework.pandok.service;


import java.util.List;

import egovframework.pandok.model.Ris1101DTO;
import egovframework.pandok.model.Ris0102DTO;
import egovframework.pandok.model.Ris0601DTO;
import egovframework.pandok.model.Ris1301DTO;
import egovframework.pandok.model.RisUserDTO;

public interface PandokService {
	List<Ris0601DTO> getRis0601List();
	List<Ris0102DTO> getRis0102List();
	List<RisUserDTO> getRisUserList();
	List<Ris1301DTO> getRis1301List();
	List<Ris1101DTO> getRis1101List();
}