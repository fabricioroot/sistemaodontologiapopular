<%--
    Document   : visualizarProcedimento
    Created on : 30/01/2010, 16:45:54
    Author     : Fabricio Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="annotations.Procedimento"%>
<%@page import="annotations.Funcionario"%>
<%@page import="web.login.ValidaGrupos"%>
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
    if(funcionarioLogado != null) {
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Administrador")){
            aux1 = true;
        }
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Administrador-TI")){
            aux2 = true;
        }
        if (aux1 && aux2) {
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
        <title>Procedimentos - SOP - Sistema de Odontologia Popular</title>
    </head>
    <body onload="javascript:goFocus('voltar')">
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value="Procedimentos"/>
        </jsp:include>
        <br> &nbsp;
        <br> &nbsp;

        <%
            // Captura objeto procedimento do request
            // Este objeto vem da pagina consultar procedimento quando clicado o botao visualizar
            // passando pelo action correspondente (visualizarProcedimentoAction)
            Procedimento procedimento = (Procedimento)request.getAttribute("procedimento");
            if (procedimento != null) {
        %>

        <table cellpadding="0" cellspacing="0" align="center">
            <thead>
                <tr>
                    <th colspan="4">Visualizar Procedimento</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="paddingCelulaTabela" align="left">
                        <strong>Nome:</strong>&nbsp;<%=procedimento.getNome()%>
                    </td>
                    <td class="paddingCelulaTabela" align="left">
                        <strong>Valor:</strong>
                        <%
                            DecimalFormat decimalFormat = new DecimalFormat("0.00");
                            if (procedimento.getValor() != Double.parseDouble("0.0")) {
                                out.print("R$" + decimalFormat.format(procedimento.getValor()));
                            }
                            else {
                                out.print("Gr&aacute;tis");
                            }
                        %>
                    </td>
                    <td class="paddingCelulaTabela" align="left">
                        <strong>Valor M&iacute;nimo:</strong>
                        <%
                            if (procedimento.getValor() != Double.parseDouble("0.0")) {
                                out.print("R$" + decimalFormat.format(procedimento.getValorMinimo()));
                            }
                            else {
                                out.print("N&atilde;o tem");
                            }
                        %>
                    </td>
                    <td class="paddingCelulaTabela" align="left">
                        <strong>Status:</strong>&nbsp;<%if (procedimento.getStatus() == 'A') { out.print("<font color='#00CC00'><strong>Ativo</strong></font>"); } else { out.print("<font color='#d42945'><strong>Inativo</strong></font>"); }%>
                    </td>
                </tr>
                <tr>
                    <td class="paddingCelulaTabela" align="left" colspan="2">
                        <strong>Tipo:</strong>&nbsp;<%if (procedimento.getTipo().equals("PD")) out.print("Parte do Dente"); else if (procedimento.getTipo().equals("DI")) out.print("Dente Inteiro"); else if (procedimento.getTipo().equals("BC")) out.print("Boca Completa");%>
                    </td>
                    <td class="paddingCelulaTabela" align="left" colspan="2">
                        <strong>Descri&ccedil;&atilde;o:</strong>&nbsp;<%=procedimento.getDescricao()%>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <%
                        String idProcedimento = procedimento.getId().toString();
                        pageContext.setAttribute("idProcedimento", idProcedimento);
                    %>
                    <td class="paddingCelulaTabela" align="center" width="50%" colspan="2">
                        <input name="editar" class="botaodefault" type="button" value="editar" title="Editar" onclick="javascript:location.href='<%=request.getContextPath()%>/app/procedimento/actionEditarProcedimento.do?idProcedimento=${idProcedimento}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                    </td>
                    <%
                        String URLProximaPagina = (String)request.getSession(false).getAttribute("proximaPagina");
                        String texto = "Voltar";
                        Boolean botaoFinalizar = (Boolean)request.getAttribute("botaoFinalizar");
                        if (botaoFinalizar != null) texto = "Finalizar";
                    %>
                    <td class="paddingCelulaTabela" align="center" width="50%" colspan="2">
                        <input name="voltar" id="voltar" class="botaodefault" type="button" value="<%=texto.toLowerCase()%>" title="<%=texto%>" onclick="javascript:<% if (botaoFinalizar != null) out.print("location.href='" + URLProximaPagina + "'"); else out.print("history.back(1)");  %>" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                    </td>
                </tr>
            </tbody>
        </table>
        <%
            } // if (procedimento != null)
            else {
        %>
                <jsp:forward page="../../mensagensDeRetorno/erro.jsp?codigoMensagem=12"></jsp:forward>
        <%
            System.out.println("Falha ao exibir os dados de procedimento em visualizar.");
            }
        %>
    </body>
</html>
