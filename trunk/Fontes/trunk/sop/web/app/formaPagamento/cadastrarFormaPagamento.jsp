<%--
    Document   : cadastrarFormaPagamento
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
    <%@include file="../utilitario.js"%>
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
        <form name="formFormaPagamento" id="formFormaPagamento" method="POST" onsubmit="return validarDados()" action="<%=request.getContextPath()%>/app/formaPagamento/actionCadastrarFormaPagamento.do">
            <table cellpadding="0" cellspacing="0" align="center">
                <thead>
                    <tr>
                        <th colspan="3">Cadastro de Formas de Pagamento (<strong><font color="#FF0000">*</font></strong> campos obrigat&oacute;rios)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="paddingCelulaTabela" align="left" width="45%"><strong><font color="#FF0000">*</font></strong>Nome:
                            <input name="nome" id="nome" class="letrasMaiusculas" type="text" size="40" maxlength="90" title="Nome da forma de pagamento">
                        </td>
                        <td class="paddingCelulaTabela" align="left" width="25%"><strong><font color="#FF0000">*</font></strong>Tipo:
                            <select name="tipo" id="tipo" onchange="mostrarXsumir(this.value)">
                                <option value = "S" selected>Selecione</option>
                                <option value = "A">&Agrave; vista</option>
                                <option value = "P">A prazo</option>
                            </select>
                        </td>
                        <td class="paddingCelulaTabela" align="left" width="30%"><strong><font color="#FF0000">*</font></strong>Status:
                            <input type="radio" name="status" id="status" value="A" checked/> Ativo
                            <input type="radio" name="status" id="status" value="I"/> Inativo
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" align="left" colspan="3">
                            <strong><font color="#FF0000">*</font></strong>Descri&ccedil;&atilde;o:
                            <input name="descricao" id="descricao" class="letrasIniciaisMaiusculas" type="text" size="50" maxlength="300" title="Descri&ccedil;&atilde;o da forma de pagamento">
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" align="center" colspan="3" style="border:none">
                            <div id="detalhesFormaPagamentoAPrazo" style="display:none">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Detalhes</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="paddingCelulaTabela" align="left" width="100%"><strong><font color="#FF0000">*</font></strong>Valor m&iacute;nimo:
                                                <input name="valorMinimoAPrazo" id="valorMinimoAPrazo" type="text" size="7" maxlength="7" onkeypress="return mascaraNumeroReal(valorMinimoAPrazo, 1, 7)" onblur="validarValorReal3D(valorMinimoAPrazo, 'valorMinimoAPrazo')">
                                                <br><font size="1" color="#FF0000">Formato: 0000.00</font>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" align="center" colspan="3" style="border:none">
                            <div id="detalhesFormaPagamentoAVista" style="display:none">
                                <table>
                                    <thead>
                                        <tr>
                                            <th colspan="2">Detalhes</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Desconto(%):
                                                <!-- Trecho de codigo para quando for usar desconto no pagamento a vista -->
                                                <input value="0.0" name="desconto" id="desconto" type="text" size="5" maxlength="5" onkeypress="return mascaraNumeroReal(desconto, 1, 5)" onblur="validarValorReal3D(desconto, 'desconto')">
                                                <br><font size="1" color="#FF0000">Formato: 00.00</font>
                                            </td>
                                            <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Valor m&iacute;nimo para desconto(R$):
                                                <!-- Trecho de codigo para quando for usar desconto no pagamento a vista -->
                                                <input value="0.0" name="pisoParaDesconto" id="pisoParaDesconto" type="text" size="7" maxlength="7" onkeypress="return mascaraNumeroReal(pisoParaDesconto, 1, 7)" onblur="validarValorReal3D(pisoParaDesconto, 'pisoParaDesconto')">
                                                <br><font size="1" color="#FF0000">Formato: 0000.00</font>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" align="left" colspan="3">
                            <table>
                                <tr>
                                    <td class="paddingCelulaTabela" align="center" style="border-top: 1px solid #e5eff8;">
                                        <input name="cadastrar" class="botaodefault" type="submit" value="cadastrar" title="Cadastrar" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                    </td>
                                    <td class="paddingCelulaTabela" align="center" style="border-top: 1px solid #e5eff8;">
                                        <input name="limpar" class="botaodefault" type="reset" value="limpar" title="Limpar" onclick="javascript:mostrarXsumir('')" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                    </td>
                                    <td class="paddingCelulaTabela" align="center" style="border-top: 1px solid #e5eff8;">
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
