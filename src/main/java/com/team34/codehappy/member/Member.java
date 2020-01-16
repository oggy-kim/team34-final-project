package com.team34.codehappy.member;

import java.util.Date;

public class Member {
	private int mNo;
	private String mId;
	private String mPwd;
	private String mNick;
	private String mLevel;
	private String aboutMe;
	private char mStatus;
	private String myTag;
	private Date joinDate;
	private Date loginDate;
	private int mPoint;
	private int aNo;
	private Date recentReply;

	public Member() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Member(int mNo, String mId, String mPwd, String mNick, String mLevel, String aboutMe, char mStatus,
			String myTag, Date joinDate, Date loginDate, int mPoint, int aNo, Date recentReply) {
		super();
		this.mNo = mNo;
		this.mId = mId;
		this.mPwd = mPwd;
		this.mNick = mNick;
		this.mLevel = mLevel;
		this.aboutMe = aboutMe;
		this.mStatus = mStatus;
		this.myTag = myTag;
		this.joinDate = joinDate;
		this.loginDate = loginDate;
		this.mPoint = mPoint;
		this.aNo = aNo;
		this.recentReply = recentReply;
	}

	public int getmNo() {
		return mNo;
	}

	public void setmNo(int mNo) {
		this.mNo = mNo;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public String getmPwd() {
		return mPwd;
	}

	public void setmPwd(String mPwd) {
		this.mPwd = mPwd;
	}

	public String getmNick() {
		return mNick;
	}

	public void setmNick(String mNick) {
		this.mNick = mNick;
	}

	public String getmLevel() {
		return mLevel;
	}

	public void setmLevel(String mLevel) {
		this.mLevel = mLevel;
	}

	public String getAboutMe() {
		return aboutMe;
	}

	public void setAboutMe(String aboutMe) {
		this.aboutMe = aboutMe;
	}

	public char getmStatus() {
		return mStatus;
	}

	public void setmStatus(char mStatus) {
		this.mStatus = mStatus;
	}

	public String getMyTag() {
		return myTag;
	}

	public void setMyTag(String myTag) {
		this.myTag = myTag;
	}

	public Date getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}

	public Date getLoginDate() {
		return loginDate;
	}

	public void setLoginDate(Date loginDate) {
		this.loginDate = loginDate;
	}

	public int getmPoint() {
		return mPoint;
	}

	public void setmPoint(int mPoint) {
		this.mPoint = mPoint;
	}

	public int getaNo() {
		return aNo;
	}

	public void setaNo(int aNo) {
		this.aNo = aNo;
	}

	public Date getRecentReply() {
		return recentReply;
	}

	public void setRecentReply(Date recentReply) {
		this.recentReply = recentReply;
	}

	@Override
	public String toString() {
		return "Member [mNo=" + mNo + ", mId=" + mId + ", mPwd=" + mPwd + ", mNick=" + mNick + ", mLevel=" + mLevel
				+ ", aboutMe=" + aboutMe + ", mStatus=" + mStatus + ", myTag=" + myTag + ", joinDate=" + joinDate
				+ ", loginDate=" + loginDate + ", mPoint=" + mPoint + ", aNo=" + aNo + ", recentReply=" + recentReply
				+ "]";
	}
	
	
}
