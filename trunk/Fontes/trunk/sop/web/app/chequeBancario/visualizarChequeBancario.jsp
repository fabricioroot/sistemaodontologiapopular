<%--
    Document   : visualizarChequeBancario
    Created on : 30/01/2010, 16:45:54
    Author     : Fabricio Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="annotations.ChequeBancario"%>
<%@page import="annotations.Funcionario"%>
<%@page import="service.StatusChequeBancarioService"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
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
    // Funcao para colocar elemento em foco
    function goFocus(elementID){
        document.getElementById(elementID).focus();
    }
</script>

<link href="<%=request.getContextPath()%>/css/estiloGeral.css" rel="stylesheet" type="text/css">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Cheques Banc&aacute;rios - SOP - Sistema de Odontologia Popular</title>
    </head>
    <body onload="javascript:goFocus('voltar')">
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value="Cheques Banc&aacute;rios"/>
        </jsp:include>
        <br> &nbsp;
        <br> &nbsp;

        <%
            DecimalFormat decimalFormat = new DecimalFormat("0.00");
            DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            // Captura objeto ChequeBancario do request
            // Este objeto vem da pagina consultar cheque bancario quando clicado o botao visualizar
            // passando pelo action correspondente (visualizarChequeBancarioAction)
            ChequeBancario chequeBancario = (ChequeBancario)request.getAttribute("chequeBancario");
            if (chequeBancario != null) {
        %>

        <table cellpadding="0" cellspacing="0" align="center">
            <thead>
                <tr>
                    <th colspan="3">Visualizar Cheque Banc&aacute;rio</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="paddingCelulaTabela" align="left">
                        <strong>Nome do Titular:</strong>&nbsp;<%=chequeBancario.getNomeTitular()%>
                    </td>
                    <td class="paddingCelulaTabela" align="left">
                        <strong>CPF do Titular:</strong>&nbsp;<%=chequeBancario.getCpfTitular()%>
                    </td>
                    <td class="paddingCelulaTabela" align="left">
                        <strong>RG do Titular:</strong>&nbsp;<% if (!chequeBancario.getRgTitular().trim().isEmpty()) out.print(chequeBancario.getRgTitular()); else out.print("Em branco"); %>
                    </td>
                </tr>
                <tr>
                    <td class="paddingCelulaTabela" align="left" colspan="1">
                        <strong>N&uacute;mero:</strong>&nbsp;<%=chequeBancario.getNumero()%>
                    </td>
                    <td class="paddingCelulaTabela" align="left" colspan="2">
                        <strong>Banco:</strong>&nbsp;<%=chequeBancario.getBanco()%>
                    </td>
                </tr>
                <tr>
                    <td class="paddingCelulaTabela" align="left">
                        <strong>Valor:</strong>&nbsp;R$<%=decimalFormat.format(chequeBancario.getValor())%>
                    </td>
                    <td class="paddingCelulaTabela" align="left">
                        <strong>Data para Depositar:</strong>&nbsp;<%=dateFormat.format(chequeBancario.getDataParaDepositar())%>
                    </td>
                    <td class="paddingCelulaTabela" align="left">
                        <strong>Status:</strong>&nbsp;
                        <%
                            if(chequeBancario.getStatus().equals(StatusChequeBancarioService.getStatusChequeBancarioIrregular()))
                                out.print("<font color='#d42945'><strong>Irregular</strong></font>");
                            else
                            if(chequeBancario.getStatus().equals(StatusChequeBancarioService.getStatusChequeBancarioCancelado()))
                                out.print("<font color='#d42945'><strong>Cancelado</strong></font>");
                            else
                            if(chequeBancario.getStatus().equals(StatusChequeBancarioService.getStatusChequeBancarioCompensado()))
                                out.print("<font color='#00CC00'><strong>Compensado</strong></font>");
                            else
                                out.print(chequeBancario.getStatus().getNome());
                        %>
                    </td>
                </tr>
                <tr>
                    <td class="paddingCelulaTabela" align="left">
                        <strong>Nome do Paciente:</strong>&nbsp;<%=chequeBancario.getNomePaciente()%>
                    </td>
                    <td class="paddingCelulaTabela" align="left" colspan="2">
                        <strong>C&oacute;digo do Paciente:</strong>&nbsp;<%=chequeBancario.getIdPaciente()%>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <table>
                            <tr>
                                <%
                                    String idChequeBancario = chequeBancario.getId().toString();
                                    pageContext.setAttribute("idChequeBancario", idChequeBancario);
                                %>
                                <td class="paddingCelulaTabela" align="center" width="50%">
                                    <input name="editar" class="botaodefault" type="button" value="editar" title="Editar" onclick="javascript:location.href='<%=request.getContextPath()%>/app/chequeBancario/actionEditarChequeBancario.do?idChequeBancario=${idChequeBancario}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                </td>
                                <td class="paddingCelulaTabela" align="center" width="50%" colspan="2">
                                    <input name="voltar" id="voltar" class="botaodefault" type="button" value="voltar" title="Voltar" onclick="javascript:history.back(1)" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
        <%
            } // if (chequeBancario != null)
            else {
        %>
                <jsp:forward page="../../mensagensDeRetorno/erro.jsp?codigoMensagem=12"></jsp:forward>
        <%
                System.out.println("Falha ao exibir dados de cheque bancario em visualizar.");
            }
        %>
    </body>
</html>