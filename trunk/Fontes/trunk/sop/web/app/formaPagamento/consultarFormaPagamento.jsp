<%--
    Document   : consultarFormaPagamento
    Created on : 30/01/2010, 16:45:54
    Author     : Fabricio Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="annotations.FormaPagamento" %>
<%@page import="annotations.Funcionario" %>
<%@page import="web.login.ValidaGrupos" %>
<%@page import="java.util.List" %>
<%@page import="java.text.DecimalFormat" %>
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
    <%@include file="formaPagamento.js"%>
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
    <body onload="goFocus('nome')">
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value="Formas de Pagamento"/>
        </jsp:include>
        <br> &nbsp;
        <br> &nbsp;
        <%
            // Marca proxima pagina
            // Usado no Action correspondente
            request.getSession(false).setAttribute("proximaPagina", request.getRequestURI().replace(".jsp", ".do"));
        %>
        <form name="formFormaPagamento" id="formFormaPagamento" method="POST" action="<%=request.getContextPath()%>/app/formaPagamento/actionConsultarFormaPagamento.do">
            <table cellpadding="0" cellspacing="0" align="center">
                <thead>
                    <tr>
                        <th colspan="2">Consulta de Formas de Pagamento</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="2">
                           &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" width="58%" align="center">Nome:
                            <input name="opcao" id="opcao" type="hidden">
                            <input name="nome" id="nome" type="text" size="30" maxlength="90" title="Nome ou parte do nome da forma de pagamento">&nbsp;
                            <input name="pesquisarNome" class="botaodefaultgra" type="button" value="pesquisar nome" title="Pesquisar nome" onclick="return confirmarBuscarTodos(nome, 0);" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra.png)'">
                        </td>
                        <td class="paddingCelulaTabela" width="42%" align="center">Tipo:
                            <select name="tipo" id="tipo" onkeydown="return consultarComEnter(event, tipo, 1)">
                                <option value = "" selected>Selecione</option>
                                <option value = "A">&Agrave; vista</option>
                                <option value = "P">A prazo</option>
                            </select>
                            <input name="pesquisarTipo" class="botaodefaultgra" type="button" value="pesquisar tipo" title="Pesquisar tipo" onclick="return confirmarBuscarTodos(tipo, 1);" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra.png)'">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                           &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <th align="center" colspan="2"><strong>Resultado da Pesquisa</strong></th>
                    </tr>
                    <tr>
                        <td colspan="2">
                           &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                <tr>
                                    <td align="center">
                                        <strong>Nome</strong>
                                    </td>
                                    <td align="center">
                                        <strong>Descri&ccedil;&atilde;o</strong>
                                    </td>
                                    <td align="center">
                                        <strong>Tipo</strong>
                                    </td>
                                    <td align="center">
                                        <strong>Detalhes</strong>
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
                                    String idFormaPagamento;
                                    List resultado = (List)request.getAttribute("resultado");
                                    if (resultado != null) {
                                        if (resultado.size() > 0) {
                                            for (int i = 0; i < resultado.size(); i++) {
                                %>
                                <tr onMouseOver="javascript:this.style.backgroundColor='#B0FFAE'" onMouseOut="javascript:this.style.backgroundColor=''">
                                    <td align="center">
                                        <%=((FormaPagamento)resultado.get(i)).getNome()%>
                                    </td>
                                    <td align="center">
                                        <%=((FormaPagamento)resultado.get(i)).getDescricao() %>
                                    </td>
                                    <td align="center">
                                        <%
                                            if (((FormaPagamento)resultado.get(i)).getTipo() == 'A') out.print("&Agrave; vista"); else out.print("A prazo");
                                        %>
                                    </td>
                                    <td align="center">
                                        <%  if(((FormaPagamento)resultado.get(i)).getTipo() == 'A') {
                                                out.print("N&atilde;o tem");
                                                // Trecho de codigo para quando for usar desconto no pagamento a vista
                                                /*out.print("Desconto: ");
                                                if (((FormaPagamento)resultado.get(i)).getDesconto() != Double.parseDouble("0.0")) {
                                                    out.print(decimalFormat.format(((FormaPagamento)resultado.get(i)).getDesconto()) + "% <strong>|</strong> ");
                                                }
                                                else {
                                                    out.print("N&atilde;o tem" + " <strong>|</strong> ");
                                                }
                                                out.print("Valor M&iacute;nimo para desconto: ");
                                                if (((FormaPagamento)resultado.get(i)).getPisoParaDesconto() != Double.parseDouble("0.0")) {
                                                    out.print("R$" + decimalFormat.format(((FormaPagamento)resultado.get(i)).getPisoParaDesconto()));
                                                }
                                                else {
                                                    out.print("N&atilde;o tem");
                                                }*/
                                            }
                                            else {
                                                if(((FormaPagamento)resultado.get(i)).getTipo() == 'P') {
                                                    out.print("Valor M&iacute;nimo: ");
                                                    if (((FormaPagamento)resultado.get(i)).getValorMinimoAPrazo() != Double.parseDouble("0.0")) {
                                                        out.print("R$" + decimalFormat.format(((FormaPagamento)resultado.get(i)).getValorMinimoAPrazo()));
                                                    }
                                                    else {
                                                        out.print("N&atilde;o tem");
                                                    }
                                                }
                                            }
                                        %>
                                    </td>
                                    <td align="center">
                                        <%
                                            if (((FormaPagamento)resultado.get(i)).getStatus() == 'A') out.print("<font color='#00CC00'><strong>Ativo</strong></font>"); else out.print("<font color='#d42945'><strong>Inativo</strong></font>");
                                        %>
                                    </td>
                                    <td align="center">
                                        <%
                                            idFormaPagamento = (String)((FormaPagamento)resultado.get(i)).getId().toString();
                                            pageContext.setAttribute("idFormaPagamento", idFormaPagamento);
                                        %>
                                        <a href="<%=request.getContextPath()%>/app/formaPagamento/actionEditarFormaPagamento.do?idFormaPagamento=${idFormaPagamento}"><img src="<%=request.getContextPath()%>/imagens/editar.png" alt="Editar" title="Editar"></a>&nbsp;&nbsp;
                                        <a href="<%=request.getContextPath()%>/app/formaPagamento/actionVisualizarFormaPagamento.do?idFormaPagamento=${idFormaPagamento}"><img src="<%=request.getContextPath()%>/imagens/visualizar.png" alt="Visualizar" title="Visualizar"/></a>
                                    </td>
                                </tr>
                                <%
                                            } // for
                                        } // if (resultado.size() > 0)
                                        else {
                                            out.println("<tr><td align='center' colspan='6'><p style='font-size:medium; font-style:italic; color:red;'>Registro(s) n&atilde;o encontrado(s)...</p></td></tr>");
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
