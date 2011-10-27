<%-- 
    Document   : visualizarPaciente
    Created on : 30/01/2010, 16:45:54
    Author     : Fabricio Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="annotations.Paciente"%>
<%@page import="annotations.Funcionario"%>
<%@page import="web.login.ValidaGrupos"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.DecimalFormat"%>
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
    boolean aux4 = false;
    boolean aux5 = false;
    boolean editaInsereFila = false;
    if(funcionarioLogado != null) {
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Financeiro")){
            aux5 = true;
        }
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Administrador")){
            aux1 = true;
        } else editaInsereFila = true;
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Administrador-TI")){
            aux2 = true;
        } else editaInsereFila = true;
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Secretaria")){
            aux3 = true;
        } else editaInsereFila = true;
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Caixa")){
            aux4 = true;
        } else editaInsereFila = true;
        if (aux1 && aux2 && aux3 && aux4 && aux5) {
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
        <title>Pacientes - SOP - Sistema de Odontologia Popular</title>
    </head>
    <body onload="javascript:goFocus('voltar')">
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value="Pacientes"/>
        </jsp:include>
        <br> &nbsp;
        <br> &nbsp;

        <%
            // Captura objeto paciente do request
            // Este objeto vem da pagina consultar paciente quando clicado o botao visualizar
            // passando pelo action correspondente (visualizarPacienteAction)
            Paciente paciente = (Paciente)request.getAttribute("paciente");
            if (paciente != null) {
        %>

        <table cellpadding="0" cellspacing="0" align="center">
            <thead>
                <tr>
                    <th>Visualizar Paciente</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="paddingCelulaTabela">
                        <table>
                            <thead>
                                <tr>
                                    <th colspan="3" align="center">Dados Pessoais</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="paddingCelulaTabela" align="left">
                                        <strong>Nome:</strong>&nbsp;<%=paciente.getNome()%>
                                    </td>
                                    <td class="paddingCelulaTabela" align="left">
                                        <strong>Sexo:</strong> <%if (paciente.getSexo() == 'F') { out.print("Feminino"); } else { out.print("Masculino"); }%>
                                    </td>
                                    <%
                                        DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                                    %>
                                    <td class="paddingCelulaTabela" align="left">
                                        <strong>Data de Nascimento:</strong>&nbsp;<%=dateFormat.format(paciente.getDataNascimento())%>
                                    </td>
                                </tr>
                                <%
                                    if ((paciente.getCpf() != null) || (paciente.getRg() != null) || (!paciente.getEstadoCivil().isEmpty())) {
                                %>
                                <tr>
                                    <%  if (paciente.getCpf() != null) { %>
                                    <td class="paddingCelulaTabela" align="left">
                                        <strong>CPF:</strong>&nbsp;<%=paciente.getCpf()%>
                                    </td>
                                    <%  }
                                        if (paciente.getRg() != null) {
                                    %>
                                    <td class="paddingCelulaTabela" align="left">
                                        <strong>RG:</strong>&nbsp;<%=paciente.getRg()%>
                                    </td>
                                    <%  }
                                        if (!paciente.getEstadoCivil().equals("")) {
                                    %>
                                    <td class="paddingCelulaTabela" align="left">
                                        <strong>Estado Civil:</strong>&nbsp;<%=paciente.getEstadoCivil()%>
                                    </td>
                                    <%  }
                                    %>
                                </tr>
                                <%  } // if ((paciente.getCpf() != null) || ...
                                    if ((!paciente.getNomePai().isEmpty()) || (!paciente.getNomeMae().isEmpty())) {
                                %>
                                <tr>
                                    <%  if (!paciente.getNomePai().isEmpty()) { %>
                                    <td class="paddingCelulaTabela" align="left">
                                        <strong>Nome do Pai:</strong>&nbsp;<%=paciente.getNomePai()%>
                                    </td>
                                    <%  }
                                        if (!paciente.getNomeMae().isEmpty()) {
                                    %>
                                    <td class="paddingCelulaTabela" align="left">
                                        <strong>Nome da M&atilde;e:</strong>&nbsp;<%=paciente.getNomeMae()%>
                                    </td>
                                    <%
                                        }
                                    %>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="paddingCelulaTabela" align="center">
                        <table>
                            <thead>
                                <tr><th colspan="3" align="center">Endere&ccedil;o</th></tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="paddingCelulaTabela" width="40%" align="left">
                                        <strong>Logradouro:</strong>&nbsp;<%=paciente.getEndereco().getLogradouro()%>
                                    </td>
                                    <td class="paddingCelulaTabela" width="29%" align="left">
                                        <strong>N&uacute;mero:</strong>&nbsp;<%=paciente.getEndereco().getNumero()%>
                                    </td>
                                    <td class="paddingCelulaTabela" width="31%" align="left">
                                        <strong>Bairro:</strong>&nbsp;<%=paciente.getEndereco().getBairro()%>
                                    </td>
                                </tr>
                                <tr>
                                    <%  if (!paciente.getEndereco().getComplemento().isEmpty()) { %>
                                    <td class="paddingCelulaTabela" align="left" colspan="3">
                                        <strong>Complemento:</strong>&nbsp;<%=paciente.getEndereco().getComplemento()%>
                                    </td>
                                    <% } %>
                                </tr>
                                <tr>
                                    <td class="paddingCelulaTabela" align="left">
                                        <strong>Cidade:</strong>&nbsp;<%=paciente.getEndereco().getCidade()%>
                                    </td>
                                    <td class="paddingCelulaTabela" align="left">
                                        <strong>Estado:</strong>&nbsp;<%=paciente.getEndereco().getEstado()%>
                                    </td>
                                    <%  if (!paciente.getEndereco().getCep().equals("")) { %>
                                    <td class="paddingCelulaTabela" align="left">
                                        <strong>CEP:</strong>&nbsp;<%=paciente.getEndereco().getCep()%>
                                    </td>
                                    <% } %>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <%
                    if ((!paciente.getTelefoneFixo().equals("")) || (!paciente.getTelefoneCelular().equals("")) || (!paciente.getEmail().equals(""))) {
                %>
                <tr>
                    <td class="paddingCelulaTabela" align="center">
                        <table>
                            <thead>
                                <tr><th colspan="3" align="center">Contatos</th></tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <%  if (!paciente.getTelefoneFixo().equals("")) { %>
                                    <td class="paddingCelulaTabela" align="left">
                                        <strong>Telefone Fixo:</strong>&nbsp;<%=paciente.getTelefoneFixo()%>
                                    </td>
                                    <%  }
                                        if (!paciente.getTelefoneCelular().equals("")) { %>
                                    <td class="paddingCelulaTabela" align="left">
                                        <strong>Telefone Celular:</strong>&nbsp;<%=paciente.getTelefoneCelular()%>
                                    </td>
                                    <%  }
                                        if (!paciente.getEmail().equals("")) { %>
                                    <td class="paddingCelulaTabela" align="left">
                                        <strong>Email:</strong>&nbsp;<%=paciente.getEmail()%>
                                    </td>
                                    <% } %>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <%  } // if((!paciente.getTelefoneFixo().equals("")) || ... %>
                <tr>
                    <td class="paddingCelulaTabela" align="center">
                        <table>
                            <thead>
                                <tr>
                                    <th colspan="4">Informa&ccedil;&otilde;es Adicionais</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="paddingCelulaTabela" align="left">
                                        <strong>Indica&ccedil;&atilde;o:</strong>&nbsp;<%= paciente.getIndicacao()%>
                                    </td>
                                    <td class="paddingCelulaTabela" align="left">
                                        <strong>Saldo: R$</strong>
                                    <%
                                        DecimalFormat decimalFormat = new DecimalFormat("0.00");
                                        if (paciente.getFicha().getSaldo() >= 0) {
                                            out.print("<font color='#00CC00'><strong>" + decimalFormat.format(paciente.getFicha().getSaldo()) + "</strong></font>");
                                        }
                                        else {
                                            out.print("<font color='#D42945'><strong>" + decimalFormat.format(paciente.getFicha().getSaldo()) + "</strong></font>");
                                        }
                                    %>
                                    </td>
                                    <%
                                       if(!paciente.getImpedimento().isEmpty()) {
                                    %>
                                    <td class="paddingCelulaTabela" align="left">
                                        <font color='#D42945' style="font-size:small"><strong>Impedimento:&nbsp;<%= paciente.getImpedimento()%></strong></font>
                                    </td>
                                    <% } %>
                                    <td class="paddingCelulaTabela" align="left">
                                        <strong>Status:</strong>&nbsp;<%if (paciente.getStatus() == 'A') { out.print("<font color='#00CC00'><strong>Ativo</strong></font>"); } else { out.print("<font color='#d42945'><strong>Inativo</strong></font>"); }%>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <table>
                            <tr>
                                <%
                                    String idPaciente = paciente.getId().toString();
                                    pageContext.setAttribute("idPaciente", idPaciente);
                                    if (editaInsereFila) {
                                        if (!paciente.isFilaOrcamento() && !paciente.isFilaTratamento()) {
                                %>
                                <td class="paddingCelulaTabela" align="center" style="border-bottom:none; border-left:none;">
                                    <input name="orcamento" class="botaodefaultextrag" type="button" value="enviar para or&ccedil;amento" title="Enviar para or&ccedil;amento" onclick="javascript:location.href='<%=request.getContextPath()%>/app/filaAtendimentoOrcamento/actionIncluirAtendimentoOrcamento.do?idPaciente=${idPaciente}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-extrag-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-extrag.png)'">
                                </td>
                                <%
                                            if (request.getAttribute("recemCadastrado") == null) {
                                %>
                                <td class="paddingCelulaTabela" align="center" style="border-bottom:none; border-left:none;">
                                    <input name="tratamento" class="botaodefaultextrag" type="button" value="enviar para tratamento" title="Enviar para tratamento" onclick="javascript:location.href='<%=request.getContextPath()%>/app/filaAtendimentoTratamento/actionIncluirAtendimentoTratamento.do?idPaciente=${idPaciente}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-extrag-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-extrag.png)'">
                                </td>
                                <%
                                            }  // if (request.getAttribute("recemCadastrado") != null) {
                                            else {  // incluir verificacao se paciente tem procedimento liberado ou saldo suficiente para fazer um procedimento
                                            }
                                        }  // if (!paciente.isFilaOrcamento() && !paciente.isFilaTratamento()) {
                                %>
                                <td class="paddingCelulaTabela" align="center" style="border-bottom:none; border-left:none;">
                                    <input name="editar" class="botaodefault" type="button" value="editar" title="Editar" onclick="javascript:location.href='<%=request.getContextPath()%>/app/paciente/actionEditarPaciente.do?idPaciente=${idPaciente}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                </td>
                                <%
                                    }
                                    String URLProximaPagina = (String)request.getSession(false).getAttribute("proximaPagina");
                                    String texto = "Voltar";
                                    Boolean botaoFinalizar = (Boolean)request.getAttribute("botaoFinalizar");
                                    if (botaoFinalizar != null) texto = "Finalizar";
                                %>
                                <td class="paddingCelulaTabela" align="center" style="border-right:none; border-left:none; border-bottom:none;">
                                    <input name="voltar" id="voltar" class="botaodefault" type="button" value="<%=texto.toLowerCase()%>" title="<%=texto%>" onclick="javascript:<% if (botaoFinalizar != null) out.print("location.href='" + URLProximaPagina + "'"); else out.print("history.back(1)");  %>" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
        <%
            } // if (paciente != null)
            else {
        %>
                <jsp:forward page="../../mensagensDeRetorno/erro.jsp?codigoMensagem=12"></jsp:forward>
        <%
            System.out.println("Falha ao exibir os dados de paciente em visualizar.");
            }
        %>
    </body>
</html>
