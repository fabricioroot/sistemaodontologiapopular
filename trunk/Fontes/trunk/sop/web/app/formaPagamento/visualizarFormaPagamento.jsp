<%--
    Document   : visualizarFormaPagamento
    Created on : 30/01/2010, 16:45:54
    Author     : Fabricio Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="annotations.FormaPagamento"%>
<%@page import="annotations.Funcionario"%>
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
        <title>Formas de Pagamento - SOP - Sistema de Odontologia Popular</title>
    </head>
    <body onload="javascript:goFocus('voltar')">
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value="Formas de Pagamento"/>
        </jsp:include>
        <br> &nbsp;
        <br> &nbsp;

        <%
            // Captura objeto formaPagamento do request
            // Este objeto vem da pagina consultar forma pagamento quando clicado o botao visualizar
            // passando pelo action correspondente (visualizarFormaPagamentoAction)
            FormaPagamento formaPagamento = (FormaPagamento)request.getAttribute("formaPagamento");
            if (formaPagamento != null) {
        %>

        <table cellpadding="0" cellspacing="0" align="center">
            <thead>
                <tr>
                    <th colspan="3">Visualizar Forma de Pagamento</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="paddingCelulaTabela" align="left" width="45%">
                        <strong>Nome:</strong>&nbsp;<%=formaPagamento.getNome()%>
                    </td>
                    <td class="paddingCelulaTabela" align="left" width="25%">
                        <strong>Tipo:</strong>&nbsp;<%if (formaPagamento.getTipo() == 'A') { out.print("&Agrave; Vista"); } else { out.print("A Prazo"); }%>
                    </td>
                    <td class="paddingCelulaTabela" align="left" width="30%">
                        <strong>Status:</strong>&nbsp;<%if (formaPagamento.getStatus() == 'A') { out.print("<font color='#00CC00'><strong>Ativo</strong></font>"); } else { out.print("<font color='#d42945'><strong>Inativo</strong></font>"); }%>
                    </td>
                </tr>
                <tr>
                    <td class="paddingCelulaTabela" align="left" colspan="3">
                        <strong>Descri&ccedil;&atilde;o:</strong>&nbsp;<%=formaPagamento.getDescricao()%>
                    </td>
                </tr>
                <%
                    if (formaPagamento.getTipo() == 'P') {
                %>
                <tr>
                    <td class="paddingCelulaTabela" align="center" colspan="3">
                        <table>
                            <thead>
                                <tr>
                                    <th>Detalhes</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="paddingCelulaTabela" align="left" width="100%">
                                        <strong>Valor m&iacute;nimo:</strong>&nbsp;
                                        <%  if (formaPagamento.getValorMinimoAPrazo() == Double.parseDouble("0.0")) {
                                                out.print("N&atilde;o tem");
                                            }
                                            else {
                                                out.print("R$" + formaPagamento.getValorMinimoAPrazo());
                                            }
                                        %>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <%
                    } // if (formaPagamento.getTipo() == 'P') {
                    // if (formaPagamento.getTipo() == 'A') { // Trecho de codigo para quando for usar desconto no pagamento a vista
                    if (formaPagamento.getTipo() == 'F') {
                %>
                <tr>
                    <td class="paddingCelulaTabela" align="center" colspan="3">
                        <table>
                            <thead>
                                <tr>
                                    <th colspan="2">Detalhes</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="paddingCelulaTabela" align="left">
                                        <strong>Desconto:</strong>&nbsp;
                                        <%  if (formaPagamento.getDesconto() == Double.parseDouble("0.0")) {
                                                out.print("N&atilde;o tem");
                                            }
                                            else {
                                                out.print(formaPagamento.getDesconto() + "%");
                                            }
                                        %>
                                    </td>
                                    <td class="paddingCelulaTabela" align="left">
                                        <strong>Valor m&iacute;nimo para desconto:</strong>&nbsp;
                                        <%  if (formaPagamento.getPisoParaDesconto() == Double.parseDouble("0.0")) {
                                                out.print("N&atilde;o tem");
                                            }
                                            else {
                                                out.print("R$" + formaPagamento.getPisoParaDesconto());
                                            }
                                        %>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <%
                    } // if (formaPagamento.getTipo() == 'A') {
                %>
                <tr>
                    <td colspan="3">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <%
                        String idFormaPagamento = formaPagamento.getId().toString();
                        pageContext.setAttribute("idFormaPagamento", idFormaPagamento);
                    %>
                    <td class="paddingCelulaTabela" align="center" width="50%">
                        <input name="editar" class="botaodefault" type="button" value="editar" title="Editar" onclick="javascript:location.href='<%=request.getContextPath()%>/app/formaPagamento/actionEditarFormaPagamento.do?idFormaPagamento=${idFormaPagamento}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
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
            } // if (formaPagamento != null)
            else {
        %>
                <jsp:forward page="../../mensagensDeRetorno/erro.jsp?codigoMensagem=12"></jsp:forward>
        <%
            System.out.println("Falha ao exibir os dados de forma de pagamento em visualizar.");
            }
        %>
    </body>
</html>
