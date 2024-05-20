package bookshop.vo;

public class BookVo {
	private Long no;
	private String title;
	private String status;
	private Long AuthorNo;
	private String authorName;
	
	
	@Override
	public String toString() {
		return "BookVo [no=" + no + ", title=" + title + ", status=" + status + ", AuthorNo=" + AuthorNo
				+ ", authorName=" + authorName + "]";
	}
	public String getAuthorName() {
		return authorName;
	}
	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}
	public Long getNo() {
		return no;
	}
	public void setNo(Long no) {
		this.no = no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Long getAuthorNo() {
		return AuthorNo;
	}
	public void setAuthorNo(Long authorNo) {
		AuthorNo = authorNo;
	}
}
