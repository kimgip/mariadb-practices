package bookmall.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookmall.vo.CartVo;
import bookmall.vo.OrderBookVo;
import bookmall.vo.OrderVo;

public class OrderDao {
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

	public int insert(OrderVo vo) {
		int result = 0;
		
		try (
				Connection conn = getConnection();
				PreparedStatement pstmt1 = conn.prepareStatement("insert into orders(number, status, payment, shipping, user_no) values(?, ?, ?, ?, ?)");
				PreparedStatement pstmt2 = conn.prepareStatement("select last_insert_id() from dual");
				
		){
			pstmt1.setString(1, vo.getNumber());
			pstmt1.setString(2, vo.getStatus());
			pstmt1.setLong(3, vo.getPayment());
			pstmt1.setString(4, vo.getShipping());
			pstmt1.setLong(5, vo.getUserNo());
			result = pstmt1.executeUpdate();
			
			ResultSet rs = pstmt2.executeQuery();
			vo.setNo(rs.next() ? rs.getLong(1) : null);
			rs.close();
		} catch (SQLException e) {
			System.out.println("error:"+e);
		}
		
		return result;
	}

	public int insertBook(OrderBookVo vo) {
		int result = 0;
		
		try (
				Connection conn = getConnection();
				PreparedStatement pstmt1 = conn.prepareStatement("insert into orders_book(quantity, price, order_no, book_no) values(?, ?, ?, ?)");
				
		){
			pstmt1.setLong(1, vo.getQuantity());
			pstmt1.setLong(2, vo.getPrice());
			pstmt1.setLong(3, vo.getOrderNo());
			pstmt1.setLong(4, vo.getBookNo());
			result = pstmt1.executeUpdate();
		} catch (SQLException e) {
			System.out.println("error:"+e);
		}
		
		return result;
		
	}

	public int deleteBooksByNo(Long no) {
		int result = 0;
		
		try (
				Connection conn = getConnection();
				PreparedStatement pstmt = conn.prepareStatement("delete from orders_book where order_no = ?");
				
		){
			pstmt.setLong(1, no);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("error:"+e);
		}
		
		return result;
		
	}

	public int deleteByNo(Long no) {
		int result = 0;
		
		try (
				Connection conn = getConnection();
				PreparedStatement pstmt = conn.prepareStatement("delete from orders where no = ?");
				
		){
			pstmt.setLong(1, no);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("error:"+e);
		}
		
		return result;
		
	}

	public OrderVo findByNoAndUserNo(Long no, Long userNo) {
		OrderVo result = null;
		
		try (
				Connection conn = getConnection();
				PreparedStatement pstmt = conn.prepareStatement("select number, status, payment, shipping from orders where no = ? and user_no = ?");
				
		){
			pstmt.setLong(1, no);
			pstmt.setLong(2, userNo);
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = new OrderVo();
				result.setNo(no);
				result.setUserNo(userNo);
				
				result.setNumber(rs.getString(1));
				result.setStatus(rs.getString(2));
				result.setPayment((int)rs.getLong(3));
				result.setShipping(rs.getString(4));
			}
			
			rs.close();
		} catch (SQLException e) {
			System.out.println("error:"+e);
		}
		
		return result;
	}

	public List<OrderBookVo> findBooksByNoAndUserNo(Long no, Long userNo) {
		List<OrderBookVo> result = new ArrayList<OrderBookVo>();
		
		try (
				Connection conn = getConnection();
				PreparedStatement pstmt = conn.prepareStatement("select b.quantity, b.price, c.no, c.title from orders a, orders_book b, book c " 
							+ "where a.no = b.order_no and b.book_no = c.no and a.no = ? and a.user_no = ?");
				
		){
			pstmt.setLong(1, no);
			pstmt.setLong(2, userNo);
			
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next()) {
				OrderBookVo vo = new OrderBookVo();
				vo.setOrderNo(no);
				vo.setQuantity((int)rs.getLong(1));
				vo.setPrice((int)rs.getLong(2));
				vo.setBookNo(rs.getLong(3));
				vo.setBookTitle(rs.getString(4));
				
				result.add(vo);
			}
			
			rs.close();
		} catch (SQLException e) {
			System.out.println("error:"+e);
		}
		
		return result;
	}
}
