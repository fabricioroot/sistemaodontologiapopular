<%-- 
    Document   : sucesso
    Created on : 04/02/2010, 22:46:38
    Author     : Fabricio Reis
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>

<script type="text/javascript" language="javascript">
    // Funcao para colocar elemento em foco
    function goFocus(elementID){
        document.getElementById(elementID).focus();
    }
</script>

<link href="<%=request.getContextPath()%>/css/estilo.css" rel="stylesheet" type="text/css">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>SOP - Sistema de Odontologia Popular</title>
    </head>
    <body onload="goFocus('proximaPagina')">
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value=""/>
        </jsp:include>
        <br> &nbsp;
        <br> &nbsp;
        <table width="100%"  border="0" cellspacing="1" cellpadding="1">
            <tr>
                <td align="center" valign="middle"><img src="<%=request.getContextPath()%>/imagens/informacao.png" width="32" height="32" alt="Advert&ecirc;ncia"></td>
            </tr>
            <tr>
                <td align="center" valign="middle"> Opera&ccedil;&atilde;o realizada com sucesso!</td>
            </tr>
            <%
                String URLProximaPagina = (String)request.getSession(false).getAttribute("proximaPagina");
                request.getSession(false).removeAttribute("proximaPagina");
            %>
            <tr>
                <td align="center" valign="middle">
                    <%
                        if (URLProximaPagina != null) {
                    %>
                        <a id="proximaPagina" name="proximaPagina" href="<%=URLProximaPagina%>">Clique aqui para continuar</a>
                    <%
                        } else {
                    %>
                        <a id="proximaPagina" name="proximaPagina" href="<%=request.getContextPath()%>/main.do">Voltar para a p&aacute;gina principal</a>
                    <%
                        }
                    %>
                </td>
            </tr>
        </table>
    </body>
</html>