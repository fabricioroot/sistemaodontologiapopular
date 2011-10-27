<%--
    Document   : consultarChequeBancario
    Created on : 30/01/2010, 16:45:54
    Author     : Fabricio P. Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="annotations.ChequeBancario" %>
<%@page import="annotations.Funcionario" %>
<%@page import="service.StatusChequeBancarioService" %>
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
    <%@include file="chequeBancario.js"%>
    <%@include file="../utilitario.js"%>
</script>

<link href="<%=request.getContextPath()%>/css/estiloGeral.css" rel="stylesheet" type="text/css">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Cheques Banc&aacute;rios - SOP - Sistema de Odontologia Popular</title>
    </head>
    <body onload="goFocus('numero')">
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value="Cheques Banc&aacute;rios"/>
        </jsp:include>
        <br> &nbsp;
        <br> &nbsp;
        <%
            // Marca proxima pagina
            // Usado no Action correspondente
            request.getSession(false).setAttribute("proximaPagina", request.getRequestURI().replace(".jsp", ".do"));
        %>
        <form name="formChequeBancario" id="formChequeBancario" method="POST" action="<%=request.getContextPath()%>/app/chequeBancario/actionConsultarChequeBancario.do">
            <table cellpadding="0" cellspacing="0" align="center">
                <thead>
                    <tr>
                        <th>Consulta de Cheques Banc&aacute;rios</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                           &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" width="100%" align="center">N&uacute;mero do cheque:
                            <input name="opcao" id="opcao" type="hidden">
                            <input name="numero" id="numero" type="text" size="40" maxlength="90" title="N&uacute;mero do cheque" onkeydown="return consultarComEnter(event, numero, 0)">&nbsp;&nbsp;&nbsp;
                            <input name="pesquisarNumero" class="botaodefaultgra" type="button" value="pesquisar n&uacute;mero" title="Pesquisar n&uacute;mero" onclick="return confirmarBuscarTodos(numero, 0);" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra.png)'">
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" width="100%">
                            <table>
                                <tr>
                                    <td width="20%" style="border:none">
                                        &nbsp;
                                    </td>
                                    <td style="border:none" align="left" width="30%">Data para depositar <strong>(IN&Iacute;CIO)</strong>:
                                        <input name="dataInicio" id="dataInicio" type="text" size="10" maxlength="10" onKeyPress="mascaraData(dataInicio)" onkeydown="return consultarComEnter(event, dataInicio, 1)" onblur="validarData(dataInicio, 'dataInicio')">
                                        <br><font size="1" color="#FF0000">Formato: dd/mm/aaaa</font>
                                    </td>
                                    <td style="border:none" align="left" width="40%">Data para depositar <strong>(FIM)</strong>:
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
                                        <strong>Nome do Titular</strong>
                                    </td>
                                    <td align="center">
                                        <strong>Banco</strong>
                                    </td>
                                    <td align="center">
                                        <strong>N&uacute;mero</strong>
                                    </td>
                                    <td align="center">
                                        <strong>Valor (R$)</strong>
                                    </td>
                                    <td align="center">
                                        <strong>Data para Depositar</strong>
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
                                    String idChequeBancario;
                                    boolean irregular = false;
                                    List resultado = (List)request.getAttribute("resultado");
                                    if (resultado != null) {
                                        if (resultado.size() > 0) {
                                            for (int i = 0; i < resultado.size(); i++) {
                                                irregular = false;
                                                if (((ChequeBancario)resultado.get(i)).getStatus().getCodigo().equals(Short.parseShort("3"))) {
                                                    irregular = true;
                                                }
                                %>
                                <tr bgcolor="<%if (irregular) out.print("#ffcccc");%>" onMouseOver="javascript:this.style.backgroundColor='<% if (irregular) out.print("#ff9999"); else out.print("#B0FFAE");%>'" onMouseOut="javascript:this.style.backgroundColor=''">
                                    <td align="center">
                                        <%=((ChequeBancario)resultado.get(i)).getNomeTitular() %>
                                    </td>
                                    <td align="center">
                                        <%=((ChequeBancario)resultado.get(i)).getBanco() %>
                                    </td>
                                    <td align="center">
                                        <%=((ChequeBancario)resultado.get(i)).getNumero() %>
                                    </td>
                                    <td align="center">
                                        <%= decimalFormat.format(((ChequeBancario)resultado.get(i)).getValor()) %>
                                    </td>
                                    <td align="center">
                                        <%= dateFormat.format(((ChequeBancario)resultado.get(i)).getDataParaDepositar()) %>
                                    </td>
                                    <td align="center">
                                        <%
                                            if(((ChequeBancario)resultado.get(i)).getStatus().equals(StatusChequeBancarioService.getStatusChequeBancarioIrregular()))
                                                out.print("<font color='#d42945'><strong>Irregular</strong></font>");
                                            else
                                            if(((ChequeBancario)resultado.get(i)).getStatus().equals(StatusChequeBancarioService.getStatusChequeBancarioCancelado()))
                                                out.print("<font color='#d42945'><strong>Cancelado</strong></font>");
                                            else
                                            if(((ChequeBancario)resultado.get(i)).getStatus().equals(StatusChequeBancarioService.getStatusChequeBancarioCompensado()))
                                                out.print("<font color='#00CC00'><strong>Compensado</strong></font>");
                                            else
                                                out.print(((ChequeBancario)resultado.get(i)).getStatus().getNome());
                                        %>
                                    </td>
                                    <td align="center">
                                        <%
                                            idChequeBancario = (String)((ChequeBancario)resultado.get(i)).getId().toString();
                                            pageContext.setAttribute("idChequeBancario", idChequeBancario);
                                        %>
                                        <a href="<%=request.getContextPath()%>/app/chequeBancario/actionEditarChequeBancario.do?idChequeBancario=${idChequeBancario}"><img src="<%=request.getContextPath()%>/imagens/editar.png" alt="Editar" title="Editar"></a>&nbsp;&nbsp;
                                        <a href="<%=request.getContextPath()%>/app/chequeBancario/actionVisualizarChequeBancario.do?idChequeBancario=${idChequeBancario}"><img src="<%=request.getContextPath()%>/imagens/visualizar.png" alt="Visualizar" title="Visualizar"/></a>
                                    </td>
                                </tr>
                                <%
                                        } // for
                                    } // if (resultado.size() > 0)
                                        else {
                                            out.println("<tr><td align='center' colspan='7'><p style='font-size:medium; font-style:italic; color:red;'>Registro(s) n&atilde;o encontrado(s)...</p></td></tr>");
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
