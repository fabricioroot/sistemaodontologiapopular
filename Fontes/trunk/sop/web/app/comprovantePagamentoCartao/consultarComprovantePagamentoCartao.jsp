<%--
    Document   : consultarComprovantePagamentoCartao
    Created on : 30/01/2010, 16:45:54
    Author     : Fabricio P. Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="annotations.ComprovantePagamentoCartao" %>
<%@page import="annotations.Funcionario" %>
<%@page import="web.login.ValidaGrupos" %>
<%@page import="java.util.List" %>
<%@page import="java.text.DecimalFormat" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
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
    <%@include file="comprovantePagamentoCartao.js"%>
    <%@include file="../utilitario.js"%>
</script>

<link href="<%=request.getContextPath()%>/css/estiloGeral.css" rel="stylesheet" type="text/css">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Comprovante de Pagamento com Cart&atilde;o - SOP - Sistema de Odontologia Popular</title>
    </head>
    <body onload="goFocus('codigoAutorizacao')">
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value="Comprovantes de Pagamentos com Cart&atilde;o"/>
        </jsp:include>
        <br> &nbsp;
        <br> &nbsp;
        <%
            // Marca proxima pagina
            // Usado no Action correspondente
            request.getSession(false).setAttribute("proximaPagina", request.getRequestURI().replace(".jsp", ".do"));
        %>
        <form name="formComprovantePagamentoCartao" id="formComprovantePagamentoCartao" method="POST" action="<%=request.getContextPath()%>/app/comprovantePagamentoCartao/actionConsultarComprovantePagamentoCartao.do">
            <table cellpadding="0" cellspacing="0" align="center">
                <thead>
                    <tr>
                        <th>Consulta de Comprovantes de Pagamentos com Cart&atilde;o</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                           &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" width="100%" align="center">C&oacute;digo de Autoriza&ccedil;&atilde;o:
                            <input name="opcao" id="opcao" type="hidden">
                            <input name="codigoAutorizacao" id="codigoAutorizacao" type="text" size="40" maxlength="90" title="C&oacute;digo de autoriza&ccedil;&atilde;o" onkeydown="return consultarComEnter(event, codigoAutorizacao, 0)">&nbsp;&nbsp;&nbsp;
                            <input name="pesquisar" class="botaodefaultgra" type="button" value="pesquisar c&oacute;digo" title="Pesquisar c&oacute;digo de autoriza&ccedil;&atilde;o" onclick="return confirmarBuscarTodos(codigoAutorizacao, 0);" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra.png)'">
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" width="100%">
                            <table>
                                <tr>
                                    <td width="25%" style="border:none">
                                        &nbsp;
                                    </td>
                                    <td style="border:none" align="left" width="20%">Data <strong>(IN&Iacute;CIO)</strong>:
                                        <input name="dataInicio" id="dataInicio" type="text" size="10" maxlength="10" onKeyPress="mascaraData(dataInicio)" onkeydown="return consultarComEnter(event, dataInicio, 1)" onblur="validarData(dataInicio, 'dataInicio')">
                                        <br><font size="1" color="#FF0000">Formato: dd/mm/aaaa</font>
                                    </td>
                                    <td style="border:none" align="left" width="35%">Data <strong>(FIM)</strong>:
                                        <input name="dataFim" id="dataFim" type="text" size="10" maxlength="10" onKeyPress="mascaraData(dataFim)" onkeydown="return consultarComEnter(event, dataInicio, 1)" onblur="validarData(dataFim, 'dataFim')">&nbsp;&nbsp;&nbsp;
                                        <input name="pesquisarPeriodo" class="botaodefaultgra" type="button" value="pesquisar per&iacute;odo" title="Pesquisar per&iacute;odo" onclick="return confirmarBuscarTodos(dataInicio, 1);" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra.png)'">
                                        <br><font size="1" color="#FF0000">Formato: dd/mm/aaaa</font>
                                    </td>
                                    <td width="10%" style="border:none">
                                        &nbsp;
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
                        <th align="center"><strong>Resultado da Pesquisa</strong></th>
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
                                        <strong>Status</strong>
                                    </td>
                                    <td align="center">
                                        <strong>Op&ccedil;&otilde;es</strong>
                                    </td>
                                </tr>
                                <%
                                    DecimalFormat decimalFormat = new DecimalFormat("0.00");
                                    DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                                    String id;
                                    List resultado = (List)request.getAttribute("resultado");
                                    if (resultado != null) {
                                        if (resultado.size() > 0) {
                                            for (int i = 0; i < resultado.size(); i++) {
                                %>
                                <tr onMouseOver="javascript:this.style.backgroundColor='#B0FFAE'" onMouseOut="javascript:this.style.backgroundColor=''">
                                    <td align="center">
                                        <%= dateFormat.format(((ComprovantePagamentoCartao)resultado.get(i)).getDataPagamento()) %>
                                    </td>
                                    <td align="center">
                                        <%=((ComprovantePagamentoCartao)resultado.get(i)).getCodigoAutorizacao() %>
                                    </td>
                                    <td align="center">
                                        <%=((ComprovantePagamentoCartao)resultado.get(i)).getBandeira() %>
                                    </td>
                                    <td align="center">
                                        <%
                                            if (((ComprovantePagamentoCartao)resultado.get(i)).getTipo() == 'C') out.print("Cr&eacute;dito"); else out.print("D&eacute;bito");
                                        %>
                                    </td>
                                    <td align="center">
                                        <%=((ComprovantePagamentoCartao)resultado.get(i)).getParcelas() %>
                                    </td>
                                    <td align="center">
                                        <%= decimalFormat.format(((ComprovantePagamentoCartao)resultado.get(i)).getValor()) %>
                                    </td>
                                    <td align="center">
                                        <%
                                            if (((ComprovantePagamentoCartao)resultado.get(i)).getStatus() == 'N')
                                                out.print("N&atilde;o Conferido");
                                            else
                                            if (((ComprovantePagamentoCartao)resultado.get(i)).getStatus() == 'O')
                                                out.print("<font color='#00CC00'><strong>Conferido</strong></font>");
                                            else
                                            if (((ComprovantePagamentoCartao)resultado.get(i)).getStatus() == 'C')
                                                out.print("<font color='#d42945'><strong>Cancelado / Estornado</strong></font>");
                                        %>
                                    </td>
                                    <td align="center">
                                        <%
                                            id = ((ComprovantePagamentoCartao)resultado.get(i)).getId().toString();
                                            pageContext.setAttribute("id", id);
                                        %>
                                        <a href="<%=request.getContextPath()%>/app/comprovantePagamentoCartao/actionEditarComprovanteCartao.do?id=${id}"><img src="<%=request.getContextPath()%>/imagens/editar.png" alt="Editar" title="Editar"></a>&nbsp;&nbsp;
                                        <a href="<%=request.getContextPath()%>/app/comprovantePagamentoCartao/actionVisualizarComprovanteCartao.do?id=${id}"><img src="<%=request.getContextPath()%>/imagens/visualizar.png" alt="Visualizar" title="Visualizar"/></a>
                                    </td>
                                </tr>
                                <%
                                        } // for
                                    } // if (resultado.size() > 0)
                                        else {
                                            out.println("<tr><td align='center' colspan='8'><p style='font-size:medium; font-style:italic; color:red;'>Registro(s) n&atilde;o encontrado(s)...</p></td></tr>");
                                        }
                                    } // if (resultado != null)
                                %>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
    </body>
</html>
