<%--
    Document   : visualizarComprovantePagamentoCartao
    Created on : 30/01/2010, 16:45:54
    Author     : Fabricio Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="annotations.ComprovantePagamentoCartao"%>
<%@page import="annotations.Funcionario"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="web.login.ValidaGrupos"%>
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
    if(funcionarioLogado != null) {
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Administrador")){
            aux1 = true;
        }
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Administrador-TI")){
            aux2 = true;
        }
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Financeiro")){
            aux3 = true;
        }
        if (aux1 && aux2 && aux3) {
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
        <title>Comprovante de Pagamento com Cart&atilde;o - SOP - Sistema de Odontologia Popular</title>
    </head>
    <body onload="javascript:goFocus('voltar')">
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value="Comprovantes de Pagamentos com Cart&atilde;o"/>
        </jsp:include>
        <br> &nbsp;
        <br> &nbsp;

        <%
            DecimalFormat decimalFormat = new DecimalFormat("0.00");
            DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            // Captura objeto ComprovantePagamentoCartao do request
            // Este objeto vem da pagina consultarComprovantePagamentoCartao quando clicado o botao visualizar
            // passando pelo action correspondente (visualizarComprovantePagamentoCartaoAction)
            ComprovantePagamentoCartao comprovantePagamentoCartao = (ComprovantePagamentoCartao)request.getAttribute("comprovantePagamentoCartao");
            if (comprovantePagamentoCartao != null) {
        %>

        <table cellpadding="0" cellspacing="0" align="center">
            <thead>
                <tr>
                    <th colspan="4">Visualizar Comprovante de Pagamento com Cart&atilde;o</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="paddingCelulaTabela" align="left">
                        <strong>Bandeira:</strong>&nbsp;<%=comprovantePagamentoCartao.getBandeira()%>
                    </td>
                    <td class="paddingCelulaTabela" align="left">
                        <strong>Tipo:</strong>&nbsp;<% if (comprovantePagamentoCartao.getTipo() == 'C') out.print("Cr&eacute;dito"); else out.print("D&eacute;bito"); %>
                    </td>
                    <td class="paddingCelulaTabela" align="left" colspan="2">
                        <strong>Parcela(s):</strong>&nbsp;<%= comprovantePagamentoCartao.getParcelas()%>
                    </td>
                </tr>
                <tr>
                    <td class="paddingCelulaTabela" align="left" colspan="1">
                        <strong>C&oacute;digo de Autoriza&ccedil;&atilde;o:</strong>&nbsp;<%=comprovantePagamentoCartao.getCodigoAutorizacao() %>
                    </td>
                    <td class="paddingCelulaTabela" align="left">
                        <strong>Valor:</strong>&nbsp;R$<%=decimalFormat.format(comprovantePagamentoCartao.getValor())%>
                    </td>
                    <td class="paddingCelulaTabela" align="left">
                        <strong>Data:</strong>&nbsp;<%=dateFormat.format(comprovantePagamentoCartao.getDataPagamento())%>
                    </td>
                    <td class="paddingCelulaTabela" align="left">
                        <strong>Status:</strong>&nbsp;
                        <%
                            if (comprovantePagamentoCartao.getStatus() == 'N')
                                out.print("N&atilde;o Conferido");
                            else
                            if (comprovantePagamentoCartao.getStatus() == 'O')
                                out.print("<font color='#00CC00'><strong>Conferido</strong></font>");
                            else
                            if (comprovantePagamentoCartao.getStatus() == 'C')
                                out.print("<font color='#d42945'><strong>Cancelado / Estornado</strong></font>");
                        %>
                    </td>
                </tr>
                <tr>
                    <td class="paddingCelulaTabela" align="left" colspan="2">
                        <strong>Nome do Paciente:</strong>&nbsp;<%=comprovantePagamentoCartao.getNomePaciente()%>
                    </td>
                    <td class="paddingCelulaTabela" align="left" colspan="2">
                        <strong>C&oacute;digo do Paciente:</strong>&nbsp;<%=comprovantePagamentoCartao.getIdPaciente()%>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <table>
                            <tr>
                                <%
                                    String id = comprovantePagamentoCartao.getId().toString();
                                    pageContext.setAttribute("id", id);
                                %>
                                <td class="paddingCelulaTabela" align="center" width="50%">
                                    <input name="editar" class="botaodefault" type="button" value="editar" title="Editar" onclick="javascript:location.href='<%=request.getContextPath()%>/app/comprovantePagamentoCartao/actionEditarComprovanteCartao.do?id=${id}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                </td>
                                <td class="paddingCelulaTabela" align="center" width="50%" colspan="2">
                                    <input name="voltar" id="voltar" class="botaodefault" type="button" value="voltar" title="Voltar" onclick="javascript:history.back(1)" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
        <%
            } // if (comprovantePagamentoCartao != null)
            else {
        %>
                <jsp:forward page="../../mensagensDeRetorno/erro.jsp?codigoMensagem=12"></jsp:forward>
        <%
                System.out.println("Falha ao exibir dados de comprovantePagamentoCartao em visualizar.");
            }
        %>
    </body>
</html>