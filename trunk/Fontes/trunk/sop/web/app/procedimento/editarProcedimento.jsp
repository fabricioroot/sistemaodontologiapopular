<%--
    Document   : editarProcedimento
    Created on : 30/01/2010, 16:45:54
    Author     : Fabricio Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="annotations.Procedimento"%>
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
<%@ include file="procedimento.js"%>
<%@ include file="../utilitario.js"%>
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
            // Captura objeto procedimento no request
            // Este objeto vem da pagina consultar procedimento quando eh clicado o botao editar procedimento.
            // Passa pelo action correspondente (EditarProcedimentoAction)
            Procedimento procedimento = (Procedimento)request.getAttribute("procedimento");
            if (procedimento != null) {
        %>
        <form name="formProcedimento" id="formProcedimento" method="POST" onsubmit="return validarDados()" action="<%=request.getContextPath()%>/app/procedimento/actionAtualizarProcedimento.do">
            <table cellpadding="0" cellspacing="0" align="center">
                <thead>
                    <tr>
                        <th colspan="4">Editar Procedimento (<strong><font color="#FF0000">*</font></strong> campos obrigat&oacute;rios)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="paddingCelulaTabela" align="left" width="36%"><strong><font color="#FF0000">*</font></strong>Nome:
                            <input name="id" id="id" value="<%= procedimento.getId() %>" type="hidden">
                            <input name="nome" id="nome" value="<%= procedimento.getNome() %>" class="letrasIniciaisMaiusculas" type="text" size="40" maxlength="90" title="Nome do procedimento">
                        </td>
                        <td class="paddingCelulaTabela" align="left" width="18%"><strong><font color="#FF0000">*</font></strong>Valor(R$):
                            <input name="valor" id="valor" value="<%= procedimento.getValor()%>" type="text" size="7" maxlength="7" title="Valor do procedimento" onkeypress="return mascaraNumeroReal(valor, 1, 7)" onblur="validarValorReal3D(valor, 'valor')">
                            <br><font size="1" color="#FF0000">Formato: 0000.00</font>
                        </td>
                        <td class="paddingCelulaTabela" align="left" width="21%"><strong><font color="#FF0000">*</font></strong>Valor M&iacute;nimo(R$):
                            <input name="valorMinimo" id="valorMinimo" value="<%= procedimento.getValorMinimo()%>" type="text" size="7" maxlength="7" title="Valor m&iacute;nimo do procedimento" onkeypress="return mascaraNumeroReal(valorMinimo, 1, 7)" onblur="validarValorReal3D(valorMinimo, 'valorMinimo')">
                            <br><font size="1" color="#FF0000">Formato: 0000.00</font>
                        </td>
                        <td class="paddingCelulaTabela" align="left" width="25%"><strong><font color="#FF0000">*</font></strong>Status:
                            <input type="radio" name="status" id="status" value="A" <%if (procedimento.getStatus() == 'A') out.print("checked"); %>/> Ativo
                            <input type="radio" name="status" id="status" value="I" <%if (procedimento.getStatus() == 'I') out.print("checked"); %>/> Inativo
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" align="left" colspan="2"><strong><font color="#FF0000">*</font></strong>Tipo:
                            <input type="radio" name="tipo" id="tipo" value="PD" <%if (procedimento.getTipo().equals("PD")) out.print("checked"); %>/> Parte do Dente
                            <input type="radio" name="tipo" id="tipo" value="DI" <%if (procedimento.getTipo().equals("DI")) out.print("checked"); %>/> Dente Inteiro
                            <input type="radio" name="tipo" id="tipo" value="BC" <%if (procedimento.getTipo().equals("BC")) out.print("checked"); %>/> Boca Completa
                        </td>
                        <td class="paddingCelulaTabela" align="left" colspan="2">
                            <strong><font color="#FF0000">*</font></strong>Descri&ccedil;&atilde;o:
                            <input name="descricao" id="descricao" value="<%= procedimento.getDescricao() %>" class="letrasIniciaisMaiusculas" type="text" size="50" maxlength="240" title="Descri&ccedil;&atilde;o do procedimento">
                            <input name="simbolo" id="simbolo" type="hidden" size="10" maxlength="40" value="<%= procedimento.getSimbolo() %>">
                        </td>
                        <!--td class="paddingCelulaTabela" align="left">S&iacute;mbolo:
                            <input name="simbolo" id="simbolo" type="text" size="10" maxlength="40">
                        </td -->
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" align="center" colspan="4">
                            <table>
                                <tr>
                                    <td class="paddingCelulaTabela" align="center">
                                        <input name="salvar" class="botaodefault" type="submit" value="salvar" title="Salvar" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                    </td>
                                    <td class="paddingCelulaTabela" align="center">
                                        <input name="desfazer" class="botaodefault" type="reset" value="desfazer" title="Desfazer" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                    </td>
                                    <td class="paddingCelulaTabela" align="center">
                                        <input name="voltar" class="botaodefault" type="button" value="voltar" title="Voltar" onclick="javascript:history.back(1)" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        <%
            } // if (procedimento != null)
            else {
        %>
                <jsp:forward page="../../mensagensDeRetorno/erro.jsp?codigoMensagem=12"></jsp:forward>
        <%
            System.out.println("Falha ao exibir os dados de procedimento em editar.");
            }
        %>
    </body>
</html>
