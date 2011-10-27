<%--
    Document   : editarComprovantePagamentoCartao
    Created on : 30/01/2010, 16:45:54
    Author     : Fabricio Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="annotations.Funcionario"%>
<%@page import="annotations.ComprovantePagamentoCartao"%>
<%@page import="web.login.ValidaGrupos"%>
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
        <%
            // Captura objeto comprovantePagamentoCartao do request
            // Este objeto vem da pagina consultarComprovantePagamentoCartao.jsp quando clicado o botao editar
            // Passa pelo action correspondente (EditarComprovantePagamentoCartaoAction)
            ComprovantePagamentoCartao comprovantePagamentoCartao = (ComprovantePagamentoCartao)request.getAttribute("comprovantePagamentoCartao");
            DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            if (comprovantePagamentoCartao != null) {
                char tipo = 'S';
        %>
        <form name="formComprovantePagamentoCartao" id="formComprovantePagamentoCartao" method="POST" onsubmit="return validarDadosEdicao()" action="<%=request.getContextPath()%>/app/comprovantePagamentoCartao/actionAtualizarComprovanteCartao.do">
            <table cellpadding="0" cellspacing="0" align="center">
                <thead>
                    <tr>
                        <th colspan="3">Editar Comprovante de Pagamento com Cart&atilde;o (<strong><font color="#FF0000">*</font></strong> campos obrigat&oacute;rios)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="paddingCelulaTabela" align="left" width="40%">
                            <input name="id" id="id" value="<%= comprovantePagamentoCartao.getId() %>" type="hidden">
                            <input name="pagamentoId" id="pagamentoId" value="<%= comprovantePagamentoCartao.getPagamento().getId() %>" type="hidden">
                            <input name="dataPagamento" id="dataPagamento" value="<%= dateFormat.format(comprovantePagamentoCartao.getDataPagamento()) %>" type="hidden">
                            <input name="statusAtual" id="statusAtual" value="<%= comprovantePagamentoCartao.getStatus() %>" type="hidden">
                            <input name="nomePaciente" id="nomePaciente" value="<%= comprovantePagamentoCartao.getNomePaciente() %>" type="hidden">
                            <input name="idPaciente" id="idPaciente" value="<%= comprovantePagamentoCartao.getIdPaciente() %>" type="hidden">
                            <strong><font color="#FF0000">*</font></strong>Bandeira:
                            <select name="bandeira" id="bandeira">
                                <option value="selected" <%if (comprovantePagamentoCartao.getBandeira().trim().equals("selected")) out.print("selected");%>>Selecione</option>
                                <option value="Visa" <%if (comprovantePagamentoCartao.getBandeira().trim().equals("Visa")) out.print("selected");%>>Visa</option>
                                <option value="MasterCard" <%if (comprovantePagamentoCartao.getBandeira().trim().equals("MasterCard")) out.print("selected");%>>MasterCard</option>
                            </select>
                        </td>
                        <td class="paddingCelulaTabela" align="left" colspan="2" width="60%">
                            <table>
                                <tr>
                                    <td style="border:none" width="40%"><strong><font color="#FF0000">*</font></strong>Tipo:
                                        <input type="radio" name="tipo" id="tipo" value="C" onclick="mostrarXsumir(this.value)" <%if (comprovantePagamentoCartao.getTipo() == 'C') { out.print("checked"); tipo = 'C'; }%>/> Cr&eacute;dito
                                        <input type="radio" name="tipo" id="tipo" value="D" onclick="mostrarXsumir(this.value)" <%if (comprovantePagamentoCartao.getTipo() == 'D') out.print("checked");%>/> D&eacute;bito
                                    </td>
                                    <td style="border:none" align="left" width="60%">
                                        <div id="infoParcelas" style="display:<%if (comprovantePagamentoCartao.getTipo() == 'C') out.print("block"); else out.print("none"); %>">
                                            <strong><font color="#FF0000">*</font></strong>Parcelas:
                                            <select name="parcelas" id="parcelas">
                                                <option value="0" <%if (comprovantePagamentoCartao.getParcelas().equals(Short.parseShort("0"))) out.print("selected");%>>Selecione</option>
                                                <option value="1" <%if (comprovantePagamentoCartao.getParcelas().equals(Short.parseShort("1"))) out.print("selected");%>>1</option>
                                                <option value="2" <%if (comprovantePagamentoCartao.getParcelas().equals(Short.parseShort("2"))) out.print("selected");%>>2</option>
                                                <option value="3" <%if (comprovantePagamentoCartao.getParcelas().equals(Short.parseShort("3"))) out.print("selected");%>>3</option>
                                                <option value="4" <%if (comprovantePagamentoCartao.getParcelas().equals(Short.parseShort("4"))) out.print("selected");%>>4</option>
                                                <option value="5" <%if (comprovantePagamentoCartao.getParcelas().equals(Short.parseShort("5"))) out.print("selected");%>>5</option>
                                                <option value="6" <%if (comprovantePagamentoCartao.getParcelas().equals(Short.parseShort("6"))) out.print("selected");%>>6</option>
                                                <option value="7" <%if (comprovantePagamentoCartao.getParcelas().equals(Short.parseShort("7"))) out.print("selected");%>>7</option>
                                                <option value="8" <%if (comprovantePagamentoCartao.getParcelas().equals(Short.parseShort("8"))) out.print("selected");%>>8</option>
                                                <option value="9" <%if (comprovantePagamentoCartao.getParcelas().equals(Short.parseShort("9"))) out.print("selected");%>>9</option>
                                                <option value="10" <%if (comprovantePagamentoCartao.getParcelas().equals(Short.parseShort("10"))) out.print("selected");%>>10</option>
                                                <option value="11" <%if (comprovantePagamentoCartao.getParcelas().equals(Short.parseShort("11"))) out.print("selected");%>>11</option>
                                                <option value="12" <%if (comprovantePagamentoCartao.getParcelas().equals(Short.parseShort("12"))) out.print("selected");%>>12</option>
                                            </select>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>C&oacute;digo de Autoriza&ccedil;&atilde;o:
                            <input name="codigoAutorizacao" id="codigoAutorizacao" value="<%= comprovantePagamentoCartao.getCodigoAutorizacao()%>" type="text" size="15" maxlength="15" title="C&oacute;digo de autoriza&ccedil;&atilde;o">
                        </td>
                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Valor: R$
                            <input name="valor" id="valor" value="<%= comprovantePagamentoCartao.getValor()%>" readonly type="text" size="7" title="Valor" maxlength="7" onblur="validarValorReal3D(valor, 'valor')">
                            <br><font size="1" color="#FF0000">Formato: 0000.00</font>
                        </td>
                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Status:
                            <select name="status" id="status">
                                <option value="S" <%if (comprovantePagamentoCartao.getStatus() == 'S') out.print("selected");%>>Selecione</option>
                                <option value="C" <%if (comprovantePagamentoCartao.getStatus() == 'C') out.print("selected");%>>Cancelado / Estornado</option>
                                <option value="O" <%if (comprovantePagamentoCartao.getStatus() == 'O') out.print("selected");%>>Conferido</option>
                                <option value="N" <%if (comprovantePagamentoCartao.getStatus() == 'N') out.print("selected");%>>N&atilde;o Conferido</option>
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
                                        <input name="desfazer" class="botaodefault" type="reset" value="desfazer" title="Desfazer" onclick="javascript:mostrarXsumir(<% out.print("'" + tipo + "'"); %>)" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
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
            } // if (comprovantePagamentoCartao != null)
            else {
        %>
                <jsp:forward page="../../mensagensDeRetorno/erro.jsp?codigoMensagem=12"></jsp:forward>
        <%
                System.out.println("Falha ao exibir os dados de comprovantePagamentoCartao para editar");
            }
        %>
    </body>
</html>
