package example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class insertEx01 {
	
	public static void main(String[] args) {		
		System.out.println(insert("기획1팀"));
		System.out.println(insert("기획2팀"));
	}
	private static boolean insert(String deptName) {
		boolean result = false;
		Connection conn = null;
		Statement stmt = null;
		try {
			// 1. JDBC Driver 로딩
			Class.forName("org.mariadb.jdbc.Driver");
			
			// 2. 연결하기
			String url = "jdbc:mariadb://192.168.0.192:3306/webdb?charset=utf-8";
			conn = DriverManager.getConnection(url, "webdb", "webdb");
			
			// 3. Statement 생성하기
			stmt = conn.createStatement();
			
			// 4. SQL 실행
			String sql = "insert into dept values(null, '" + deptName +"')";
			int count = stmt.executeUpdate(sql);
			
			// 5. 결과처리
			result = count == 1;
			
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패:"+e);
		} catch (SQLException e) {
			System.out.println("error:"+e);
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					System.out.println("error:"+e);
				}
			}
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println("error:"+e);
				}
			}
		}
		
		return result;
	}

}
