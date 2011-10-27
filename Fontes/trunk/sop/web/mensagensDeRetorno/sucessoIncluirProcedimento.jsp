<%--
    Document   : sucessoIncluirProcedimento
    Created on : 04/02/2010, 22:46:38
    Author     : Fabricio Reis
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="annotations.AtendimentoOrcamento"%>

<%
    // Captura o tipo do procedimento.. valor definido no forward mapeado em struts-config
    String tipo = "";
    if (request.getParameter("tipo") != null) {
        tipo = request.getParameter("tipo");
    }

    // Captura o id do dente colocado na sessao por VisualizarHistoricoDenteAction
    String idDente = "";
    if (request.getSession(false).getAttribute("idDente") != null) {
        idDente = (String)request.getSession(false).getAttribute("idDente");
    }

    // Captura o id da boca colocada na sessao por VisualizarHistoricoBocaAction
    String idBoca = "";
    if (request.getSession(false).getAttribute("idBoca") != null) {
        idBoca = (String)request.getSession(false).getAttribute("idBoca");
    }

    // Captura o id do paciente colocado na sessao por AtenderAtendimentoOrcamentoAction, ContinuarAtendimentoOrcamentoAction ou VisualizarHistoricoBocaAction
    String idPaciente = "";
    if (request.getSession(false).getAttribute("idPaciente") != null) {
        idPaciente = (String) request.getSession(false).getAttribute("idPaciente");
    }
%>

<link href="<%=request.getContextPath()%>/css/estilo.css" rel="stylesheet" type="text/css">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <%
            if (idDente.startsWith("S") && !idPaciente.isEmpty() && tipo.equals("dente")) {
        %>
        <meta http-equiv="refresh" content="1;url=<%=request.getContextPath()%>/app/filaAtendimentoOrcamento/actionContinuarAtendimentoOrcamento.do?idPaciente=<%=idPaciente%>">
        <%
            } else if (!idDente.isEmpty() && tipo.equals("dente")) {
        %>
        <meta http-equiv="refresh" content="1;url=<%=request.getContextPath()%>/app/atendimentoOrcamento/incluirProcedimento.do?idBoca=<%=idBoca%>&idDente=<%=idDente%>">
        <%
            } else if (!idBoca.isEmpty() && tipo.equals("boca")) {
        %>
        <meta http-equiv="refresh" content="1;url=<%=request.getContextPath()%>/app/atendimentoOrcamento/incluirProcedimentoBoca.do?idPaciente=<%=idPaciente%>">
        <%
            }
        %>
        <title>SOP - Sistema de Odontologia Popular</title>
    </head>
    <body>
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value=""/>
        </jsp:include>
        <br> &nbsp;
        <br> &nbsp;
        <table width="100%"  border="0" cellspacing="1" cellpadding="1">
            <tr>
                <td align="center" valign="middle"><img src="<%=request.getContextPath()%>/imagens/informacao.png" width="32" height="32" alt="Informa&ccedil;&atilde;o"></td>
            </tr>
            <tr>
                <td align="center" valign="middle"> Opera&ccedil;&atilde;o realizada com sucesso!</td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td align="center">
                    <font style="color:#D42945; font-size:small; text-decoration:blink;"><strong>Um instante por favor... Redirecionando... </strong></font>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <img src="<%=request.getContextPath()%>/imagens/aguardando.gif" width="105" height="16" alt="Aguarde">
                </td>
            </tr>
        </table>
    </body>
</html>