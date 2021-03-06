/**
 * 
 */
package kr.or.ddit.score.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.persistence.criteria.CriteriaBuilder.Case;

import org.springframework.stereotype.Service;

import kr.or.ddit.score.dao.StudentScoreRetrieveDAO;

/**
 * @author 작성자명
 * @since 2022. 5. 19.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2022. 5. 19.      민진홍       최초작성
 * Copyright (c) 2022 by DDIT All right reserved
 * </pre>
 */
@Service
public class StudentScoreRetrieveServiceImpl implements StudentScoreRetrieveService {

	@Inject
	private StudentScoreRetrieveDAO dao;
	/* (non-Javadoc)
	 * @see kr.or.ddit.score.service.StudentScoreRetrieveService#studentAllScoreList(int)
	 */
	@Override
	public List<Map<String, Object>> studentAllScoreList(int userNo) {
		List<Map<String,Object>> list = dao.studentAllScoreList(userNo);
		List<Map<String,Object>> rsList = new ArrayList<>();
		
		if(list == null || list.size() == 0) {
			return rsList;
		}
		
		double rct = 0;
		double crdt = 0;
		int credit = 0;
		int totalCredit = 0;
		int applyCredit = 0;
		int majorA = 0;
		int majorB = 0;
		int majorC = 0;
		int count = 0;
		int totalcount = 0;
		int resetCount = 0;
		
		double rsRct;
		double rsCrdt;
		double totalRsRct = 0;
		double totalRsCrdt = 0;
		double totalMiddle = 0;
		double totalFinal = 0;
		double totalAttend = 0;
		double totalAssignment  = 0;
		
		Object sems = list.get(0).get("LEC_SEMS");
		for(Map<String,Object> map : list) {
			
			if(!sems.equals(map.get("LEC_SEMS"))){
			rsRct = Math.round((rct / resetCount) * 100) / 100.0; //배점평균
			rsCrdt = Math.round((crdt / resetCount) * 100) / 100.0; //평점평균
			totalRsCrdt += Math.round((crdt / list.size()) * 100) / 100.0; //배점평균
			totalRsRct += Math.round((rct / list.size()) * 100) / 100.0; //배점평균
			
			totalCredit += credit;
			count++;
			Map<String,Object> rsmap = new HashMap<>();
			rsmap.put("sems", sems);
			rsmap.put("rct", rsRct);
			rsmap.put("crdt", rsCrdt);
			rsmap.put("credit", credit);
			rsmap.put("majorA", majorA);
			rsmap.put("majorB", majorB);
			rsmap.put("majorC", majorC);
			rsmap.put("applyCredit", applyCredit);
			rsList.add(rsmap);
			sems = map.get("LEC_SEMS");
			
			rct = 0;
			crdt = 0;
			credit = 0;
			majorA = 0;
			majorB = 0;
			majorC = 0;
			applyCredit = 0;
			resetCount = 0;
			
			
			}
			
			rct += Double.parseDouble((String.valueOf( map.get("CLS_RCT"))));
			applyCredit += Integer.parseInt(String.valueOf(map.get("SJT_CREDIT")));
			credit += Integer.parseInt(String.valueOf(map.get("SJT_CREDIT")));
			String crdtName = (String) map.get("CLS_CRDT");
			String major = (String) map.get("SJT_MAJOR");
			totalMiddle +=  Double.parseDouble(String.valueOf(map.get("CLS_MEXAM")));
			totalFinal +=  Double.parseDouble(String.valueOf(map.get("CLS_FEXAM")));
			totalAttend +=  Double.parseDouble(String.valueOf(map.get("CLS_ATTABS")));
			totalAssignment +=  Double.parseDouble(String.valueOf(map.get("CLS_HWK")));
			totalcount++;
			resetCount++;
			switch (major) {
			case "전필":
				majorA++;
				break;
			case "전선":
				majorB++;
				break;
			case "교양":
				majorC++;
				break;

			default:
				break;
			}
			
			switch (crdtName) {
			case "A+":
				crdt += 4.5;
				break;
			case "A":
				crdt += 4;
				break;
			case "B+":
				crdt += 3.5;
				break;
			case "B":
				crdt += 3;
				break;
			case "C+":
				crdt += 2.5;
				break;
			case "C":
				crdt += 2;
				break;
			case "D+":
				crdt += 1.5;
				break;
			case "D":
				crdt += 1;
				break;
			case "F":
				credit -= Integer.parseInt(String.valueOf(map.get("SJT_CREDIT")));
				break;
				
			default:
				break;
			}
			
			
		}
		if(rsList.isEmpty()){
			rsRct = Math.round((rct / resetCount) * 100) / 100.0; //배점평균
			rsCrdt = Math.round((crdt / resetCount) * 100) / 100.0; //평점평균
			totalRsCrdt += Math.round((crdt / list.size()) * 100) / 100.0; //배점평균
			totalRsRct += Math.round((rct / list.size()) * 100) / 100.0; //배점평균
			totalCredit += credit;
			Map<String,Object> rsmap = new HashMap<>();
			rsmap.put("sems", sems);
			rsmap.put("rct", rsRct);
			rsmap.put("crdt", rsCrdt);
			rsmap.put("credit", credit);
			rsmap.put("majorA", majorA);
			rsmap.put("majorB", majorB);
			rsmap.put("majorC", majorC);
			rsmap.put("applyCredit", applyCredit);
			count++;
			
			rsList.add(rsmap);
	
			
			rct = 0;
			crdt = 0;
			credit = 0;
			majorA = 0;
			majorB = 0;
			majorC = 0;
			applyCredit = 0;
			resetCount = 0;
			
			}
		Map<String, Object> totalList = new HashMap<>();
		totalList.put("totalCredit", totalCredit);
		totalRsCrdt = Math.round((totalRsCrdt / count) * 100) / 100.0; 
		totalRsRct = Math.round((totalRsRct / count) * 100) / 100.0; 
		totalList.put("totalRsCrdt", totalRsCrdt);
		totalList.put("totalRsRct", totalRsRct);
		totalMiddle = Math.round((totalMiddle / totalcount * 100) / 100.0); //중간고사
		totalFinal = Math.round((totalFinal / totalcount * 100) / 100.0); //기말고사
		totalAttend = Math.round((totalAttend / totalcount * 100) / 100.0); //출석
		totalAssignment = Math.round((totalAssignment / totalcount * 100) / 100.0); //과제
		totalList.put("totalMiddle", totalMiddle);
		totalList.put("totalFinal", totalFinal);
		totalList.put("totalAttend", totalAttend);
		totalList.put("totalAssignment", totalAssignment);
		rsList.add(totalList);
		return rsList;
	}
	


}
