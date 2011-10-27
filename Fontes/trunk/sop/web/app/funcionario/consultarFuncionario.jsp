<%-- 
    Document   : consultarFuncionario
    Created on : 30/01/2010, 16:45:54
    Author     : Fabricio Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="annotations.Funcionario" %>
<%@page import="web.login.ValidaGrupos" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Iterator" %>
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
        <title>Funcion&aacute;rios - SOP - Sistema de Odontologia Popular</title>
    </head>
    <body onload="goFocus('nome')">
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value="Funcion&aacute;rios"/>
        </jsp:include>
        <br> &nbsp;
        <br> &nbsp;
        <%
            // Marca proxima pagina
            // Usado no Action correspondente
            request.getSession(false).setAttribute("proximaPagina", request.getRequestURI().replace(".jsp", ".do"));
        %>
        <form name="formFuncionario" id="formFuncionario" method="POST" action="<%=request.getContextPath()%>/app/funcionario/actionConsultarFuncionario.do">
            <table cellpadding="0" cellspacing="0" align="center" width="80%">
                <thead>
                    <tr>
                        <th>Consulta de Funcion&aacute;rios</th>
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
                            <input name="nome" id="nome" type="text" size="45" maxlength="250" title="Nome ou parte do nome do funcion&aacute;rio">&nbsp;&nbsp;&nbsp;
                            <!-- <input name="pesquisar" class="botaodefault" type="submit" value="pesquisar" title="Pesquisar" onMouseOver="javascript:this.style.backgroundColor='#00EE76'" onMouseOut="javascript:this.style.backgroundColor=''"> -->
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
                                        <strong>Nome</strong>
                                    </td>
                                    <td align="center">
                                        <strong>Nome de Usu&aacute;rio</strong>
                                    </td>
                                    <td align="center">
                                        <strong>Cargo</strong>
                                    </td>
                                    <td align="center">
                                        <strong>Status</strong>
                                    </td>
                                    <td align="center">
                                        <strong>Op&ccedil;&otilde;es</strong>
                                    </td>
                                </tr>
                                <%
                                    String idFuncionario;
                                    Funcionario funcionarioAux;
                                    List<Funcionario> resultado = (List<Funcionario>)request.getAttribute("resultado");
                                    if (resultado != null) {
                                        Iterator iterator = resultado.iterator();
                                        if (!resultado.isEmpty()) {
                                            while (iterator.hasNext()) {
                                                funcionarioAux = (Funcionario) iterator.next();
                                %>
                                <tr onMouseOver="javascript:this.style.backgroundColor='#B0FFAE'" onMouseOut="javascript:this.style.backgroundColor=''">
                                    <td align="center">
                                        <%= funcionarioAux.getNome()%>
                                    </td>
                                    <td align="center">
                                        <%= funcionarioAux.getNomeDeUsuario()%>
                                    </td>
                                    <td align="center">
                                        <%= funcionarioAux.getCargo() %>
                                    </td>
                                    <td align="center">
                                        <%
                                            if (funcionarioAux.getStatus() == 'A') out.print("<font color='#00CC00'><strong>Ativo</strong></font>"); else out.print("<font color='#d42945'><strong>Inativo</strong></font>");
                                        %>
                                    </td>
                                    <td align="center">
                                        <%
                                            idFuncionario = (String)funcionarioAux.getId().toString();
                                            pageContext.setAttribute("idFuncionario", idFuncionario);
                                        %>
                                        <a href="<%=request.getContextPath()%>/app/funcionario/actionEditarFuncionario.do?idFuncionario=${idFuncionario}"><img src="<%=request.getContextPath()%>/imagens/editar.png" alt="Editar" title="Editar"></a>&nbsp;&nbsp;
                                        <a href="<%=request.getContextPath()%>/app/funcionario/actionVisualizarFuncionario.do?idFuncionario=${idFuncionario}"><img src="<%=request.getContextPath()%>/imagens/visualizar.png" alt="Visualizar" title="Visualizar"/></a>
                                    </td>
                                </tr>
                                <%
                                            } // while (iterator.hasNext())
                                        }
                                        else {
                                            out.println("<tr><td align='center' colspan='5'><p style='font-size:medium; font-style:italic; color:red;'>Registro(s) n&atilde;o encontrado(s)...</p></td></tr>");
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
