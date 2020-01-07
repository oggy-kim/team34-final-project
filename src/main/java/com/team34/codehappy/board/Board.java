package com.team34.codehappy.board;

import java.util.Date;

public class Board {
	private int aNo;
	private int mNo;
	private String mNick;
	private int aType;
	private String aboutMe;
	private int mPoint;
	private String aTag;
	private int view;
	private int like;
	private Date writeDate;
	private Date replyDate;
	private Date changeDate;
	private String bHeader;
	private String bContent;
	private char aStatus;
	private int cType;
	private int star;
	private int reply;

	public Board() {}

	public Board(int aNo, int mNo, String mNick, int aType, String aboutMe, int mPoint, String aTag, int view,
			int like, Date writeDate, Date replyDate, Date changeDate, String bHeader, String bContent, char aStatus,
			int cType, int star, int reply) {
		super();
		this.aNo = aNo;
		this.mNo = mNo;
		this.mNick = mNick;
		this.aType = aType;
		this.aboutMe = aboutMe;
		this.mPoint = mPoint;
		this.aTag = aTag;
		this.view = view;
		this.like = like;
		this.writeDate = writeDate;
		this.replyDate = replyDate;
		this.changeDate = changeDate;
		this.bHeader = bHeader;
		this.bContent = bContent;
		this.aStatus = aStatus;
		this.cType = cType;
		this.star = star;
		this.reply = reply;
	}

	public int getaNo() {
		return aNo;
	}

	public void setaNo(int aNo) {
		this.aNo = aNo;
	}

	public int getmNo() {
		return mNo;
	}

	public void setmNo(int mNo) {
		this.mNo = mNo;
	}

	public String getmNick() {
		return mNick;
	}

	public void setmNick(String mNick) {
		this.mNick = mNick;
	}

	public int getaType() {
		return aType;
	}

	public void setaType(int aType) {
		this.aType = aType;
	}

	public String getAboutMe() {
		return aboutMe;
	}

	public void setAboutMe(String aboutMe) {
		this.aboutMe = aboutMe;
	}

	public int getmPoint() {
		return mPoint;
	}

	public void setmPoint(int mPoint) {
		this.mPoint = mPoint;
	}

	public String getaTag() {
		return aTag;
	}

	public void setaTag(String aTag) {
		this.aTag = aTag;
	}

	public int getView() {
		return view;
	}

	public void setView(int view) {
		this.view = view;
	}

	public int getLike() {
		return like;
	}

	public void setLike(int like) {
		this.like = like;
	}

	public Date getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}

	public Date getReplyDate() {
		return replyDate;
	}

	public void setReplyDate(Date replyDate) {
		this.replyDate = replyDate;
	}

	public Date getChangeDate() {
		return changeDate;
	}

	public void setChangeDate(Date changeDate) {
		this.changeDate = changeDate;
	}

	public String getbHeader() {
		return bHeader;
	}

	public void setbHeader(String bHeader) {
		this.bHeader = bHeader;
	}

	public String getbContent() {
		return bContent;
	}

	public void setbContent(String bContent) {
		this.bContent = bContent;
	}

	public char getaStatus() {
		return aStatus;
	}

	public void setaStatus(char aStatus) {
		this.aStatus = aStatus;
	}

	public int getcType() {
		return cType;
	}

	public void setcType(int cType) {
		this.cType = cType;
	}

	public int getStar() {
		return star;
	}

	public void setStar(int star) {
		this.star = star;
	}

	public int getReply() {
		return reply;
	}

	public void setReply(int reply) {
		this.reply = reply;
	}

	@Override
	public String toString() {
		return "Board [aNo=" + aNo + ", mNo=" + mNo + ", mNick=" + mNick + ", aType=" + aType + ", aboutMe=" + aboutMe
				+ ", mPoint=" + mPoint + ", aTag=" + aTag + ", view=" + view + ", like=" + like
				+ ", writeDate=" + writeDate + ", replyDate=" + replyDate + ", changeDate=" + changeDate + ", bHeader="
				+ bHeader + ", bContent=" + bContent + ", aStatus=" + aStatus + ", cType=" + cType + ", star=" + star
				+ ", reply=" + reply + "]";
	}

	
}
