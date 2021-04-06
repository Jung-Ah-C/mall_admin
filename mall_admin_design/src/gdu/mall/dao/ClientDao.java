package gdu.mall.dao;
import gdu.mall.util.*;
import gdu.mall.vo.*;
import java.util.*;
import java.sql.*;

public class ClientDao {
	
	// 수정 메소드
	public static void updateClient(String clientMail, String clientPw) throws Exception {
		// 쿼리 작성 (client_mail을 기준으로)
		String sql = "UPDATE client SET client_pw = PASSWORD(?) WHERE client_mail=?";
		
		// DB 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, clientPw);
		stmt.setString(2, clientMail);
		
		// 디버깅
		System.out.println(stmt+ "<-- ClientDao.updateClient의 stmt"); // 디버깅
		
		// 수정한 것 실행
		stmt.executeUpdate();
	}
		
	// 삭제 메소드
	public static void deleteClient(String clientMail) throws Exception {
		// 쿼리 작성 (client_mail을 기준으로)
		String sql = "DELETE FROM client WHERE client_mail=?";
		
		// DB 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, clientMail);
		
		// 디버깅
		System.out.println(stmt+ "<-- ClientDao.deleteClient의 stmt"); // 디버깅
		
		// 삭제한 것 실행
		stmt.executeUpdate();
	}

	// 전체 행의 수 세기
	public static int totalCount(String searchWord) throws Exception {
		
		int totalRow = 0;
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		
		// 쿼리 작성
		String sql = "";
		if(searchWord.equals("")) {
			sql = "SELECT COUNT(*) cnt FROM client";
			stmt = conn.prepareStatement(sql);
		} else {
			sql = "SELECT COUNT(*) cnt FROM client WHERE client_mail LIKE ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%"); // %가 앞뒤로 있어야 검색한 내용이 포함된 결과물이 나옴
		}
		System.out.println(stmt + " <-- Client count stmt"); // 디버깅
		ResultSet rs = stmt.executeQuery();
			while(rs.next()) { // 고객 데이터의 총 개수
				totalRow = rs.getInt("cnt");
		}
		// 결과값 리턴
		return totalRow;
	}
	
	// 목록 메소드
	public static ArrayList<Client> selectClientListByPage(int rowPerPage, int beginRow, String searchWord) throws Exception {
		
		
		// 2. 리턴값 초기화
		ArrayList<Client> list = new ArrayList<>();
		
		// 3. DB 핸들링
		Connection conn = DBUtil.getConnection();
		
		PreparedStatement stmt = null;
		String sql = "";
		
		if(searchWord.equals("")) { // 검색어가 없으면
			sql = "SELECT client_mail clientMail, client_date clientDate FROM client ORDER BY client_date DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
		} else { // 검색어가 있으면
			sql = "SELECT client_mail clientMail, client_date clientDate FROM client WHERE client_mail LIKE ? ORDER BY client_date DESC LIMIT ?, ?";
			// like는 = 연산자와 같은 기능을 함
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
		}
		ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Client c = new Client();
				c.setClientMail(rs.getString("clientMail"));
				c.setClientDate(rs.getString("clientDate"));
				list.add(c);
			}
		// 4. 결과값 리턴
		return list;
	}
}