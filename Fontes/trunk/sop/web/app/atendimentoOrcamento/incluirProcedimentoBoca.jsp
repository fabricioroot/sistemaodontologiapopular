<%--
    Document   : incluirProcedimento
    Created on : 21/03/2010, 10:55:31
    Author     : Fabricio P. Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="annotations.Funcionario" %>
<%@page import="annotations.Boca" %>
<%@page import="annotations.HistoricoBoca" %>
<%@page import="service.StatusProcedimentoService" %>
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
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Dentista-Orcamento")){
            aux3 = true;
        }
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Dentista-Tratamento")){
            aux4 = true;
        }
        if (aux1 && aux2 && aux3 && aux4) {
            response.sendRedirect(request.getContextPath() + "/mensagensDeRetorno/erro.jsp?codigoMensagem=11");
        }
    }
%>

<script type="text/javascript" language="javascript">
    <%@include file="atendimentoOrcamento.js"%>
    <%@include file="../utilitario.js"%>
</script>

<!-- Includes para DWR -->
<script type='text/javascript' src='/sop/dwr/engine.js'></script>
<script type='text/javascript' src='/sop/dwr/util.js'></script>
<script type='text/javascript' src='/sop/dwr/interface/Procedimento.js'></script>
<!-- Fim includes para DWR -->

