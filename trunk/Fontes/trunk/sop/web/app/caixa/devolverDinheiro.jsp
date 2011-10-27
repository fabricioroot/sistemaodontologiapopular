<%-- 
    Document   : devolverDinheiro
    Created on : 10/06/2010, 22:00:11
    Author     : Fabricio Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="annotations.Funcionario" %>
<%@page import="annotations.Ficha" %>
<%@page import="annotations.Pagamento" %>
<%@page import="web.login.ValidaGrupos" %>
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

<link href="<%=request.getContextPath()%>/css/estiloGeral.css" rel="stylesheet" type="text/css">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Devolver Dinheiro - SOP - Sistema de Odontologia Popular</title>
    </head>
    <body onload="javascript:goFocus('voltar')">
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value="Devolver Dinheiro"/>
        </jsp:include>
        <br> &nbsp;
        <br> &nbsp;

        <%
            // Captura objeto ficha do request
            // Este objeto vem do action DevolverDinheiroAction acionado por botao da pagina listarPagamentos.jsp
            Ficha ficha = (Ficha)request.getAttribute("ficha");
            if (ficha != null) {
        %>

        <table cellpadding="1" cellspacing="1" align="center" width="100%">
            <tr>
                <th align="center">
                    <font style="color:black; font-size:medium;"><strong><u>Paciente:</u> <%= ficha.getPaciente().getNome()%></strong></font>
                </th>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td align="center">
                    <table cellpadding="1" cellspacing="1" align="center" width="80%" style="border:none">
                        <%
                            // Captura objeto 'pagamento' do request
                            // Este objeto vem do action DevolverDinheiroAction acionado por botao da pagina listarPagamentos.jsp
                            Pagamento pagamento = (Pagamento)request.getAttribute("pagamento");
                            if (pagamento != null) {
                        %>
                        <tr>
                            <td bgcolor="#EBE9E9" align="center" style="border:none" colspan="2">
                                <font style="color:black; font-size:small;"><strong>C&oacute;digo do Pagamento:&nbsp;<%= pagamento.getId() %></strong></font>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="border:none">
                                <table border="0" cellpadding="1" cellspacing="1" style="border:none">
                                    <tr>
                                        <td style="border:none">
                                            <%  DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                                                DecimalFormat decimalFormat = new DecimalFormat("0.00");
                                            %>
                                            <strong>Data:</strong> <%= dateFormat.format(pagamento.getDataHora())%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border:none">
                                            <strong>Forma de Pagamento:</strong> <%= pagamento.getFormaPagamento().getNome()%>
                                        </td>
                                    </tr>
                                    <%
                                        if (pagamento.getValorEmCheque() > Double.parseDouble("0")) {
                                    %>
                                    <tr>
                                        <td style="border:none">
                                            <strong>Valor em Cheque:</strong> R$<%= decimalFormat.format(pagamento.getValorEmCheque()) %>
                                        </td>
                                    </tr>
                                    <%
                                        } // if (pagamento.getValorEmCheque() > Double.parseDouble("0"))
                                        if (pagamento.getValorEmCartao() > Double.parseDouble("0")) {
                                    %>
                                    <tr>
                                        <td style="border:none">
                                            <strong>Valor em Cart&atilde;o:</strong> R$<%= decimalFormat.format(pagamento.getValorEmCartao()) %>
                                        </td>
                                    </tr>
                                    <%
                                        } // if (pagamento.getValorEmCartao() > Double.parseDouble("0"))
                                    %>
                                    <tr>
                                        <td style="border:none">
                                            <font style="color:#d42945"><strong>Valor em Dinheiro: R$<%= decimalFormat.format(pagamento.getValorEmDinheiro()) %></strong></font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border:none">
                                            <strong>Valor Total do Pagamento: R$<%= decimalFormat.format(pagamento.getValorFinal()) %></strong>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <%
                                String idPaciente = ficha.getPaciente().getId().toString();
                                pageContext.setAttribute("idPaciente", idPaciente);
                                String idPagamento = pagamento.getId().toString();
                                pageContext.setAttribute("idPagamento", idPagamento);
                            %>
                            <td style="border:none" align="center" valign="middle">
                                <input name="devolverValorEmDinheiro" class="botaodefaultgra" type="button" value="devolver dinheiro" title="Devolver valor em dinheiro" onclick="javascript: if (confirm('Tem certeza que deseja DEVOLVER o valor em dinheiro deste pagamento para o paciente?')) location.href='<%=request.getContextPath()%>/app/caixa/actionRegistrarDevolucaoDinheiro.do?idPagamento=${idPagamento}&idPaciente=${idPaciente}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra.png)'">
                            </td>
                        </tr>
                        <%
                            } // if (pagamento != null)
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
                <%
                    String idPaciente = ficha.getPaciente().getId().toString();
                    pageContext.setAttribute("idPaciente", idPaciente);
                %>
                <td class="paddingCelulaTabela" align="center">
                    <input name="voltar" id="voltar" class="botaodefault" type="button" value="voltar" title="Voltar" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionListarPagamentos.do?idPaciente=${idPaciente}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                </td>
            </tr>
        </table>
        <%
            } // if (ficha != null)
        %>
    </body>
</html>