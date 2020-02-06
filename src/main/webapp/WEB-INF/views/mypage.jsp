<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="common/include.jsp" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<div id="body">
<!-- Wrapper -->
<div id="wrapper">
        <!-- Main -->
        <div id="main">
                <div class="inner">
                    <c:import url="./common/header.jsp"/>
                    <style>
                        p {
                            margin: 20px 0px;
                        }
                    </style>
                    <c:import url="./mypage/mymain.jsp"/>
                </div>
        </div>
        <c:import url="./common/sidebar.jsp"/>
        <form action="${contextPath}/mypage/${loginMember.mNo}" method="post">
            <input id="test_mid" name="mId" value="${loginMember.mId}">
            <input id="test_mid" name="mPoint" value="${loginMember.mPoint}">
            <input id="test_mid" name="aNo" value="${loginMember.aNo}">
            <!-- 닉네임 변경 시작 -->
            <div class="modifyForm" id="modifynick">
                            <div class="popup">
                                    <div id="nick-div">
                                            <div id="nick-margin">
                                                <h2 id="nick-h2">변경할 닉네임</h2>
                                                <h3 id="nick-h3">(9글자 내)</h3>
                                            </div>
                                        </div>
                                <a class="close" href="#">&times;</a>
                                <br>
                                <div class="contented">
                                    <input type="text" name="mNick" id="mNick" value="${ loginMember.mNick }" autocomplete="off">
                                    <input type="hidden" name="mNickCheck" id="mNickCheck" value="0">
                                </div>
                                <br>
                                <div class="actionButton">
                                    <input type="submit" value="확인" onclick="return mNickValidate();">&nbsp;&nbsp;
                                    <!-- onclick="return mNickValidate();" -->
                                    <button type="button" onclick="location.href='${ mymain }'">취소</button>
                                </div>
                            </div>
            </div>

            <script>
                $(function(){
                    $("#mNick").focusout(function(){
                    // $("#mNick").on("keyup", function(){
                    var mNick = $(this).val();
                    
                    if(mNick.length < 2){
                        $("#mNickCheck").val(0);

                        return false;
                    }

                    $.ajax({
                        url:"dupnick",
                        data:{mNick:mNick},
                        success:function(data){
                            if(data.isUsable == true){
                                $("#mNickCheck").val(1);
                            } else {
                                $("#mNickCheck").val(0);

                                console.log(mNickCheck);
                            }
                        },
                        error:function(){
                            console.log("ajax 통신 실패");
                        }
                    });
                });
            });

            function mNickValidate() {
                if($('#mNick').val().length<2){
                    alert("닉네임은 두 글자 이상입니다.");
                    $('#mNick').focus();
                    return false;
                }
                
                if($('#mNick').val().length>9){
                    alert("닉네임은 9글자 이하입니다.");
                    $('#mNick').focus();
                    return false;
                }

                if($("#mNickCheck").val() == 0){
                    alert('해당 닉네임이 존재합니다. 사용 가능한 닉네임을 입력해주세요')
                    $("#mNick").focus();
                    return false;
                }
            };
            </script>
            <!-- 닉네임 변경 끝 -->
            <!-- 자기소개 변경 시작 -->
            <div class="aboutmeForm" id="aboutMe">
                <div class="popup2">
                        <div id="nick-div2">
                                <div id="nick-margin2">
                                    <h2 id="nick-h2">자기소개를 등록해주세요.</h2>
                                    <h3 id="nick-h3">(최대 50자)</h3>
                                </div>
                            </div>
                    <a class="close" href="#">&times;</a>
                    <br>
                    <div class="contented2">
                        <p>
                            <textarea class="aboutMe" id="aboutMe" name="aboutMe" placeholder="자기소개는 최대 50자까지 입력됩니다."
                                style="padding: 5px; width: 100%; height: 150px" maxlength="50"></textarea>
                            <span style="coloe:#aaa;" id="counter">(0 / 최대 50자)</span>
                        </p>
                    </div>
                    <br>
                    <div class="actionButton2">
                        <input type="submit" value="확인">&nbsp;&nbsp;&nbsp;&nbsp;
                        <button type="button" onclick="location.href='${ mymain }'">취소</button>
                    </div>
                </div>
            </div>
            <script>
                $('.aboutMe').keyup(function(e){
                    var content = $(this).val();
                    $('#counter').html("("+content.length+" / 최대 50자)");

                    if(content.length > 50){
                        alert("최대 50자까지 입력 가능합니다.");
                        $(this).val(content.substring(0,50));
                        $('#counter').html("(50 / 최대 50자)");
                    }
                });

            </script>
            <!-- 자기소개 변경 끝 -->
            </form>
        </div>
</div>



    <!-- Scripts -->
    <script src="resources/js/jquery.min.js"></script>
    <script src="resources/js/browser.min.js"></script>
    <script src="resources/js/breakpoints.min.js"></script>
    <script src="resources/js/util.js"></script>
    <script src="resources/js/main.js"></script>
    <script src="resources/js/fetch.js"></script>
    <script src="resources/js/slim.min.js"></script>
    <script src="resources/js/popper.min.js"></script>
    <script src="resources/js/bootstrap.min.js"></script>
</body>
</html>