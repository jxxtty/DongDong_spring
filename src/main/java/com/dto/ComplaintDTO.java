package com.dto;

import org.apache.ibatis.type.Alias;

@Alias("ComplaintDTO")
public class ComplaintDTO {
	private int coNum;
	private int coType;
	private String coTarget;
	private String userid;
	private String coContent;
	private String coYn;
	private String createDate;
	private String endDate;
	public ComplaintDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ComplaintDTO(int coNum, int coType, String coTarget, String userid, String coContent, String coYn,
			String createDate, String endDate) {
		super();
		this.coNum = coNum;
		this.coType = coType;
		this.coTarget = coTarget;
		this.userid = userid;
		this.coContent = coContent;
		this.coYn = coYn;
		this.createDate = createDate;
		this.endDate = endDate;
	}
	@Override
	public String toString() {
		return "ComplaintDTO [coNum=" + coNum + ", coType=" + coType + ", coTarget=" + coTarget + ", userid=" + userid
				+ ", coContent=" + coContent + ", coYn=" + coYn + ", createDate=" + createDate + ", endDate=" + endDate
				+ "]";
	}
	public int getCoNum() {
		return coNum;
	}
	public void setCoNum(int coNum) {
		this.coNum = coNum;
	}
	public int getCoType() {
		return coType;
	}
	public void setCoType(int coType) {
		this.coType = coType;
	}
	public String getCoTarget() {
		return coTarget;
	}
	public void setCoTarget(String coTarget) {
		this.coTarget = coTarget;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getCoContent() {
		return coContent;
	}
	public void setCoContent(String coContent) {
		this.coContent = coContent;
	}
	public String getCoYn() {
		return coYn;
	}
	public void setCoYn(String coYn) {
		this.coYn = coYn;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
}
