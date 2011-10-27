<%-- 
    Document   : controleSessao
    Created on : 19/02/2010, 14:11:16
    Author     : fabricio
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd"> 
<%@page contentType="text/html;charset=ISO-8859-1"%>
<%@page import="dao.HibernateUtil"%>
<%
    if (request.getSession(false).getAttribute("status") == null) {
%>
        <jsp:forward page="../login/login.jsp?isSessionExpired=1"></jsp:forward>
<%  }
    else {
        if(!(Boolean)request.getSession(false).getAttribute("status")) {
%>
            <jsp:forward page="../login/login.jsp?isSessionExpired=1"></jsp:forward>
<%      }
    }
    try {
        HibernateUtil.getSessionFactory().close();
    } catch (Exception e) {
        System.out.println("Falha ao tentar fechar sessao com banco quando sessao do navegador expirou. Exception: " + e.getMessage());
    }
%>