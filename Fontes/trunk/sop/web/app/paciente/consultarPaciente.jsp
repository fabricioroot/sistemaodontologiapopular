<%-- 
    Document   : consultarPaciente
    Created on : 30/01/2010, 16:45:54
    Author     : Fabricio Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="annotations.Paciente" %>
<%@page import="annotations.Funcionario" %>
<%@page import="web.login.ValidaGrupos" %>
<%@page import="java.util.List" %>
<%@page import="java.text.DecimalFormat" %>
<%@page import="java.text.DateFormat" %>
<%@page import="java.text.SimpleDateFormat" %>
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
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Secretaria")){
            aux3 = true;
        }
        if (aux1 && aux2 && aux3) {
            response.sendRedirect(request.getContextPath() + "/mensagensDeRetorno/erro.jsp?codigoMensagem=11");
        }
    }
%>

<script type="text/javascript" language="javascript">
    <%@include file="paciente.js"%>
    <%@include file="../utilitario.js"%>
</script>

<link href="<%=request.getContextPath()%>/css/estiloGeral.css" rel="stylesheet" type="text/css">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Pacientes - SOP - Sistema de Odontologia Popular</title>
    </head>
    <body onload="goFocus('nome')">
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value="Pacientes"/>
        </jsp:include>
        <br> &nbsp;
        <br> &nbsp;
        <%
            // Marca proxima pagina
            // Usado no Action correspondente
            request.getSession(false).setAttribute("proximaPagina", request.getRequestURI().replace(".jsp", ".do"));
        %>
        <form name="formPaciente" id="formPaciente" method="POST" action="<%=request.getContextPath()%>/app/paciente/actionConsultarPaciente.do">
            <table cellpadding="0" cellspacing="0" align="center" width="80%">
                <thead>
                    <tr>
                        <th colspan="2">Consulta de Pacientes</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="2">
                           &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" width="60%" align="center">Nome:
                            <input name="opcao" id="opcao" type="hidden">
                            <input name="nome" id="nome" type="text" size="35" maxlength="150" title="Nome ou parte do nome do paciente" onkeydown="return consultarComEnter(event, nome, 0)">&nbsp;
                            <input name="pesquisarNome" class="botaodefaultgra" type="button" value="pesquisar nome" title="Pesquisar nome" onclick="return confirmarBuscarTodos(nome, 0);" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra.png)'">
                        </td>
                        <td class="paddingCelulaTabela" width="40%" align="center">CPF:
                            <input name="cpf" id="cpf" type="text" size="14" maxlength="14" title="CPF do paciente" onkeypress="javascript:mascaraCpf(cpf)" onkeydown="return consultarComEnter(event, cpf, 1)" onblur="javascript:validarCpf(cpf, 'cpf')">&nbsp;
                            <input name="pesquisarCpf" class="botaodefaultgra" type="button" value="pesquisar CPF" title="Pesquisar CPF" onclick="return confirmarBuscarTodos(cpf, 1);" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra.png)'">
                            <br><font size="1" color="#FF0000">Formato: 000.000.000-00</font>
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" width="60%" align="center">Logradouro:
                            <input name="logradouro" id="logradouro" class="letrasIniciaisMaiusculas" type="text" size="25" maxlength="150" title="Logradouro ou parte do logradouro do paciente" onkeydown="return consultarComEnter(event, logradouro, 2)">&nbsp;
                            <input name="pesquisarLogradouro" class="botaodefaultextrag" type="button" value="pesquisar logradouro" title="Pesquisar logradouro" onclick="return confirmarBuscarTodos(logradouro, 2);" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-extrag-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-extrag.png)'">
                        </td>
                        <td class="paddingCelulaTabela" width="40%" align="center">C&oacute;digo:
                            <input name="codigo" id="codigo" type="text" size="8" maxlength="10" title="C&oacute;digo do paciente" onkeypress="javascript:mascaraInteiro(codigo)" onkeydown="return consultarComEnter(event, codigo, 3)" onblur="javascript:validarCampoSoNumeros(codigo, 'codigo')">&nbsp;
                            <input name="pesquisarId" class="botaodefaultgra" type="button" value="pesquisar c&oacute;digo" title="Pesquisar c&oacute;digo" onclick="return confirmarBuscarTodos(codigo, 3);" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra.png)'">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                           &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <th align="center" colspan="2"><strong>Resultado da Pesquisa</strong></th>
                    </tr>
                    <tr>
                        <td colspan="2">
                           &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                <tr>
                                    <td align="center">
                                        <strong>C&oacute;digo</strong>
                                    </td>
                                    <td align="center">
                                        <strong>Nome</strong>
                                    </td>
                                    <td align="center">
                                        <strong>CPF</strong>
                                    </td>
                                    <td align="center">
                                        <strong>Logradouro</strong>
                                    </td>
                                    <td align="center">
                                        <strong>Data de nascimento</strong>
                                    </td>
                                    <td align="center">
                                        <strong>Saldo (R$)</strong>
                                    </td>
                                    <td align="center">
                                        <strong>Impedimento</strong>
                                    </td>
                                    <td align="center">
                                        <strong>Status</strong>
                                    </td>
                                    <td align="center">
                                        <strong>Op&ccedil;&otilde;es</strong>
                                    </td>
                                </tr>
                                <%
                                    DecimalFormat decimalFormat = new DecimalFormat("0.00");
                                    DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                                    String idPaciente;
                                    boolean impedido = false;
                                    List resultado = (List)request.getAttribute("resultado");
                                    if (resultado != null) {
                                        if (resultado.size() > 0) {
                                            for (int i = 0; i < resultado.size(); i++) {
                                                impedido = false;
                                                if (!((Paciente)resultado.get(i)).getImpedimento().trim().isEmpty()) {
                                                    impedido = true;
                                                }
                                %>
                                <tr bgcolor="<%if (impedido) out.print("#ffcccc");%>" onMouseOver="javascript:this.style.backgroundColor='<% if (impedido) out.print("#ff9999"); else out.print("#B0FFAE");%>'" onMouseOut="javascript:this.style.backgroundColor=''">
                                    <td align="center">
                                        <%=((Paciente)resultado.get(i)).getId()%>
                                    </td>
                                    <td align="center">
                                        <%=((Paciente)resultado.get(i)).getNome()%>
                                    </td>
                                    <td align="center">
                                        <% if ((((Paciente)resultado.get(i)).getCpf()) != null) { out.print(((Paciente)resultado.get(i)).getCpf()); } else { out.print("Em branco"); } %>
                                    </td>
                                    <td align="center">
                                        <%=((Paciente)resultado.get(i)).getEndereco().getLogradouro()%>
                                    </td>
                                    <td align="center">
                                        <%= dateFormat.format(((Paciente)resultado.get(i)).getDataNascimento()) %>
                                    </td>
                                    <td align="center">
                                        <%
                                            if (((Paciente)resultado.get(i)).getFicha().getSaldo() >= 0) {
                                                out.print("<font color='#00CC00'><strong>" + decimalFormat.format(((Paciente)resultado.get(i)).getFicha().getSaldo()) + "</strong></font>");
                                            }
                                            else {
                                                out.print("<font color='#D42945'><strong>" + decimalFormat.format(((Paciente)resultado.get(i)).getFicha().getSaldo()) + "</strong></font>");
                                            }
                                        %>
                                    </td>
                                    <td align="center">
                                        <%  if (((Paciente) resultado.get(i)).getImpedimento().trim().isEmpty()) { out.print("Nenhum");} else { out.print("<font color='#D42945'><strong>SIM</strong></font>"); } %>
                                    </td>
                                    <td align="center">
                                        <%
                                            if (((Paciente)resultado.get(i)).getStatus() == 'A') out.print("<font color='#00CC00'><strong>Ativo</strong></font>"); else out.print("<font color='#D42945'><strong>Inativo</strong></font>");
                                        %>
                                    </td>
                                    <td align="center">
                                        <%
                                            idPaciente = (String)((Paciente)resultado.get(i)).getId().toString();
                                            pageContext.setAttribute("idPaciente", idPaciente);
                                        %>
                                        <a href="<%=request.getContextPath()%>/app/paciente/actionEditarPaciente.do?idPaciente=${idPaciente}"><img src="<%=request.getContextPath()%>/imagens/editar.png" alt="Editar" title="Editar"></a>
                                        <a href="<%=request.getContextPath()%>/app/paciente/actionVisualizarPaciente.do?idPaciente=${idPaciente}"><img src="<%=request.getContextPath()%>/imagens/visualizar.png" alt="Visualizar" title="Visualizar"/></a>
                                        <a href="<%=request.getContextPath()%>/app/paciente/odontograma/actionVisualizarOdontograma.do?idPaciente=${idPaciente}"><img src="<%=request.getContextPath()%>/imagens/dente.png" alt="Odontograma" title="Odontrograma"/></a>
                                        <%
                                            if (!((Paciente)resultado.get(i)).isFilaOrcamento() && !((Paciente)resultado.get(i)).isFilaTratamento() && ((Paciente)resultado.get(i)).getStatus() == 'A') {
                                        %>
                                        <a href="<%=request.getContextPath()%>/app/filaAtendimentoOrcamento/actionIncluirAtendimentoOrcamento.do?idPaciente=${idPaciente}"><img src="<%=request.getContextPath()%>/imagens/adicionarAmarelo.png" alt="Orcamento" title="Incluir na fila de OR&Ccedil;AMENTOS" onclick="return confirmarAcao('ORCAMENTOS')"/></a>
                                        <%
                                            }
                                            else {
                                        %>
                                        <img src="<%=request.getContextPath()%>/imagens/adicionarCinza.png" alt="Orcamento" title="Paciente INATIVO ou est&aacute; na fila de atendimento"/>
                                        <%
                                            }
                                            if (!((Paciente)resultado.get(i)).isFilaTratamento() && !((Paciente)resultado.get(i)).isFilaOrcamento() && ((Paciente)resultado.get(i)).getStatus() == 'A') {
                                        %>
                                        <a href="<%=request.getContextPath()%>/app/filaAtendimentoTratamento/actionIncluirAtendimentoTratamento.do?idPaciente=${idPaciente}"><img src="<%=request.getContextPath()%>/imagens/adicionarVerde.png" alt="Tratamento" title="Incluir na fila de TRATAMENTOS" onclick="return confirmarAcao('TRATAMENTOS')"/></a>
                                        <%
                                            }
                                            else {
                                        %>
                                        <img src="<%=request.getContextPath()%>/imagens/adicionarCinza.png" alt="Tratamento" title="Paciente INATIVO ou est&aacute; na fila de atendimento"/>
                                        <%
                                            }
                                        %>
                                    </td>
                                </tr>
                                <%
                                        } // for
                                    } // if (resultado.size() > 0)
                                        else {
                                            out.println("<tr><td align='center' colspan='9'><p style='font-size:medium; font-style:italic; color:red;'>Registro(s) n&atilde;o encontrado(s)...</p></td></tr>");
                                        }
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
