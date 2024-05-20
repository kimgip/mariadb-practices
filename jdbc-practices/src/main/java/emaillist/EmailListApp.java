package emaillist;

import java.util.List;
import java.util.Scanner;

import emaillist.dao.EmaillistDao;
import emaillist.vo.EmaillistVo;

public class EmailListApp {
	private static Scanner scanner = null;
	private static EmaillistDao emaillistdao = new EmaillistDao();
	
	public static void main(String[] args) {
		scanner = new Scanner(System.in);
		
		while(true) {
			System.out.print("(l)ist (d)elete (i)nsert (q)uit > ");
			String command = scanner.nextLine();
			
			if("l".equals(command)) {
				 doList();
			} else if("d".equals(command)) {
				 doDelete();
			} else if("i".equals(command)) {
				doInsert();
			} else if("q".equals(command)) {
				break;
			}
		}
		
		if (scanner!= null) {
			scanner.close();
		}
	}

	private static void doInsert() {
		System.out.print("성:");
		String firstName = scanner.nextLine();
		
		System.out.print("이름:");
		String lastName = scanner.nextLine();
		
		System.out.print("이메일:");
		String email = scanner.nextLine();
		
		EmaillistVo vo = new EmaillistVo();
		vo.setFirstName(firstName);
		vo.setLastName(lastName);
		vo.setEmail(email);
		
		emaillistdao.insert(vo);
		
		doList();
	}

	private static void doDelete() {
		System.out.println("이메일:");
		String email = scanner.nextLine();
		
		emaillistdao.deleteByEmail(email);
	}

	private static void doList() {
		List<EmaillistVo> list = emaillistdao.findAll();
		for(EmaillistVo vo : list) {
			System.out.println(vo.toString());
		}
	}

}
