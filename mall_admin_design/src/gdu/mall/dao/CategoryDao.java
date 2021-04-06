package gdu.mall.dao;
import gdu.mall.vo.*;
import gdu.mall.util.*;
import java.sql.*;
import java.util.*;

public class CategoryDao {
		
	// 카테고리 목록 메소드
	public static ArrayList<String> categoryNameList() throws Exception {
		// 1. 쿼리 작성 (가중치에 따라 내림차순, 날짜별로 오름차순)
		String sql = "SELECT category_name categoryName FROM category ORDER BY category_weight DESC";
		
		// 2. 리턴값 초기화
		ArrayList<String> list = new ArrayList<>();
		
		// 3. DB 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt =  conn.prepareStatement(sql);
		System.out.println(stmt+ "<-- CategoryDao.list의 stmt"); // 디버깅
		
		ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				String cn = rs.getString("categoryName");
				list.add(cn);
			}
			return list;
		}
	
	// 목록 메소드
	public static ArrayList<Category> selectCategoryList() throws Exception {
		// 1. 쿼리 작성 (가중치에 따라 내림차순, 날짜별로 오름차순)
		String sql = "SELECT category_no categoryNo, category_name categoryName, category_date categoryDate, category_weight categoryWeight FROM category ORDER BY category_weight DESC, category_date ASC";
		
		// 2. 리턴값 초기화
		ArrayList<Category> list = new ArrayList<>();
		
		// 3. DB 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt =  conn.prepareStatement(sql);
		System.out.println(stmt+ "<-- CategoryDao.list의 stmt"); // 디버깅
		ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Category c = new Category();
				c.setCategoryNo(rs.getInt("categoryNo"));
				c.setCategoryName(rs.getString("categoryName"));
				c.setCategoryDate(rs.getString("categoryDate"));
				c.setCategoryWeight(rs.getInt("categoryWeight"));
				list.add(c);
			}
		// 4. 리턴
		return list;
		}
	
	// CategoryWeight 수정 메소드
	public static void updateCategoryWeight(int categoryNo, int categoryWeight) throws Exception {
		// 쿼리 작성
		String sql = "UPDATE category SET category_weight=? WHERE category_no=?";
		
		// DB 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryWeight); // 선택한 가중치 값을 넣음
		stmt.setInt(2, categoryNo); // categoryNo 값을 통해서 수정할 행 구분
		
		// 디버깅
		System.out.println(stmt+ "<-- CategoryDao updateCategoryWeight의 stmt"); 
		
		// 가중치 수정한 것 실행
		stmt.executeUpdate();
		}
	
	// category 삭제 메소드
	public static void deleteCategory(String categoryName) throws Exception {
		// 쿼리 작성 (category_name을 기준으로 삭제할 행 선택)
		String sql = "DELETE FROM category WHERE category_name = ?";
		
		// DB 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		
		// 디버깅
		System.out.println(stmt+ "<-- ClientDao deleteCategory의 stmt"); // 디버깅
		
		// 삭제한 것 실행
		stmt.executeUpdate();
		}
	
	// categoryName 중복 여부 메소드
	public static String selectCategoryName(String categoryName) throws Exception {
		// 1. 쿼리 작성
		String sql = "SELECT category_name FROM category WHERE category_name = ?";
		
		// 2. 리턴타입 초기화
		String returnCategoryName = null;
		
		// 3. DB 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		System.out.println(stmt+ "<-- CategoryDao selectCategoryName의 stmt"); // 디버깅
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) { // 입력값이 한개니까 반복문을 쓸 필요가 없음
			returnCategoryName = rs.getString("category_name");
		}

		// 4. 리턴
		return returnCategoryName;
		}
	
	// category 입력 메소드
	public static int insertCategory(String categoryName) throws Exception {
		// 쿼리 작성
		String sql = "INSERT INTO category(category_name, category_weight, category_date) VALUES(?,0,now())";
		
		// 변수 초기화
		int rowCnt = 0; // 입력 성공하면 1, 실패하면 0 으로 리턴됨
		
		// DB 핸들링
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		System.out.println(stmt+ "<-- CategoryDao insertCategory의 stmt"); // 디버깅
		rowCnt = stmt.executeUpdate();
		
		// 결과값 리턴
		return rowCnt;
		}
}
