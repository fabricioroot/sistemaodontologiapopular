<%-- 
    Document   : consultarGruposDeAcesso
    Created on : 25/02/2010, 00:10:21
    Author     : Fabricio Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="annotations.Funcionario" %>
<%@page import="annotations.GrupoAcesso" %>
<%@page import="web.login.ValidaGrupos" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Set" %>
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
    <%@include file="grupoAcesso.js"%>
    // Funcao para colocar elemento em foco
    function goFocus(elementID){
        document.getElementById(elementID).focus();
    }

    // Funcao 'trim'
    function trim(string){
        return string.replace(/^\s+|\s+$/g,"");
    }
</script>

<link href="<%=request.getContextPath()%>/css/estiloGeral.css" rel="stylesheet" type="text/css">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Grupos de Acesso - SOP - Sistema de Odontologia Popular</title>
    </head>
    <body onload="goFocus('grupoAcessoId')">
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value="Grupos de Acesso"/>
        </jsp:include>
        <br> &nbsp;
        <br> &nbsp;
        <form name="formGrupoAcesso" id="formGrupoAcesso" method="POST" action="<%=request.getContextPath()%>/app/grupoAcesso/actionConsultarGrupoAcesso.do">
            <table cellpadding="0" cellspacing="0" align="center">
                <thead>
                    <tr>
                        <th>Consulta de Usu&aacute;rios de um Grupo de Acesso</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                           &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" width="100%" align="center">Grupo de Acesso:
                            <select name="grupoAcessoId" id="grupoAcessoId" onkeydown="return consultarComEnter(event)">
                                <option value="" selected>Selecione</option>
                                <option value="1">Administrador</option>
                                <option value="2">Administrador de TI</option>
                                <option value="3">Caixa</option>
                                <option value="4">Dentista-Or&ccedil;amento</option>
                                <option value="5">Dentista-Tratamento</option>
                                <option value="6">Financeiro</option>
                                <option value="7">Relat&oacute;rio</option>
                                <option value="8">Secretaria</option>
                            </select>
                            &nbsp;&nbsp;&nbsp;<input name="pesquisar" id="pesquisar" class="botaodefault" type="submit" value="pesquisar" title="Pesquisar" onclick="return validarPesquisar(grupoAcessoId)" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
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
                                        <strong>Nome do Grupo de Acesso</strong>
                                    </td>
                                    <td align="center">
                                        <strong>Nome do Funcion&aacute;rio</strong>
                                    </td>
                                    <td align="center">
                                        <strong>Nome de Usu&aacute;rio do Funcion&aacute;rio</strong>
                                    </td>
                                    <td align="center">
                                        <strong>Cargo do Funcion&aacute;rio</strong>
                                    </td>
                                </tr>
                                <%
                                    boolean controle = false;
                                    List<GrupoAcesso> resultado = (List<GrupoAcesso>)request.getAttribute("resultado");
                                    if (resultado != null) {
                                        if (resultado.size() > 0) {
                                            controle = resultado.size() == 1 ? true : false;
                                            Iterator iteratorGrupo = resultado.iterator();
                                            while(iteratorGrupo.hasNext()) {
                                                GrupoAcesso grupoAcesso = (GrupoAcesso) iteratorGrupo.next();
                                                Set<Funcionario> funcionarioSet = grupoAcesso.getFuncionarioSet();
                                                if (funcionarioSet != null) {
                                                    if (funcionarioSet.size() > 0) {
                                                        Iterator iterator = funcionarioSet.iterator();
                                                        while (iterator.hasNext()) {
                                                            Funcionario funcionario = (Funcionario) iterator.next();
                                %>
                                <tr onMouseOver="javascript:this.style.backgroundColor='#B0FFAE'" onMouseOut="javascript:this.style.backgroundColor=''">
                                    <td align="center">
                                        <%=grupoAcesso.getNome()%>
                                    </td>
                                    <td align="center">
                                        <%
                                            if (funcionario != null) {
                                                out.print(funcionario.getNome());
                                            }
                                            else {
                                                out.print("Nenhum");
                                            }
                                        %>
                                    </td>
                                    <td align="center">
                                        <%
                                            if (funcionario != null) {
                                                out.print(funcionario.getNomeDeUsuario());
                                            }
                                            else {
                                                out.print("Nenhum");
                                            }
                                        %>
                                    </td>
                                    <td align="center">
                                        <%
                                            if (funcionario != null) {
                                                out.print(funcionario.getCargo());
                                            }
                                            else {
                                                out.print("Nenhum");
                                            }
                                        %>
                                    </td>
                                </tr>
                                <%
                                                        } // while (iterator.hasNext())
                                                    } // if (funcionarioSet.size() > 0)
                                                    else if(controle) {
                                                        out.println("<tr><td align='center' colspan='4'><p style='font-size:medium; font-style:italic; color:red;'>Grupo de acesso vazio...</p></td></tr>");
                                                    }
                                                } // if (funcionarioSet != null)
                                            } // while (iteratorGrupo.hasNext())
                                        } // if (resultado.size() > 0)
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
