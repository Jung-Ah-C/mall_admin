package gdu.mall.dao;
import java.sql.*;
import java.text.DecimalFormat;
import java.util.*;
import gdu.mall.util.*;
import gdu.mall.vo.*;

public class EbookDao {
	
	// updateEbookSummary 메소드
	public static void updateEbookSummary(Ebook ebook) throws Exception{
		// 쿼리 작성
		String sql = "UPDATE ebook SET ebook_summary=? WHERE ebook_isbn = ?";
		
		// db연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookSummary());
		stmt.setString(2, ebook.getEbookISBN());
		
		// 디버깅
		System.out.println(stmt + "<-- EbookDao updateEbookSummary의 stmt"); // 디버깅
		
		// 쿼리 업데이트
		stmt.executeUpdate();
	}
	
	// updateEbook 메소드
	public static void updateEbook (Ebook ebook) throws Exception {
		// 쿼리 (ebookNO 빼고 컬럼 다 가져오기)
		String sql = "UPDATE ebook SET category_name=?, ebook_title=?, ebook_author=?, ebook_company=?, ebook_page_count=?, ebook_price=?, ebook_summary=?, ebook_state=? WHERE ebook_isbn = ?";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getCategoryName());
		stmt.setString(2, ebook.getEbookTitle());
		stmt.setString(3, ebook.getEbookAuthor());
		stmt.setString(4, ebook.getEbookCompany());
		stmt.setInt(5, ebook.getEbookPageCount());
		stmt.setInt(6, ebook.getEbookPrice());
		stmt.setString(7, ebook.getEbookSummary());
		stmt.setString(8, ebook.getEbookState());
		stmt.setString(9, ebook.getEbookISBN());
		System.out.println(stmt + "<-- EbookDao updateEbook의 stmt"); // 디버깅
		
