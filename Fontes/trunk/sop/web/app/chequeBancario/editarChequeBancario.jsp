<%--
    Document   : editarChequeBancario
    Created on : 30/01/2010, 16:45:54
    Author     : Fabricio Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="annotations.Funcionario"%>
<%@page import="annotations.ChequeBancario"%>
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
        <%
            // Captura objeto chequeBancario do request
            // Este objeto vem da pagina consultarChequeBancario.jsp quando clicado o botao editar
            // Passa pelo action correspondente (EditarChequeBancarioAction)
            ChequeBancario chequeBancario = (ChequeBancario)request.getAttribute("chequeBancario");
            if (chequeBancario != null) {
        %>
        <form name="formChequeBancario" id="formChequeBancario" method="POST" onsubmit="return validarDadosEdicao()" action="<%=request.getContextPath()%>/app/chequeBancario/actionAtualizarChequeBancario.do">
            <table cellpadding="0" cellspacing="0" align="center">
                <thead>
                    <tr>
                        <th colspan="3">Editar Cheque Banc&aacute;rio (<strong><font color="#FF0000">*</font></strong> campos obrigat&oacute;rios)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="paddingCelulaTabela" align="left" width="40%"><strong><font color="#FF0000">*</font></strong>Nome do Titular:
                            <input name="id" id="id" value="<%= chequeBancario.getId() %>" type="hidden">
                            <input name="pagamentoId" id="pagamentoId" value="<%= chequeBancario.getPagamento().getId() %>" type="hidden">
                            <input name="codigoStatusAtual" id="codigoStatusAtual" value="<%= chequeBancario.getStatus().getCodigo() %>" type="hidden">
                            <input name="nomePaciente" id="nomePaciente" value="<%= chequeBancario.getNomePaciente() %>" type="hidden">
                            <input name="idPaciente" id="idPaciente" value="<%= chequeBancario.getIdPaciente() %>" type="hidden">
                            <input name="nomeTitular" id="nomeTitular" value="<%= chequeBancario.getNomeTitular() %>" class="letrasIniciaisMaiusculas" type="text" size="40" maxlength="90" title="Nome do titular">
                        </td>
                        <td class="paddingCelulaTabela" align="left" width="27%"><strong><font color="#FF0000">*</font></strong>CPF do Titular:
                            <input name="cpfTitular" id="cpfTitular" value="<%= chequeBancario.getCpfTitular() %>" type="text" size="14" maxlength="14" title="CPF do titular" onkeypress="mascaraCpf(cpfTitular)" onblur="validarCpf(cpfTitular, 'cpfTitular')">
                            <br><font size="1" color="#FF0000">Formato: 000.000.000-00</font>
                        </td>
                        <td class="paddingCelulaTabela" align="left" width="33%">RG do Titular:
                            <input name="rgTitular" id="rgTitular" value="<% if (!chequeBancario.getRgTitular().trim().isEmpty()) out.print(chequeBancario.getRgTitular()); %>" class="letrasMaiusculas" type="text" size="15" maxlength="15" title="RG do titular" onblur="validarRg(rgTitular)">
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>N&uacute;mero do Cheque:
                            <input name="numero" id="numero" value="<%= chequeBancario.getNumero() %>" class="letrasMaiusculas" type="text" size="15" maxlength="15" title="N&uacute;mero do cheque">
                        </td>
                        <td class="paddingCelulaTabela" align="left" colspan="2">
                            <table>
                                <tr>
                                    <td style="border:none">
                                        <strong><font color="#FF0000">*</font></strong>Banco:
                                        <select name="banco" id="banco" onchange="mostrarXsumir(this.value)">
                                            <option value="" <%if (chequeBancario.getBanco().trim().isEmpty()) out.print("selected");%>>Selecione</option>
                                            <option value="Banco do Brasil" <%if (chequeBancario.getBanco().equals("Banco do Brasil")) out.print("selected");%>>Banco do Brasil</option>
                                            <option value="Banco Real" <%if (chequeBancario.getBanco().equals("Banco Real")) out.print("selected");%>>Banco Real</option>
                                            <option value="Bradesco" <%if (chequeBancario.getBanco().equals("Bradesco")) out.print("selected");%>>Bradesco</option>
                                            <option value="Caixa Economica Federal" <%if (chequeBancario.getBanco().equals("Caixa Economica Federal")) out.print("selected");%>>Caixa Econ&ocirc;mica Federal</option>
                                            <option value="HSBC" <%if (chequeBancario.getBanco().equals("HSBC")) out.print("selected");%>>HSBC</option>
                                            <option value="Itau" <%if (chequeBancario.getBanco().equals("Itau")) out.print("selected");%>>Ita&uacute;</option>
                                            <option value="Mercantil" <%if (chequeBancario.getBanco().equals("Mercantil")) out.print("selected");%>>Mercantil</option>
                                            <option value="Unibanco" <%if (chequeBancario.getBanco().equals("Unibanco")) out.print("selected");%>>Unibanco</option>
                                            <%  String selected = "";
                                                if ((!chequeBancario.getBanco().trim().isEmpty()) && (!chequeBancario.getBanco().equals("Banco do Brasil"))
                                                    && (!chequeBancario.getBanco().equals("Banco Real")) && (!chequeBancario.getBanco().equals("Bradesco"))
                                                    && (!chequeBancario.getBanco().equals("Caixa Economica Federal")) && (!chequeBancario.getBanco().equals("HSBC"))
                                                    && (!chequeBancario.getBanco().equals("Itau")) && (!chequeBancario.getBanco().equals("Mercantil"))
                                                    && (!chequeBancario.getBanco().equals("Unibanco"))) {
                                                        selected = "selected";
                                                }
                                            %>
                                            <option value="selected" <%=selected%>>Outro</option>
                                        </select>
                                    </td>
                                    <td style="border:none" align="left">
                                        <div id="infoOutroBanco" style="display:<%if (!selected.isEmpty()) out.print("block"); else out.print("none");%>">
                                            <strong><font color="#FF0000">*</font></strong>Qual?&nbsp;
                                            <input name="outroBanco" id="outroBanco" value="<%= chequeBancario.getBanco() %>" class="letrasIniciaisMaiusculas" type="text" size="20" maxlength="20">
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Valor(R$):
                            <input name="valor" id="valor" value="<%= chequeBancario.getValor() %>" readonly type="text" size="7" maxlength="7" title="Valor do cheque" onblur="validarValorReal3D(valor, 'valor')">
                            <br><font size="1" color="#FF0000">Formato: 0000.00</font>
                        </td>
                        <%
                            DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                        %>
                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Data para Depositar:
                            <input name="dataParaDepositar" id="dataParaDepositar" value="<%= dateFormat.format(chequeBancario.getDataParaDepositar()) %>" type="text" size="10" maxlength="10" title="Data para depositar" onKeyPress="mascaraData(dataParaDepositar)" onblur="validarData(dataParaDepositar, 'dataParaDepositar')">
                            <br><font size="1" color="#FF0000">Formato: dd/mm/aaaa</font>
                        </td>
                        <td class="paddingCelulaTabela" align="left">
                            <strong><font color="#FF0000">*</font></strong>Status:
                            <select name="codigoStatus" id="codigoStatus">
                                <option value="" <%if (chequeBancario.getStatus().toString().trim().isEmpty()) out.print("selected");%>>Selecione</option>
                                <option value="2" <%if (chequeBancario.getStatus().getCodigo().equals(Short.parseShort("2"))) out.print("selected");%>>Aguardando Confirma&ccedil;&atilde;o de Cr&eacute;dito (depositado)</option>
                                <option value="5" <%if (chequeBancario.getStatus().getCodigo().equals(Short.parseShort("5"))) out.print("selected");%>>Cancelado</option>
                                <option value="4" <%if (chequeBancario.getStatus().getCodigo().equals(Short.parseShort("4"))) out.print("selected");%>>Compensado</option>
                                <option value="3" <%if (chequeBancario.getStatus().getCodigo().equals(Short.parseShort("3"))) out.print("selected");%>>Irregular</option>
                                <option value="1" <%if (chequeBancario.getStatus().getCodigo().equals(Short.parseShort("1"))) out.print("selected");%>>N&atilde;o Depositado</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" align="left" colspan="3">
                            <table>
                                <tr>
                                    <td class="paddingCelulaTabela" align="center">
                                        <input name="salvar" class="botaodefault" type="submit" value="salvar" title="Salvar" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                    </td>
                                    <td class="paddingCelulaTabela" align="center">
                                        <input name="desfazer" class="botaodefault" type="reset" value="desfazer" title="Desfazer" onclick="javascript:mostrarXsumir(<% out.print("'" + selected + "'"); %>)" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
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
            } // if (chequeBancario != null)
            else {
        %>
                <jsp:forward page="../../mensagensDeRetorno/erro.jsp?codigoMensagem=12"></jsp:forward>
        <%
                System.out.println("Falha ao exibir os dados de cheque bancario para editar");
            }
        %>
    </body>
</html>
