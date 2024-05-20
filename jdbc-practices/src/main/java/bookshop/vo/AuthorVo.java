package bookshop.vo;

public class AuthorVo {
	private Long no;
	private String name;
	
	public Long getNo() {
		return no;
	}
	@Override
	public String toString() {
		return "AuthorVo [no=" + no + ", name=" + name + "]";
	}
	public void setNo(Long no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}	
}
