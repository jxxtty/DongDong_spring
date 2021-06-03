package com.dto;

public class Alarm {
	private String sender; // 댓글 작성한 회원
	private String receiver; // 글 작성한 회원
	private String type; // 댓글
	private String info; // 어떤글에?
	private int isRead;
	
	public Alarm() {
		super();
	}

	public Alarm(String sender, String receiver, String type, String info, int isRead) {
		super();
		this.sender = sender;
		this.receiver = receiver;
		this.type = type;
		this.info = info;
		this.isRead = isRead;
	}

	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getIsRead() {
		return isRead;
	}
	public void setIsRead(int isRead) {
		this.isRead = isRead;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}
	
	@Override
	public String toString() {
		return "Alarm [sender=" + sender + ", receiver=" + receiver + ", type=" + type + ", info=" + info
				+ ", isRead=" + isRead + "]";
	}
	
}
