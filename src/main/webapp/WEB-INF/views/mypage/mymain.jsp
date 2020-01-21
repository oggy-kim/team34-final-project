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
                    <div class="filebox">
                        <div class="col-6 col-12-small">
                            <img src="${contextPath}/resources/images/member/${r.mNo}.png" onerror="this.src='${contextPath}/resources/images/member/default.png'" class="profile-big">
                            <input type="file" id="upload_file" name="upload_file">
                            <label for="upload_file" class="button small">사진업로드</label>
                        </div>
                    </div>
                    <div class="nicknamefont">
                        <div class="col-4 col-12-small">
                            <h1>${loginMember.mNick}</h1>
                            <h4>${loginMember.aboutMe}</h4>
                            <a class="button small" href="#aboutMe">자기소개 수정</a>
                        </div>
                    </div>
                        <div class="col-6 col-12-small">
                            <a class="button small" href="#modifynick">닉네임 수정</a>
                        </div>
                
            
                </div>
                <br>
                <div class="row myactivity">
                    <div class="col-5 col-12-medium mypoint">
            	        <h4>점수</h4>
            	        	<p>
                        		<h3>${loginMember.mPoint}점</h3>
                        	</p>
                    </div>
                    <div class="col-5 col-12-medium myactivity">
                        <h4>활동</h4>
                        <h3>${loginMember.aNo}</h3> 
                    </div>
                </div>
                <br>
                <!-- nav 탭 시작!! -->
                    <ul class="nav nav-tabs">
                        <li class="nav-item">
                            <a class="nav-link active" data-toggle="tab" href="#questions">질문</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#answer">답변</a>
                        </li>
                    </ul>

                    <<div class="tab-content">
                        <div class="tab-pane fade show active" id="##questions">
                        	<c:forEach var="b" items="${ bList }">
                        		<c:out value="${ b.aNo }"></c:out>
                        		<c:out value="${ b.bContent }"></c:out>
                        	</c:forEach>
                            <p>테스트1</p>
                        </div>
                       <%--  <div class="tab-pane fade" id="#answer">
                        	<c:forEach var="r" items="rList">
                        		<c:out value="${ r.rNo }"></c:out>
                        		<c:out value="${ r.rContent }"></c:out>
							</c:forEach>                        	
                            <p>테스트2</p> --%>
                        </div>
                    </div>
		
            </section>
            


