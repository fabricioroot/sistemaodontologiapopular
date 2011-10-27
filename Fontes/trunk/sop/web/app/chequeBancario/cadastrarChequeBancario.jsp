<%--
    Document   : cadastrarChequeBancario
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
    <%@include file="chequeBancario.js"%>
    <%@include file="../utilitario.js"%>
</script>

<link href="<%=request.getContextPath()%>/css/estiloGeral.css" rel="stylesheet" type="text/css">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Cheque Banc&aacute;rio - SOP - Sistema de Odontologia Popular</title>
    </head>
    <body onload="goFocus('nomeTitular')">
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value="Cheques Banc&aacute;rios"/>
        </jsp:include>
        <br> &nbsp;
        <br> &nbsp;
        <form name="formChequeBancario" id="formChequeBancario" method="POST" onsubmit="return validarDados()" action="<%=request.getContextPath()%>/app/chequeBancario/actionCadastrarChequeBancario.do">
            <table cellpadding="0" cellspacing="0" align="center">
                <thead>
                    <tr>
                        <th colspan="3">Cadastro de Cheques Banc&aacute;rios (<strong><font color="#FF0000">*</font></strong> campos obrigat&oacute;rios)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="paddingCelulaTabela" align="left" width="40%"><strong><font color="#FF0000">*</font></strong>Nome do Titular:
                            <input name="nomeTitular" id="nomeTitular" class="letrasIniciaisMaiusculas" type="text" size="40" maxlength="90" title="Nome do titular">
                        </td>
                        <td class="paddingCelulaTabela" align="left" width="27%"><strong><font color="#FF0000">*</font></strong>CPF do Titular:
                            <input name="cpfTitular" id="cpfTitular" type="text" size="14" maxlength="14" title="CPF do titular" onkeypress="mascaraCpf(cpfTitular)" onblur="validarCpf(cpfTitular, 'cpfTitular')">
                            <br><font size="1" color="#FF0000">Formato: 000.000.000-00</font>
                        </td>
                        <td class="paddingCelulaTabela" align="left" width="33%">RG do Titular:
                            <input name="rgTitular" id="rgTitular" class="letrasMaiusculas" type="text" size="15" title="RG do titular" maxlength="15" onblur="validarRg(rgTitular)">
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>N&uacute;mero do Cheque:
                            <input name="numero" id="numero" class="letrasMaiusculas" type="text" size="15" maxlength="15" title="N&uacute;mero do cheque">
                        </td>
                        <td class="paddingCelulaTabela" align="left" colspan="2">
                            <table>
                                <tr>
                                    <td style="border:none">
                                        <strong><font color="#FF0000">*</font></strong>Banco:
                                        <select name="banco" id="banco" onchange="mostrarXsumir(this.value)">
                                            <option value="" selected>Selecione</option>
                                            <option value="Banco do Brasil">Banco do Brasil</option>
                                            <option value="Banco Real">Banco Real</option>
                                            <option value="Bradesco">Bradesco</option>
                                            <option value="Caixa Economica Federal">Caixa Econ&ocirc;mica Federal </option>
                                            <option value="HSBC">HSBC</option>
                                            <option value="Itau">Ita&uacute;</option>
                                            <option value="Mercantil">Mercantil</option>
                                            <option value="Santander">Santander</option>
                                            <option value="Unibanco">Unibanco</option>
                                            <option value="selected">Outro</option>
                                        </select>
                                    </td>
                                    <td style="border:none" align="left">
                                        <div id="infoOutroBanco" style="display:none">
                                            <strong><font color="#FF0000">*</font></strong>Qual?&nbsp;
                                            <input name="outroBanco" id="outroBanco" type="text" size="20" maxlength="20">
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Valor: R$
                            <input name="valor" id="valor" type="text" size="7" maxlength="7" title="Valor do cheque" onkeypress="return mascaraNumeroReal(valor, 1, 7)" onblur="validarValorReal3D(valor, 'valor')">
                            <br><font size="1" color="#FF0000">Formato: 0000.00</font>
                        </td>
                        <%
                            String tipoFormaPagamento = "";
                            if (request.getParameter("tipoFormaPagamento") != null) {
                                tipoFormaPagamento = request.getParameter("tipoFormaPagamento");
                            }
                            String valorCampo = "";
                            if (tipoFormaPagamento.equals("A")) {
                                DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                                valorCampo = "value='" + dateFormat.format(new Date()).toString() + "' readonly";
                            }
                        %>
                        <td class="paddingCelulaTabela" align="left" colspan="2"><strong><font color="#FF0000">*</font></strong>Data para Depositar:
                            <input name="dataParaDepositar" id="dataParaDepositar" type="text" size="10" maxlength="10" title="Data para depositar" onKeyPress="mascaraData(dataParaDepositar)" onblur="validarData(dataParaDepositar, 'dataParaDepositar')" <% if (!valorCampo.isEmpty()) out.print(valorCampo); %>>
                            <br><font size="1" color="#FF0000">Formato: dd/mm/aaaa</font>
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
