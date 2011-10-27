<%--
    Document   : cadastrarProcedimento
    Created on : 30/01/2010, 16:45:54
    Author     : Fabricio Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="annotations.Funcionario"%>
<%@page import="web.login.ValidaGrupos"%>
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
    <%@include file="procedimento.js"%>
    <%@include file="../utilitario.js"%>
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
        <form name="formProcedimento" id="formProcedimento" method="POST" onsubmit="return validarDados()" action="<%=request.getContextPath()%>/app/procedimento/actionCadastrarProcedimento.do">
            <table cellpadding="0" cellspacing="0" align="center">
                <thead>
                    <tr>
                        <th colspan="4">Cadastro de Procedimentos (<strong><font color="#FF0000">*</font></strong> campos obrigat&oacute;rios)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="paddingCelulaTabela" align="left" width="36%"><strong><font color="#FF0000">*</font></strong>Nome:
                            <input name="nome" id="nome" class="letrasIniciaisMaiusculas" type="text" size="40" maxlength="90" title="Nome do procedimento">
                        </td>
                        <td class="paddingCelulaTabela" align="left" width="18%"><strong><font color="#FF0000">*</font></strong>Valor(R$):
                            <input name="valor" id="valor" type="text" size="7" maxlength="7" title="Valor do procedimento" onkeypress="return mascaraNumeroReal(valor, 1, 7)" onblur="validarValorReal3D(valor, 'valor')">
                            <br><font size="1" color="#FF0000">Formato: 0000.00</font>
                        </td>
                        <td class="paddingCelulaTabela" align="left" width="21%"><strong><font color="#FF0000">*</font></strong>Valor M&iacute;nimo(R$):
                            <input name="valorMinimo" id="valorMinimo" type="text" size="7" maxlength="7" title="Valor m&iacute;nimo do procedimento" onkeypress="return mascaraNumeroReal(valorMinimo, 1, 7)" onblur="validarValorReal3D(valorMinimo, 'valorMinimo')">
                            <br><font size="1" color="#FF0000">Formato: 0000.00</font>
                        </td>
                        <td class="paddingCelulaTabela" align="left" width="25%"><strong><font color="#FF0000">*</font></strong>Status:
                            <input type="radio" name="status" id="status" value="A" checked/> Ativo
                            <input type="radio" name="status" id="status" value="I"/> Inativo
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" align="left" colspan="2"><strong><font color="#FF0000">*</font></strong>Tipo:
                            <input type="radio" name="tipo" id="tipo" value="PD" checked/> Parte de Dente
                            <input type="radio" name="tipo" id="tipo" value="DI"/> Dente Inteiro
                            <input type="radio" name="tipo" id="tipo" value="BC"/> Boca Completa
                        </td>
                        <td class="paddingCelulaTabela" align="left" colspan="2">
                            <strong><font color="#FF0000">*</font></strong>Descri&ccedil;&atilde;o:
                            <input name="descricao" id="descricao" class="letrasIniciaisMaiusculas" type="text" size="50" maxlength="240" title="Descri&ccedil;&atilde;o do procedimento">
                            <input name="simbolo" id="simbolo" type="hidden" size="10" maxlength="40" value="">
                        </td>
                        <!--td class="paddingCelulaTabela" align="left">S&iacute;mbolo:
                            <input name="simbolo" id="simbolo" type="text" size="10" maxlength="40">
                        </td -->
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" align="left" colspan="4">
                            <table>
                                <tr>
                                    <td class="paddingCelulaTabela" align="center">
                                        <input name="cadastrar" class="botaodefault" type="submit" value="cadastrar" title="Cadastrar" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                    </td>
                                    <td class="paddingCelulaTabela" align="center">
                                        <input name="limpar" class="botaodefault" type="reset" value="limpar" title="Limpar" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                    </td>
                                    <td class="paddingCelulaTabela" align="center">
                                        <input name="cancelar" class="botaodefault" type="button" value="cancelar" title="Cancelar" onclick="javascript:window.location.href='<%=request.getContextPath()%>/main.do';" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
    </body>
</html>