<link href="<%=request.getContextPath()%>/css/estiloOdontograma.css" rel="stylesheet" type="text/css">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Incluir Procedimento / Boca Completa - SOP - Sistema de Odontologia Popular</title>
    </head>
    <body onload="goFocus('procedimentoId')">
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value="Incluir Procedimento / Boca Completa"/>
        </jsp:include>
        <br> &nbsp;
        <br> &nbsp;

        <%
            // Captura objeto boca do request
            // Este objeto vem do action VisualizarHistoricoBocaAction acionado por botao da pagina atenderAtendimentoOrcamento
            Boca boca = (Boca)request.getAttribute("boca");
            if (boca != null) {
        %>

        <!-- TO DO com que nao seja chamada duas vezes a mesma funcao abaixo  -->
        <script type="text/javascript">
            Procedimento.carregarProcedimentosBC();
        </script>
        <table cellpadding="1" cellspacing="1" align="center" width="100%">
            <tr> <!-- TO DO - colocar idade do paciente  -->
                <th align="center" colspan="4">
                    <font style="color:black; font-size:medium;"><strong><u>Paciente:</u> <% out.print(boca.getPaciente().getNome()); %></strong></font>
                </th>
            </tr>
            <tr>
                <td colspan="4">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="4"><strong><u>Legenda</u></strong></td>
            </tr>
            <tr>
                <td bgcolor="#FFDD00" align="center"><strong>Or&ccedil;ado</strong></td>
                <td bgcolor="#87FF00" align="center"><strong>Liberado para tratamento (pago)</strong></td>
                <td bgcolor="#00FFFF" align="center"><strong>Em tratamento</strong></td>
                <td bgcolor="#CDC8B1" align="center"><strong>Procedimento finalizado</strong></td>
            </tr>
            <tr>
                <td colspan="4">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td align="center" colspan="4" style="border:none">
                    <table cellpadding="1" cellspacing="1" align="center" width="60%" style="border:none">
                        <%
                            HistoricoBoca historicoBoca = new HistoricoBoca();
                            // Captura objeto 'historicoBocaCollectionOrdenadoDescData' do request
                            // Este objeto vem do action VisualizarHistoricoBocaAction acionado por botao da pagina atenderAtendimentoOrcamento
                            Collection<HistoricoBoca> historicoBocaCollectionOrdenadoDescData = (Collection<HistoricoBoca>)request.getAttribute("historicoBocaCollectionOrdenadoDescData");
                            Iterator iterator = historicoBocaCollectionOrdenadoDescData.iterator();
                            int i = 1;
                            while (iterator.hasNext()) {
                                historicoBoca = (HistoricoBoca) iterator.next();
                        %>
                        <tr>
                            <td bgcolor="#EBE9E9" align="center" style="border:none" colspan="3">
                                <font style="color:black; font-size:small;"><strong>Hist&oacute;rico - Registro&nbsp;<%=i%></strong></font>
                            </td>
                        </tr>
                        <tr>
                            <%
                                boolean orcado = false;
                                if (historicoBoca.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoOrcado())) {
                                    orcado = true;
                                }
                            %>
                            <td align="left" colspan="<% if(orcado) out.print("1"); else out.print("2"); %>" style="border:none">
                                <table border="0" cellpadding="1" cellspacing="1" style="border:none">
                                    <tr>
                                        <td style="border:none">
                                            <%
                                                DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                                                DecimalFormat decimalFormat = new DecimalFormat("0.00");
                                            %>
                                            <strong>Data:</strong> <%= dateFormat.format(historicoBoca.getDataHora())%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border:none">
                                            <strong>Procedimento:</strong> <%= historicoBoca.getProcedimento().getNome()%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border:none">
                                            <strong>Valor Cobrado: R$<%= decimalFormat.format(historicoBoca.getValorCobrado()) %></strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border:none">
                                            <%
                                                String status = "";
                                                Short codigoStatus = historicoBoca.getStatusProcedimento().getCodigo();
                                                switch (codigoStatus) {
                                                    case 1: {
                                                        status = "<font color='#FFDD00'>Or&ccedil;ado</font>";
                                                    } break;
                                                    case 2: {
                                                        status = "<font color='#32CD32'>Liberado para tratamento (pago)</font>";
                                                    } break;
                                                    case 3: {
                                                        status = "<font color='#00FFFF'>Em tratamento</font>";
                                                    } break;
                                                    case 4: {
                                                        status = "<font color='#CDC8B1'>Procedimento finalizado</font>";
                                                    } break;
                                                }
                                            %>
                                            <strong>Status: <%= status %></strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border:none">
                                            <strong>Dentista:</strong> <%= historicoBoca.getDentista().getNome()%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border:none">
                                            <strong>Observa&ccedil;&atilde;o:</strong> <%= historicoBoca.getObservacao()%>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <%
                                if (orcado) {
                                    String idHistoricoBoca = historicoBoca.getId().toString();
                                    pageContext.setAttribute("idHistoricoBoca", idHistoricoBoca);
                                    String idBoca = historicoBoca.getBoca().getId().toString();
                                    pageContext.setAttribute("idBoca", idBoca);
                            %>
                            <td style="border:none" align="center" valign="middle">
                                <input name="excluirRegistroHistoricoBoca" class="botaodefault" type="button" value="excluir" title="Excluir" onclick="javascript: if (confirm('Tem certeza que deseja excluir este registro?')) location.href='<%=request.getContextPath()%>/app/atendimentoOrcamento/excluirRegistroHistoricoBoca.do?idHistoricoBoca=${idHistoricoBoca}&idBoca=${idBoca}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                            </td>
                            <%
                                } // if (orcado)
                            %>
                        </tr>
                        <%
                                i++;
                            } // while (iterator.hasNext())
                        %>
                        <tr>
                            <td colspan="3" style="border:none">
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="4" style="border:none">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <form name="formIncluirProcedimento" id="formIncluirProcedimento" method="POST" onsubmit="return validarDadosBoca()" action="<%=request.getContextPath()%>/app/atendimentoOrcamento/actionIncluirProcedimentoBoca.do">
                        <input name="bocaId" id="bocaId" value="<% if(boca.getId() != null) { out.print(boca.getId());}%>" type="hidden"/>
                        <table cellpadding="0" cellspacing="0" align="center" width="60%">
                            <thead>
                                <tr>
                                    <th>Inclus&atilde;o de Procedimento (<strong><font color="#FF0000">*</font></strong> campos obrigat&oacute;rios)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td align="center" style="border-bottom:1px solid #e5eff8;">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Procedimento:
                                                    <input name="tipoProcedimento" id="tipoProcedimento" type="hidden">
                                                    <select name="procedimentoId" id="procedimentoId" onchange="Procedimento.marcarValoresBC(this.value)" onkeydown="return enter(event)">
                                                        <option value="" selected>Selecione</option>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="paddingCelulaTabela" align="left">Valor: R$
                                                    <input name="valor" id="valor" type="text" size="7" maxlength="7" onkeypress="return mascaraNumeroReal(valor, 1, 7)" onblur="validarValorReal3D(valor, 'valor')" readonly disabled>
                                                    <input name="valorMinimo" id="valorMinimo" type="hidden">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Valor Cobrado: R$
                                                    <input name="valorCobrado" id="valorCobrado" type="text" size="7" maxlength="7" onkeypress="return mascaraNumeroReal(valorCobrado, 1, 7)" onblur="validarValorReal3D(valorCobrado, 'valorCobrado')">
                                                    <br><font size="1" color="#FF0000">Formato: 0000.00</font>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="paddingCelulaTabela" align="left">Observa&ccedil;&atilde;o:
                                                    <textarea name="observacao" id="observacao" rows="3" cols="35"></textarea>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td class="paddingCelulaTabela" align="left" style="border-bottom:1px solid #e5eff8;">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td class="paddingCelulaTabela" align="center" style="border-left:none; border-right:none;">
                                                    <input name="incluirProcedimentoBoca" class="botaodefault" type="submit" value="incluir" title="Incluir procedimento" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                                </td>
                                                <td class="paddingCelulaTabela" align="center" style="border-left:none; border-right:none;">
                                                    <input name="limpar" class="botaodefault" type="reset" value="limpar" title="Limpar" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                                </td>
                                                <td class="paddingCelulaTabela" align="center" style="border-left:none; border-right:none;">
                                                    <input name="verOdontograma" class="botaodefaultgra" type="button" value="ver odontograma" title="Odontograma" onclick="javascript:location.href='<%=request.getContextPath()%>/app/filaAtendimentoOrcamento/actionContinuarAtendimentoOrcamento.do?idPaciente=<%=(String)request.getSession(false).getAttribute("idPaciente")%>'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra.png)'">
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
                </td>
            </tr>
        </table>
        <%
            } // if (boca != null)
        %>
    </body>
</html>