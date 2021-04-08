package gdu.mall.dao;

import java.util.*;
import java.sql.*;

import gdu.mall.util.*;
import gdu.mall.vo.*;

public class OrdersDao {
	// ordersList 메소드
	// orders 리스트X --> orders join ebook join client 리스트O
	/*
	 * SELECT
		o.orders_no ordersNo,
		o.ebook_no ebookNo,
		e.ebook_title ebookTitle,
		o.client_no clientNo,
		c.client_mail clientMail,
		o.orders_data ordersDate,
		o.orders_state ordersState
		FROM orders o INNER JOIN ebook e INNER JOIN client c
		ON o.ebook_no = e.ebook_no AND o.client_no = c.client_no;
		ORDER BY o.orders_no desc
	 */
	public static ArrayList<OrdersAndEbookAndClient> selectOrdersListByPage(int rowPerPage, int beginRow) throws Exception {
		// 쿼리 작성
		String sql = "SELECT o.orders_no ordersNo, o.ebook_no ebookNo, e.ebook_title ebookTitle, o.client_no clientNo, c.client_mail clientMail, o.orders_date ordersDate, o.orders_state ordersState FROM orders o INNER JOIN ebook e INNER JOIN client c ON o.ebook_no = e.ebook_no AND o.client_no = c.client_no ORDER BY o.orders_no desc limit ?,?";
		
		// 배열 초기화
		ArrayList<OrdersAndEbookAndClient> list = new ArrayList<>();
		
		// DB 연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		System.out.println(stmt + "<-- OrdersDao selectOrdersListByPage의 stmt"); // 디버깅
		
		// 결과값 추출
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			OrdersAndEbookAndClient oec = new OrdersAndEbookAndClient();
			
			Orders o = new Orders();
			o.setOrdersNo(rs.getInt("ordersNo"));
			o.setEbookNo(rs.getInt("ebookNo"));
			o.setClientNo(rs.getInt("clientNo"));
			o.setOrdersDate(rs.getString("ordersDate"));
			o.setOrdersState(rs.getString("ordersState"));
			oec.setOrders(o);
			
			Ebook e = new Ebook();
			e.setEbookTitle(rs.getString("ebookTitle"));
			oec.setEbook(e);
			
			Client c = new Client();
			c.setClientMail(rs.getString("clientMail"));
			oec.setClient(c);
			
			list.add(oec);
		}
		
		// 리턴
		return list;
	}
	
	// 전체 행의 개수 세는 메소드
		public static int totalCount() throws Exception {
			// 변수 초기화
			int totalRow = 0;
			
			// 쿼리 작성
			String sql = "SELECT COUNT(*) cnt FROM orders";
			
			// DB 연결
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			System.out.println(stmt + " <-- OrdersDao totalcount의 stmt"); // 디버깅
			ResultSet rs = stmt.executeQuery();
				while(rs.next()) {
					totalRow = rs.getInt("cnt");
			}
			
			// 리턴값
			return totalRow;
		}
		
	// 주문 상태 업데이트 메소드 (updateOrdersState)
	public static void updateOrdersState (OrdersAndEbookAndClient oec) throws Exception {
		// 쿼리작성
		String sql = "UPDATE orders SET orders_state = ? WHERE orders_no = ?";
		
		// DB 연결
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, oec.getOrders().getOrdersState());
		stmt.setInt(2, oec.getOrders().getOrdersNo());
		System.out.println(stmt + "<-- OrdersDao updateOrdersState의 stmt"); // 디버깅
		
		// 업데이트 실행
		stmt.executeUpdate();
	}
}
