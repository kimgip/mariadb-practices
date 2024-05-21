package bookmall.vo;

import java.util.Objects;

public class OrderBookVo {
	private int quantity;
	private int price;
	private Long orderNo;
	private Long bookNo;
	private String bookTitle;
	
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public Long getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(Long ordersNo) {
		this.orderNo = ordersNo;
	}
	public Long getBookNo() {
		return bookNo;
	}
	public void setBookNo(Long bookNo) {
		this.bookNo = bookNo;
	}
	public String getBookTitle() {
		return bookTitle;
	}
	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}
	@Override
	public int hashCode() {
		return Objects.hash(bookNo, orderNo, price, quantity);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		OrderBookVo other = (OrderBookVo) obj;
		return Objects.equals(bookNo, other.bookNo) && Objects.equals(orderNo, other.orderNo) && price == other.price
				&& quantity == other.quantity;
	}
}