		stmt.executeUpdate();
	}
	
	// 삭제 메소드
	public static void deleteEbook(String ebookISBN) throws Exception {
		// 쿼리 작성
		String sql = "DELETE FROM ebook WHERE ebook_isbn = ?";

		// DB 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebookISBN);
		System.out.println(stmt+ "<-- EbookDao.deleteEbook의 stmt"); // 디버깅
		stmt.executeUpdate();
	}
	
	// 책상태 수정을 위한 목록 배열
	public static String[] ebookStateList() throws Exception {
		String[] list = {"판매중", "품절", "절판", "구편절판"};
		
		return list;
	}
	
	// 책상태 수정 메소드
	public static void updateEbookState(Ebook ebook) throws Exception {
		String sql = "UPDATE ebook SET ebook_state = ? WHERE ebook_isbn = ?";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookState());
		stmt.setString(2, ebook.getEbookISBN());
		stmt.executeUpdate();
	}
	
	// 이미지 수정 메소드
	public static int updateEbookImg(Ebook ebook) throws Exception {
		String sql = "UPDATE ebook SET ebook_img = ? WHERE ebook_isbn = ?";
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookImg());
		stmt.setString(2, ebook.getEbookISBN());
		int rowCnt = stmt.executeUpdate();
		return rowCnt;
	}
	
	// ISBN 중복 체크
	public static String doubleCheckISBN(String ebookISBN) throws Exception {
		// 1. 쿼리 작성
		String sql = "SELECT ebook_isbn ebookISBN FROM ebook WHERE ebook_isbn = ?";
		
		// 2. 리턴타입 초기화
		String doubleCheckISBN = null;
		
		// 3. DB 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebookISBN);
		System.out.println(stmt+ "<-- ebookDao doubleCheckISBN의 stmt"); // 디버깅
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) { // 입력값이 한개니까 반복문을 쓸 필요가 없음
			doubleCheckISBN = rs.getString("ebook_isbn");
		}

		// 4. 리턴
		return doubleCheckISBN;
		}
	
	// ebook의 상세정보 (ebookOne)
	public static Ebook selectEbookOne(String ebookISBN) throws Exception {
		// 쿼리 (ebookNO 빼고 컬럼 다 가져오기)
		String sql = "SELECT ebook_no ebookNo ,ebook_isbn ebookISBN, category_name categoryName, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_company ebookCompany, ebook_page_count ebookPageCount, ebook_price ebookPrice, ebook_img ebookImg, ebook_summary ebookSummary, ebook_date ebookDate, ebook_state ebookState FROM ebook WHERE ebook_isbn = ?";
		Ebook ebook = null;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebookISBN);
		System.out.println(stmt + "<-- EbookDao selectEbookOne의 stmt"); // 디버깅
		
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			ebook = new Ebook();
			ebook.setEbookNo(rs.getInt("ebookNo"));
			ebook.setCategoryName(rs.getString("categoryName"));
			ebook.setEbookISBN(rs.getString("ebookISBN"));
			ebook.setEbookTitle(rs.getString("ebookTitle"));
			ebook.setEbookAuthor(rs.getString("ebookAuthor"));
			ebook.setEbookCompany(rs.getString("ebookCompany"));
			ebook.setEbookPageCount(rs.getInt("ebookPageCount"));
			ebook.setEbookPrice(rs.getInt("ebookPrice"));
			ebook.setEbookSummary(rs.getString("ebookSummary"));
			ebook.setEbookImg(rs.getString("ebookImg"));
			ebook.setEbookDate(rs.getString("ebookDate"));
			ebook.setEbookState(rs.getString("ebookState"));
		}

		return ebook;
	}
	
	// ebook 입력 메소드
	public static int insertEbook(Ebook ebook) throws Exception {
		
		/*
		 * INSERT INTO ebook(ebook_isbn, category_name, ebook_title, ebook_author, ebook_company, ebook_page_count, ebook_price, ebook_summary, ebook_img, ebook_date, ebook_state) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'default.jpg', NOW(), '판매중');
		 */
		String sql = "INSERT INTO ebook(ebook_isbn, category_name, ebook_title, ebook_author, ebook_company, ebook_page_count, ebook_price, ebook_summary, ebook_img, ebook_date, ebook_state) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'default.jpg', NOW(), '판매중')";
		int rowCnt = 0;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebook.getEbookISBN());
		stmt.setString(2, ebook.getCategoryName());
		stmt.setString(3, ebook.getEbookTitle());
		stmt.setString(4, ebook.getEbookAuthor());
		stmt.setString(5, ebook.getEbookCompany());
		stmt.setInt(6, ebook.getEbookPageCount());
		stmt.setInt(7, ebook.getEbookPrice());
		stmt.setString(8, ebook.getEbookSummary());
		System.out.println(stmt + "<-- EbookDao insertEbook의 stmt"); // 디버깅
		
		rowCnt = stmt.executeUpdate();
		
		return rowCnt;
	}
	
	// ebook 목록 메소드
	// 카테고리별로 보는 기능도 같이 추가
	public static ArrayList <Ebook> selectEbookListByPage(int rowPerPage, int beginRow, String categoryName) throws Exception {
		
		// 리턴값 초기화
		ArrayList<Ebook> list = new ArrayList<>();
		String sql = null;
		PreparedStatement stmt = null;
		
		// category별로 보는 서브메뉴를 클릭하지 않았을 경우
		if(categoryName == null) {
		// 쿼리 작성
		sql = "SELECT category_name categoryName, ebook_isbn ebookISBN, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_date ebookDate, ebook_price ebookPrice FROM ebook ORDER BY ebook_date DESC LIMIT ?, ?";
		
		// DB 핸들링
		Connection conn = DBUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		} else {
		// 쿼리 작성
		sql = "SELECT category_name categoryName, ebook_isbn ebookISBN, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_date ebookDate, ebook_price ebookPrice FROM ebook WHERE category_name = ? ORDER BY ebook_date DESC LIMIT ?, ?";
		
		// DB 핸들링
		Connection conn = DBUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		}
		
		// 디버깅
		System.out.println(stmt + "<-- EbookDao selectEbookListByPage의 stmt");
		
		ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Ebook e = new Ebook();
				e.setCategoryName(rs.getString("categoryName"));
				e.setEbookISBN(rs.getString("ebookISBN"));
				e.setEbookTitle(rs.getString("ebookTitle"));
				e.setEbookAuthor(rs.getString("ebookAuthor"));
				e.setEbookDate(rs.getString("ebookDate"));
				e.setEbookPrice(rs.getInt("ebookPrice"));
				list.add(e);
			}
		// 4. 결과값 리턴
		return list;
		}
	
	// 전체 행의 수 세는 메소드
	public static int totalCount() throws Exception {
		// 변수 초기화
		int totalRow = 0;
		
		// 쿼리 작성
		String sql = "SELECT COUNT(*) cnt FROM ebook";
		
		// DB 핸들링
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt + " <-- Ebook count의 stmt"); // 디버깅
		ResultSet rs = stmt.executeQuery();
			while(rs.next()) { // ebook 데이터의 총 개수
				totalRow = rs.getInt("cnt");
		}
		// 결과값 리턴
		return totalRow;
	}
}
