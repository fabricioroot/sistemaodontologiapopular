<%--
    Document   : consultarFilaAtendimentoTratamentoEmAtendimento
    Created on : 11/03/2010, 00:36:26
    Author     : Fabricio Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="annotations.Funcionario" %>
<%@page import="annotations.AtendimentoTratamento" %>
<%@page import="web.login.ValidaGrupos" %>
<%@page import="java.util.Collection" %>
<%@page import="java.util.Iterator" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
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
    boolean administrador = false;
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
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Dentista-Tratamento")){
            aux4 = true;
        }
        if (aux1 && aux2 && aux3 && aux4) {
            response.sendRedirect(request.getContextPath() + "/mensagensDeRetorno/erro.jsp?codigoMensagem=11");
        }

        // Trecho de codigo para identificar se o funcionario pertence ao grupo 'Administrador' ou 'Administrador-TI'
        if ((ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Administrador")) || (ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Administrador-TI"))){
            administrador = true;
        }
    }
%>

<script type="text/javascript" language="javascript">
    <%@include file="filaAtendimentoTratamento.js"%>
</script>

<link href="<%=request.getContextPath()%>/css/estiloGeral.css" rel="stylesheet" type="text/css">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <!--meta http-equiv="refresh" content="7"-->
        <title>Pacientes em Atendimento de Tratamento - SOP - Sistema de Odontologia Popular</title>
    </head>
    <body>
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value="Pacientes em Atendimento de Tratamento"/>
        </jsp:include>
        <br> &nbsp;
        <br> &nbsp;
        <%
            // Marca proxima pagina
            // Usado no Action correspondente
            request.getSession(false).setAttribute("proximaPagina", request.getRequestURI().replace(".jsp", ".do"));
        %>
        <table cellpadding="0" cellspacing="0" align="center" width="80%">
            <tr>
                <th align="center"><strong>Pacientes em Atendimento de Tratamento</strong></th>
            </tr>
            <tr>
                <td>
                   &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <table width="100%" border="0" cellspacing="1" cellpadding="1">
                        <tr>
                            <td align="center">
                                <strong>C&oacute;digo do Paciente</strong>
                            </td>
                            <td align="center">
                                <strong>Nome</strong>
                            </td>
                            <td align="center">
                                <strong>Idade</strong>
                            </td>
                            <td align="center">
                                <strong>In&iacute;cio</strong>
                            </td>
                            <td align="center">
                                <strong>Dentista</strong>
                            </td>
                            <td align="center">
                                <strong>Op&ccedil;&otilde;es</strong>
                            </td>
                        </tr>
                        <%
                            Collection<AtendimentoTratamento> atendimentoTratamentoCollection = (Collection<AtendimentoTratamento>)request.getAttribute("atendimentoTratamentoCollection");
                            AtendimentoTratamento atendimentoTratamento = new AtendimentoTratamento();
                            if (!atendimentoTratamentoCollection.isEmpty()) {
                                Iterator iterator = atendimentoTratamentoCollection.iterator();
                                while (iterator.hasNext()) {
                                    atendimentoTratamento = (AtendimentoTratamento) iterator.next();
                        %>
                        <tr onMouseOver="javascript:this.style.backgroundColor='#B0FFAE'" onMouseOut="javascript:this.style.backgroundColor=''">
                            <td align="center">
                                <%= atendimentoTratamento.getFicha().getPaciente().getId() %>
                            </td>
                            <td align="center">
                                <%= atendimentoTratamento.getFicha().getPaciente().getNome() %>
                            </td>
                            <%  DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                                String dataNascimento = dateFormat.format(atendimentoTratamento.getFicha().getPaciente().getDataNascimento());
                                dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                            %>
                            <td align="center">
                                <!-- TO DO: Colocar idade ao inves da data de nascimento -->
                                <%= dataNascimento %>
                            </td>
                            <td align="center">
                                <%= dateFormat.format(atendimentoTratamento.getDataInicio()) %>
                            </td>
                            <td align="center">
                                <%= atendimentoTratamento.getDentista().getNome() %>
                            </td>
                            <td align="center">
                                <%
                                    String idPaciente = atendimentoTratamento.getFicha().getPaciente().getId().toString();
                                    pageContext.setAttribute("idPaciente", idPaciente);
                                    String idAtendimento = atendimentoTratamento.getId().toString();
                                    pageContext.setAttribute("idAtendimento", idAtendimento);
                                    if (funcionarioLogado.getId() == atendimentoTratamento.getDentista().getId() || administrador)  {
                                %>
                                <a href="<%=request.getContextPath()%>/app/filaAtendimentoTratamento/actionContinuarAtendimentoTratamento.do?idPaciente=${idPaciente}&idAtendimento=${idAtendimento}"><img src="<%=request.getContextPath()%>/imagens/ok.png" alt="Atender" title="Continuar atendimento" onclick="return confirmarAcao('continuar este atendimento')"></a>&nbsp;
                                <%
                                    }
                                %>
                                <a href="<%=request.getContextPath()%>/app/paciente/odontograma/actionVisualizarOdontograma.do?idPaciente=${idPaciente}"><img src="<%=request.getContextPath()%>/imagens/dente.png" alt="Visualizar" title="Odontrograma"/></a>
                            </td>
                        </tr>
                        <%
                                } // while (iterator.hasNext())
                            } // if (!atendimentoTratamentoSet.isEmpty())
                            else {
                                out.println("<tr><td align='center' colspan='6'><p style='font-size:medium; font-style:italic; color:red;'>Fila vazia...</p></td></tr>");
                            }
                        %>
                    </table>
                </td>
            </tr>
        </table>
    </body>
</html>
