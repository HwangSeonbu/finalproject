package kr.or.ddit.room.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.AssignVO;
import kr.or.ddit.vo.DepartLectureAssignVO;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.GwanVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.PlanVO;

@Mapper
public interface ProfessorRoomSetDAO {

	public List<DepartLectureAssignVO> selectDepartLecList(PlanVO vo);
	public DepartmentVO selectDepartOne(String deptId);
	public GwanVO selectGwanOne(String gwanName);
	
	public List<AssignVO> selectRoomAssignList(AssignVO vo);
	
	public int updateLecAssignOne(AssignVO vo);
	
	public List<DepartLectureAssignVO> selectSubmitTargetList(PlanVO vo);
	
	public List<DepartLectureAssignVO> selectDuplicatedList(int nextSems);
	
	//강의 개설
	public LectureVO selectLectureOne(int planNo);
	public int updateAssignStatus(int planNo);
	public int updatePlanStatus(int planNo);
	public int insertLecture(LectureVO vo);
}
