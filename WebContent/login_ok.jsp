<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
String userid = request.getParameter("userid");
String userpw = request.getParameter("userpw"); // 저장해주고

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String sql = "";
String url = "jdbc:mysql://localhost:3306/jspstudy";
String uid = "root";
String upw = "donkii";

try {
   Class.forName("com.mysql.jdbc.Driver"); // com.mysql.cj.jdbc.Driver
   conn = DriverManager.getConnection(url, uid, upw);
   if (conn != null) {
      sql = "SELECT mem_idx, mem_name FROM tb_member WHERE mem_userid=? AND mem_userpw=?";
      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, userid);
      pstmt.setString(2, userpw);
      rs = pstmt.executeQuery();

      if (rs.next()) {
         //로그인성공!
   session.setAttribute("userid", userid);
   session.setAttribute("username", rs.getString("mem_name"));
   session.setAttribute("useridx", rs.getString("mem_idx"));
%>
<script>
   alert('로그인 되었습니다');
   location.href = 'login.jsp'; // 캐시가 사라져서 새로고침되서 여기로 다시 넘어감
</script>
<%
} else {
   //로그인실패!
%>
<script>
   alert('아이디 또는 비밀번호를 확인하세요');
   history.back(); // 캐시가 남아서 돌아가고,다시 전페이지로 돌아감,login.jsp
</script>
<%
}

}
} catch (Exception e) {
e.printStackTrace();

}
%>
