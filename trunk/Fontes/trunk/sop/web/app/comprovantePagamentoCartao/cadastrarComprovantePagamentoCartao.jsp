<%--
    Document   : cadastrarComprovantePagamentoCartao
    Created on : 30/01/2010, 16:45:54
    Author     : Fabricio Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="annotations.Funcionario"%>
<%@page import="web.login.ValidaGrupos"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat" %>
<%@page import="java.text.SimpleDateFormat" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<!-- Include de pagina que controla sessao -->
<jsp:include page="/app/controleSessao.jsp"/>

<!-- Controle de acesso a pagina -->
<%  Funcionario funcionarioLogado = (Funcionario) request.getSession(false).getAttribute("funcionarioLogado");
    boolean aux1 = false;
    boolean aux2 = false;
    boolean aux3 = false;
    boolean aux4 = false;
    if(funcionarioLogado != null) {
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Administrador")){
            aux1 = true;
        }
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Administrador-TI")){
            aux2 = true;
        }
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Caixa")){
            aux3 = true;
        }
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Financeiro")){
            aux4 = true;
        }
        if (aux1 && aux2 && aux3 && aux4) {
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
    <body onload="goFocus('bandeira')">
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value="Comprovantes de Pagamentos com Cart&atilde;o"/>
        </jsp:include>
        <br> &nbsp;
        <br> &nbsp;
        <form name="formComprovantePagamentoCartao" id="formComprovantePagamentoCartao" method="POST" onsubmit="return validarDados()" action="<%=request.getContextPath()%>/app/comprovantePagamentoCartao/actionCadastrarComprovantePagamentoCartao.do">
            <table cellpadding="0" cellspacing="0" align="center">
                <thead>
                    <tr>
                        <th colspan="3">Cadastro de Comprovantes de Pagamentos com Cart&atilde;o (<strong><font color="#FF0000">*</font></strong> campos obrigat&oacute;rios)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="paddingCelulaTabela" align="left" width="40%">
                            <strong><font color="#FF0000">*</font></strong>Bandeira:
                            <select name="bandeira" id="bandeira">
                                <option value="selected" selected>Selecione</option>
                                <option value="Visa">Visa</option>
                                <option value="MasterCard">MasterCard</option>
                            </select>
                        </td>
                        <td class="paddingCelulaTabela" align="left" colspan="2" width="60%">
                            <table>
                                <tr>
                                    <%
                                        String tipoFormaPagamento = "";
                                        if (request.getParameter("tipoFormaPagamento") != null) {
                                            tipoFormaPagamento = request.getParameter("tipoFormaPagamento");
                                        }
                                        boolean aVista = false;
                                        if (tipoFormaPagamento.equals("A")) {
                                            aVista = true;
                                        }
                                    %>
                                    <td style="border:none" width="40%"><strong><font color="#FF0000">*</font></strong>Tipo:
                                        <input type="radio" name="tipo" id="tipo" value="C" onclick="mostrarXsumir(this.value)" /> Cr&eacute;dito
                                        <input type="radio" name="tipo" id="tipo" value="D" onclick="mostrarXsumir(this.value)" checked/> D&eacute;bito
                                    </td>
                                    <td style="border:none" align="left" width="60%">
                                        <div id="infoParcelas" style="display:none">
                                            <strong><font color="#FF0000">*</font></strong>Parcelas:
                                            <select name="parcelas" id="parcelas">
                                                <option value="0" selected>Selecione</option>
                                                <option value="1">1</option>
                                                <%
                                                    if (!aVista) {
                                                %>
                                                <option value="2">2</option>
                                                <option value="3">3</option>
                                                <option value="4">4</option>
                                                <option value="5">5</option>
                                                <option value="6">6</option>
                                                <option value="7">7</option>
                                                <option value="8">8</option>
                                                <option value="9">9</option>
                                                <option value="10">10</option>
                                                <option value="11">11</option>
                                                <option value="12">12</option>
                                                <%
                                                    } // if (!aVista)
                                                %>
                                            </select>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>C&oacute;digo de Autoriza&ccedil;&atilde;o:
                            <input name="codigoAutorizacao" id="codigoAutorizacao" type="text" size="15" maxlength="15" title="C&oacute;digo de autoriza&ccedil;&atilde;o">
                        </td>
                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Valor: R$
                            <input name="valor" id="valor" type="text" size="7" maxlength="7" title="Valor" onkeypress="return mascaraNumeroReal(valor, 1, 7)" onblur="validarValorReal3D(valor, 'valor')">
                            <br><font size="1" color="#FF0000">Formato: 0000.00</font>
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" align="left" colspan="3">
                            <table>
                                <tr>
                                    <td class="paddingCelulaTabela" align="center">
                                        <input name="cadastrar" class="botaodefault" type="submit" value="cadastrar" title="Cadastrar" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                    </td>
                                    <td class="paddingCelulaTabela" align="center">
                                        <input name="limpar" class="botaodefault" type="reset" value="limpar" title="Limpar" onclick="javascript:mostrarXsumir('')" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                    </td>
                                    <td class="paddingCelulaTabela" align="center">
                                        <input name="cancelar" class="botaodefault" type="button" value="cancelar" title="Cancelar" onclick="javascript:history.back(1)" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
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
