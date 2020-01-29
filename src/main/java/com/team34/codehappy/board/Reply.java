package com.team34.codehappy.board;

import java.util.Date;

public class Reply {
	private int rNo; // 댓글 고유번호
	private int mNo; // 댓글 작성자
	private String mNick; // 회원 닉네임
	private String mPoint; // 회원 점수
	private String aboutMe; // 회원 자기소개
	private int aNo; // 댓글 소속 글번호
	private int like; // 댓글 좋아요
	private String rContent; // 댓글 내용
	private Date writeDate; // 댓글 작성 시간
	private Date modifyDate; // 댓글 수정 시간
	private char rStatus; // 댓글 상태
	private int refRNo; // 참고 댓글 번호
	
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
