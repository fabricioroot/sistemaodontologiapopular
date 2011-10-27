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
        <table width="100%"  border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td align="center" valign="middle"><img src="<%=request.getContextPath()%>/imagens/advertencia.png" width="32" height="32" alt="Advert&ecirc;ncia"></td>
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
                            if (codigoMensagem.equals("1")) { voltar = true; %>
                                <bean:message key="ficha.jaEstaNaFilaAtendimentoOrcamento"/>
                    <%      }
                            else
                                if (codigoMensagem.equals("2")) { voltar = true; %>
                                    <bean:message key="ficha.jaEstaNaFilaAtendimentoTratamento"/>
                             <% }
                            else
                                if (codigoMensagem.equals("3")) { voltar = true; %>
                                    <bean:message key="funcionario.naoEhDentista"/>
                             <% }
                            else
                                if (codigoMensagem.equals("4")) { voltar = true; %>
                                    <bean:message key="nomeDeUsuario.jaExiste"/>
                             <% }
                            else
                                if (codigoMensagem.equals("5")) { voltar = true; %>
                                    <bean:message key="cpf.jaExiste"/>
                             <% }
                            else
                                if (codigoMensagem.equals("6")) { voltar = true; %>
                                    <bean:message key="rg.jaExiste"/>
                             <% }
                            else
                                if (codigoMensagem.equals("7")) { voltar = true; %>
                                    <bean:message key="cro.jaExiste"/>
                             <% }
                            else
                                if (codigoMensagem.equals("8")) { voltar = true; %>
                                    <bean:message key="obrigatorios.emBranco"/>
                             <% }
                            else
                                if (codigoMensagem.equals("9")) { voltar = true; %>
                                    <bean:message key="nome.procedimento.jaExiste"/>
                             <% }
                            else
                                if (codigoMensagem.equals("10")) { voltar = true; %>
                                    <bean:message key="descricao.procedimento.jaExiste"/>
                             <% }
                            else
                                if (codigoMensagem.equals("11")) { voltar = true; %>
                                    <bean:message key="nome.formaPagamento.jaExiste"/>
                             <% }
                            else
                                if (codigoMensagem.equals("12")) { voltar = true; %>
                                    <bean:message key="descricao.formaPagamento.jaExiste"/>
                             <% }
                            else
                                if (codigoMensagem.equals("13")) { voltar = true; %>
                                    <bean:message key="atendimento.iniciadoOuRemovidoDaFila"/>
                             <% }
                            else
                                if (codigoMensagem.equals("14")) { voltar = true; %>
                                    <bean:message key="valorMinimo.naoAtingido"/>
                             <% }
                            else
                                if (codigoMensagem.equals("15")) { voltar = true; %>
                                    <bean:message key="saldo.insuficiente"/>
                             <% }
                            else
                                if (codigoMensagem.equals("16")) { voltar = true; %>
                                    <bean:message key="naoEhRegistroLiberado"/>
                             <% }
                            else
                                if (codigoMensagem.equals("17")) { voltar = true; %>
                                    <bean:message key="naoEhRegistroEmTratamento"/>
                             <% }
                            else
                                if (codigoMensagem.equals("18")) { voltar = true; %>
                                    <bean:message key="valorMinimo.invalido"/>
                             <% }
                            else
                                if (codigoMensagem.equals("19")) { voltar = true; %>
                                    <bean:message key="valorCobrado.invalido"/>
                             <% }
                            else
                                if (codigoMensagem.equals("25")) { voltar = true; %>
                                    <bean:message key="naoEhRegistroDeOrcamento"/>
                             <% }
                            else
                                if (codigoMensagem.equals("26")) { voltar = true; %>
                                    <bean:message key="paciente.inativo"/>
                             <% }
                            else
                                if (codigoMensagem.equals("28")) { voltar = true; %>
                                    <bean:message key="naoEhRegistroPagoOuExecutando"/>
                             <% }
                        }
                    %>
                </td>
            </tr>
            <tr>
                <td align="center" valign="middle">
                    <%
                        if (voltar) {
                            out.print("<a id=\"voltar\" href=\"javascript:history.back(1);\"> Voltar!</a>");
                        }
                        else {
                            out.print("<a id=\"voltar\" href=\"" + request.getContextPath() + "/main.do\"> Voltar para a p&aacute;gina principal!</a>");
                        }
                    %>
                </td>
            </tr>
        </table>
    </body>
</html>