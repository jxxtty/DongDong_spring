package com.dto;

public class ChatMessage {
	private int pr_id;
	private String sendtime;
	private String chatid;
	private String fromname;
	private String toname;
	private String fromid;
	private String toid;
	private String message;
	private int chatread;
	private String pr_email;

	public ChatMessage() {

	}
	
	public ChatMessage(int pr_id) {
		this.pr_id = pr_id;
	}
	
	public ChatMessage(String message, String fromname, String sendtime, String fromid) {
		this.message = message;
		this.fromname = fromname;
		this.sendtime = sendtime;
		this.fromid = fromid;
	}

	

	public ChatMessage(int pr_id, String toname, String toid) {
		super();
		this.pr_id = pr_id;
		this.toname = toname;
		this.toid = toid;
	}

	public ChatMessage(int pr_id, String sendtime, String fromname, String toname, String fromid, String toid,
			String message, int chatread, String chatid, String pr_email) {
		super();
		this.pr_id = pr_id;
		this.sendtime = sendtime;
		this.fromname = fromname;
		this.toname = toname;
		this.fromid = fromid;
		this.toid = toid;
		this.message = message;
		this.chatread = chatread;
		this.chatid = chatid;
		this.pr_email = pr_email;
	}

	@Override
	public String toString() {
		return "ChatMessage [pr_id=" + pr_id + ", sendtime=" + sendtime + ", chatid=" + chatid + ", fromname="
				+ fromname + ", toname=" + toname + ", fromid=" + fromid + ", toid=" + toid + ", message=" + message
				+ ", chatread=" + chatread + ", pr_email=" + pr_email + "]";
	}

	public int getPr_id() {
		return pr_id;
	}

	public void setPr_id(int pr_id) {
		this.pr_id = pr_id;
	}

	public String getSendtime() {
		return sendtime;
	}

	public void setSendtime(String sendtime) {
		this.sendtime = sendtime;
	}

	public String getChatid() {
		return chatid;
	}

	public void setChatid(String chatid) {
		this.chatid = chatid;
	}

	public String getFromname() {
		return fromname;
	}

	public void setFromname(String fromname) {
		this.fromname = fromname;
	}

	public String getToname() {
		return toname;
	}

	public void setToname(String toname) {
		this.toname = toname;
	}

	public String getFromid() {
		return fromid;
	}

	public void setFromid(String fromid) {
		this.fromid = fromid;
	}

	public String getToid() {
		return toid;
	}

	public void setToid(String toid) {
		this.toid = toid;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public int getChatread() {
		return chatread;
	}

	public void setChatread(int chatread) {
		this.chatread = chatread;
	}

	public String getPr_email() {
		return pr_email;
	}

	public void setPr_email(String pr_email) {
		this.pr_email = pr_email;
	}
	
	
    
    
    
    
}
