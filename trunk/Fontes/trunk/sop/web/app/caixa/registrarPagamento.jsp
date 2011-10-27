<%--
    Document   : registrarPagamento
    Created on : 21/03/2010, 10:55:31
    Author     : Fabricio P. Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="annotations.Funcionario" %>
<%@page import="annotations.ChequeBancario" %>
<%@page import="annotations.ComprovantePagamentoCartao" %>
<%@page import="annotations.Paciente" %>
<%@page import="annotations.Pagamento" %>
<%@page import="annotations.HistoricoDente" %>
<%@page import="annotations.HistoricoBoca" %>
<%@page import="service.PagamentoService" %>
<%@page import="web.login.ValidaGrupos" %>
<%@page import="java.util.Iterator" %>
<%@page import="java.util.Collection" %>
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
    <%@include file="../utilitario.js"%>
</script>

<!-- Includes para DWR -->
<script type='text/javascript' src='/sop/dwr/engine.js'></script>
<script type='text/javascript' src='/sop/dwr/util.js'></script>
<script type='text/javascript' src='/sop/dwr/interface/FormaPagamento.js'></script>
<!-- Fim includes para DWR -->

<link href="<%=request.getContextPath()%>/css/estiloOdontograma.css" rel="stylesheet" type="text/css">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Registrar Pagamento - SOP - Sistema de Odontologia Popular</title>
    </head>
    <body>
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value="Registrar Pagamento"/>
        </jsp:include>
        <br> &nbsp;
        <br> &nbsp;
        <script type="text/javascript">
            FormaPagamento.carregarFormasDePagamento();
        </script>
        <%
            // Captura objeto paciente do request
            // Este objeto vem de RegistrarPagamentoAction
            Paciente paciente = (Paciente)request.getAttribute("paciente");
        %>
        <form name="formPagamento" id="formPagamento" method="POST" onsubmit="return confirmarAcao('registrar este pagamento')" action="<%=request.getContextPath()%>/app/caixa/faturarPagamento.do">
            <table cellpadding="1" cellspacing="1" align="center" width="100%">
                <tr> <!-- TO DO - colocar idade do paciente  -->
                    <th align="center">
                        <font style="color:black; font-size:medium;"><strong><u>Paciente:</u> <% out.print(paciente.getNome()); %></strong></font>
                    </th>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <table width="100%" style="border:thin" cellpadding="1" cellspacing="1" align="center">
                            <thead>
                                <tr>
                                    <th colspan="4">Plano de Tratamento</th>
                                </tr>
                            </thead>
                            <tr>
                                <th style="text-align:center">
                                    <strong>Procedimento</strong>
                                </th>
                                <th style="text-align:center">
                                    <strong>Dente / Boca Completa</strong>
                                </th>
                                <th style="text-align:center">
                                    <strong>Status</strong>
                                </th>
                                <th style="text-align:center">
                                    <strong>Valor Cobrado (R$)</strong>
                                </th>
                            </tr>
                            <%
                                Collection<HistoricoDente> planoTratamentoDentes = (Collection<HistoricoDente>)request.getAttribute("planoTratamentoDentes");
                                HistoricoDente historicoDenteAux;
                                DecimalFormat decimalFormat = new DecimalFormat("0.00");
                                if (planoTratamentoDentes != null) {
                                    Iterator iterator = planoTratamentoDentes.iterator();
                                    while (iterator.hasNext()) {
                                        historicoDenteAux = (HistoricoDente) iterator.next();
                            %>
                            <tr>
                                <td align="center">
                                    <%= historicoDenteAux.getProcedimento().getNome() %>
                                </td>
                                <td align="center">
                                    <%= historicoDenteAux.getDente().getNome() %>&nbsp;<strong>|</strong>&nbsp;Posi&ccedil;&atilde;o:&nbsp;<%= historicoDenteAux.getDente().getPosicao() %>
                                </td>
                                <td align="center">
                                    <%= historicoDenteAux.getStatusProcedimento().getNome() %>
                                </td>
                                <td align="center">
                                    <%= decimalFormat.format(historicoDenteAux.getValorCobrado()) %>
                                </td>
                            </tr>
                            <%
                                    } // while (iterator.hasNext())
                                } // if (planoTratamentoDentes != null)

                                Collection<HistoricoBoca> planoTratamentoBoca = (Collection<HistoricoBoca>)request.getAttribute("planoTratamentoBoca");
                                HistoricoBoca historicoBocaAux;
                                if (planoTratamentoBoca != null) {
                                    Iterator iteratorBoca = planoTratamentoBoca.iterator();
                                    while (iteratorBoca.hasNext()) {
                                        historicoBocaAux = (HistoricoBoca) iteratorBoca.next();
                            %>
                            <tr>
                                <td align="center">
                                    <%= historicoBocaAux.getProcedimento().getNome() %>
                                </td>
                                <td align="center">
                                    Boca Completa
                                </td>
                                <td align="center">
                                    <%= historicoBocaAux.getStatusProcedimento().getNome() %>
                                </td>
                                <td align="center">
                                    <%= decimalFormat.format(historicoBocaAux.getValorCobrado()) %>
                                </td>
                            </tr>
                            <%
                                    } // while (iterator.hasNext())
                                } // if (planoTratamentoBoca != null)
                                if (planoTratamentoDentes.isEmpty() && planoTratamentoBoca.isEmpty()) {
                                    out.println("<tr><td align='center' colspan='4'><p style='font-size:small; font-style:italic; color:red;'>Plano de tratamento vazio...</p></td></tr>");
                                }
                                else if (request.getAttribute("totalTratamento") != null) {
                                    out.println("<tr><td style='border:none'>&nbsp;</td><td style='border:none'>&nbsp;</td><td style='border:none'>&nbsp;</td><td align='center' style='border:none'><font style='font-size:medium' color='#d42945'><strong>Total: R$" + decimalFormat.format((Double) request.getAttribute("totalTratamento")) + "</strong></font></td></tr>");
                                }
                            %>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <table width="100%" style="border:thin" cellpadding="1" cellspacing="1" align="center">
                            <thead>
                                <tr>
                                    <th colspan="2">Resumo Financeiro</th>
                                </tr>
                            </thead>
                            <tr>
                                <th style="text-align:center">
                                    <strong>Cr&eacute;dito (pagamentos)</strong>
                                </th>
                                <th style="text-align:center">
                                    <strong>D&eacute;bito (procedimentos liberados, iniciados ou finalizados) </strong>
                                </th>
                            </tr>
                            <tr>
                                <td align="center">
                                    <table width="100%" style="border:thin" cellpadding="1" cellspacing="1" align="center">
                                        <tr>
                                            <td align="center" style="border-left:none">
                                                <strong>Data</strong>
                                            </td>
                                            <td align="center">
                                                <strong>Forma de Pagamento</strong>
                                            </td>
                                            <td align="center" style="border-right:none">
                                                <strong>Valor (R$)</strong>
                                            </td>
                                        </tr>
                                        <%
                                            DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                                            Collection<Pagamento> pagamentos = (Collection<Pagamento>)request.getAttribute("pagamentos");
                                            Pagamento pagamentoAux;
                                            if (pagamentos != null) {
                                                Iterator iterator = pagamentos.iterator();
                                                while (iterator.hasNext()) {
                                                    pagamentoAux = (Pagamento) iterator.next();
                                        %>
                                        <tr>
                                            <td align="center" style="border-left:none">
                                                <%= dateFormat.format(pagamentoAux.getDataHora()) %>
                                            </td>
                                            <td align="center">
                                                <%
                                                    out.print(pagamentoAux.getFormaPagamento().getNome());
                                                    if (pagamentoAux.getValorEmDinheiro() > Double.parseDouble("0")) {
                                                        out.print("&nbsp;<strong>|</strong>&nbsp;Dinheiro");
                                                    }
                                                    if (pagamentoAux.getValorEmCheque() > Double.parseDouble("0")) {
                                                        out.print("&nbsp;<strong>|</strong>&nbsp;Cheque(s)");
                                                    }
                                                    if (pagamentoAux.getValorEmCartao() > Double.parseDouble("0")) {
                                                        out.print("&nbsp;<strong>|</strong>&nbsp;Cart&atilde;o");
                                                    }
                                                %>
                                            </td>
                                            <td align="center" style="border-right:none">
                                                <%= decimalFormat.format(pagamentoAux.getValorFinal()) %>
                                            </td>
                                        </tr>
                                        <%
                                                } // while (iterator.hasNext())
                                            } // if (pagamentos != null)
                                            if (pagamentos.isEmpty()) {
                                                out.println("<tr><td align='center' colspan='3' style='border:none'><p style='font-size:small; font-style:italic; color:red;'>Nenhum pagamento efetuado...</p></td></tr>");
                                            }
                                            else if (request.getAttribute("totalPagamentos") != null) {
                                                out.println("<tr><td style='border:none'>&nbsp;</td><td style='border:none'>&nbsp;</td><td align='center' style='border:none'><font style='font-size:medium' color='#d42945'><strong>Total: R$" + decimalFormat.format((Double) request.getAttribute("totalPagamentos")) + "</strong></font></td></tr>");
                                            }
                                        %>
                                    </table>
                                </td>
                                <td align="center">
                                    <table width="100%" style="border:thin" cellpadding="1" cellspacing="1" align="center">
                                        <tr>
                                            <td align="center" style="border-left:none">
                                                <strong>Data</strong>
                                            </td>
                                            <td align="center">
                                                <strong>Procedimento</strong>
                                            </td>
                                            <td align="center">
                                                <strong>Dente / Boca Completa</strong>
                                            </td>
                                            <td align="center">
                                                <strong>Status</strong>
                                            </td>
                                            <td align="center" style="border-right:none">
                                                <strong>Valor (R$)</strong>
                                            </td>
                                        </tr>
                                        <%
                                            Collection<HistoricoDente> debitosDente = (Collection<HistoricoDente>)request.getAttribute("debitosDente");
                                            HistoricoDente debitoDenteAux;
                                            if (debitosDente != null) {
                                                Iterator iterator = debitosDente.iterator();
                                                while (iterator.hasNext()) {
                                                    debitoDenteAux = (HistoricoDente) iterator.next();
                                        %>
                                        <tr>
                                            <td align="center" style="border-left:none">
                                                <%= dateFormat.format(debitoDenteAux.getDataHora()) %>
                                            </td>
                                            <td align="center">
                                                <%= debitoDenteAux.getProcedimento().getNome() %>
                                            </td>
                                            <td align="center">
                                                Dente: <%= debitoDenteAux.getDente().getPosicao() %>
                                            </td>
                                            <td align="center">
                                                <%= debitoDenteAux.getStatusProcedimento().getNome() %>
                                            </td>
                                            <td align="center" style="border-right:none">
                                                <%= decimalFormat.format(debitoDenteAux.getValorCobrado()) %>
                                            </td>
                                        </tr>
                                        <%
                                                } // while (iterator.hasNext())
                                            } // if (debitosDente != null)

                                            Collection<HistoricoBoca> debitosBoca = (Collection<HistoricoBoca>)request.getAttribute("debitosBoca");
                                            HistoricoBoca debitoBocaAux;
                                            if (debitosBoca != null) {
                                                Iterator iterator = debitosBoca.iterator();
                                                while (iterator.hasNext()) {
                                                    debitoBocaAux = (HistoricoBoca) iterator.next();
                                        %>
                                        <tr>
                                            <td align="center" style="border-left:none">
                                                <%= dateFormat.format(debitoBocaAux.getDataHora()) %>
                                            </td>
                                            <td align="center">
                                                <%= debitoBocaAux.getProcedimento().getNome() %>
                                            </td>
                                            <td align="center">
                                                Boca Completa
                                            </td>
                                            <td align="center">
                                                <%= debitoBocaAux.getStatusProcedimento().getNome() %>
                                            </td>
                                            <td align="center" style="border-right:none">
                                                <%= decimalFormat.format(debitoBocaAux.getValorCobrado()) %>
                                            </td>
                                        </tr>
                                        <%
                                                } // while (iterator.hasNext())
                                            } // if (debitosBoca != null)
                                            if (debitosDente.isEmpty() && debitosBoca.isEmpty()) {
                                                out.println("<tr><td align='center' style='border:none' colspan='5'><p style='font-size:small; font-style:italic; color:red;'>Nenhum d&eacute;bito efetuado...</p></td></tr>");
                                            }
                                            else if (request.getAttribute("totalDebitos") != null) {
                                                out.println("<tr><td style='border:none'>&nbsp;</td><td style='border:none'>&nbsp;</td><td style='border:none'>&nbsp;</td><td style='border:none'>&nbsp;</td><td align='center' style='border:none'><font style='font-size:medium' color='#d42945'><strong>Total: R$" + decimalFormat.format((Double) request.getAttribute("totalDebitos")) + "</strong></font></td></tr>");
                                            }
                                        %>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center" style="border-top:1px solid #e5eff8">
                                    <%
                                        Double totalPagamentos = Double.parseDouble("0");
                                        Double totalDebitos = Double.parseDouble("0");
                                        Double saldo = Double.parseDouble("0");
                                        if (request.getAttribute("totalPagamentos") != null) {
                                            totalPagamentos = (Double) request.getAttribute("totalPagamentos");
                                        }
                                        if (request.getAttribute("totalDebitos") != null) {
                                            totalDebitos = (Double) request.getAttribute("totalDebitos");
                                        }
                                        if (request.getAttribute("saldoFicha") != null) {
                                            saldo = (Double) request.getAttribute("saldoFicha");
                                        }
                                        out.print("<font style='font-size:medium'><strong><u>Saldo do Paciente:</u></strong></font>");
                                        if (saldo < Double.parseDouble("0"))
                                            out.print("<font style='font-size:medium' color='#d42945'><strong> R$" + decimalFormat.format(saldo) + "</strong></font>");
                                        else
                                            out.print("<font style='font-size:medium' color='#00CC00'><strong> R$" + decimalFormat.format(saldo) + "</strong></font>");
                                    %>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom:1px solid #e5eff8; border-left:none; border-right:none" colspan="2">
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="border:none">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <table width="100%" cellpadding="1" cellspacing="1" align="center" style="border:none">
                            <tr>
                                <td class="paddingCelulaTabela" align="center" style="border:none"><strong><font color="#FF0000">*</font>Forma de Pagamento:</strong>
                                    <select name="formaPagamentoId" id="formaPagamentoId" onchange="FormaPagamento.marcarValores(this.value)">
                                        <option value="" selected>Selecione</option>
                                    </select>
                                    <input name="tipoPagamento" id="tipoPagamento" type="hidden">
                                </td>
                            </tr>
                            <tr>
                                <td class="paddingCelulaTabela" align="center" style="border:none">
                                    <div id="pagamentoAVista" style="display:none">
                                        <table width="100%">
                                            <thead>
                                                <tr>
                                                    <th colspan="4">&Agrave; vista</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <%
                                                Collection<ChequeBancario> chequeBancarioCollectionAVista;
                                                if (request.getSession(false).getAttribute("chequeBancarioCollectionPagar") != null) {
                                                    chequeBancarioCollectionAVista = (Collection<ChequeBancario>) request.getSession(false).getAttribute("chequeBancarioCollectionPagar");
                                                    if (!chequeBancarioCollectionAVista.isEmpty()) {
                                            %>
                                            <tr>
                                                <td class="paddingCelulaTabela" align="center" colspan="4">
                                                    <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                                        <tr>
                                                            <th align="center" colspan="5"><strong>Cheque(s) Inserido(s)</strong></th>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">
                                                                <strong>Nome do Titular</strong>
                                                            </td>
                                                            <td align="center">
                                                                <strong>N&uacute;mero</strong>
                                                            </td>
                                                            <td align="center">
                                                                <strong>Data Para Depositar</strong>
                                                            </td>
                                                            <td align="center">
                                                                <strong>Valor (R$)</strong>
                                                            </td>
                                                            <td align="center">
                                                                <strong>Remover</strong>
                                                            </td>
                                                        </tr>
                                                        <%
                                                            dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                                                            Iterator iteratorCheque = chequeBancarioCollectionAVista.iterator();
                                                            ChequeBancario chequeBancarioAux = new ChequeBancario();
                                                            while (iteratorCheque.hasNext()) {
                                                                chequeBancarioAux = (ChequeBancario) iteratorCheque.next();
                                                        %>
                                                        <tr>
                                                            <td align="center">
                                                                <%= chequeBancarioAux.getNomeTitular() %>
                                                            </td>
                                                            <td align="center">
                                                                <%= chequeBancarioAux.getNumero() %>
                                                            </td>
                                                            <td align="center">
                                                                <%= dateFormat.format(chequeBancarioAux.getDataParaDepositar()) %>
                                                            </td>
                                                            <td align="center">
                                                                <%= decimalFormat.format(chequeBancarioAux.getValor()) %>
                                                            </td>
                                                            <%
                                                                String numeroCheque = chequeBancarioAux.getNumero();
                                                                pageContext.setAttribute("numeroCheque", numeroCheque);
                                                            %>
                                                            <td align="center">
                                                                <a href="<%=request.getContextPath()%>/app/chequeBancario/actionRemoverChequeBancario.do?numeroCheque=${numeroCheque}"><img src="<%=request.getContextPath()%>/imagens/remover.png" alt="Remover" title="Remover" onclick="return confirmarAcao('remover este cheque do pagamento')"></a>&nbsp;&nbsp;
                                                            </td>
                                                        </tr>
                                                        <%
                                                            } // while (iteratorCheque.hasNext())
                                                        %>
                                                        <tr>
                                                            <td class="paddingCelulaTabela" colspan="3" style="border:none; border-left:1px solid #e5eff8; border-bottom:1px solid #e5eff8;">
                                                                &nbsp;
                                                            </td>
                                                            <td class="paddingCelulaTabela" align="center" style="border:none; border-bottom:1px solid #e5eff8;">
                                                                <font color='#D42945'><strong>Total - Cheques R$: <% if (request.getSession(false).getAttribute("totalCheques") != null) out.print(decimalFormat.format(request.getSession(false).getAttribute("totalCheques"))); else out.print("0,00"); %></strong></font>
                                                            </td>
                                                            <td class="paddingCelulaTabela" style="border:none; border-right:1px solid #e5eff8; border-bottom:1px solid #e5eff8;">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <%
                                                    } // if (!chequeBancarioCollectionAVista.isEmpty())
                                                } // if (request.getSession(false).getAttribute("chequeBancarioCollectionPagar") != null)

                                                Collection<ComprovantePagamentoCartao> comprovantePagamentoCartaoCollectionAVista;
                                                if (request.getSession(false).getAttribute("comprovantePagamentoCartaoCollectionPagar") != null) {
                                                    comprovantePagamentoCartaoCollectionAVista = (Collection<ComprovantePagamentoCartao>) request.getSession(false).getAttribute("comprovantePagamentoCartaoCollectionPagar");
                                                    if (!comprovantePagamentoCartaoCollectionAVista.isEmpty()) {
                                            %>
                                            <tr>
                                                <td class="paddingCelulaTabela" align="center" colspan="4">
                                                    <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                                        <tr>
                                                            <th align="center" colspan="6"><strong>Comprovante(s) de Pagamento(s) com Cart&atilde;o(&otilde;es) Inserido(s)</strong></th>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">
                                                                <strong>C&oacute;digo de Autoriza&ccedil;&atilde;o</strong>
                                                            </td>
                                                            <td align="center">
                                                                <strong>Bandeira</strong>
                                                            </td>
                                                            <td align="center">
                                                                <strong>Tipo</strong>
                                                            </td>
                                                            <td align="center">
                                                                <strong>Parcelas</strong>
                                                            </td>
                                                            <td align="center">
                                                                <strong>Valor (R$)</strong>
                                                            </td>
                                                            <td align="center">
                                                                <strong>Remover</strong>
                                                            </td>
                                                        </tr>
                                                        <%
                                                            Iterator iteratorComprovanteCartao = comprovantePagamentoCartaoCollectionAVista.iterator();
                                                            ComprovantePagamentoCartao comprovantePagamentoCartaoAux = new ComprovantePagamentoCartao();
                                                            while (iteratorComprovanteCartao.hasNext()) {
                                                                comprovantePagamentoCartaoAux = (ComprovantePagamentoCartao) iteratorComprovanteCartao.next();
                                                        %>
                                                        <tr>
                                                            <td align="center">
                                                                <%= comprovantePagamentoCartaoAux.getCodigoAutorizacao() %>
                                                            </td>
                                                            <td align="center">
                                                                <%= comprovantePagamentoCartaoAux.getBandeira() %>
                                                            </td>
                                                            <td align="center">
                                                                <%if (comprovantePagamentoCartaoAux.getTipo() == 'C') out.print("Cr&eacute;dito"); else out.print("D&eacute;bito"); %>
                                                            </td>
                                                            <td align="center">
                                                                <%if (comprovantePagamentoCartaoAux.getTipo() == 'C') out.print(comprovantePagamentoCartaoAux.getParcelas()); else out.print("N&atilde;o tem"); %>
                                                            </td>
                                                            <td align="center">
                                                                <%= decimalFormat.format(comprovantePagamentoCartaoAux.getValor()) %>
                                                            </td>
                                                            <%
                                                                String codigoAutorizacao = comprovantePagamentoCartaoAux.getCodigoAutorizacao();
                                                                pageContext.setAttribute("codigoAutorizacao", codigoAutorizacao);
                                                            %>
                                                            <td align="center">
                                                                <a href="<%=request.getContextPath()%>/app/comprovantePagamentoCartao/actionRemoverComprovantePagamentoCartao.do?codigoAutorizacao=${codigoAutorizacao}"><img src="<%=request.getContextPath()%>/imagens/remover.png" alt="Remover" title="Remover" onclick="return confirmarAcao('remover este comprovante do pagamento')"></a>&nbsp;&nbsp;
                                                            </td>
                                                        </tr>
                                                        <%
                                                            } // while (iteratorComprovanteCartao.hasNext())
                                                        %>
                                                        <tr>
                                                            <td class="paddingCelulaTabela" colspan="4" style="border:none; border-left:1px solid #e5eff8; border-bottom:1px solid #e5eff8;">
                                                                &nbsp;
                                                            </td>
                                                            <td class="paddingCelulaTabela" style="border:none; border-bottom:1px solid #e5eff8;">
                                                                <font color='#D42945'><strong>Total - Cart&atilde;o R$: <% if (request.getSession(false).getAttribute("totalCartao") != null) out.print(decimalFormat.format(request.getSession(false).getAttribute("totalCartao"))); else out.print("0,00"); %></strong></font>
                                                            </td>
                                                            <td class="paddingCelulaTabela" style="border:none; border-right:1px solid #e5eff8; border-bottom:1px solid #e5eff8;">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <%
                                                    } // if (!comprovantePagamentoCartaoCollectionAVista.isEmpty())
                                                } // if (request.getSession(false).getAttribute("comprovantePagamentoCartaoCollectionPagar") != null)
                                            %>
                                            <tr>
                                                <td class="paddingCelulaTabela" align="center" colspan="2"><strong><font color="#FF0000">*</font><font color='#D42945'>Total em Dinheiro R$:</font></strong>
                                                    <input name="totalAVistaEmDinheiro" id="totalAVistaEmDinheiro" type="text" size="7" maxlength="7" onkeypress="return mascaraNumeroReal(totalAVistaEmDinheiro, 1, 7)" onblur="validarValorReal3D(totalAVistaEmDinheiro, 'totalAVistaEmDinheiro'); recalcularTotalAVista();">
                                                    <br><font size="1" color="#FF0000">Formato: 0000.00</font>
                                                    <input name="totalChequesAVista" id="totalChequesAVista" type="hidden" value="<% if (request.getSession(false).getAttribute("totalCheques") != null) out.print(request.getSession(false).getAttribute("totalCheques")); else out.print("0"); %>">
                                                    <input name="totalCartaoAVista" id="totalCartaoAVista" type="hidden" value="<% if (request.getSession(false).getAttribute("totalCartao") != null) out.print(request.getSession(false).getAttribute("totalCartao")); else out.print("0"); %>">
                                                </td>
                                                <td class="paddingCelulaTabela" align="center"><strong><font color="#FF0000">*</font><font color='#D42945'>Subtotal R$:</font></strong>
                                                    <input name="subtotalAVista" id="subtotalAVista" type="text" size="7" maxlength="7" readonly>
                                                </td>
                                                <td class="paddingCelulaTabela" align="center" valign="middle">
                                                    <input name="inserirChequeBancarioAVista" class="botaodefaultgra" type="button" value="inserir cheque" title="Pagamento com cheques" onclick="javascript:location.href='<%=request.getContextPath()%>/app/chequeBancario/cadastrarChequeBancario.do?tipoFormaPagamento=A'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra.png)'">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="paddingCelulaTabela" colspan="2">
                                                    &nbsp;
                                                </td>
                                                <td class="paddingCelulaTabela" align="center"><strong><font color="#FF0000">*</font> <font color='#d42945'>Total R$:</font></strong>
                                                    <input name="totalAVista" id="totalAVista" type="text" size="7" maxlength="7" style="font-weight:bold; font-size:small; background:yellow" readonly>
                                                </td>
                                                <td class="paddingCelulaTabela" align="center" valign="middle">
                                                    <input name="inserirComprovantePagamentoCartaoAVista" class="botaodefaultgra" type="button" value="inserir cart&atilde;o" title="Pagamento com cart&otilde;es" onclick="javascript:location.href='<%=request.getContextPath()%>/app/comprovantePagamentoCartao/cadastrarComprovantePagamentoCartao.do?tipoFormaPagamento=A'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra.png)'">
                                                </td>
                                            </tr>
                                            <!-- Trecho de codigo para quando for usar desconto no pagamento a vista
                                            <tr>
                                                <td class="paddingCelulaTabela" align="center"><strong>Valor Total M&iacute;nimo para Desconto R$:</strong>
                                                    <input name="pisoParaDesconto" id="pisoParaDesconto" type="text" size="7" maxlength="7" readonly>
                                                </td>
                                                <td class="paddingCelulaTabela" align="center"><strong><font color="#FF0000">*</font><font color='#D42945'>Total em Dinheiro R$:</font></strong>
                                                    <input name="totalAVistaEmDinheiro" id="totalAVistaEmDinheiro" type="text" size="7" maxlength="7" onkeypress="return mascaraNumeroReal(totalAVistaEmDinheiro, 1, 7)" onblur="validarValorReal3D(totalAVistaEmDinheiro, 'totalAVistaEmDinheiro'); recalcularTotalAVista();">
                                                    <br><font size="1" color="#FF0000">Formato: 0000.00</font>
                                                    <input name="totalChequesAVista" id="totalChequesAVista" type="hidden" value="<% if (request.getSession(false).getAttribute("totalCheques") != null) out.print(request.getSession(false).getAttribute("totalCheques")); else out.print("0"); %>">
                                                    <input name="totalCartaoAVista" id="totalCartaoAVista" type="hidden" value="<% if (request.getSession(false).getAttribute("totalCartao") != null) out.print(request.getSession(false).getAttribute("totalCartao")); else out.print("0"); %>">
                                                </td>
                                                <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font><font color='#D42945'>Subtotal R$:</font></strong>
                                                    <input name="subtotalAVista" id="subtotalAVista" type="text" size="7" maxlength="7" readonly>
                                                </td>
                                                <td class="paddingCelulaTabela" align="center" valign="middle">
                                                    <input name="inserirChequeBancarioAVista" class="botaodefault" type="button" value="inserir cheque" title="Pagamento com cheques" onclick="javascript:location.href='<%=request.getContextPath()%>/app/chequeBancario/cadastrarChequeBancario.do?tipoFormaPagamento=A'" onMouseOver="javascript:this.style.backgroundColor='#00EE76'" onMouseOut="javascript:this.style.backgroundColor=''">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="paddingCelulaTabela" colspan="2">
                                                    &nbsp;
                                                </td>
                                                <td class="paddingCelulaTabela" align="left"><strong>Desconto (%):</strong>
                                                    <input name="descontoVisual" id="descontoVisual" type="text" size="4" maxlength="4" readonly>
                                                    <input name="desconto" id="desconto" type="hidden">
                                                </td>
                                                <td class="paddingCelulaTabela" align="center" valign="middle">
                                                    <input name="inserirComprovantePagamentoCartaoAVista" class="botaodefault" type="button" value="inserir cart&atilde;o" title="Pagamento com cart&otilde;es" onclick="javascript:location.href='<%=request.getContextPath()%>/app/comprovantePagamentoCartao/cadastrarComprovantePagamentoCartao.do'" onMouseOver="javascript:this.style.backgroundColor='#00EE76'" onMouseOut="javascript:this.style.backgroundColor=''">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="paddingCelulaTabela" colspan="2">
                                                    &nbsp;
                                                </td>
                                                <td class="paddingCelulaTabela" align="left" colspan="2"><strong><font color="#FF0000">*</font> <font color='#D42945'>Total com Desconto R$:</font></strong>
                                                    <input name="totalAVistaComDesconto" id="totalAVistaComDesconto" type="text" size="7" maxlength="7" style="font-weight:bold; font-size:small; background:yellow" readonly>
                                                </td>
                                            </tr> -->
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="paddingCelulaTabela" align="center" style="border:none">
                                    <div id="pagamentoAPrazo" style="display:none">
                                        <table width="100%">
                                            <thead>
                                                <tr>
                                                    <th colspan="4">A Prazo</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <%
                                                Collection<ChequeBancario> chequeBancarioCollectionAPrazo;
                                                if (request.getSession(false).getAttribute("chequeBancarioCollectionPagar") != null) {
                                                    chequeBancarioCollectionAPrazo = (Collection<ChequeBancario>) request.getSession(false).getAttribute("chequeBancarioCollectionPagar");
                                                    if (!chequeBancarioCollectionAPrazo.isEmpty()) {
                                            %>
                                            <tr>
                                                <td class="paddingCelulaTabela" align="center" colspan="4">
                                                    <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                                        <tr>
                                                            <th align="center" colspan="5"><strong>Cheque(s) Inserido(s)</strong></th>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">
                                                                <strong>Nome do Titular</strong>
                                                            </td>
                                                            <td align="center">
                                                                <strong>N&uacute;mero</strong>
                                                            </td>
                                                            <td align="center">
                                                                <strong>Data Para Depositar</strong>
                                                            </td>
                                                            <td align="center">
                                                                <strong>Valor (R$)</strong>
                                                            </td>
                                                            <td align="center">
                                                                <strong>Remover</strong>
                                                            </td>
                                                        </tr>
                                                        <%
                                                            dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                                                            Iterator iteratorCheque = chequeBancarioCollectionAPrazo.iterator();
                                                            ChequeBancario chequeBancarioAux2 = new ChequeBancario();
                                                            while (iteratorCheque.hasNext()) {
                                                                chequeBancarioAux2 = (ChequeBancario) iteratorCheque.next();
                                                        %>
                                                        <tr>
                                                            <td align="center">
                                                                <%= chequeBancarioAux2.getNomeTitular() %>
                                                            </td>
                                                            <td align="center">
                                                                <%= chequeBancarioAux2.getNumero() %>
                                                            </td>
                                                            <td align="center">
                                                                <%= dateFormat.format(chequeBancarioAux2.getDataParaDepositar()) %>
                                                            </td>
                                                            <td align="center">
                                                                <%= decimalFormat.format(chequeBancarioAux2.getValor()) %>
                                                            </td>
                                                            <%
                                                                String numeroCheque = chequeBancarioAux2.getNumero();
                                                                pageContext.setAttribute("numeroCheque", numeroCheque);
                                                            %>
                                                            <td align="center">
                                                                <a href="<%=request.getContextPath()%>/app/chequeBancario/actionRemoverChequeBancario.do?numeroCheque=${numeroCheque}"><img src="<%=request.getContextPath()%>/imagens/remover.png" alt="Remover" title="Remover" onclick="return confirmarAcao('remover este cheque do pagamento')"></a>&nbsp;&nbsp;
                                                            </td>
                                                        </tr>
                                                        <%
                                                            } // while (iteratorCheque.hasNext())
                                                        %>
                                                        <tr>
                                                            <td class="paddingCelulaTabela" colspan="3" style="border:none; border-left:1px solid #e5eff8; border-bottom:1px solid #e5eff8;">
                                                                &nbsp;
                                                            </td>
                                                            <td class="paddingCelulaTabela" align="center" style="border:none; border-bottom:1px solid #e5eff8;">
                                                                <font color='#D42945'><strong>Total - Cheques R$: <% if (request.getSession(false).getAttribute("totalCheques") != null) out.print(decimalFormat.format(request.getSession(false).getAttribute("totalCheques"))); else out.print("0,00"); %></strong></font>
                                                            </td>
                                                            <td class="paddingCelulaTabela" style="border:none; border-right:1px solid #e5eff8; border-bottom:1px solid #e5eff8;">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <%
                                                    } // if (!chequeBancarioCollectionAPrazo.isEmpty())
                                                } // if (request.getSession(false).getAttribute("chequeBancarioCollectionPagar") != null)

                                                Collection<ComprovantePagamentoCartao> comprovantePagamentoCartaoCollectionAPrazo;
                                                if (request.getSession(false).getAttribute("comprovantePagamentoCartaoCollectionPagar") != null) {
                                                    comprovantePagamentoCartaoCollectionAPrazo = (Collection<ComprovantePagamentoCartao>) request.getSession(false).getAttribute("comprovantePagamentoCartaoCollectionPagar");
                                                    if (!comprovantePagamentoCartaoCollectionAPrazo.isEmpty()) {
                                            %>
                                            <tr>
                                                <td class="paddingCelulaTabela" align="center" colspan="4">
                                                    <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                                        <tr>
                                                            <th align="center" colspan="6"><strong>Comprovante(s) de Pagamento(s) com Cart&atilde;o(&otilde;es) Inserido(s)</strong></th>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">
                                                                <strong>C&oacute;digo de Autoriza&ccedil;&atilde;o</strong>
                                                            </td>
                                                            <td align="center">
                                                                <strong>Bandeira</strong>
                                                            </td>
                                                            <td align="center">
                                                                <strong>Tipo</strong>
                                                            </td>
                                                            <td align="center">
                                                                <strong>Parcelas</strong>
                                                            </td>
                                                            <td align="center">
                                                                <strong>Valor (R$)</strong>
                                                            </td>
                                                            <td align="center">
                                                                <strong>Remover</strong>
                                                            </td>
                                                        </tr>
                                                        <%
                                                            Iterator iteratorComprovanteCartao = comprovantePagamentoCartaoCollectionAPrazo.iterator();
                                                            ComprovantePagamentoCartao comprovantePagamentoCartaoAux = new ComprovantePagamentoCartao();
                                                            while (iteratorComprovanteCartao.hasNext()) {
                                                                comprovantePagamentoCartaoAux = (ComprovantePagamentoCartao) iteratorComprovanteCartao.next();
                                                        %>
                                                        <tr>
                                                            <td align="center">
                                                                <%= comprovantePagamentoCartaoAux.getCodigoAutorizacao() %>
                                                            </td>
                                                            <td align="center">
                                                                <%= comprovantePagamentoCartaoAux.getBandeira() %>
                                                            </td>
                                                            <td align="center">
                                                                <%if (comprovantePagamentoCartaoAux.getTipo() == 'C') out.print("Cr&eacute;dito"); else out.print("D&eacute;bito"); %>
                                                            </td>
                                                            <td align="center">
                                                                <%if (comprovantePagamentoCartaoAux.getTipo() == 'C') out.print(comprovantePagamentoCartaoAux.getParcelas()); else out.print("N&atilde;o tem"); %>
                                                            </td>
                                                            <td align="center">
                                                                <%= decimalFormat.format(comprovantePagamentoCartaoAux.getValor()) %>
                                                            </td>
                                                            <%
                                                                String codigoAutorizacao = comprovantePagamentoCartaoAux.getCodigoAutorizacao();
                                                                pageContext.setAttribute("codigoAutorizacao", codigoAutorizacao);
                                                            %>
                                                            <td align="center">
                                                                <a href="<%=request.getContextPath()%>/app/comprovantePagamentoCartao/actionRemoverComprovantePagamentoCartao.do?codigoAutorizacao=${codigoAutorizacao}"><img src="<%=request.getContextPath()%>/imagens/remover.png" alt="Remover" title="Remover" onclick="return confirmarAcao('remover este comprovante do pagamento')"></a>&nbsp;&nbsp;
                                                            </td>
                                                        </tr>
                                                        <%
                                                            } // while (iteratorComprovanteCartao.hasNext())
                                                        %>
                                                        <tr>
                                                            <td class="paddingCelulaTabela" colspan="4" style="border:none; border-left:1px solid #e5eff8; border-bottom:1px solid #e5eff8;">
                                                                &nbsp;
                                                            </td>
                                                            <td class="paddingCelulaTabela" style="border:none; border-bottom:1px solid #e5eff8;">
                                                                <font color='#D42945'><strong>Total - Cart&atilde;o R$: <% if (request.getSession(false).getAttribute("totalCartao") != null) out.print(decimalFormat.format(request.getSession(false).getAttribute("totalCartao"))); else out.print("0,00"); %></strong></font>
                                                            </td>
                                                            <td class="paddingCelulaTabela" style="border:none; border-right:1px solid #e5eff8; border-bottom:1px solid #e5eff8;">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <%
                                                    } // if (!comprovantePagamentoCartaoCollectionAPrazo.isEmpty())
                                                } // if (request.getSession(false).getAttribute("comprovantePagamentoCartaoCollectionPagar") != null)
                                            %>
                                            <tr>
                                                <td class="paddingCelulaTabela" align="center"><strong>Valor M&iacute;nimo R$:</strong>
                                                    <input name="valorMinimoAPrazo" id="valorMinimoAPrazo" type="text" size="7" maxlength="7" readonly>
                                                </td>
                                                <td class="paddingCelulaTabela" align="center"><strong><font color="#FF0000">*</font><font color='#D42945'>Total em Dinheiro R$:</font></strong>
                                                    <input name="totalAPrazoEmDinheiro" id="totalAPrazoEmDinheiro" type="text" size="7" maxlength="7" onkeypress="return mascaraNumeroReal(totalAPrazoEmDinheiro, 1, 7)" onblur="validarValorReal3D(totalAPrazoEmDinheiro, 'totalAPrazoEmDinheiro'); recalcularTotalAPrazo();">
                                                    <br><font size="1" color="#FF0000">Formato: 0000.00</font>
                                                    <input name="totalChequesAPrazo" id="totalChequesAPrazo" type="hidden" value="<% if (request.getSession(false).getAttribute("totalCheques") != null) out.print(request.getSession(false).getAttribute("totalCheques")); else out.print("0"); %>">
                                                    <input name="totalCartaoAPrazo" id="totalCartaoAPrazo" type="hidden" value="<% if (request.getSession(false).getAttribute("totalCartao") != null) out.print(request.getSession(false).getAttribute("totalCartao")); else out.print("0"); %>">
                                                </td>
                                                <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font><font color='#D42945'>Subtotal R$:</font></strong>
                                                    <input name="subtotalAPrazo" id="subtotalAPrazo" type="text" size="7" maxlength="7" readonly>
                                                </td>
                                                <td class="paddingCelulaTabela" align="center" valign="middle">
                                                    <input name="inserirChequeBancarioAPrazo" class="botaodefaultgra" type="button" value="inserir cheque" title="Pagamento com cheques" onclick="javascript:location.href='<%=request.getContextPath()%>/app/chequeBancario/cadastrarChequeBancario.do'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra.png)'">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="paddingCelulaTabela" colspan="2">
                                                    &nbsp;
                                                </td>
                                                <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font> <font color='#d42945'>Total R$:</font></strong>
                                                    <input name="totalAPrazo" id="totalAPrazo" type="text" size="7" maxlength="7" style="font-weight:bold; font-size:small; background:yellow" readonly>
                                                </td>
                                                <td class="paddingCelulaTabela" align="center" valign="middle">
                                                    <input name="inserirComprovantePagamentoCartaoAPrazo" class="botaodefaultgra" type="button" value="inserir cart&atilde;o" title="Pagamento com cart&otilde;es" onclick="javascript:location.href='<%=request.getContextPath()%>/app/comprovantePagamentoCartao/cadastrarComprovantePagamentoCartao.do'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra.png)'">
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="border:none">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td style="border:none">
                        <table align="center" width="100%">
                            <tr>
                                <td style="border:none" align="center" valign="middle" width="50%" class="paddingCelulaTabela">
                                    <%
                                        String textoAlert = "";
                                        if (request.getSession(false).getAttribute("chequeBancarioCollectionPagar") != null && request.getSession(false).getAttribute("comprovantePagamentoCartaoCollectionPagar") != null)
                                            textoAlert = "PARA PAGAMENTO A VISTA, A DATA DE DEPOSITO DE CHEQUES SAO REMARCADAS PARA A DATA ATUAL\\nE COMPROVANTES DE PAGAMENTO COM CARTAO DE CREDITO SAO REMARCADOS PARA 1 PARCELA!";
                                        else
                                        if (request.getSession(false).getAttribute("chequeBancarioCollectionPagar") != null && request.getSession(false).getAttribute("comprovantePagamentoCartaoCollectionPagar") == null)
                                            textoAlert = "PARA PAGAMENTO A VISTA, A DATA DE DEPOSITO DE CHEQUES SAO REMARCADAS PARA A DATA ATUAL!";
                                        else
                                        if (request.getSession(false).getAttribute("chequeBancarioCollectionPagar") == null && request.getSession(false).getAttribute("comprovantePagamentoCartaoCollectionPagar") != null)
                                            textoAlert = "PARA PAGAMENTO A VISTA, COMPROVANTES DE PAGAMENTO COM CARTAO DE CREDITO SAO REMARCADOS PARA 1 PARCELA!";
                                    %>
                                    <input name="registrarPagamento" class="botaodefaultextrag" type="submit" value="registrar pagamento" title="Registrar pagamento" onclick="javascript: if(tipoPagamento.value == 'A') { <% if (!textoAlert.isEmpty()) { %> alert('<%=textoAlert%>'); <% } %> } return validarDados();" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-extrag-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-extrag.png)'">
                                    <input name="totalCheques" id="totalCheques" type="hidden" value="<% if (request.getSession(false).getAttribute("totalCheques") != null) out.print(request.getSession(false).getAttribute("totalCheques")); else out.print("0"); %>">
                                    <input name="totalCartao" id="totalCartao" type="hidden" value="<% if (request.getSession(false).getAttribute("totalCartao") != null) out.print(request.getSession(false).getAttribute("totalCartao")); else out.print("0"); %>">
                                </td>
                                <td style="border:none" align="center" valign="middle" width="50%" class="paddingCelulaTabela">
                                    <input name="cancelarVoltar" class="botaodefaultgra" type="button" value="cancelar / voltar" title="Voltar" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/cancelarPagamento.do'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra.png)'">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>
