<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<jsp:useBean id="now" class="java.util.Date" />

<!-- 메인페이지 주요 게시글 -->
            <section>
                <header class="major">
                    <h2>My Profile</h2>
                </header>
                <!-- 프로필, 이름, 설정-->
                <div class="row">
                    <label class="label" data-toggle="tooltip" title="프로필사진 변경">
                        <img class="profile-big" id="avatar" src="${contextPath}/resources/images/member/${loginMember.mNo}.png" onerror="this.src='${contextPath}/resources/images/member/default.png'" alt="avatar">
                        <input type="file" class="sr-only" id="input" name="image" accept="image/*">
                    </label>
                    <div class="alert" role="alert"></div>
                    <div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title" id="modalLabel">이미지 사이즈를 조정해주세요.</h3>
                        </div>
                        <div class="modal-body">
                            <div class="img-container">
                            <img id="image" src="https://avatars0.githubusercontent.com/u/3456749">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="button secondary" data-dismiss="modal">취소</button>
                            <button type="button" class="button primary" id="crop">등록</button>
                        </div>
                        </div>
                    </div>
                    </div>
                    <script src="https://code.jquery.com/jquery-3.4.1.min.js" crossorigin="anonymous"></script>
                    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
                    <script type="text/javascript" src="${contextPath}/resources/js/cropper.js"></script>

                    <script>
                        window.addEventListener('DOMContentLoaded', function () {
                          var avatar = document.getElementById('avatar');
                          var image = document.getElementById('image');
                          var input = document.getElementById('input');
                          var $progress = $('.progress');
                          var $progressBar = $('.progress-bar');
                          var $alert = $('.alert');
                          var $modal = $('#modal');
                          var cropper;
                    
                          $('[data-toggle="tooltip"]').tooltip();
                    
                          input.addEventListener('change', function (e) {
                            var files = e.target.files;
                            var done = function (url) {
                              input.value = '';
                              image.src = url;
                              $alert.hide();
                              $modal.modal('show');
                            };
                            var reader;
                            var file;
                            var url;
                    
                            if (files && files.length > 0) {
                              file = files[0];
                    
                              if (URL) {
                                done(URL.createObjectURL(file));
                              } else if (FileReader) {
                                reader = new FileReader();
                                reader.onload = function (e) {
                                  done(reader.result);
                                };
                                reader.readAsDataURL(file);
                              }
                            }
                          });
                    
                          $modal.on('shown.bs.modal', function () {
                            cropper = new Cropper(image, {
                              aspectRatio: 1,
                              viewMode: 3,
                            });
                          }).on('hidden.bs.modal', function () {
                            cropper.destroy();
                            cropper = null;
                          });
                    
                          document.getElementById('crop').addEventListener('click', function () {
                            var initialAvatarURL;
                            var canvas;
                    
                            $modal.modal('hide');
                    
                            if (cropper) {
                              canvas = cropper.getCroppedCanvas({
                                width: 160,
                                height: 160,
                              });
                              initialAvatarURL = avatar.src;
                              avatar.src = canvas.toDataURL();
                              $progress.show();
                              $alert.removeClass('alert-success alert-warning');
                              canvas.toBlob(function (blob) {
                                var formData = new FormData();
                    
                                formData.append('avatar', blob);
                                console.log(formData);
                                $.ajax('${contextPath}/mypage/updateProfilePic', {
                                  method: 'POST',
                                  data: formData,
                                  processData: false,
                                  contentType: false,
                    
                                  xhr: function () {
                                    var xhr = new XMLHttpRequest();
                    
                                    xhr.upload.onprogress = function (e) {
                                      var percent = '0';
                                      var percentage = '0%';
                    
                                      if (e.lengthComputable) {
                                        percent = Math.round((e.loaded / e.total) * 100);
                                        percentage = percent + '%';
                                        $progressBar.width(percentage).attr('aria-valuenow', percent).text(percentage);
                                      }
                                    };
                    
                                    return xhr;
                                  },
                                  success: function (result) {
                                    console.log(result);
                                    console.log("성공");
                                  },
                    
                                  error: function () {
                                    avatar.src = initialAvatarURL;
                                  },
                    
                                  complete: function () {
                                    $progress.hide();
                                  },
                                });
                              }, 'image/png');
                            }
                          });
                        });
                      </script>

                    <div class="nicknamefont">
                        <div class="col-4 col-12-small">
                            <h1>${loginMember.mNick}</h1>
                            <h4>${loginMember.aboutMe}</h4>
                            <a class="button small" href="#aboutMe">자기소개 수정</a>
                            <!-- href="#aboutMe"  -->
                        </div>
                        <br>
                        <div class="col-4 col-12-small">
                            <a class="button small" onclick="updatePwd();">비밀번호 변경</a>
                        </div>
                        <br>
                        <div class="col-4 col-12-small">
                            <a class="button small" onclick="deleteMember(${loginMember.mNo});">**회원 탈퇴**</a>
                        </div>
                    </div>
                        <div class="col-6 col-12-small">
                            <a class="button small" href="#modifynick">닉네임 수정</a>
                            <!-- href="#modifynick" -->
                        </div>
                </div>

                <script>
                    function deleteMember(mNo) {
                        if(confirm('삭제하시겠습니까?')) {
                            location.href="${contextPath}/member/" + mNo;
                        }
                    }

                </script>
                
                <br>
                <div class="row myactivity">
                    <div class="col-4 col-12-medium mylist">
                        <h4>나의 최근게시글</h4>
                        <div class="table-wrapper">
                            <table>
                            <thead>
                                <tr>
                                    <th style="width:50%;">제목</th>
                                    <th>작성</th>
                                    <th>댓글</th>
                                    <th>조회</th>
                                </tr>
                        </thead>
                        <tbody>
                            <c:if test="${fn:length(bList) eq 0}">작성한 게시글이 없습니다.</c:if>
                            <c:forEach var="b" items="${bList}" begin="0" end="4">
                            <tr class="board-list" value="${b.aNo}">
                                <td>
                                    <input type="hidden" name="aNo" value="${b.aNo}">${b.bHeader} 
                                </td>
                                <td>
                                    <fmt:parseNumber value="${b.writeDate.time}" integerOnly="true" var="writeDate"/>
                                    <fmt:parseNumber value="${now.time}" integerOnly="true" var="nowDate"/>
                                    <c:set var="diff" value="${nowDate / 1000 - writeDate / 1000}"/>
                                    <c:choose>
                                        <c:when test="${diff lt 120}">방금 전
                                        </c:when>
                                        <c:when test="${diff lt (60*60)}">
                                            <fmt:parseNumber var="minute" integerOnly="true" value="${diff / 60}"/>
                                            ${minute}분 전
                                        </c:when>
                                        <c:when test="${diff lt (60*60*24)}">
                                            <fmt:parseNumber var="hour" integerOnly="true" value="${diff / (60 * 60)}"/>
                                                ${hour}시간 전
                                        </c:when>
                                        <c:when test="${diff lt (60*60*24*7)}">
                                            <fmt:parseNumber var="day" integerOnly="true" value="${diff / (60*60*24) }"/>
                                            ${day}일 전
                                        </c:when>
                                        <c:when test="${diff lt (60*60*24*30)}">
                                            <fmt:parseNumber var="week" integerOnly="true" value="${diff / (60*60*24*7) }"/>
                                            ${week}주 전
                                        </c:when>
                                        <c:when test="${diff lt (60*60*24*365)}">
                                            <fmt:parseNumber var="month" integerOnly="true" value="${diff / (60*60*24*30) }"/>
                                            ${month}달 전
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:parseNumber var="year" integerOnly="true" value="${diff / (60*60*24*30*365) }"/>
                                            ${year}년 전
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <c:choose>
                                    <c:when test="${b.replyDate ne null}">
                                        <td>
                                            <fmt:parseNumber value="${b.replyDate.time}" integerOnly="true" var="writeDate"/>
                                            <fmt:parseNumber value="${now.time}" integerOnly="true" var="nowDate"/>
                                            <c:set var="diff" value="${nowDate / 1000 - writeDate / 1000}"/>
                                            <c:choose>
                                                <c:when test="${diff lt 120}">방금 전
                                                </c:when>
                                                <c:when test="${diff lt (60*60)}">
                                                    <fmt:parseNumber var="minute" integerOnly="true" value="${diff / 60}"/>
                                                    ${minute}분 전
                                                </c:when>
                                                <c:when test="${diff lt (60*60*24)}">
                                                    <fmt:parseNumber var="hour" integerOnly="true" value="${diff / (60 * 60)}"/>
                                                        ${hour}시간 전
                                                </c:when>
                                                <c:when test="${diff lt (60*60*24*7)}">
                                                    <fmt:parseNumber var="day" integerOnly="true" value="${diff / (60*60*24) }"/>
                                                    ${day}일 전
                                                </c:when>
                                                <c:when test="${diff lt (60*60*24*30)}">
                                                    <fmt:parseNumber var="week" integerOnly="true" value="${diff / (60*60*24*7) }"/>
                                                    ${week}주 전
                                                </c:when>
                                                <c:when test="${diff lt (60*60*24*365)}">
                                                    <fmt:parseNumber var="month" integerOnly="true" value="${diff / (60*60*24*30) }"/>
                                                    ${month}달 전
                                                </c:when>
                                                <c:otherwise>
                                                    <fmt:parseNumber var="year" integerOnly="true" value="${diff / (60*60*24*30*365) }"/>
                                                    ${year}년 전
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </c:when>
                                    <c:otherwise>
                                        <td>
                                            없음
                                        </td>
                                    </c:otherwise>
                                </c:choose>
                                <td>
                                    ${b.view}
                                </td>
                            </tr>
                        </c:forEach>
                        
                        </tbody>
                        </table>
                        </div>
                    </div>
                    <div class="col-3 col-12-medium mylist">
                        <h4>나의 찜목록</h4>
                        <div class="table-wrapper">
                        <table>
                        <thead>
                            <tr>
                                <th style="width:70%;">제목</th>
                                <th>작성일</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${fn:length(sList) eq 0}">찜한 게시글이 없습니다.</c:if>
                            <c:set var="offset" value="1"/>
                            <c:forEach var="s" items="${sList}" begin="0" end="4">
                                <tr class="board-list" value="${s.aNo}">
                                    <td>
                                        <input type="hidden" name="aNo" value="${s.aNo}">${s.bHeader}
                                    </td>
                                    <td>
                                        <fmt:parseNumber value="${s.writeDate.time}" integerOnly="true" var="writeDate"/>
                                        <fmt:parseNumber value="${now.time}" integerOnly="true" var="nowDate"/>
                                        <c:set var="diff" value="${nowDate / 1000 - writeDate / 1000}"/>
                                        <c:choose>
                                            <c:when test="${diff lt 120}">
                                                방금 전
                                            </c:when>
                                            <c:when test="${diff lt (60*60)}">
                                                <fmt:parseNumber var="minute" integerOnly="true" value="${diff / 60}"/>
                                                ${minute}분 전
                                            </c:when>
                                            <c:when test="${diff lt (60*60*24)}">
                                                <fmt:parseNumber var="hour" integerOnly="true" value="${diff / (60 * 60)}"/>
                                                    ${hour}시간 전
                                            </c:when>
                                            <c:when test="${diff lt (60*60*24*7)}">
                                                <fmt:parseNumber var="day" integerOnly="true" value="${diff / (60*60*24) }"/>
                                                ${day}일 전
                                            </c:when>
                                            <c:when test="${diff lt (60*60*24*30)}">
                                            <fmt:parseNumber var="week" integerOnly="true" value="${diff / (60*60*24*7) }"/>
                                                ${week}주 전
                                            </c:when>
                                            <c:when test="${diff lt (60*60*24*365)}">
                                                <fmt:parseNumber var="month" integerOnly="true" value="${diff / (60*60*24*30) }"/>
                                                ${month}달 전
                                            </c:when>
                                            <c:otherwise>
                                                <fmt:parseNumber var="year" integerOnly="true" value="${diff / (60*60*24*30*365) }"/>
                                                ${year}년 전
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    </div>
                    </div>
                    <div class="col-4 col-12-medium mylist">
                        <h4>최근 댓글활동</h4>
                        <div class="table-wrapper">
                        <table>
                        <thead>
                            <tr>
                                <th style="width:60%;">제목</th>
                                <th>작성일</th>
                                <th>좋아요</th>
                            </tr>
                        </thead>
                         <tbody>
                             <c:if test="${fn:length(rList) eq 0}">작성한 댓글 내용이 없습니다.</c:if>
                             <c:set var="offset" value="1"/>
                             <c:forEach var="r" items="${rList}" begin="0" end="4">
                                <tr class="reply-list" value="${r.aNo}">
                                    <td>
                                        <input type="hidden" name="rNo" value="${r.aNo}">${r.rContent} 
                                    </td>
                                    <td>
                                        <fmt:parseNumber value="${r.writeDate.time}" integerOnly="true" var="writeDate"/>
                                        <fmt:parseNumber value="${now.time}" integerOnly="true" var="nowDate"/>
                                        <c:set var="diff" value="${nowDate / 1000 - writeDate / 1000}"/>
                                        <c:choose>
                                            <c:when test="${diff lt 120}">
                                                방금 전
                                            </c:when>
                                            <c:when test="${diff lt (60*60)}">
                                                <fmt:parseNumber var="minute" integerOnly="true" value="${diff / 60}"/>
                                                ${minute}분 전
                                            </c:when>
                                            <c:when test="${diff lt (60*60*24)}">
                                                <fmt:parseNumber var="hour" integerOnly="true" value="${diff / (60 * 60)}"/>
                                                    ${hour}시간 전
                                            </c:when>
                                            <c:when test="${diff lt (60*60*24*7)}">
                                                <fmt:parseNumber var="day" integerOnly="true" value="${diff / (60*60*24) }"/>
                                                ${day}일 전
                                            </c:when>
                                            <c:when test="${diff lt (60*60*24*30)}">
                                                <fmt:parseNumber var="week" integerOnly="true" value="${diff / (60*60*24*7) }"/>
                                                ${week}주 전
                                            </c:when>
                                            <c:when test="${diff lt (60*60*24*365)}">
                                                <fmt:parseNumber var="month" integerOnly="true" value="${diff / (60*60*24*30) }"/>
                                                ${month}달 전
                                            </c:when>
                                            <c:otherwise>
                                                <fmt:parseNumber var="year" integerOnly="true" value="${diff / (60*60*24*30*365) }"/>
                                                ${year}년 전
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        ${r.like}
                                    </td>
                                </tr>
                             </c:forEach>
                         </tbody>
                        </table>
                    </div>
                    </div>
                </div>
                <br>
                    <!-- 비밀번호 재설정 윈도우 창 띄우기!! -->
                    <script>
                        function updatePwd(){
                            window.open('updatePwd','비밀번호 재설정','width=550, height=400, left=300, top=150');
                            
                        }

                        const myactivity = document.querySelector('.myactivity');
                        myactivity.addEventListener('click', (e) => {
                            if(e.target.parentElement.className === 'board-list' || e.target.parentElement.className === 'reply-list') {
                                const aNo = e.target.parentElement.getAttribute('value');
                                location.href="${contextPath}/board/" + aNo;
                            }
                        })
                    </script>
            </section>
            


