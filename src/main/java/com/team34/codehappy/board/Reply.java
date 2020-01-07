package com.team34.codehappy.board;

import java.util.Date;

public class Reply {
	private int rNo;
	private int mNo;
	private String mNick;
	private String mPoint;
	private String aboutMe;
	private int aNo;
	private int like;
	private String rContent;
	private Date writeDate;
	private Date modifyDate;
	private char rStatus;
	private int refRNo;
	
	public Reply() {}

	public Reply(int rNo, int mNo, String mNick, String mPoint, String aboutMe, int aNo, int like, String rContent,
			Date writeDate, Date modifyDate, char rStatus, int refRNo) {
		super();
		this.rNo = rNo;
		this.mNo = mNo;
		this.mNick = mNick;
		this.mPoint = mPoint;
		this.aboutMe = aboutMe;
		this.aNo = aNo;
		this.like = like;
		this.rContent = rContent;
		this.writeDate = writeDate;
		this.modifyDate = modifyDate;
		this.rStatus = rStatus;
		this.refRNo = refRNo;
	}

	public int getrNo() {
		return rNo;
	}

	public void setrNo(int rNo) {
		this.rNo = rNo;
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

	public String getmPoint() {
		return mPoint;
	}

	public void setmPoint(String mPoint) {
		this.mPoint = mPoint;
	}

	public String getAboutMe() {
		return aboutMe;
	}

	public void setAboutMe(String aboutMe) {
		this.aboutMe = aboutMe;
	}

	public int getaNo() {
		return aNo;
	}

	public void setaNo(int aNo) {
		this.aNo = aNo;
	}

	public int getLike() {
		return like;
	}

	public void setLike(int like) {
		this.like = like;
	}

	public String getrContent() {
		return rContent;
	}

	public void setrContent(String rContent) {
		this.rContent = rContent;
	}

	public Date getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}

	public Date getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}

	public char getrStatus() {
		return rStatus;
	}

	public void setrStatus(char rStatus) {
		this.rStatus = rStatus;
	}

	public int getRefRNo() {
		return refRNo;
	}

	public void setRefRNo(int refRNo) {
		this.refRNo = refRNo;
	}

	@Override
	public String toString() {
		return "Reply [rNo=" + rNo + ", mNo=" + mNo + ", mNick=" + mNick + ", mPoint=" + mPoint + ", aboutMe=" + aboutMe
				+ ", aNo=" + aNo + ", like=" + like + ", rContent=" + rContent + ", writeDate=" + writeDate
				+ ", modifyDate=" + modifyDate + ", rStatus=" + rStatus + ", refRNo=" + refRNo + "]";
	}
	
}
