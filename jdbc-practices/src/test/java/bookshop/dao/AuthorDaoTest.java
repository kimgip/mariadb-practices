package bookshop.dao;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;

import bookshop.vo.AuthorVo;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class AuthorDaoTest {
	private static int count = 0;
	private static AuthorDao authordao = new AuthorDao();
	private static AuthorVo mockAuthorVo = new AuthorVo();
	
	@BeforeAll
	public static void setUP() {
		count = authordao.findAll().size();
	}
	
	@Test
	@Order(1)
	public void testInsert() {
		mockAuthorVo.setName("칼세이건");
		
		authordao.insert(mockAuthorVo);
		// assertTrue(result);
		System.out.println(mockAuthorVo);
		assertNotNull(mockAuthorVo.getNo());
	}
	
	@Test
	@Order(2)
	public void testFindAll() {
		assertEquals(count+1, authordao.findAll().size());
	}
	
	@AfterAll
	public static void cleanUP() {
		authordao.deleteByNo(mockAuthorVo.getNo());
	}
}
