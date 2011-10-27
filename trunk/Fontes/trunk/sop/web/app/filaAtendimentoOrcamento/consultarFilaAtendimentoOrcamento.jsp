<%-- 
    Document   : consultarFilaAtendimentoOrcamento
    Created on : 11/03/2010, 00:36:26
    Author     : Fabricio P. Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="annotations.Funcionario" %>
<%@page import="annotations.AtendimentoOrcamento" %>
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
    boolean dentista = false;
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
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Dentista-Orcamento")){
            aux4 = true;
        }
        if (aux1 && aux2 && aux3 && aux4) {
            response.sendRedirect(request.getContextPath() + "/mensagensDeRetorno/erro.jsp?codigoMensagem=11");
        }

        // Trecho de codigo para identificar se o funcionario pertence ao grupo 'Administrador' ou 'Administrador-TI'
        if (ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Administrador") || ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Administrador-TI")){
            administrador = true;
        }

        // Trecho de codigo para identificar se o funcionario pertence ao grupo 'Dentista-Orcamento'
        if (ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Dentista-Orcamento") || ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Dentista-Tratamento")){
            dentista = true;
        }
    }
%>

<script type="text/javascript" language="javascript">
    <%@include file="filaAtendimentoOrcamento.js"%>
</script>

<link href="<%=request.getContextPath()%>/css/estiloGeral.css" rel="stylesheet" type="text/css">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <!--meta http-equiv="refresh" content="7"-->
        <title>Fila de Espera de Or&ccedil;amentos - SOP - Sistema de Odontologia Popular</title>
    </head>
    <body>
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value="Fila de Espera de Or&ccedil;amentos"/>
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
                <th align="center"><strong>Fila de Espera de Or&ccedil;amentos</strong></th>
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
                                <!-- TO DO: Colocar a data da ultima consulta e qual foi o dentista que atendeu  -->
                                <strong>&Uacute;ltima Consulta</strong>
                            </td>
                            <td align="center">
                                <strong>Paciente desde</strong>
                            </td>
                            <td align="center">
                                <strong>Op&ccedil;&otilde;es</strong>
                            </td>
                        </tr>
                        <%  Collection<AtendimentoOrcamento> atendimentoOrcamentoCollection = (Collection<AtendimentoOrcamento>)request.getAttribute("atendimentoOrcamentoCollection");
                            AtendimentoOrcamento atendimentoOrcamento = new AtendimentoOrcamento();
                            if (administrador) {
                                if (!atendimentoOrcamentoCollection.isEmpty()) {
                                    Iterator iterator = atendimentoOrcamentoCollection.iterator();
                                    while (iterator.hasNext()) {
                                        atendimentoOrcamento = (AtendimentoOrcamento) iterator.next();
                        %>
                        <tr onMouseOver="javascript:this.style.backgroundColor='#B0FFAE'" onMouseOut="javascript:this.style.backgroundColor=''">
                            <td align="center">
                                <%= atendimentoOrcamento.getFicha().getPaciente().getId() %>
                            </td>
                            <td align="center">
                                <%= atendimentoOrcamento.getFicha().getPaciente().getNome() %>
                            </td>
                            <%
                                DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                                String dataUltimaConsultaAux = "";
                                if (atendimentoOrcamento.getFicha().getDataUltimaConsulta() == null) {
                                    dataUltimaConsultaAux = "Novo";
                                }
                                else {
                                    dataUltimaConsultaAux = dateFormat.format(atendimentoOrcamento.getFicha().getDataUltimaConsulta());
                                }
                            %>
                            <td align="center">
                                <!-- TO DO: Colocar idade ao inves da data de nascimento -->
                                <%= dateFormat.format(atendimentoOrcamento.getFicha().getPaciente().getDataNascimento()) %>
                            </td>
                            <td align="center">
                                <%= dataUltimaConsultaAux %>
                            </td>
                            <td align="center">
                                <%= dateFormat.format(atendimentoOrcamento.getFicha().getDataCriacao()) %>
                            </td>
                            <td align="center">
                                <%
                                    String idFicha = atendimentoOrcamento.getFicha().getId().toString();
                                    pageContext.setAttribute("idFicha", idFicha);
                                    String idPaciente = atendimentoOrcamento.getFicha().getPaciente().getId().toString();
                                    pageContext.setAttribute("idPaciente", idPaciente);
                                %>
                                <a href="<%=request.getContextPath()%>/app/filaAtendimentoOrcamento/actionAtenderAtendimentoOrcamento.do?idPaciente=${idPaciente}"><img src="<%=request.getContextPath()%>/imagens/ok.png" alt="Atender" title="Iniciar atendimento" onclick="return confirmarAcao('iniciar este atendimento')"></a>
                                <a href="<%=request.getContextPath()%>/app/paciente/odontograma/actionVisualizarOdontograma.do?idPaciente=${idPaciente}"><img src="<%=request.getContextPath()%>/imagens/dente.png" alt="Odontograma" title="Odontrograma"/></a>
                                <%
                                    if (!atendimentoOrcamento.isPrioridade()) {
                                %>
                                <a href="<%=request.getContextPath()%>/app/filaAtendimentoOrcamento/actionPriorizarAtendimentoOrcamento.do?idFicha=${idFicha}"><img src="<%=request.getContextPath()%>/imagens/priorizar.png" alt="Priorizar" title="Priorizar" onclick="return confirmarAcao('priorizar o atendimento deste paciente')"/></a>
                                <%
                                    }
                                    else {
                                %>
                                <img src="<%=request.getContextPath()%>/imagens/priorizarDesativado.png" alt="Priorizar" title="Atendimento priorizado"/>
                                <%
                                    }
                                %>
                                <a href="<%=request.getContextPath()%>/app/filaAtendimentoOrcamento/actionRemoverAtendimentoOrcamento.do?idPaciente=${idPaciente}"><img src="<%=request.getContextPath()%>/imagens/remover.png" alt="Remover" title="Remover da fila" onclick="return confirmarAcao('remover este paciente da fila')"/></a>
                            </td>
                        </tr>
                        <%
                                    } // while (iterator.hasNext())
                                } // if (!atendimentoOrcamentoSet.isEmpty())
                                else {
                                    out.println("<tr><td align='center' colspan='6'><p style='font-size:medium; font-style:italic; color:red;'>Fila vazia...</p></td></tr>");
                                }
                            } // if (administrador)
                            else {
                                if (!atendimentoOrcamentoCollection.isEmpty()) {
                                    Iterator iterator = atendimentoOrcamentoCollection.iterator();
                                    int i = 0;
                                    while (iterator.hasNext()) {
                                        atendimentoOrcamento = (AtendimentoOrcamento) iterator.next();
                        %>
                        <tr onMouseOver="javascript:this.style.backgroundColor='#B0FFAE'" onMouseOut="javascript:this.style.backgroundColor=''">
                            <td align="center">
                                <%= atendimentoOrcamento.getFicha().getPaciente().getId() %>
                            </td>
                            <td align="center">
                                <%= atendimentoOrcamento.getFicha().getPaciente().getNome() %>
                            </td>
                            <%
                                DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                                String dataUltimaConsultaAux = "";
                                if (atendimentoOrcamento.getFicha().getDataUltimaConsulta() == null) {
                                    dataUltimaConsultaAux = "Novo";
                                }
                                else {
                                    dataUltimaConsultaAux = dateFormat.format(atendimentoOrcamento.getFicha().getDataUltimaConsulta());
                                }
                            %>
                            <td align="center">
                                <!-- TO DO: Colocar idade ao inves da data de nascimento -->
                                <%= dateFormat.format(atendimentoOrcamento.getFicha().getPaciente().getDataNascimento()) %>
                            </td>
                            <td align="center">
                                <%= dataUltimaConsultaAux %>
                            </td>
                            <td align="center">
                                <%= dateFormat.format(atendimentoOrcamento.getFicha().getDataCriacao()) %>
                            </td>
                            <td align="center">
                                <%
                                    String idPaciente = atendimentoOrcamento.getFicha().getPaciente().getId().toString();
                                    pageContext.setAttribute("idPaciente", idPaciente);
                                    if (i == 0) {
                                        if (dentista) {
                                %>
                                <a href="<%=request.getContextPath()%>/app/filaAtendimentoOrcamento/actionAtenderAtendimentoOrcamento.do?idPaciente=${idPaciente}"><img src="<%=request.getContextPath()%>/imagens/ok.png" alt="Atender" title="Iniciar atendimento" onclick="return confirmarAcao('iniciar este atendimento')"></a>
                                <%
                                        } // if (dentista)
                                    } // if (i == 0)
                                %>
                                <a href="<%=request.getContextPath()%>/app/paciente/odontograma/actionVisualizarOdontograma.do?idPaciente=${idPaciente}"><img src="<%=request.getContextPath()%>/imagens/dente.png" alt="Odontograma" title="Odontrograma"/></a>
                                <a href="<%=request.getContextPath()%>/app/filaAtendimentoOrcamento/actionRemoverAtendimentoOrcamento.do?idPaciente=${idPaciente}"><img src="<%=request.getContextPath()%>/imagens/remover.png" alt="Remover" title="Remover da fila" onclick="return confirmarAcao('remover este paciente da fila')"/></a>
                            </td>
                        </tr>
                        <%
                                        i++;
                                    } // while (iterator.hasNext())
                                } // if (!atendimentoOrcamentoSet.isEmpty())
                                else {
                                    out.println("<tr><td align='center' colspan='6'><p style='font-size:medium; font-style:italic; color:red;'>Fila vazia...</p></td></tr>");
                                }
                            } // else
                        %>
                    </table>
                </td>
            </tr>
        </table>
    </body>
</html>
