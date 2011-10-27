<%--
    Document   : listarPagamentos
    Created on : 08/06/2010, 00:36:26
    Author     : Fabricio P. Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="annotations.Funcionario" %>
<%@page import="annotations.Paciente" %>
<%@page import="annotations.Pagamento" %>
<%@page import="web.login.ValidaGrupos" %>
<%@page import="java.util.Collection" %>
<%@page import="java.util.Iterator" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="javax.servlet.http.HttpSession"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<!-- Include de pagina que controla sessao -->
<jsp:include page="/app/controleSessao.jsp"/>

<!-- Controle de acesso a pagina -->
<%  Funcionario funcionarioLogado = (Funcionario) request.getSession(false).getAttribute("funcionarioLogado");
    boolean aux1 = false;
    boolean aux2 = false;
    boolean aux3 = false;
    boolean aux4 = false;
    if(funcionarioLogado != null) {
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Administrador")){
            aux1 = true;
        }
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Administrador-TI")){
            aux2 = true;
        }
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Caixa")){
            aux3 = true;
        }
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Financeiro")){
            aux4 = true;
        }
        if (aux1 && aux2 && aux3 && aux4) {
            response.sendRedirect(request.getContextPath() + "/mensagensDeRetorno/erro.jsp?codigoMensagem=11");
        }
    }
%>

<script type="text/javascript" language="javascript">
    <%@include file="caixa.js"%>
    // Funcao para colocar elemento em foco
    function goFocus(elementID){
        document.getElementById(elementID).focus();
    }
</script>

<link href="<%=request.getContextPath()%>/css/estiloGeral.css" rel="stylesheet" type="text/css">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Caixa - Lista de Pagamentos - SOP - Sistema de Odontologia Popular</title>
    </head>
    <body onload="javascript:goFocus('voltar')">
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value="Lista de Pagamentos"/>
        </jsp:include>
        <br> &nbsp;
        <br> &nbsp;
        <%
            // Captura objeto paciente do request
            // Este objeto vem de RegistrarPagamentoAction
            Paciente paciente = (Paciente)request.getAttribute("paciente");
        %>
        <table cellpadding="0" cellspacing="0" align="center" width="80%">
            <tr>
                <th align="center">
                    <font style="color:black; font-size:medium;"><strong>Pagamentos do paciente:&nbsp;<%= paciente.getNome() %></strong></font>
                </th>
            </tr>
            <tr>
                <td>
                   &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <table width="100%" border="0" cellspacing="1" cellpadding="1">
                        <tr>
                            <td align="center">
                                <strong>Data</strong>
                            </td>
                            <td align="center">
                                <strong>Forma de Pagamento</strong>
                            </td>
                            <td align="center">
                                <strong>Valor em Dinheiro</strong>
                            </td>
                            <td align="center">
                                <strong>Valor em Cheque</strong>
                            </td>
                            <td align="center">
                                <strong>Valor em Cart&atilde;o</strong>
                            </td>
                            <td align="center">
                                <strong>Total</strong>
                            </td>
                            <td align="center">
                                <strong>Op&ccedil;&otilde;es</strong>
                            </td>
                        </tr>
                        <%  Collection<Pagamento> pagamentoCollection = (Collection<Pagamento>)request.getAttribute("pagamentoCollection");
                            Pagamento pagamento = new Pagamento();
                            if (!pagamentoCollection.isEmpty()) {
                                Iterator iterator = pagamentoCollection.iterator();
                                while (iterator.hasNext()) {
                                    pagamento = (Pagamento) iterator.next();
                        %>
                        <tr onMouseOver="javascript:this.style.backgroundColor='#B0FFAE'" onMouseOut="javascript:this.style.backgroundColor=''">
                            <%
                                DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                                DecimalFormat decimalFormat = new DecimalFormat("0.00");
                            %>
                            <td align="center">
                                <%= dateFormat.format(pagamento.getDataHora()) %>
                            </td>
                            <td align="center">
                                <%= pagamento.getFormaPagamento().getNome() %>
                            </td>
                            <td align="center">
                                <strong>
                                <%
                                    if (pagamento.getValorEmDinheiro().equals(Double.parseDouble("0"))) {
                                        out.print("<font color='#D42945'>" + decimalFormat.format(pagamento.getValorEmDinheiro()) + "</font>");
                                    }
                                    else {
                                        out.print(decimalFormat.format(pagamento.getValorEmDinheiro()));
                                    }
                                %>
                                </strong>
                            </td>
                            <td align="center">
                                <%= decimalFormat.format(pagamento.getValorEmCheque()) %>
                            </td>
                            <td align="center">
                                <%= decimalFormat.format(pagamento.getValorEmCartao()) %>
                            </td>
                            <td align="center">
                                <%= decimalFormat.format(pagamento.getValorFinal()) %>
                            </td>
                            <td align="center">
                                <%
                                    String idPaciente = paciente.getId().toString();
                                    pageContext.setAttribute("idPaciente", idPaciente);
                                    String idPagamento = pagamento.getId().toString();
                                    pageContext.setAttribute("idPagamento", idPagamento);
                                    if (pagamento.getValorEmDinheiro() > Double.parseDouble("0")) {
                                %>
                                <a href="<%=request.getContextPath()%>/app/caixa/devolverDinheiro.do?idPaciente=${idPaciente}&idPagamento=${idPagamento}"><img src="<%=request.getContextPath()%>/imagens/apagar.png" alt="Prosseguir" title="Prosseguir" onclick="return confirmarAcao('prosseguir com a DEVOLUCAO DE DINHEIRO ao paciente')"></a>
                                <%
                                    } // if (pagamento.getValorEmDinheiro() > Double.parseDouble("0"))
                                    else {
                                        out.print("<strong><font color='#D42945'>Indispon&iacute;vel</font></strong>");
                                    }
                                %>
                            </td>
                        </tr>
                        <%
                                } // while (iterator.hasNext())
                            } // if (!pagamentoCollection.isEmpty())
                            else {
                                out.println("<tr><td align='center' colspan='7'><p style='font-size:medium; font-style:italic; color:red;'>Nenhum pagamento efetuado...</p></td></tr>");
                            }
                        %>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="border:none">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="paddingCelulaTabela" align="center" colspan="4" style="border:none">
                    <input name="voltar" id="voltar" class="botaodefault" type="button" value="voltar" title="Voltar" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/registrarDevolucaoDinheiro.do'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                </td>
            </tr>
        </table>
    </body>
</html>
