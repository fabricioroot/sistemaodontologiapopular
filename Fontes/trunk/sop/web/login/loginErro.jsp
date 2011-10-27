<%-- 
    Document   : loginErro
    Created on : 07/01/2010, 17:39:20
    Author     : Fabricio P. Reis
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="annotations.Funcionario"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>

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
        <title>SOP - P&aacute;gina de autentica&ccedil;&atilde;o</title>
    </head>
    <body onload="goFocus('voltar')">
        <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td width="10%" align="left" valign="top" bgcolor="#E0EEE0"><img src="<%=request.getContextPath()%>/imagens/empresa_logo.jpg" border="0" alt="Logotipo"></td>
                <td width="90%" align="center" bgcolor="#E0EEE0"><strong>SOP - Sistema de Odontologia Popular</strong></td>
            </tr>
        </table>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <table width="100%"  border="0" cellspacing="0" cellpadding="0">
            <%
                String codigoMensagem = "";
                if (request.getParameter("codigoMensagem") != null) {
                    codigoMensagem = request.getParameter("codigoMensagem");
                }
                if (!codigoMensagem.equals("")) {
            %>
            <tr>
                <td align="center" valign="middle"><img src="<%=request.getContextPath()%><%if(codigoMensagem.equals("1") || codigoMensagem.equals("5")) out.print("/imagens/advertencia.png"); else out.print("/imagens/erro.png");%>" width="32" height="32" alt="Advert&ecirc;ncia"></td>
            </tr>
            <%
                    if(codigoMensagem.equals("1")) {
            %>
            <tr>
                <td align="center" valign="middle"><bean:message key="nomeDeUsuarioOuSenha.invalido"/></td>
            </tr>
            <%
                }
                else
                    if (codigoMensagem.equals("2")) {
            %>
            <tr>
                <td align="center" valign="middle"><bean:message key="falha.validarUsuario"/></td>
            </tr>
            <%
                }
                else
                    if (codigoMensagem.equals("3")) {
            %>
            <tr>
                <td align="center" valign="middle"><bean:message key="falha.registrar.usuario.sessao"/></td>
            </tr>
            <%
                }
                else
                    if (codigoMensagem.equals("4")) {
            %>
            <tr>
                <td align="center" valign="middle"><bean:message key="falha.consultar.usuario"/></td>
            </tr>
            <%
                }
                else
                    if (codigoMensagem.equals("5")) {
                        Funcionario funcionario = (Funcionario)request.getAttribute("funcionario");
            %>
            <tr>
                <td align="center" valign="middle"><bean:message key="senha.invalida"/>
                    <%
                        if(!funcionario.getFraseEsqueciMinhaSenha().trim().isEmpty()) {
                    %>
                        <br>
                        Lembrete de senha: <strong>&ldquo;<%=funcionario.getFraseEsqueciMinhaSenha()%>&rdquo;</strong>
                    <%
                        }
                    %>
                </td>
            </tr>
            <%
                    }
                } // if (!codigoMensagem.equals(""))
            %>
            <tr>
                <td align="center" valign="middle">
                    <strong><font color="#FF8C00">Problemas de acesso? Contate o administrator do sistema</font></strong>
                    <br>
                    <br>
                    <a id="voltar" href="<%=request.getContextPath()%>"> Clique aqui para tentar novamente!</a>
                </td>
            </tr>
        </table>
    </body>
</html>