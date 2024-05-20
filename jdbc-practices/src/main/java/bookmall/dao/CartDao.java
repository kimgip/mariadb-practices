package bookmall.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookmall.vo.CartVo;

public class CartDao {
	private Connection getConnection() throws SQLException {
		Connection conn = null;
		
		// 1. JDBC Driver 로딩
		try {
			Class.forName("org.mariadb.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패:"+e);
		}
		
		// 2. 연결하기
		String url = "jdbc:mariadb://192.168.0.192:3306/bookmall?charset=utf-8";
		conn = DriverManager.getConnection(url, "bookmall", "bookmall");
		
		return conn;
	}

	public int insert(CartVo vo) {
		int result = 0;
		
		try (
				Connection conn = getConnection();
				PreparedStatement pstmt1 = conn.prepareStatement("insert into cart(quantity, user_no, book_no) values(?, ?, ?)");
				PreparedStatement pstmt2 = conn.prepareStatement("select last_insert_id() from dual");
				
		){
			pstmt1.setLong(1, vo.getQuantity());
			pstmt1.setLong(2, vo.getUserNo());
			pstmt1.setLong(3, vo.getBookNo());
			result = pstmt1.executeUpdate();
			
			ResultSet rs = pstmt2.executeQuery();
			vo.setNo(rs.next() ? rs.getLong(1) : null);
			rs.close();
		} catch (SQLException e) {
			System.out.println("error:"+e);
		}
		
		return result;
	}

	public int deleteByUserNoAndBookNo(Long userNo, Long no) {
		int result = 0;
		
		try (
				Connection conn = getConnection();
				PreparedStatement pstmt = conn.prepareStatement("delete from cart where user_no = ? and book_no = ?");
				
		){
			pstmt.setLong(1, userNo);
			pstmt.setLong(2, no);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("error:"+e);
		}
		
		return result;
		
	}
}
