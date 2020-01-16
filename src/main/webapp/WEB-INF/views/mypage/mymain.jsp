<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- 메인페이지 주요 게시글 -->
            <section>
                <header class="major">
                    <h2>My Profile</h2>
                </header>
                <!-- 프로필, 이름, 설정-->
                <div class="row">
                    <div class="col-2 col-12-small">
                        <img src="${contextPath}/resources/images/member/${r.mNo}.png" onerror="this.src='${contextPath}/resources/images/member/default.png'" class="profile-big">
                        <a href="#" class="button small fit">사진 업로드</a>
                    </div>
                    <div class="col-4 col-12-small">
                        <h1>${loginMember.mNick}</h1>
                    </div>
                    
                    <div class="col-6 col-12-small">
                        <a class="button" href="#modifynick">닉네임 수정</a>
                    </div>
            
                </div>
                <br>
                <div class="row myactivity">
                    <div class="col-5 col-12-medium mypoint">
            	        <h4>점수</h4>
                        <p>블라블라  블라블라  블라블라  블라블라  블라블라  블라블라  블라블라  블라블라  블라블라  </p> 
                    </div>
                    <div class="col-5 col-12-medium myactivity">
                        <h4>활동</h4>
                        <p>블라블라  블라블라  블라블라  블라블라  블라블라  블라블라  블라블라  블라블라  블라블라  </p> 
                    </div>
                </div>
                <br>

                <div class="box">
                    추후 별도 수정
                </div>
		
            </section>
            


