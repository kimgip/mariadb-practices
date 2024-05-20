package bookmall.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookmall.vo.CategoryVo;

public class CategoryDao {
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

	public int insert(CategoryVo vo) {
		int result = 0;
		
		try (
				Connection conn = getConnection();
				PreparedStatement pstmt1 = conn.prepareStatement("insert into category(name) values(?)");
				PreparedStatement pstmt2 = conn.prepareStatement("select last_insert_id() from dual");
				
		){
			pstmt1.setString(1, vo.getName());
			result = pstmt1.executeUpdate();
			
			ResultSet rs = pstmt2.executeQuery();
			vo.setNo(rs.next() ? rs.getLong(1) : null);
			rs.close();
		} catch (SQLException e) {
			System.out.println("error:"+e);
		}
		
		return result;
	}

	public int deleteByNo(Long no) {
		int result = 0;
		
		try (
				Connection conn = getConnection();
				PreparedStatement pstmt = conn.prepareStatement("delete from category where no = ?");
				
		){
			pstmt.setLong(1, no);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("error:"+e);
		}
		
		return result;
	}
}
