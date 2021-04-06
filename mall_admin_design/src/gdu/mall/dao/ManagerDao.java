package gdu.mall.dao;
import gdu.mall.vo.Manager;
import gdu.mall.util.*;
import java.util.*;
import java.sql.*;
public class ManagerDao {
	
	// 승인 대기중 메소드
	public static ArrayList<Manager> selectManagerListByZero() throws Exception {
		// 1. sql
		String sql = "SELECT manager_id managerId, manager_level managerLevel, manager_date managerDate FROM manager WHERE manager_level=0";
		
		// 2. 리턴값 초기화
		ArrayList<Manager> list = new ArrayList<>();
		
		// 3. DB 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt =  conn.prepareStatement(sql);
		System.out.println(stmt+ "<--stmt"); // 디버깅
		ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Manager m = new Manager();
				m.setManagerId(rs.getString("managerId"));
				m.setManagerDate(rs.getString("managerDate"));
				list.add(m);
			}
		// 4. 리턴
		return list;
	}
	
	// 수정 메소드
	public static int updateManagerLevel(int managerNo, int managerLevel) throws Exception {
		// 1. 쿼리 작성
		String sql = "UPDATE manager SET manager_level=? WHERE manager_no=?";
		 
		// 2. 리턴값 초기화
		int rowCnt = 0;
		
		// 3. DB 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, managerLevel); // 입력한 level값을 받음
		stmt.setInt(2, managerNo); // managerNo 값을 통해서 수정할 행 구분
		System.out.println(stmt+ "<--stmt"); // 디버깅
		rowCnt = stmt.executeUpdate();
		
		return rowCnt;
	}
	
	// 삭제 메소드
	public static int deleteManager(int managerNo) throws Exception {
		// 1. 쿼리 작성
		String sql = "DELETE FROM manager WHERE manager_no=?";
		
		// 2. 리턴값 초기화
		int rowCnt = 0;
		
		// 3. DB 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, managerNo); // primary key인 managerNo로 행을 구분해서 삭제함
		System.out.println(stmt+ "<--stmt"); // 디버깅
		rowCnt = stmt.executeUpdate();
		
		return rowCnt;
	}
	
	// 목록 메소드
	public static ArrayList<Manager> selectManagerListByPage(int rowPerPage, int beginRow) throws Exception {
		// 1. sql
		String sql = "SELECT manager_no managerNo, manager_id managerId, manager_name managerName, manager_date managerDate, manager_level managerLevel FROM manager ORDER BY manager_level DESC, manager_date ASC LIMIT ?,?";
		
		// 2. 리턴값 초기화
		ArrayList<Manager> list = new ArrayList<>();
		
		// 3. DB 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt =  conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		System.out.println(stmt+ "<--stmt"); // 디버깅
		ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Manager m = new Manager();
				m.setManagerNo(rs.getInt("managerNo"));
				m.setManagerId(rs.getString("managerId"));
				m.setManagerName(rs.getString("managerName"));
				m.setManagerDate(rs.getString("managerDate"));
				m.setManagerLevel(rs.getInt("managerLevel"));
				list.add(m);
			}
		// 4. 리턴
		return list;
	}
	
	// 입력 메소드
	public static int insertManager(String managerId, String managerPw, String managerName) throws Exception {
		// 1. 
		String sql = "INSERT INTO manager(manager_id,manager_pw,manager_name,manager_date,manager_level) VALUES(?,?,?,now(),0)";
		// 2.
		int rowCnt = 0; // 입력 성공하면 1, 실패하면 0 으로 리턴됨
		// 3.
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		stmt.setString(2, managerPw);
		stmt.setString(3, managerName);
		System.out.println(stmt+ "<--stmt"); // 디버깅
		rowCnt = stmt.executeUpdate();
		
		return rowCnt;
	}
	// id 사용가능여부
	public static String selectManagerId(String managerId) throws Exception {
		// 1. sql문
		String sql = "SELECT manager_id FROM manager WHERE manager_id = ?";
		
		// 2. 리턴타입 초기화
		String returnManagerId = null;
		
		// 3. DB 처리
		Connection conn = DBUtil.getConnection();
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			returnManagerId = rs.getString("manager_id");
		}
		
		// 4. 리턴
		return returnManagerId;
	}
	
	// 로그인 메소드
	public static Manager login(String managerId, String managerPw) throws Exception {
		// manager_level 0인 사람은 로그인 하지 못하게 해서, 레벨에 따라서 접근 메뉴를 다르게 할 수 있음
		String sql = "SELECT manager_id, manager_name, manager_level FROM manager WHERE manager_id=? AND manager_pw=? AND manager_level>0";
		Manager manager = null;
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/mall","root","java1004");
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		stmt.setString(2, managerPw);
		System.out.println(stmt + " <--login() sql");
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			manager = new Manager();
			manager.setManagerId(rs.getString("manager_id"));
			manager.setManagerName(rs.getString("manager_name"));
			manager.setManagerLevel(rs.getInt("manager_level"));
		}
		return manager;
	}
	
	// 전체 행의 수를 세는 메소드
		public static int totalCount() throws Exception {
			// 변수 초기화
			int totalRow = 0;
			
			// 쿼리 작성
			String sql = "SELECT COUNT(*) cnt FROM manager";
			
			// DB 연결
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			System.out.println(stmt + " <-- ManagerDao totalcount의 stmt"); // 디버깅
			ResultSet rs = stmt.executeQuery();
				while(rs.next()) {
					totalRow = rs.getInt("cnt");
			}
			
			// 리턴값
			return totalRow;
		}
}
