<%-- 
    Document   : principal
    Created on : 08/01/2010, 10:21:56
    Author     : fabricio
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<!-- Include de pagina que controla sessao -->
<jsp:include page="/app/controleSessao.jsp"/>

<link href="<%=request.getContextPath()%>/css/estiloGeral.css" rel="stylesheet" type="text/css">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>SOP - Sistema de Odontologia Popular</title>
    </head>
    <body>
        <jsp:include page="/app/cabecalho.jsp" flush="true"/>
    </body>
</html>
