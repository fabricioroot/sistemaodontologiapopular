<%--
    Document   : principal
    Created on : 08/01/2010, 10:21:56
    Author     : Fabricio Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>

<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
    <tr align="left" valign="top" bgcolor="#B0FFAE">
        <td height="27" colspan="4" valign="top" bgcolor="#B0FFAE" style="border: none">
            <%@include file="../menu/menus.jsp"%>
        </td>
    </tr>
    <tr>
        <% // Pega o titulo passado como parametro no request
            String titulo = "";
            try {
                if (request.getParameter("titulo") != null) {
                    titulo = request.getParameter("titulo");
                }
            } catch (Exception e) {
                System.out.println("Falha ao exibir titulo de pagina no cabecalho " + e.getMessage());
            }
        %>
        <td width="4%" align="left" valign="top" style="border: none">
            <img src="<%=request.getContextPath()%>/imagens/empresa_logo.jpg" alt="Logotipo" border="0" title="SOP">
        </td>
        <td width="86%" style="border: none; background-image: url(<%=request.getContextPath()%>/imagens/fundoMenu.jpg)" align="center">
            <div align="center"><strong><font color="#333" size="3"><%= titulo%></font></strong></div>
        </td>
        <td width="10%" style="border: none; background-image: url(<%=request.getContextPath()%>/imagens/fundoMenu.jpg)">
            <table width="100%" cellspacing="0" cellpadding="0" style="border:none">
                <tr>
                    <td style="border:none; background-image: url(<%=request.getContextPath()%>/imagens/fundoMenu.jpg)">
                        <a href="<%=request.getContextPath()%>/main.do" style="border:none"><img src='<%=request.getContextPath()%>/imagens/home.png' style="border:none" alt="Home" title="P&aacute;gina inicial"></a>
                    </td>
                    <td style="border:none; background-image: url(<%=request.getContextPath()%>/imagens/fundoMenu.jpg)">
                        &nbsp;&nbsp;
                    </td>
                    <td style="border:none; background-image: url(<%=request.getContextPath()%>/imagens/fundoMenu.jpg)">
                        <a href="<%=request.getContextPath()%>/login/logout" style="border:none"><img src='<%=request.getContextPath()%>/imagens/sair.png' style="border:none" alt="Sair" title="Sair"></a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>