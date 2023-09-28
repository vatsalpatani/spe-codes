<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String s = request.getParameter("txtName");
            String c = request.getParameter("txtCity");
             try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost/college","root","");
                Statement st = con.createStatement();  
                if(request.getParameter("insert")!=null)
                {
                    st.executeUpdate("INSERT into students (name,city) values('"+s+"','"+c+"')");
                }
                else if(request.getParameter("update")!=null)
                {
                    st.executeUpdate("UPDATE students SET name= '"+ s + "',city ='"+c+"'  where name='"+s + "'");
                }
                else if(request.getParameter("delete")!=null)
                {
                    st.executeUpdate("DELETE FROM students WHERE name='" + s +"'");
                }
                String qry = "select * from students";
                ResultSet rs = st.executeQuery(qry);
                %>
                <table border=1>
                <thead><b>Student's List</b></thead>
                <tr>
                <th>Name<th>City</tr>
                <%
                while (rs.next()) {
                    s = rs.getString("name");
                    c = rs.getString("city");
                    %>
                    <tr>
                    <td>  <%=s%>  <td>  <%=c%> 
                    </tr>
                <%}%>
                </table>
                <%
                rs.close();
                st.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </body>
</html>
