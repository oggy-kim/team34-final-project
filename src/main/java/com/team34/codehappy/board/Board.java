package com.team34.codehappy.board;

import java.util.Date;

public class Board {
	private int aNo; // 게시판 번호
	private int mNo; // 게시글 작성자
	private String mNick; // 회원 닉네임
	private int aType; // 게시판 분료 (1:게시판 / 2: 블로그)
	private String aboutMe; // 회원 자기소개
	private int mPoint; // 회원 점수
	private String aTag; // 글 분류 태그
	private int view; // 글 조회 수
	private int like; // 글 좋아요 수
	private Date writeDate; // 글 작성일
	private Date replyDate; // 댓글 작성시간
	private Date changeDate; // 게시물 & 댓글 바뀐 시간
	private String bHeader; // 게시글 제목
	private String bContent; // 게시글 내용
	private char aStatus; // 게시글 상태
	private int cType; // 게시물 내용 분류
	private int star;
	private int reply;
	private String imageUrl;

	public Board() {
	}

	public Board(int aNo, int mNo, String mNick, int aType, String aboutMe, int mPoint, String aTag, int view, int like,
			Date writeDate, Date replyDate, Date changeDate, String bHeader, String bContent, char aStatus, int cType,
			int star, int reply, String imageUrl) {
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
		this.imageUrl = imageUrl;
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

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	@Override
	public String toString() {
		return "Board [aNo=" + aNo + ", mNo=" + mNo + ", mNick=" + mNick + ", aType=" + aType + ", aboutMe=" + aboutMe
				+ ", mPoint=" + mPoint + ", aTag=" + aTag + ", view=" + view + ", like=" + like + ", writeDate="
				+ writeDate + ", replyDate=" + replyDate + ", changeDate=" + changeDate + ", bHeader=" + bHeader
				+ ", bContent=" + bContent + ", aStatus=" + aStatus + ", cType=" + cType + ", star=" + star + ", reply="
				+ reply + ", imageUrl=" + imageUrl + "]";
	}

	
}
