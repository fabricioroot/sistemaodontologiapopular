<%-- 
    Document   : login
    Created on : 06/01/2010, 15:21:14
    Author     : Fabricio P. Reis
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
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
        <title>SOP - P&aacute;gina de Autentica&ccedil;&atilde;o</title>
    </head>
    <body onload="goFocus('nomeDeUsuario')">
        <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td width="10%" align="left" valign="top" bgcolor="#E0EEE0"><img src="<%=request.getContextPath()%>/imagens/empresa_logo.jpg" border="0" alt="Logotipo"></td>
                <td width="90%" align="center" bgcolor="#E0EEE0"><strong>SOP - Sistema de Odontologia Popular</strong></td>
            </tr>
        </table>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <%
            String isSessionExpired = "";
            if (request.getParameter("isSessionExpired") != null) {
                isSessionExpired = request.getParameter("isSessionExpired");
                if (isSessionExpired.equals("1")) { %>
                    <div align="center"><font color="#FF0000"><strong><bean:message key="erro.sessaoExpirou"/></strong></font></div>
                    <br>
            <%  }
            }
        %>
        <form name="formLogin" method="post" action="<%=request.getContextPath()%>/login/login.do">
            <table id="login" width="527" border="0" align="center">
                <tr align="left" valign="top">
                    <td colspan="3">
                        &nbsp;
                    </td>
                </tr>
                <tr align="left" valign="top">
                    <td colspan="3">
                        <strong><font color="#26403F">&nbsp;&nbsp;Login do Sistema</font></strong><hr style="color: #CCCCCC" size="1px" width="289" align="left">
                    </td>
                </tr>
                <tr>
                    <td width="36%"><div align="right"><strong>Usu&aacute;rio:</strong></div></td>
                    <td width="2%"><div align="right"></div></td>
                    <td width="62%"><input name="nomeDeUsuario" type="text" id="nomeDeUsuario" title="Digite aqui o nome do usu&aacute;rio de acesso ao sistema" size="20" maxlength="15"></td>
                </tr>
                <tr>
                    <td><div align="right"><strong>Senha:</strong></div></td>
                    <td><div align="right"></div></td>
                    <td><input name="senha" type="password" id="senha" title="Digite aqui a senha de acesso ao sistema" size="20" maxlength="10"></td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="3">
                        <div align="center">
                            <input name="botaoLogar" type="submit" class="botaologin" value="Login">
                            &nbsp;
                            <input name="botaoLimpar" type="reset" class="botaologin" value="Limpar">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;
                     </td>
                </tr>
            </table>
        </form>
    </body>
</html>