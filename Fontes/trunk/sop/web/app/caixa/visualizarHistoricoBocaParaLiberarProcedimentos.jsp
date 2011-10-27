<%-- 
    Document   : visualizarHistoricoBocaParaLiberarProcedimentos
    Created on : 20/05/2010, 23:54:56
    Author     : Fabricio Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="annotations.Funcionario" %>
<%@page import="annotations.Boca" %>
<%@page import="annotations.HistoricoBoca" %>
<%@page import="service.StatusProcedimentoService" %>
<%@page import="web.login.ValidaGrupos" %>
<%@page import="java.util.Collection" %>
<%@page import="java.util.Iterator" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.text.DateFormat" %>
<%@page import="java.text.DecimalFormat" %>
<%@page import="javax.servlet.http.HttpSession" %>

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
    // Funcao para colocar elemento em foco
    function goFocus(elementID){
        document.getElementById(elementID).focus();
    }
</script>

<link href="<%=request.getContextPath()%>/css/estiloOdontograma.css" rel="stylesheet" type="text/css">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Hist&oacute;rico Boca Completa - SOP - Sistema de Odontologia Popular</title>
    </head>
    <body onload="javascript:goFocus('voltar')">
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value="Hist&oacute;rico Boca Completa"/>
        </jsp:include>
        <br> &nbsp;
        <br> &nbsp;

        <%
            // Captura objeto boca do request
            // Este objeto vem do action VisualizarHistoricoBocaAction acionado pelo botao '+ Boca Completa' da pagina liberarProcedimentos
            Boca boca = (Boca)request.getAttribute("boca");
            if (boca != null) {
        %>

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
                <td align="center" colspan="4">
                    <table cellpadding="1" cellspacing="1" align="center" width="80%" style="border:none">
                        <%
                            // Captura objeto 'historicoBocaCollectionOrdenadoDescData' do request
                            // Este objeto vem do action VisualizarHistoricoBocaAction acionado por botao da pagina liberarProcedimentos
                            Collection<HistoricoBoca> historicoBocaCollectionOrdenadoDescData = (Collection<HistoricoBoca>)request.getAttribute("historicoBocaCollectionOrdenadoDescData");
                            if (!historicoBocaCollectionOrdenadoDescData.isEmpty()) {
                                HistoricoBoca historicoBoca;
                                Iterator iterator = historicoBocaCollectionOrdenadoDescData.iterator();
                                int i = 1;
                                while (iterator.hasNext()) {
                                    historicoBoca = (HistoricoBoca) iterator.next();
                        %>
                        <tr>
                            <td bgcolor="#EBE9E9" align="center" style="border:none" colspan="3">
                                <font style="color:black; font-size:small;"><strong>Registro&nbsp;<%=i%></strong></font>
                            </td>
                        </tr>
                        <tr>
                            <%
                                boolean orcado = false;
                                boolean liberado = false;
                                if (historicoBoca.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoOrcado())) {
                                    orcado = true;
                                }
                                else
                                if (historicoBoca.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoPago())) {
                                    liberado = true;
                                }
                            %>
                            <td colspan="2" align="left" style="border:none">
                                <table border="0" cellpadding="1" cellspacing="1" style="border:none">
                                    <tr>
                                        <td style="border:none">
                                            <%  DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
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
                                String idHistoricoBoca = historicoBoca.getId().toString();
                                pageContext.setAttribute("idHistoricoBoca", idHistoricoBoca);
                                String idBoca = historicoBoca.getBoca().getId().toString();
                                pageContext.setAttribute("idBoca", idBoca);
                                if (orcado) {
                            %>
                            <td style="border:none" align="center" valign="middle">
                                <input name="liberarProcedimentoBocaCompleta" class="botaodefault" type="button" value="liberar" title="Liberar procedimento" onclick="javascript: if (confirm('Tem certeza que deseja LIBERAR este procedimento?')) location.href='<%=request.getContextPath()%>/app/caixa/liberarProcedimentoBocaCompleta.do?idHistoricoBoca=${idHistoricoBoca}&idBoca=${idBoca}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                            </td>
                            <%
                                } // if (orcado)
                                else
                                if (liberado) {
                            %>
                            <td style="border:none" align="center" valign="middle">
                                <input name="cancelarLiberacaoProcedimentoBocaCompleta" class="botaodefaultextrag" type="button" value="cancelar libera&ccedil;&atilde;o" title="Cancelar libera&ccedil;&atilde;o" onclick="javascript: if (confirm('Tem certeza que deseja CANCELAR esta libera&ccedil;&atilde;o de procedimento?')) location.href='<%=request.getContextPath()%>/app/caixa/cancelarLiberacaoProcedimentoBocaCompleta.do?idHistoricoBoca=${idHistoricoBoca}&idBoca=${idBoca}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-extrag-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-extrag.png)'">
                            </td>
                            <%
                                } // if (liberado)
                            %>
                        </tr>
                            <%
                                        i++;
                                    } // while (iterator.hasNext())
                                } // if (!historicoBocaCollectionOrdenadoDescData.isEmpty())
                                else {
                                    out.println("<tr><td align='center' colspan='3' style='border:none'><p style='font-size:medium; font-style:italic; color:red;'>Hist&oacute;rico vazio...</p></td></tr>");
                                }
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
                <%
                    String idPaciente = boca.getPaciente().getId().toString();
                    pageContext.setAttribute("idPaciente", idPaciente);
                %>
                <td class="paddingCelulaTabela" align="center" colspan="4">
                    <input name="voltar" id="voltar" class="botaodefault" type="button" value="voltar" title="Voltar" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionLiberacaoProcedimentos.do?idPaciente=${idPaciente}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                </td>
            </tr>
        </table>
        <%
            } // if (boca != null)
        %>
    </body>
</html>
