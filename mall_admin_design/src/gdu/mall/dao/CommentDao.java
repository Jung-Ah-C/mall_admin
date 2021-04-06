package gdu.mall.dao;

import java.sql.*;
import java.util.*;

import gdu.mall.util.*;
import gdu.mall.vo.*;

public class CommentDao {
	
	// 댓글 입력 메소드
	public static int insertComment(Comment comment) throws Exception {
		// 쿼리 작성
		String sql = "INSERT INTO comment (notice_no , manager_id, comment_content, comment_date) VALUES (?, ?, ?, NOW())";
		
		// 변수 초기화
		int rowCnt = 0;
		
		// DB 메소드 사용
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, comment.getNoticeNo());
		stmt.setString(2, comment.getManagerId());
		stmt.setString(3, comment.getCommentContent());
		System.out.println(stmt + "<-- CommentDao insertComment의 stmt"); // 디버깅
		
		// 결과물 복사
		rowCnt = stmt.executeUpdate();
		
		// 리턴
		return rowCnt;
	}
	
	// 댓글 목록 메소드
	public static ArrayList<Comment> selectCommentListByNoticeNo(int noticeNo) throws Exception {
		// 쿼리 작성
		String sql = "SELECT comment_no commentNo, notice_no noticeNo, manager_id managerId, comment_content commentContent, comment_date commentDate FROM comment WHERE notice_no=?";
		
		// DB 메소드 사용
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		System.out.println(stmt + "<-- CommentDao selectCommentListByNoticeNo의 stmt"); // 디버깅
		
		// 결과물 복사
		ArrayList<Comment> list = new ArrayList<Comment>();
		ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Comment c = new Comment();
				c.setCommentNo(rs.getInt("commentNo"));
				c.setCommentContent(rs.getString("commentContent"));
				c.setManagerId(rs.getString("managerId"));
				c.setCommentDate(rs.getString("commentDate"));
				list.add(c);
			}
		
		// list 리턴
		return list;
		}
	
	// 댓글 삭제 메소드 (2가지)
	
	// 레벨 2인 관리자는 모든 댓글 삭제 가능
	// 자바는 동일한 이름의 메소드 (오버로딩) 만들 수 있음 (매개변수만 다르다면) --> 객체지향 문법에서 나옴
	public static void deleteComment(int commentNo) throws Exception { // commentNo
		// 쿼리 작성
		String sql = "DELETE FROM comment WHERE comment_no=?";
		
		// DB 연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		System.out.println(stmt+ "<-- CommentDao deleteComment의 stmt"); // 디버깅
		
		// 삭제 실행
		stmt.executeUpdate();

	}
	
	// 레벨 2 미만인 관리자
	public static void deleteComment(int commentNo, String managerId) throws Exception { // commentNo, managerId
		// delete from comment where comment_no? and manager_id=?
		// 쿼리 작성
		String sql = "DELETE FROM comment WHERE comment_no=? and manager_id=?";
		
		// DB 연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		stmt.setString(2, managerId);
		System.out.println(stmt+ "<-- CommentDao deleteComment의 stmt"); // 디버깅
		
		// 삭제 실행
		stmt.executeUpdate();

	}
	
	// 
	public static int selectCommentCnt(int noticeNo) throws Exception {
		int rowCnt = 0;
		// 쿼리 작성
		String sql = "SELECT count(*) cnt FROM comment WHERE comment_no=?";
		
		// DB 메소드 사용
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		System.out.println(stmt + "<-- CommentDao selectCommentCnt의 stmt"); // 디버깅
		
		// 결과물 복사
		ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				rowCnt = rs.getInt("cnt");
			}
		
		// 리턴
		return rowCnt;
	}
}
