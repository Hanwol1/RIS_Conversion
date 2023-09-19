package egovframework.pandok.model;

public class Ris1301DTO {
	private String ordrFk;			// 처방FK
	private String ptntId;			// 환자ID
	private String ptntNm;			// 환자명
	private String ordrDate;		// 처방일
	private String prscDate;		// 촬영일자
	private String ordrCd;			// 촬영코드(촬영명)
	private String vistDvsn;		// 내원구분
	private String trtmDprtCd;		// 진료과
	private String ordrDocId;		// 처방의사
	private String viewYn;			// 판독완료(판독일자가 있으면 Y)
	private String viewDay;			// 판독일자(판독일시에서 일자만)
	private String viewTime;		// 판독시간(판독일시에서 시간만)
	private String viewDocId;		// 판독의사
	private String voicViewYn;		// 음성판독여부
	private String rdlgId;			// 방사선사
	private String ordrPrgrDvsn;	// 처방진행구분
	
	public String getOrdrFk() {
		return ordrFk;
	}
	public void setOrdrFk(String ordrFk) {
		this.ordrFk = ordrFk;
	}
	public String getPtntId() {
		return ptntId;
	}
	public void setPtntId(String ptntId) {
		this.ptntId = ptntId;
	}
	public String getPtntNm() {
		return ptntNm;
	}
	public void setPtntNm(String ptntNm) {
		this.ptntNm = ptntNm;
	}
	public String getOrdrDate() {
		return ordrDate;
	}
	public void setOrdrDate(String ordrDate) {
		this.ordrDate = ordrDate;
	}
	public String getPrscDate() {
		return prscDate;
	}
	public void setPrscDate(String prscDate) {
		this.prscDate = prscDate;
	}
	public String getOrdrCd() {
		return ordrCd;
	}
	public void setOrdrCd(String ordrCd) {
		this.ordrCd = ordrCd;
	}
	public String getVistDvsn() {
		return vistDvsn;
	}
	public void setVistDvsn(String vistDvsn) {
		this.vistDvsn = vistDvsn;
	}
	public String getTrtmDprtCd() {
		return trtmDprtCd;
	}
	public void setTrtmDprtCd(String trtmDprtCd) {
		this.trtmDprtCd = trtmDprtCd;
	}
	public String getOrdrDocId() {
		return ordrDocId;
	}
	public void setOrdrDocId(String ordrDocId) {
		this.ordrDocId = ordrDocId;
	}
	public String getViewYn() {
		return viewYn;
	}
	public void setViewYn(String viewYn) {
		this.viewYn = viewYn;
	}
	public String getViewDay() {
		return viewDay;
	}
	public void setViewDay(String viewDay) {
		this.viewDay = viewDay;
	}
	public String getViewTime() {
		return viewTime;
	}
	public void setViewTime(String viewTime) {
		this.viewTime = viewTime;
	}
	public String getViewDocId() {
		return viewDocId;
	}
	public void setViewDocId(String viewDocId) {
		this.viewDocId = viewDocId;
	}
	public String getVoicViewYn() {
		return voicViewYn;
	}
	public void setVoicViewYn(String voicViewYn) {
		this.voicViewYn = voicViewYn;
	}
	public String getRdlgId() {
		return rdlgId;
	}
	public void setRdlgId(String rdlgId) {
		this.rdlgId = rdlgId;
	}
	public String getOrdrPrgrDvsn() {
		return ordrPrgrDvsn;
	}
	public void setOrdrPrgrDvsn(String ordrPrgrDvsn) {
		this.ordrPrgrDvsn = ordrPrgrDvsn;
	}
}