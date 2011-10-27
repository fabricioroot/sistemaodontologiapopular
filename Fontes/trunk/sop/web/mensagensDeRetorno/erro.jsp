<%-- 
    Document   : erro
    Created on : 04/02/2010, 22:46:38
    Author     : Fabricio Reis
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>

<!-- Include de pagina que controla sessao -->
<jsp:include page="/app/controleSessao.jsp"/>

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
    <body onload="goFocus('voltar')">
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value=""/>
        </jsp:include>
        <br> &nbsp;
        <br> &nbsp;
        <table width="100%"  border="0" cellspacing="1" cellpadding="1">
            <tr>
                <td align="center" valign="middle"><img src="<%=request.getContextPath()%>/imagens/erro.png" width="32" height="32" alt="Erro"></td>
            </tr>
            <tr>
                <td align="center" valign="middle">
                    <% 
                        String codigoMensagem = "";
                        boolean voltar = false;
                        if (request.getParameter("codigoMensagem") != null) {
                            codigoMensagem = request.getParameter("codigoMensagem");
                        }
                        if (!codigoMensagem.equals("")) {
                            if (codigoMensagem.equals("1")) { %>
                                <bean:message key="erro.geral"/>
                         <% }
                            else
                                if (codigoMensagem.equals("2")) { %>
                                    <bean:message key="falha.identificar.atendimento"/>
                             <% }
                            else
                                if (codigoMensagem.equals("3")) { %>
                                    <bean:message key="falha.continuar.orcamento"/>
                             <% }
                            else
                                if (codigoMensagem.equals("4")) { %>
                                    <bean:message key="falha.identificar.dente"/>
                             <% }
                            else
                                if (codigoMensagem.equals("5")) { %>
                                    <bean:message key="falha.apagar"/>
                             <% }
                            else
                                if (codigoMensagem.equals("6")) { %>
                                    <bean:message key="falha.validar"/>
                             <% }
                            else
                                if (codigoMensagem.equals("7")) { %>
                                    <bean:message key="falha.salvar"/>
                             <% }
                            else
                                if (codigoMensagem.equals("8")) { %>
                                    <bean:message key="falha.consultar"/>
                             <% }
                            else
                                if (codigoMensagem.equals("9")) { %>
                                    <bean:message key="falha.atualizar"/>
                             <% }
                            else
                                if (codigoMensagem.equals("10")) { %>
                                    <bean:message key="falha.inserirDentista"/>
                             <% }
                            else
                                if (codigoMensagem.equals("11")) { voltar = true; %>
                                    <bean:message key="erro.acessoNegado"/>
                             <% }
                            else
                                if (codigoMensagem.equals("13")) { voltar = true; %>
                                    <bean:message key="falha.formatarData"/>
                             <% }
                            else
                                if (codigoMensagem.equals("19")) { voltar = true; %>
                                    <bean:message key="falha.consultarGrupoAcesso"/>
                             <% }
                            else
                                if (codigoMensagem.equals("20")) { voltar = true; %>
                                    <bean:message key="falha.incluirFicha.filaOrcamento"/>
                             <% }
                            else
                                if (codigoMensagem.equals("21")) { voltar = true; %>
                                    <bean:message key="falha.identificar.usuarioLogado"/>
                             <% }
                            else
                                if (codigoMensagem.equals("23")) { voltar = true; %>
                                    <bean:message key="falha.capturar.registros.chequesBancarios"/>
                             <% }
                            else
                                if (codigoMensagem.equals("24")) { voltar = true; %>
                                    <bean:message key="falha.identificar.ficha"/>
                             <% }
                            else
                                if (codigoMensagem.equals("25")) { voltar = true; %>
                                    <bean:message key="falha.capturar.registros.comprovantesPagamentosCartao"/>
                             <% }
                            else
                                if (codigoMensagem.equals("26")) { voltar = true; %>
                                    <bean:message key="falha.identificar.formaPagamento"/>
                             <% }
                            else
                                if (codigoMensagem.equals("27")) { voltar = true; %>
                                    <bean:message key="falha.valorFinal.naoConfere"/>
                             <% }
                        } %>
                </td>
            </tr>
            <tr>
                <td align="center" valign="middle">
                    <%
                        if (voltar) {
                            out.print("<a href=\"javascript:history.back(1);\"> Voltar!</a>");
                        }
                        else {
                            out.print("<a href=\"" + request.getContextPath() + "/main.do\"> Voltar para a p&aacute;gina principal!</a>");
                        }
                    %>
                </td>
            </tr>
        </table>
    </body>
</html>