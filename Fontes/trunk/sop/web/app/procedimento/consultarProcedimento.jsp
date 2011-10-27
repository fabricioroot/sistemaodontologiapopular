<%--
    Document   : consultarProcedimento
    Created on : 30/01/2010, 16:45:54
    Author     : Fabrício Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="annotations.Procedimento" %>
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
    <body onload="goFocus('nome')">
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value="Procedimentos"/>
        </jsp:include>
        <br> &nbsp;
        <br> &nbsp;
        <%
            // Marca proxima pagina
            // Usado no Action correspondente
            request.getSession(false).setAttribute("proximaPagina", request.getRequestURI().replace(".jsp", ".do"));
        %>
        <form name="formProcedimento" id="formProcedimento" method="POST" action="<%=request.getContextPath()%>/app/procedimento/actionConsultarProcedimento.do">
            <table cellpadding="0" cellspacing="0" align="center">
                <thead>
                    <tr>
                        <th>Consulta de Procedimentos</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                           &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" width="100%" align="center">Nome:
                            <input name="nome" id="nome" type="text" size="40" maxlength="90" title="Nome ou parte do nome do procedimento">&nbsp;&nbsp;&nbsp;
                           <!-- <input name="pesquisar" class="botaodefault" type="submit" value="pesquisar" title="Pesquisar"  onclick="return confirmarBuscarTodos(nome);" onMouseOver="javascript:this.style.backgroundColor='#00EE76'" onMouseOut="javascript:this.style.backgroundColor=''"> -->
                            <input name="pesquisar" class="botaodefault" type="submit" value="pesquisar" title="Pesquisar" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
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
                                        <strong>C&oacute;digo</strong>
                                    </td>
                                    <td align="center">
                                        <strong>Nome</strong>
                                    </td>
                                    <td align="center">
                                        <strong>Tipo</strong>
                                    </td>
                                    <td align="center">
                                        <strong>Descri&ccedil;&atilde;o</strong>
                                    </td>
                                    <td align="center">
                                        <strong>Status</strong>
                                    </td>
                                    <td align="center">
                                        <strong>Valor (R$)</strong>
                                    </td>
                                    <td align="center">
                                        <strong>Valor M&iacute;nimo (R$)</strong>
                                    </td>
                                    <td align="center">
                                        <strong>Op&ccedil;&otilde;es</strong>
                                    </td>
                                </tr>
                                <%
                                    DecimalFormat decimalFormat = new DecimalFormat("0.00");
                                    String idProcedimento;
                                    List resultado = (List)request.getAttribute("resultado");
                                    if (resultado != null) {
                                        if (resultado.size() > 0) {
                                            for (int i = 0; i < resultado.size(); i++) {
                                %>
                                <tr onMouseOver="javascript:this.style.backgroundColor='#B0FFAE'" onMouseOut="javascript:this.style.backgroundColor=''">
                                    <td align="center">
                                        <%=((Procedimento)resultado.get(i)).getId()%>
                                    </td>
                                    <td align="center">
                                        <%=((Procedimento)resultado.get(i)).getNome()%>
                                    </td>
                                    <td align="center">
                                        <%
                                            if (((Procedimento)resultado.get(i)).getTipo().equals("PD")) out.print("Parte de Dente"); else if (((Procedimento)resultado.get(i)).getTipo().equals("DI")) out.print("Dente Inteiro"); else if (((Procedimento)resultado.get(i)).getTipo().equals("BC")) out.print("Boca Completa");
                                        %>
                                    </td>
                                    <td align="center">
                                        <%=((Procedimento)resultado.get(i)).getDescricao() %>
                                    </td>
                                    <td align="center">
                                        <%
                                            if (((Procedimento)resultado.get(i)).getStatus() == 'A') out.print("<font color='#00CC00'><strong>Ativo</strong></font>"); else out.print("<font color='#d42945'><strong>Inativo</strong></font>");
                                        %>
                                    </td>
                                    <td align="center">
                                        <%
                                            if (((Procedimento)resultado.get(i)).getValor() != Double.parseDouble("0.0")) {
                                                out.print(decimalFormat.format(((Procedimento)resultado.get(i)).getValor()));
                                            }
                                            else {
                                                out.print("Gr&aacute;tis");
                                            }
                                        %>
                                    </td>
                                    <td align="center">
                                        <%
                                            if (((Procedimento)resultado.get(i)).getValorMinimo() != Double.parseDouble("0.0")) {
                                                out.print(decimalFormat.format(((Procedimento)resultado.get(i)).getValorMinimo()));
                                            }
                                            else {
                                                out.print("N&atilde;o tem");
                                            }
                                        %>
                                    </td>
                                    <td align="center">
                                        <%
                                            idProcedimento = (String)((Procedimento)resultado.get(i)).getId().toString();
                                            pageContext.setAttribute("idProcedimento", idProcedimento);
                                        %>
                                        <a href="<%=request.getContextPath()%>/app/procedimento/actionEditarProcedimento.do?idProcedimento=${idProcedimento}"><img src="<%=request.getContextPath()%>/imagens/editar.png" alt="Editar" title="Editar"></a>&nbsp;&nbsp;
                                        <a href="<%=request.getContextPath()%>/app/procedimento/actionVisualizarProcedimento.do?idProcedimento=${idProcedimento}"><img src="<%=request.getContextPath()%>/imagens/visualizar.png" alt="Visualizar" title="Visualizar"/></a>
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
