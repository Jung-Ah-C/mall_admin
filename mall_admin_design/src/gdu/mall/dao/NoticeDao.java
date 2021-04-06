package gdu.mall.dao;

import java.sql.*;
import java.util.*;
import gdu.mall.util.*;
import gdu.mall.vo.*;

public class NoticeDao {
	// 공지 목록 메소드
	public static ArrayList <Notice> selectNoticeListByPage(int rowPerPage, int beginRow) throws Exception {
		// 쿼리 작성
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, notice_date noticeDate, manager_id managerId FROM notice ORDER BY notice_date DESC LIMIT ?, ?";
		
		// 배열 변수 초기화
		ArrayList<Notice> list = new ArrayList<>();
		
		// DB 메소드 사용
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		System.out.println(stmt + "<-- NoticeDao selectNoticeListByPage의 stmt"); // 디버깅
		
		// 결과물 복사
		ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Notice n = new Notice();
				n.setNoticeNo(rs.getInt("noticeNo"));
				n.setNoticeTitle(rs.getString("noticeTitle"));
				n.setNoticeContent(rs.getString("noticeContent"));
				n.setNoticeDate(rs.getString("noticeDate"));
				n.setManagerId(rs.getString("managerId"));
				list.add(n);
			}
		
		// list 리턴
		return list;
		}
	
	// 전체 행의 개수 세는 메소드
	public static int totalCount() throws Exception {
		// 변수 초기화
		int totalRow = 0;
		
		// 쿼리 작성
		String sql = "SELECT COUNT(*) cnt FROM notice";
		
		// DB 연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt + " <-- NoticeDao totalcount의 stmt"); // 디버깅
		ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				totalRow = rs.getInt("cnt");
		}
		
		// 리턴값
		return totalRow;
	}
	
	// 공지 추가 메소드 (noticeInsertForm)
	public static void insertNotice(Notice notice) throws Exception {
		// 쿼리 작성
		String sql = "INSERT INTO notice (notice_title, notice_content, notice_date, manager_id) VALUES (?, ?, NOW(), ?)";
		
		// DB 연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.setString(3, notice.getManagerId());
		System.out.println(stmt + "<-- NoticeDao insertNotice의 stmt"); // 디버깅
		
		// 추가 실행
		stmt.executeUpdate();
	}
	
	// 공지 상세보기 메소드 (noticeOne)
	public static Notice selectNoticeOne(int noticeNo) throws Exception {
		// 쿼리 작성
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, manager_id managerId, notice_date noticeDate FROM notice WHERE notice_no = ?";
		
		// 변수 초기화
		Notice notice = null;
		
		// DB 연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		System.out.println(stmt + "<-- NoticeDao selectNoticeOne의 stmt"); // 디버깅
		
		// 결과값 복사
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) { // 클릭한 공지에 대한 상세정보라서 반복문 대신 if 사용
			notice = new Notice();
			notice.setNoticeNo(rs.getInt("noticeNo"));
			notice.setNoticeTitle(rs.getString("noticeTitle"));
			notice.setNoticeContent(rs.getString("noticeContent"));
			notice.setManagerId(rs.getString("managerId"));
			notice.setNoticeDate(rs.getString("noticeDate"));
		}

		// 리턴
		return notice;
	}
	
	// 공지 업데이트 메소드 (updateNotice)
	public static void updateNoticeOne (Notice notice) throws Exception {
		// 쿼리작성
		String sql = "UPDATE notice SET notice_title=?, notice_content=? WHERE notice_no = ?";
		
		// DB 연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.setInt(3, notice.getNoticeNo());
		System.out.println(stmt + "<-- NoticeDao updateNoticeOne의 stmt"); // 디버깅
		
		// 업데이트 실행
		stmt.executeUpdate();
	}
	
	// 공지 삭제 메소드 (deleteNoticeOneAction)
	public static void deleteNoticeOne(int noticeNo) throws Exception {
		// 쿼리 작성
		String sql = "DELETE FROM notice WHERE notice_no = ?";

		// DB 연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		System.out.println(stmt+ "<-- NoticeDao deleteNoticeOne의 stmt"); // 디버깅
		
		// 삭제 실행
		stmt.executeUpdate();
	}
}
