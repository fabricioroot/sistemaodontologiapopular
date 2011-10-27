<%--
    Document   : liberarProcedimentos
    Created on : 11/03/2010, 00:36:26
    Author     : Fabricio P. Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="annotations.Funcionario" %>
<%@page import="annotations.Paciente" %>
<%@page import="annotations.Dente" %>
<%@page import="annotations.HistoricoDente" %>
<%@page import="annotations.HistoricoBoca" %>
<%@page import="annotations.Pagamento" %>
<%@page import="service.PagamentoService" %>
<%@page import="java.util.Iterator" %>
<%@page import="java.util.Collection" %>
<%@page import="java.util.Set" %>
<%@page import="java.util.HashSet" %>
<%@page import="java.text.DateFormat" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.text.DecimalFormat" %>
<%@page import="web.login.ValidaGrupos" %>
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
    // Funcao para colocar elemento em foco
    function goFocus(elementID){
        document.getElementById(elementID).focus();
    }
</script>

<link href="<%=request.getContextPath()%>/css/estiloOdontograma.css" rel="stylesheet" type="text/css">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Odontograma - SOP - Sistema de Odontologia Popular</title>
    </head>
    <body onload="javascript:goFocus('voltar')">
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value="Odontograma (libera&ccedil;&atilde;o de procedimentos)"/>
        </jsp:include>
        <br> &nbsp;
        <br> &nbsp;

        <%
            // Captura objeto paciente do request
            // Este objeto vem da seguinte pagina: consultarPacienteParaLiberarProcedimentos quando clicado o botao liberarProcedimentos
            // Passa pelo action VisualizarOdontrogramaAction
            Paciente paciente = (Paciente)request.getAttribute("paciente");
            if (paciente != null) {
                Dente dente18 = (Dente)request.getAttribute("dente18");
                Dente dente17 = (Dente)request.getAttribute("dente17");
                Dente dente16 = (Dente)request.getAttribute("dente16");
                Dente dente15 = (Dente)request.getAttribute("dente15");
                Dente dente14 = (Dente)request.getAttribute("dente14");
                Dente dente13 = (Dente)request.getAttribute("dente13");
                Dente dente12 = (Dente)request.getAttribute("dente12");
                Dente dente11 = (Dente)request.getAttribute("dente11");
                Dente dente21 = (Dente)request.getAttribute("dente21");
                Dente dente22 = (Dente)request.getAttribute("dente22");
                Dente dente23 = (Dente)request.getAttribute("dente23");
                Dente dente24 = (Dente)request.getAttribute("dente24");
                Dente dente25 = (Dente)request.getAttribute("dente25");
                Dente dente26 = (Dente)request.getAttribute("dente26");
                Dente dente27 = (Dente)request.getAttribute("dente27");
                Dente dente28 = (Dente)request.getAttribute("dente28");
                Dente dente31 = (Dente)request.getAttribute("dente31");
                Dente dente32 = (Dente)request.getAttribute("dente32");
                Dente dente33 = (Dente)request.getAttribute("dente33");
                Dente dente34 = (Dente)request.getAttribute("dente34");
                Dente dente35 = (Dente)request.getAttribute("dente35");
                Dente dente36 = (Dente)request.getAttribute("dente36");
                Dente dente37 = (Dente)request.getAttribute("dente37");
                Dente dente38 = (Dente)request.getAttribute("dente38");
                Dente dente48 = (Dente)request.getAttribute("dente48");
                Dente dente47 = (Dente)request.getAttribute("dente47");
                Dente dente46 = (Dente)request.getAttribute("dente46");
                Dente dente45 = (Dente)request.getAttribute("dente45");
                Dente dente44 = (Dente)request.getAttribute("dente44");
                Dente dente43 = (Dente)request.getAttribute("dente43");
                Dente dente42 = (Dente)request.getAttribute("dente42");
                Dente dente41 = (Dente)request.getAttribute("dente41");
        %>

        <table cellpadding="1" cellspacing="1" align="center" width="100%">
            <tr> <!-- TO DO - colocar idade do paciente  -->
                <th align="center" colspan="4">
                    <font style="color:black; font-size:medium;"><strong><u>Paciente:</u> <% out.print(paciente.getNome()); %></strong></font>
                </th>
            </tr>
            <tr>
                <td colspan="4">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="4"><strong><u>Legenda</u></strong></td>
            </tr>
            <tr>
                <td bgcolor="#FFDD00" align="center"><strong>Or&ccedil;ado</strong></td>
                <td bgcolor="#87FF00" align="center"><strong>Liberado para tratamento (pago)</strong></td>
                <td bgcolor="#00FFFF" align="center"><strong>Em tratamento</strong></td>
                <td bgcolor="#CDC8B1" align="center"><strong>Procedimento finalizado</strong></td>
            </tr>
            <tr>
                <td colspan="4">
                    &nbsp;
                </td>
            </tr>
            <%
                // Coloca o id do paciente no contexto da pagina para passar para action que ira exibir historicoBoca
                pageContext.setAttribute("idPaciente", paciente.getId());
                // Coloca o id da boca no contexto da pagina para passar para action que ira exibir historicoBoca
                pageContext.setAttribute("idBoca", paciente.getBoca().getId());
            %>
            <tr>
                <td colspan="4">
                    <input name="historicoBoca" class="botaodefaultgra" type="button" value="+ Boca Completa" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoBocaParaLiberarProcedimentos.do?idPaciente=${idPaciente}&idBoca=${idBoca}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra.png)'">
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <table width="100%" border="0" cellspacing="1" cellpadding="1">
                        <!-- Arco Superior Direito -->
                        <tr>
                            <td colspan="3">
                                &nbsp;
                            </td>
                            <td align="center" bgcolor="#66CCFF" colspan="2">
                                <strong>Arco Superior - Direito</strong>
                            </td>
                            <td colspan="3">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <%
                                String fundoFaceDistal = "";
                                String fundoFaceMesial = "";
                                String fundoFaceIncisal = "";
                                String fundoFaceBucal = "";
                                String fundoFaceLingual = "";
                                String fundoRaiz = "";
                                if (dente18 != null) {
                                    // Face Distal
                                    switch (dente18.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente18.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente18.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente18.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente18.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente18.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
                                    // Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente18", dente18.getId());
                                }
                            %>
                            <!-- Dente 18 - Terceiro Molar -->
                            <td align="center">
                                <%
                                    if (dente18 != null) {
                                %>
                                <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente18}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
                                    }
                                %>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Terceiro Molar"><input type="checkbox" name="dente18Raiz" id="dente18Raiz" title="Raiz - Terceiro Molar" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Terceiro Molar"><input type="checkbox" name="dente18Bucal" id="dente18Bucal" title="Face Bucal - Terceiro Molar" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Terceiro Molar"><input type="checkbox" name="dente18Distal" id="dente18Distal" title="Face Distal - Terceiro Molar" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Terceiro Molar"><input type="checkbox" name="dente18Incisal" id="dente18Incisal" title="Face Incisal - Terceiro Molar" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Terceiro Molar"><input type="checkbox" name="dente18Mesial" id="dente18Mesial" title="Face Mesial - Terceiro Molar" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Terceiro Molar"><input type="checkbox" name="dente18Lingual" id="dente18Lingual" title="Face Lingual - Terceiro Molar" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente17 != null) {
                                    // Face Distal
                                    switch (dente17.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente17.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente17.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente17.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente17.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente17.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
                                    // Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente17", dente17.getId());
                                }
                            %>
                            <!-- Dente 17 - Segundo Molar -->
                            <td align="center">
                                <%
                                    if (dente17 != null) {
                                %>
                                <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente17}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
                                    }
                                %>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Segundo Molar"><input type="checkbox" name="dente17Raiz" id="dente17Raiz" title="Raiz - Segundo Molar" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Segundo Molar"><input type="checkbox" name="dente17Bucal" id="dente17Bucal" title="Face Bucal - Segundo Molar" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Segundo Molar"><input type="checkbox" name="dente17Distal" id="dente17Distal" title="Face Distal - Segundo Molar" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Segundo Molar"><input type="checkbox" name="dente17Incisal" id="dente17Incisal" title="Face Incisal - Segundo Molar" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Segundo Molar"><input type="checkbox" name="dente17Mesial" id="dente17Mesial" title="Face Mesial - Segundo Molar" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Segundo Molar"><input type="checkbox" name="dente17Lingual" id="dente17Lingual" title="Face Lingual - Segundo Molar" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente16 != null) {
                                    // Face Distal
                                    switch (dente16.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente16.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente16.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente16.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente16.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente16.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
                                    // Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente16", dente16.getId());
                                }
                            %>
                            <!-- Dente 16 - Primeiro Molar -->
                            <td align="center">
                                <%
                                    if (dente16 != null) {
                                %>
                                <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente16}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
                                        }
                                %>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Primeiro Molar"><input type="checkbox" name="dente16Raiz" id="dente16Raiz" title="Raiz - Primeiro Molar" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Primeiro Molar"><input type="checkbox" name="dente16Bucal" id="dente16Bucal" title="Face Bucal - Primeiro Molar" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Primeiro Molar"><input type="checkbox" name="dente16Distal" id="dente16Distal" title="Face Distal - Primeiro Molar" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Primeiro Molar"><input type="checkbox" name="dente16Incisal" id="dente16Incisal" title="Face Incisal - Primeiro Molar" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Primeiro Molar"><input type="checkbox" name="dente16Mesial" id="dente16Mesial" title="Face Mesial - Primeiro Molar" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Primeiro Molar"><input type="checkbox" name="dente16Lingual" id="dente16Lingual" title="Face Lingual - Primeiro Molar" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente15 != null) {
                                    // Face Distal
                                    switch (dente15.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente15.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente15.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente15.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente15.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente15.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
                                    // Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente15", dente15.getId());
                                }
                            %>
                            <!-- Dente 15 - Segundo Pre-Molar -->
                            <td align="center">
                                <%
                                    if (dente15 != null) {
                                %>
                                <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente15}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
                                    }
                                %>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Segundo Pr&eacute;-Molar"><input type="checkbox" name="dente15Raiz" id="dente15Raiz" title="Raiz - Segundo Pr&eacute;-Molar" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Segundo Pr&eacute;-Molar"><input type="checkbox" name="dente15Bucal" id="dente15Bucal" title="Face Bucal - Segundo Pr&eacute;-Molar" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Segundo Pr&eacute;-Molar"><input type="checkbox" name="dente15Distal" id="dente15Distal" title="Face Distal - Segundo Pr&eacute;-Molar" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Segundo Pr&eacute;-Molar"><input type="checkbox" name="dente15Incisal" id="dente15Incisal" title="Face Incisal - Segundo Pr&eacute;-Molar" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Segundo Pr&eacute;-Molar"><input type="checkbox" name="dente15Mesial" id="dente15Mesial" title="Face Mesial - Segundo Pr&eacute;-Molar" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Segundo Pr&eacute;-Molar"><input type="checkbox" name="dente15Lingual" id="dente15Lingual" title="Face Lingual - Segundo Pr&eacute;-Molar" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente14 != null) {
                                    // Face Distal
                                    switch (dente14.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente14.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente14.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente14.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente14.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente14.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
                                    // Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente14", dente14.getId());
                                }
                            %>
                            <!-- Dente 14 - Primeiro Pre-Molar -->
                            <td align="center">
                                <%
                                    if (dente14 != null) {
                                %>
                                <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente14}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
                                    }
                                %>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Primeiro Pr&eacute;-Molar"><input type="checkbox" name="dente14Raiz" id="dente14Raiz" title="Raiz - Primeiro Pr&eacute;-Molar" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Primeiro Pr&eacute;-Molar"><input type="checkbox" name="dente14Bucal" id="dente14Bucal" title="Face Bucal - Primeiro Pr&eacute;-Molar" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Primeiro Pr&eacute;-Molar"><input type="checkbox" name="dente14Distal" id="dente14Distal" title="Face Distal - Primeiro Pr&eacute;-Molar" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Primeiro Pr&eacute;-Molar"><input type="checkbox" name="dente14Incisal" id="dente14Incisal" title="Face Incisal - Primeiro Pr&eacute;-Molar" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Primeiro Pr&eacute;-Molar"><input type="checkbox" name="dente14Mesial" id="dente14Mesial" title="Face Mesial - Primeiro Pr&eacute;-Molar" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Primeiro Pr&eacute;-Molar"><input type="checkbox" name="dente14Lingual" id="dente14Lingual" title="Face Lingual - Primeiro Pr&eacute;-Molar" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente13 != null) {
                                    // Face Distal
                                    switch (dente13.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente13.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente13.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente13.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente13.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente13.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
                                    // Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente13", dente13.getId());
                                }
                            %>
                            <!-- Dente 13 - Canino -->
                            <td align="center">
                                <%
                                    if (dente13 != null) {
                                %>
                                <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente13}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
                                    }
                                %>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Canino"><input type="checkbox" name="dente13Raiz" id="dente13Raiz" title="Raiz - Canino" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Canino"><input type="checkbox" name="dente13Bucal" id="dente13Bucal" title="Face Bucal - Canino" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Canino"><input type="checkbox" name="dente13Distal" id="dente13Distal" title="Face Distal - Canino" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Canino"><input type="checkbox" name="dente13Incisal" id="dente13Incisal" title="Face Incisal - Canino" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Canino"><input type="checkbox" name="dente13Mesial" id="dente13Mesial" title="Face Mesial - Canino" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Canino"><input type="checkbox" name="dente13Lingual" id="dente13Lingual" title="Face Lingual - Canino" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente12 != null) {
                                    // Face Distal
                                    switch (dente12.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente12.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente12.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente12.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente12.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente12.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
                                    // Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente12", dente12.getId());
                                }
                            %>
                            <!-- Dente 12 - Incisivo Lateral -->
                            <td align="center">
                                <%
									if (dente12 != null) {
                                %>
                                    <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente12}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
									}
								%>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Incisivo Lateral"><input type="checkbox" name="dente12Raiz" id="dente12Raiz" title="Raiz - Incisivo Lateral" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Incisivo Lateral"><input type="checkbox" name="dente12Bucal" id="dente12Bucal" title="Face Bucal - Incisivo Lateral" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Incisivo Lateral"><input type="checkbox" name="dente12Distal" id="dente12Distal" title="Face Distal - Incisivo Lateral" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Incisivo Lateral"><input type="checkbox" name="dente12Incisal" id="dente12Incisal" title="Face Incisal - Incisivo Lateral" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Incisivo Lateral"><input type="checkbox" name="dente12Mesial" id="dente12Mesial" title="Face Mesial - Incisivo Lateral" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Incisivo Lateral"><input type="checkbox" name="dente12Lingual" id="dente12Lingual" title="Face Lingual - Incisivo Lateral" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente11 != null) {
                                    // Face Distal
                                    switch (dente11.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente11.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente11.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente11.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente11.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente11.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
                                    // Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente11", dente11.getId());
                                }
                            %>
                            <!-- Dente 11 - Incisivo Central -->
                            <td align="center">
                                <%
									if (dente11 != null) {
                                %>
                                    <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente11}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
									}
								%>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Incisivo Central"><input type="checkbox" name="dente11Raiz" id="dente11Raiz" title="Raiz - Incisivo Central" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Incisivo Central"><input type="checkbox" name="dente11Bucal" id="dente11Bucal" title="Face Bucal - Incisivo Central" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Incisivo Central"><input type="checkbox" name="dente11Distal" id="dente11Distal" title="Face Distal - Incisivo Central" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Incisivo Central"><input type="checkbox" name="dente11Incisal" id="dente11Incisal" title="Face Incisal - Incisivo Central" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Incisivo Central"><input type="checkbox" name="dente11Mesial" id="dente11Mesial" title="Face Mesial - Incisivo Central" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Incisivo Central"><input type="checkbox" name="dente11Lingual" id="dente11Lingual" title="Face Lingual - Incisivo Central" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" bgcolor="#e7e6e6"><strong>18 - 3&ordm; Molar</strong></td>
                            <td align="center" bgcolor="#e7e6e6"><strong>17 - 2&ordm; Molar</strong></td>
                            <td align="center" bgcolor="#e7e6e6"><strong>16 - 1&ordm; Molar</strong></td>
                            <td align="center" bgcolor="#e7e6e6"><strong>15 - 2&ordm; Pr&eacute;-Molar</strong></td>
                            <td align="center" bgcolor="#e7e6e6"><strong>14 - 1&ordm; Pr&eacute;-Molar</strong></td>
                            <td align="center" bgcolor="#e7e6e6"><strong>13 - Canino</strong></td>
                            <td align="center" bgcolor="#e7e6e6"><strong>12 - Incisivo Lateral</strong></td>
                            <td align="center" bgcolor="#e7e6e6"><strong>11 - Incisivo Central</strong></td>
                        </tr>
                        <!-- Fim do Arco Superior Direito -->
                        <tr>
                            <td colspan="8">
                                &nbsp;
                            </td>
                        </tr>
                        <!-- Arco Superior Esquerdo -->
                        <tr>
                            <td colspan="3">
                                &nbsp;
                            </td>
                            <td align="center" bgcolor="#66CCFF" colspan="2">
                                <strong>Arco Superior - Esquerdo</strong>
                            </td>
                            <td colspan="3">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente21 != null) {
                                    // Face Distal
                                    switch (dente21.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente21.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente21.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente21.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente21.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente21.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
                                    // Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente21", dente21.getId());
                                }
                            %>
                            <!-- Dente 21 - Incisivo Central -->
                            <td align="center">
                                <%
									if (dente21 != null) {
                                %>
                                    <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente21}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
									}
								%>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Incisivo Central"><input type="checkbox" name="dente21Raiz" id="dent21Raiz" title="Raiz - Incisivo Central" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Incisivo Central"><input type="checkbox" name="dente21Bucal" id="dente21Bucal" title="Face Bucal - Incisivo Central" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Incisivo Central"><input type="checkbox" name="dente21Mesial" id="dente21Mesial" title="Face Mesial - Incisivo Central" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Incisivo Central"><input type="checkbox" name="dente21Incisal" id="dente21Incisal" title="Face Incisal - Incisivo Central" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Incisivo Central"><input type="checkbox" name="dente21Distal" id="dente21Distal" title="Face Distal - Incisivo Central" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Incisivo Central"><input type="checkbox" name="dente21Lingual" id="dente21Lingual" title="Face Lingual - Incisivo Central" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente22 != null) {
                                    // Face Distal
                                    switch (dente22.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente22.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente22.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente22.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente22.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente22.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
                                    // Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente22", dente22.getId());
                                }
                            %>
                            <!-- Dente 22 - Incisivo Lateral -->
                            <td align="center">
                                <%
									if (dente22 != null) {
                                %>
                                    <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente22}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
									}
								%>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Incisivo Lateral"><input type="checkbox" name="dente22Raiz" id="dent22Raiz" title="Raiz - Incisivo Lateral" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Incisivo Lateral"><input type="checkbox" name="dente22Bucal" id="dente22Bucal" title="Face Bucal - Incisivo Lateral" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Incisivo Lateral"><input type="checkbox" name="dente22Mesial" id="dente22Mesial" title="Face Mesial - Incisivo Lateral" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Incisivo Lateral"><input type="checkbox" name="dente22Incisal" id="dente22Incisal" title="Face Incisal - Incisivo Lateral" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Incisivo Lateral"><input type="checkbox" name="dente22Distal" id="dente22Distal" title="Face Distal - Incisivo Lateral" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Incisivo Lateral"><input type="checkbox" name="dente22Lingual" id="dente22Lingual" title="Face Lingual - Incisivo Lateral" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente23 != null) {
                                    // Face Distal
                                    switch (dente23.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente23.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente23.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente23.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente23.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente23.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
                                    // Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente23", dente23.getId());
                                }
                            %>
                            <!-- Dente 23 - Canino -->
                            <td align="center">
                                <%
									if (dente23 != null) {
                                %>
                                    <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente23}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
									}
								%>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Canino"><input type="checkbox" name="dente23Raiz" id="dent23Raiz" title="Raiz - Canino" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Canino"><input type="checkbox" name="dente23Bucal" id="dente23Bucal" title="Face Bucal - Canino" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Canino"><input type="checkbox" name="dente23Mesial" id="dente23Mesial" title="Face Mesial - Canino" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Canino"><input type="checkbox" name="dente23Incisal" id="dente23Incisal" title="Face Incisal - Canino" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Canino"><input type="checkbox" name="dente23Distal" id="dente23Distal" title="Face Distal - Canino" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Canino"><input type="checkbox" name="dente23Lingual" id="dente23Lingual" title="Face Lingual - Canino" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente24 != null) {
                                    // Face Distal
                                    switch (dente24.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente24.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente24.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente24.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente24.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente24.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
                                    // Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente24", dente24.getId());
                                }
                            %>
                            <!-- Dente 24 - Primeiro Pre-Molar -->
                            <td align="center">
                                <%
									if (dente24 != null) {
                                %>
                                    <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente24}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
									}
								%>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Primeiro Pr&eacute;-Molar"><input type="checkbox" name="dente24Raiz" id="dent24Raiz" title="Raiz - Primeiro Pr&eacute;-Molar" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Primeiro Pr&eacute;-Molar"><input type="checkbox" name="dente24Bucal" id="dente24Bucal" title="Face Bucal - Primeiro Pr&eacute;-Molar" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Primeiro Pr&eacute;-Molar"><input type="checkbox" name="dente24Mesial" id="dente24Mesial" title="Face Mesial - Primeiro Pr&eacute;-Molar" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Primeiro Pr&eacute;-Molar"><input type="checkbox" name="dente24Incisal" id="dente24Incisal" title="Face Incisal - Primeiro Pr&eacute;-Molar" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Primeiro Pr&eacute;-Molar"><input type="checkbox" name="dente24Distal" id="dente24Distal" title="Face Distal - Primeiro Pr&eacute;-Molar" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Primeiro Pr&eacute;-Molar"><input type="checkbox" name="dente24Lingual" id="dente24Lingual" title="Face Lingual - Primeiro Pr&eacute;-Molar" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente25 != null) {
                                    // Face Distal
                                    switch (dente25.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente25.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente25.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente25.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente25.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente25.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
                                    // Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente25", dente25.getId());
                                }
                            %>
                            <!-- Dente 25 - Segundo Pre-Molar -->
                            <td align="center">
                                <%
									if (dente25 != null) {
                                %>
                                <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente25}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
									}
								%>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Segundo Pr&eacute;-Molar"><input type="checkbox" name="dente25Raiz" id="dent25Raiz" title="Raiz - Segundo Pr&eacute;-Molar" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
									<tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Segundo Pr&eacute;-Molar"><input type="checkbox" name="dente25Bucal" id="dente25Bucal" title="Face Bucal - Segundo Pr&eacute;-Molar" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Segundo Pr&eacute;-Molar"><input type="checkbox" name="dente25Mesial" id="dente25Mesial" title="Face Mesial - Segundo Pr&eacute;-Molar" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Segundo Pr&eacute;-Molar"><input type="checkbox" name="dente25Incisal" id="dente25Incisal" title="Face Incisal - Segundo Pr&eacute;-Molar" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Segundo Pr&eacute;-Molar"><input type="checkbox" name="dente25Distal" id="dente25Distal" title="Face Distal - Segundo Pr&eacute;-Molar" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Segundo Pr&eacute;-Molar"><input type="checkbox" name="dente25Lingual" id="dente25Lingual" title="Face Lingual - Segundo Pr&eacute;-Molar" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente26 != null) {
                                    // Face Distal
                                    switch (dente26.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente26.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente26.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente26.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente26.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente26.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
                                    // Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente26", dente26.getId());
                                }
                            %>
                            <!-- Dente 26 - Primeiro Molar -->
                            <td align="center">
                                <%
									if (dente26 != null) {
                                %>
                                <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente26}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
									}
								%>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Primeiro Molar"><input type="checkbox" name="dente26Raiz" id="dent26Raiz" title="Raiz - Primeiro Molar" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
									<tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Primeiro Molar"><input type="checkbox" name="dente26Bucal" id="dente26Bucal" title="Face Bucal - Primeiro Molar" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Primeiro Molar"><input type="checkbox" name="dente26Mesial" id="dente26Mesial" title="Face Mesial - Primeiro Molar" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Primeiro Molar"><input type="checkbox" name="dente26Incisal" id="dente26Incisal" title="Face Incisal - Primeiro Molar" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Primeiro Molar"><input type="checkbox" name="dente26Distal" id="dente26Distal" title="Face Distal - Primeiro Molar" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Primeiro Molar"><input type="checkbox" name="dente26Lingual" id="dente26Lingual" title="Face Lingual - Primeiro Molar" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente27 != null) {
                                    // Face Distal
                                    switch (dente27.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente27.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente27.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente27.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente27.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente27.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
                                    // Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente27", dente27.getId());
                                }
                            %>
                            <!-- Dente 27 - Segundo Molar -->
                            <td align="center">
                                <%
									if (dente27 != null) {
                                %>
                                <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente27}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
									}
								%>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Segundo Molar"><input type="checkbox" name="dente27Raiz" id="dent27Raiz" title="Raiz - Segundo Molar" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
									<tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Segundo Molar"><input type="checkbox" name="dente27Bucal" id="dente27Bucal" title="Face Bucal - Segundo Molar" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Segundo Molar"><input type="checkbox" name="dente27Mesial" id="dente27Mesial" title="Face Mesial - Segundo Molar" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Segundo Molar"><input type="checkbox" name="dente27Incisal" id="dente27Incisal" title="Face Incisal - Segundo Molar" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Segundo Molar"><input type="checkbox" name="dente27Distal" id="dente27Distal" title="Face Distal - Segundo Molar" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Segundo Molar"><input type="checkbox" name="dente27Lingual" id="dente27Lingual" title="Face Lingual - Segundo Molar" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente28 != null) {
                                    // Face Distal
                                    switch (dente28.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente28.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente28.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente28.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente28.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente28.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
                                    // Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente28", dente28.getId());
                                }
                            %>
                            <!-- Dente 28 - Terceiro Molar -->
                            <td align="center">
                                <%
									if (dente28 != null) {
                                %>
                                <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente28}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
									}
								%>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Terceiro Molar"><input type="checkbox" name="dente28Raiz" id="dent28Raiz" title="Raiz - Terceiro Molar" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
									<tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Terceiro Molar"><input type="checkbox" name="dente28Bucal" id="dente28Bucal" title="Face Bucal - Terceiro Molar" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Terceiro Molar"><input type="checkbox" name="dente28Mesial" id="dente28Mesial" title="Face Mesial - Terceiro Molar" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Terceiro Molar"><input type="checkbox" name="dente28Incisal" id="dente28Incisal" title="Face Incisal - Terceiro Molar" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Terceiro Molar"><input type="checkbox" name="dente28Distal" id="dente28Distal" title="Face Distal - Terceiro Molar" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Terceiro Molar"><input type="checkbox" name="dente28Lingual" id="dente28Lingual" title="Face Lingual - Terceiro Molar" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" bgcolor="#e7e6e6"><strong>21 - Incisivo Central</strong></td>
                            <td align="center" bgcolor="#e7e6e6"><strong>22 - Incisivo Lateral</strong></td>
                            <td align="center" bgcolor="#e7e6e6"><strong>23 - Canino</strong></td>
                            <td align="center" bgcolor="#e7e6e6"><strong>24 - 1&ordm; Pr&eacute;-Molar</strong></td>
                            <td align="center" bgcolor="#e7e6e6"><strong>25 - 2&ordm; Pr&eacute;-Molar</strong></td>
                            <td align="center" bgcolor="#e7e6e6"><strong>26 - 1&ordm; Molar</strong></td>
                            <td align="center" bgcolor="#e7e6e6"><strong>27 - 2&ordm; Molar</strong></td>
                            <td align="center" bgcolor="#e7e6e6"><strong>28 - 3&ordm; Molar</strong></td>
                        </tr>
                        <!-- Fim do Arco Superior Esquerdo -->
                        <tr>
                            <td colspan="8">
                                &nbsp;
                            </td>
                        </tr>
                        <!-- Arco Inferior Esquerdo -->
                        <tr>
                            <td colspan="3">
                                &nbsp;
                            </td>
                            <td align="center" bgcolor="#66CCFF" colspan="2">
                                <strong>Arco Inferior - Esquerdo</strong>
                            </td>
                            <td colspan="3">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente31 != null) {
                                    // Face Distal
                                    switch (dente31.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente31.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente31.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente31.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente31.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente31.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
									// Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente31", dente31.getId());
                                }
                            %>
                            <!-- Dente 31 - Incisivo Central -->
                            <td align="center">
                                <%
									if (dente31 != null) {
                                %>
                                <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente31}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
									}
								%>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Incisivo Central"><input type="checkbox" name="dente31Lingual" id="dente31Lingual" title="Face Lingual - Incisivo Central" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Incisivo Central"><input type="checkbox" name="dente31Mesial" id="dente31Mesial" title="Face Mesial - Incisivo Central" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Incisivo Central"><input type="checkbox" name="dente31Incisal" id="dente31Incisal" title="Face Incisal - Incisivo Central" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Incisivo Central"><input type="checkbox" name="dente31Distal" id="dente31Distal" title="Face Distal - Incisivo Central" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Incisivo Central"><input type="checkbox" name="dente31Bucal" id="dente31Bucal" title="Face Bucal - Incisivo Central" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
									<tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Incisivo Central"><input type="checkbox" name="dente31Raiz" id="dent31Raiz" title="Raiz - Incisivo Central" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente32 != null) {
                                    // Face Distal
                                    switch (dente32.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente32.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente32.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente32.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente32.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente32.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
									// Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente32", dente32.getId());
                                }
                            %>
                            <!-- Dente 32 - Incisivo Lateral -->
                            <td align="center">
                                <%
									if (dente32 != null) {
                                %>
                                <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente32}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
									}
								%>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Incisivo Lateral"><input type="checkbox" name="dente32Lingual" id="dente32Lingual" title="Face Lingual - Incisivo Lateral" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Incisivo Lateral"><input type="checkbox" name="dente32Mesial" id="dente32Mesial" title="Face Mesial - Incisivo Lateral" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Incisivo Lateral"><input type="checkbox" name="dente32Incisal" id="dente32Incisal" title="Face Incisal - Incisivo Lateral" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Incisivo Lateral"><input type="checkbox" name="dente32Distal" id="dente32Distal" title="Face Distal - Incisivo Lateral" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Incisivo Lateral"><input type="checkbox" name="dente32Bucal" id="dente32Bucal" title="Face Bucal - Incisivo Lateral" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
									<tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Incisivo Lateral"><input type="checkbox" name="dente32Raiz" id="dent32Raiz" title="Raiz - Incisivo Lateral" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente33 != null) {
                                    // Face Distal
                                    switch (dente33.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente33.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente33.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente33.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente33.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente33.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
									// Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente33", dente33.getId());
                                }
                            %>
                            <!-- Dente 33 - Canino -->
                            <td align="center">
                                <%
									if (dente33 != null) {
                                %>
                                <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente33}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
									}
								%>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Canino"><input type="checkbox" name="dente33Lingual" id="dente33Lingual" title="Face Lingual - Canino" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Canino"><input type="checkbox" name="dente33Mesial" id="dente33Mesial" title="Face Mesial - Canino" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Canino"><input type="checkbox" name="dente33Incisal" id="dente33Incisal" title="Face Incisal - Canino" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Canino"><input type="checkbox" name="dente33Distal" id="dente33Distal" title="Face Distal - Canino" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Canino"><input type="checkbox" name="dente33Bucal" id="dente33Bucal" title="Face Bucal - Canino" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
									<tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Canino"><input type="checkbox" name="dente33Raiz" id="dent33Raiz" title="Raiz - Canino" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente34 != null) {
                                    // Face Distal
                                    switch (dente34.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente34.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente34.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente34.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente34.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente34.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
									// Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente34", dente34.getId());
                                }
                            %>
                            <!-- Dente 34 - Primeiro Pre-Molar -->
                            <td align="center">
                                <%
									if (dente34 != null) {
                                %>
                                <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente34}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
									}
								%>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Primeiro Pr&eacute;-Molar"><input type="checkbox" name="dente34Lingual" id="dente34Lingual" title="Face Lingual - Primeiro Pr&eacute;-Molar" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Primeiro Pr&eacute;-Molar"><input type="checkbox" name="dente34Mesial" id="dente34Mesial" title="Face Mesial - Primeiro Pr&eacute;-Molar" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Primeiro Pr&eacute;-Molar"><input type="checkbox" name="dente34Incisal" id="dente34Incisal" title="Face Incisal - Primeiro Pr&eacute;-Molar" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Primeiro Pr&eacute;-Molar"><input type="checkbox" name="dente34Distal" id="dente34Distal" title="Face Distal - Primeiro Pr&eacute;-Molar" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Primeiro Pr&eacute;-Molar"><input type="checkbox" name="dente34Bucal" id="dente34Bucal" title="Face Bucal - Primeiro Pr&eacute;-Molar" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
									<tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Primeiro Pr&eacute;-Molar"><input type="checkbox" name="dente34Raiz" id="dent34Raiz" title="Raiz - Primeiro Pr&eacute;-Molar" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente35 != null) {
                                    // Face Distal
                                    switch (dente35.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente35.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente35.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente35.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente35.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente35.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
									// Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente35", dente35.getId());
                                }
                            %>
                            <!-- Dente 35 - Segundo Pre-Molar -->
                            <td align="center">
                                <%
									if (dente35 != null) {
                                %>
                                <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente35}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
									}
								%>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Segundo Pr&eacute;-Molar"><input type="checkbox" name="dente35Lingual" id="dente35Lingual" title="Face Lingual - Segundo Pr&eacute;-Molar" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Segundo Pr&eacute;-Molar"><input type="checkbox" name="dente35Mesial" id="dente35Mesial" title="Face Mesial - Segundo Pr&eacute;-Molar" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Segundo Pr&eacute;-Molar"><input type="checkbox" name="dente35Incisal" id="dente35Incisal" title="Face Incisal - Segundo Pr&eacute;-Molar" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Segundo Pr&eacute;-Molar"><input type="checkbox" name="dente35Distal" id="dente35Distal" title="Face Distal - Segundo Pr&eacute;-Molar" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Segundo Pr&eacute;-Molar"><input type="checkbox" name="dente35Bucal" id="dente35Bucal" title="Face Bucal - Segundo Pr&eacute;-Molar" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
									<tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Segundo Pr&eacute;-Molar"><input type="checkbox" name="dente35Raiz" id="dent35Raiz" title="Raiz - Segundo Pr&eacute;-Molar" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente36 != null) {
                                    // Face Distal
                                    switch (dente36.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente36.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente36.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente36.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente36.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente36.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
									// Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente36", dente36.getId());
                                }
                            %>
                            <!-- Dente 36 - Primeiro Molar -->
                            <td align="center">
                                <%
									if (dente36 != null) {
                                %>
                                <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente36}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
									}
								%>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Primeiro Molar"><input type="checkbox" name="dente36Lingual" id="dente36Lingual" title="Face Lingual - Primeiro Molar" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Primeiro Molar"><input type="checkbox" name="dente36Mesial" id="dente36Mesial" title="Face Mesial - Primeiro Molar" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Primeiro Molar"><input type="checkbox" name="dente36Incisal" id="dente36Incisal" title="Face Incisal - Primeiro Molar" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Primeiro Molar"><input type="checkbox" name="dente36Distal" id="dente36Distal" title="Face Distal - Primeiro Molar" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Primeiro Molar"><input type="checkbox" name="dente36Bucal" id="dente36Bucal" title="Face Bucal - Primeiro Molar" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
									<tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Primeiro Molar"><input type="checkbox" name="dente36Raiz" id="dent36Raiz" title="Raiz - Primeiro Molar" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente37 != null) {
                                    // Face Distal
                                    switch (dente37.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente37.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente37.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente37.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente37.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente37.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
									// Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente37", dente37.getId());
                                }
                            %>
                            <!-- Dente 37 - Segundo Molar -->
                            <td align="center">
                                <%
									if (dente37 != null) {
                                %>
                                <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente37}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
									}
								%>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Segundo Molar"><input type="checkbox" name="dente37Lingual" id="dente37Lingual" title="Face Lingual - Segundo Molar" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Segundo Molar"><input type="checkbox" name="dente37Mesial" id="dente37Mesial" title="Face Mesial - Segundo Molar" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Segundo Molar"><input type="checkbox" name="dente37Incisal" id="dente37Incisal" title="Face Incisal - Segundo Molar" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Segundo Molar"><input type="checkbox" name="dente37Distal" id="dente37Distal" title="Face Distal - Segundo Molar" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Segundo Molar"><input type="checkbox" name="dente37Bucal" id="dente37Bucal" title="Face Bucal - Segundo Molar" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
									<tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Segundo Molar"><input type="checkbox" name="dente37Raiz" id="dent37Raiz" title="Raiz - Segundo Molar" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente38 != null) {
                                    // Face Distal
                                    switch (dente38.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente38.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente38.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente38.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente38.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente38.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
									// Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente38", dente38.getId());
                                }
                            %>
                            <!-- Dente 38 - Terceiro Molar -->
                            <td align="center">
                                <%
									if (dente38 != null) {
                                %>
                                <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente38}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
									}
								%>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Terceiro Molar"><input type="checkbox" name="dente38Lingual" id="dente38Lingual" title="Face Lingual - Terceiro Molar" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Terceiro Molar"><input type="checkbox" name="dente38Mesial" id="dente38Mesial" title="Face Mesial - Terceiro Molar" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Terceiro Molar"><input type="checkbox" name="dente38Incisal" id="dente38Incisal" title="Face Incisal - Terceiro Molar" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Terceiro Molar"><input type="checkbox" name="dente38Distal" id="dente38Distal" title="Face Distal - Terceiro Molar" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Terceiro Molar"><input type="checkbox" name="dente38Bucal" id="dente38Bucal" title="Face Bucal - Terceiro Molar" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
									<tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Terceiro Molar"><input type="checkbox" name="dente38Raiz" id="dent38Raiz" title="Raiz - Terceiro Molar" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" bgcolor="#e7e6e6"><strong>31 - Incisivo Central</strong></td>
                            <td align="center" bgcolor="#e7e6e6"><strong>32 - Incisivo Lateral</strong></td>
                            <td align="center" bgcolor="#e7e6e6"><strong>33 - Canino</strong></td>
                            <td align="center" bgcolor="#e7e6e6"><strong>34 - 1&ordm; Pr&eacute;-Molar</strong></td>
                            <td align="center" bgcolor="#e7e6e6"><strong>35 - 2&ordm; Pr&eacute;-Molar</strong></td>
                            <td align="center" bgcolor="#e7e6e6"><strong>36 - 1&ordm; Molar</strong></td>
                            <td align="center" bgcolor="#e7e6e6"><strong>37 - 2&ordm; Molar</strong></td>
                            <td align="center" bgcolor="#e7e6e6"><strong>38 - 3&ordm; Molar</strong></td>
                        </tr>
                        <!-- Fim do Arco Inferior Esquerdo -->
                        <tr>
                            <td colspan="8">
                                &nbsp;
                            </td>
                        </tr>
                        <!-- Arco Inferior Direito -->
                        <tr>
                            <td colspan="3">
                                &nbsp;
                            </td>
                            <td align="center" bgcolor="#66CCFF" colspan="2">
                                <strong>Arco Inferior - Direito</strong>
                            </td>
                            <td colspan="3">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente48 != null) {
                                    // Face Distal
                                    switch (dente48.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente48.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente48.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente48.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente48.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente48.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
									// Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente48", dente48.getId());
                                }
                            %>
                            <!-- Dente 48 - Terceiro Molar -->
                            <td align="center">
                                <%
									if (dente48 != null) {
                                %>
                                <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente48}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
									}
								%>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Terceiro Molar"><input type="checkbox" name="dente48Lingual" id="dente48Lingual" title="Face Lingual - Terceiro Molar" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Terceiro Molar"><input type="checkbox" name="dente48Distal" id="dente48Distal" title="Face Distal - Terceiro Molar" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Terceiro Molar"><input type="checkbox" name="dente48Incisal" id="dente48Incisal" title="Face Incisal - Terceiro Molar" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Terceiro Molar"><input type="checkbox" name="dente48Mesial" id="dente48Mesial" title="Face Mesial - Terceiro Molar" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Terceiro Molar"><input type="checkbox" name="dente48Bucal" id="dente48Bucal" title="Face Bucal - Terceiro Molar" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
									<tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Terceiro Molar"><input type="checkbox" name="dente48Raiz" id="dent48Raiz" title="Raiz - Terceiro Molar" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente47 != null) {
                                    // Face Distal
                                    switch (dente47.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente47.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente47.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente47.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente47.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente47.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
									// Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente47", dente47.getId());
                                }
                            %>
                            <!-- Dente 47 - Segundo Molar -->
                            <td align="center">
                                <%
									if (dente47 != null) {
                                %>
                                <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente47}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
									}
								%>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Segundo Molar"><input type="checkbox" name="dente47Lingual" id="dente47Lingual" title="Face Lingual - Segundo Molar" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Segundo Molar"><input type="checkbox" name="dente47Distal" id="dente47Distal" title="Face Distal - Segundo Molar" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Segundo Molar"><input type="checkbox" name="dente47Incisal" id="dente47Incisal" title="Face Incisal - Segundo Molar" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Segundo Molar"><input type="checkbox" name="dente47Mesial" id="dente47Mesial" title="Face Mesial - Segundo Molar" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Segundo Molar"><input type="checkbox" name="dente47Bucal" id="dente47Bucal" title="Face Bucal - Segundo Molar" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
									<tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Segundo Molar"><input type="checkbox" name="dente47Raiz" id="dent47Raiz" title="Raiz - Segundo Molar" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente46 != null) {
                                    // Face Distal
                                    switch (dente46.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente46.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente46.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente46.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente46.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente46.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
									// Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente46", dente46.getId());
                                }
                            %>
                            <!-- Dente 46 - Primeiro Molar -->
                            <td align="center">
                                <%
									if (dente46 != null) {
                                %>
                                <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente46}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
									}
								%>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Primeiro Molar"><input type="checkbox" name="dente46Lingual" id="dente46Lingual" title="Face Lingual - Primeiro Molar" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Primeiro Molar"><input type="checkbox" name="dente46Distal" id="dente46Distal" title="Face Distal - Primeiro Molar" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Primeiro Molar"><input type="checkbox" name="dente46Incisal" id="dente46Incisal" title="Face Incisal - Primeiro Molar" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Primeiro Molar"><input type="checkbox" name="dente46Mesial" id="dente46Mesial" title="Face Mesial - Primeiro Molar" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Primeiro Molar"><input type="checkbox" name="dente46Bucal" id="dente46Bucal" title="Face Bucal - Primeiro Molar" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
									<tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Primeiro Molar"><input type="checkbox" name="dente46Raiz" id="dent46Raiz" title="Raiz - Primeiro Molar" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente45 != null) {
                                    // Face Distal
                                    switch (dente45.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente45.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente45.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente45.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente45.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente45.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
									// Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente45", dente45.getId());
                                }
                            %>
                            <!-- Dente 45 - Segundo Pre-Molar -->
                            <td align="center">
                                <%
									if (dente45 != null) {
                                %>
                                <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente45}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
									}
								%>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Segundo Pr&eacute;-Molar"><input type="checkbox" name="dente45Lingual" id="dente45Lingual" title="Face Lingual - Segundo Pr&eacute;-Molar" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Segundo Pr&eacute;-Molar"><input type="checkbox" name="dente45Distal" id="dente45Distal" title="Face Distal - Segundo Pr&eacute;-Molar" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Segundo Pr&eacute;-Molar"><input type="checkbox" name="dente45Incisal" id="dente45Incisal" title="Face Incisal - Segundo Pr&eacute;-Molar" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Segundo Pr&eacute;-Molar"><input type="checkbox" name="dente45Mesial" id="dente45Mesial" title="Face Mesial - Segundo Pr&eacute;-Molar" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Segundo Pr&eacute;-Molar"><input type="checkbox" name="dente45Bucal" id="dente45Bucal" title="Face Bucal - Segundo Pr&eacute;-Molar" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
									<tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Segundo Pr&eacute;-Molar"><input type="checkbox" name="dente45Raiz" id="dent45Raiz" title="Raiz - Segundo Pr&eacute;-Molar" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente44 != null) {
                                    // Face Distal
                                    switch (dente44.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente44.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente44.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente44.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente44.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente44.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
                                    // Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente44", dente44.getId());
                                }
                            %>
                            <!-- Dente 44 - Primeiro Pre-Molar -->
                            <td align="center">
                                <%
									if (dente44 != null) {
                                %>
                                <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente44}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
									}
								%>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Primeiro Pr&eacute;-Molar"><input type="checkbox" name="dente44Lingual" id="dente44Lingual" title="Face Lingual - Primeiro Pr&eacute;-Molar" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Primeiro Pr&eacute;-Molar"><input type="checkbox" name="dente44Distal" id="dente44Distal" title="Face Distal - Primeiro Pr&eacute;-Molar" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Primeiro Pr&eacute;-Molar"><input type="checkbox" name="dente44Incisal" id="dente44Incisal" title="Face Incisal - Primeiro Pr&eacute;-Molar" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Primeiro Pr&eacute;-Molar"><input type="checkbox" name="dente44Mesial" id="dente44Mesial" title="Face Mesial - Primeiro Pr&eacute;-Molar" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Primeiro Pr&eacute;-Molar"><input type="checkbox" name="dente44Bucal" id="dente44Bucal" title="Face Bucal - Primeiro Pr&eacute;-Molar" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
									<tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Primeiro Pr&eacute;-Molar"><input type="checkbox" name="dente44Raiz" id="dent44Raiz" title="Raiz - Primeiro Pr&eacute;-Molar" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente43 != null) {
                                    // Face Distal
                                    switch (dente43.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente43.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente43.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente43.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente43.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente43.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
									// Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente43", dente43.getId());
                                }
                            %>
                            <!-- Dente 43 - Canino -->
                            <td align="center">
                                <%
									if (dente43 != null) {
                                %>
                                <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente43}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
									}
								%>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Canino"><input type="checkbox" name="dente43Lingual" id="dente43Lingual" title="Face Lingual - Canino" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Canino"><input type="checkbox" name="dente43Distal" id="dente43Distal" title="Face Distal - Canino" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Canino"><input type="checkbox" name="dente43Incisal" id="dente43Incisal" title="Face Incisal - Canino" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Canino"><input type="checkbox" name="dente43Mesial" id="dente43Mesial" title="Face Mesial - Canino" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Canino"><input type="checkbox" name="dente43Bucal" id="dente43Bucal" title="Face Bucal - Canino" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
									<tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Canino"><input type="checkbox" name="dente43Raiz" id="dent43Raiz" title="Raiz - Canino" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente42 != null) {
                                    // Face Distal
                                    switch (dente42.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente42.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente42.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente42.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente42.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente42.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
                                    // Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente42", dente42.getId());
                                }
                            %>
                            <!-- Dente 42 - Incisivo Lateral -->
                            <td align="center">
                                <%
									if (dente42 != null) {
                                %>
                                <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente42}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
									}
								%>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Incisivo Lateral"><input type="checkbox" name="dente42Lingual" id="dente42Lingual" title="Face Lingual - Incisivo Lateral" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Incisivo Lateral"><input type="checkbox" name="dente42Distal" id="dente42Distal" title="Face Distal - Incisivo Lateral" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Incisivo Lateral"><input type="checkbox" name="dente42Incisal" id="dente42Incisal" title="Face Incisal - Incisivo Lateral" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Incisivo Lateral"><input type="checkbox" name="dente42Mesial" id="dente42Mesial" title="Face Mesial - Incisivo Lateral" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Incisivo Lateral"><input type="checkbox" name="dente42Bucal" id="dente42Bucal" title="Face Bucal - Incisivo Lateral" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
									<tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Incisivo Lateral"><input type="checkbox" name="dente42Raiz" id="dent42Raiz" title="Raiz - Incisivo Lateral" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                            <%  fundoFaceBucal = "";
                                fundoFaceDistal = "";
                                fundoFaceIncisal = "";
                                fundoFaceMesial = "";
                                fundoFaceLingual = "";
                                fundoRaiz = "";
                                if (dente41 != null) {
                                    // Face Distal
                                    switch (dente41.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceDistal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceDistal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceDistal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceDistal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceDistal = "";
                                        }
                                    }

                                    // Face Mesial
                                    switch (dente41.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceMesial = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceMesial = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceMesial = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceMesial = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceMesial = "";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente41.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceIncisal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceIncisal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceIncisal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceIncisal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceIncisal = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente41.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceBucal = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceBucal = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceBucal = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceBucal = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceBucal = "";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente41.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoFaceLingual = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoFaceLingual = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoFaceLingual = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoFaceLingual = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoFaceLingual = "";
                                        }
                                    }

                                    // Raiz
                                    switch (dente41.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            fundoRaiz = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            fundoRaiz = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            fundoRaiz = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            fundoRaiz = "#CDC8B1";
                                        } break;
                                        default: {
                                            fundoRaiz = "";
                                        }
                                    }
									// Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                    // "botao mais"
                                    pageContext.setAttribute("idDente41", dente41.getId());
                                }
                            %>
                            <!-- Dente 41 - Incisivo Central -->
                            <td align="center">
                                <%
									if (dente41 != null) {
                                %>
                                <input name="historico" class="botaodefaultpeq" type="button" value="+" title="Liberar procedimentos" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/actionVisualizarHistoricoDenteParaLiberarProcedimentos.do?idBoca=${idBoca}&idDente=${idDente41}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
									}
								%>
                                <table border="1" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceLingual%>" title="Face Lingual - Incisivo Central"><input type="checkbox" name="dente41Lingual" id="dente41Lingual" title="Face Lingual - Incisivo Central" disabled <% if (!fundoFaceLingual.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td bgcolor="<%=fundoFaceDistal%>" title="Face Distal - Incisivo Central"><input type="checkbox" name="dente41Distal" id="dente41Distal" title="Face Distal - Incisivo Central" disabled <% if (!fundoFaceDistal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceIncisal%>" title="Face Incisal - Incisivo Central"><input type="checkbox" name="dente41Incisal" id="dente41Incisal" title="Face Incisal - Incisivo Central" disabled <% if (!fundoFaceIncisal.isEmpty()) out.print("checked"); %>/></td>
                                        <td bgcolor="<%=fundoFaceMesial%>" title="Face Mesial - Incisivo Central"><input type="checkbox" name="dente41Mesial" id="dente41Mesial" title="Face Mesial - Incisivo Central" disabled <% if (!fundoFaceMesial.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoFaceBucal%>" title="Face Bucal - Incisivo Central"><input type="checkbox" name="dente41Bucal" id="dente41Bucal" title="Face Bucal - Incisivo Central" disabled <% if (!fundoFaceBucal.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
									<tr>
                                        <td colspan="3" align="center" bgcolor="<%=fundoRaiz%>" title="Raiz - Incisivo Central"><input type="checkbox" name="dente41Raiz" id="dent41Raiz" title="Raiz - Incisivo Central" disabled <% if (!fundoRaiz.isEmpty()) out.print("checked"); %>/></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" bgcolor="#e7e6e6"><strong>48 - 3&ordm; Molar</strong></td>
                            <td align="center" bgcolor="#e7e6e6"><strong>47 - 2&ordm; Molar</strong></td>
                            <td align="center" bgcolor="#e7e6e6"><strong>46 - 1&ordm; Molar</strong></td>
                            <td align="center" bgcolor="#e7e6e6"><strong>45 - 2&ordm; Pr&eacute;-Molar</strong></td>
                            <td align="center" bgcolor="#e7e6e6"><strong>44 - 1&ordm; Pr&eacute;-Molar</strong></td>
                            <td align="center" bgcolor="#e7e6e6"><strong>43 - Canino</strong></td>
                            <td align="center" bgcolor="#e7e6e6"><strong>42 - Incisivo Lateral</strong></td>
                            <td align="center" bgcolor="#e7e6e6"><strong>41 - Incisivo Central</strong></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <table width="100%" style="border:thin" cellpadding="1" cellspacing="1" align="center">
                        <thead>
                            <tr>
                                <th colspan="4">Plano de Tratamento</th>
                            </tr>
                        </thead>
                        <tr>
                            <th style="text-align:center">
                                <strong>Procedimento</strong>
                            </th>
                            <th style="text-align:center">
                                <strong>Dente / Boca Completa</strong>
                            </th>
                            <th style="text-align:center">
                                <strong>Status</strong>
                            </th>
                            <th style="text-align:center">
                                <strong>Valor Cobrado (R$)</strong>
                            </th>
                        </tr>
                        <%
                            Collection<HistoricoDente> planoTratamentoDentes = (Collection<HistoricoDente>)request.getAttribute("planoTratamentoDentes");
                            HistoricoDente historicoDenteAux;
                            DecimalFormat decimalFormat = new DecimalFormat("0.00");
                            if (planoTratamentoDentes != null) {
                                Iterator iterator = planoTratamentoDentes.iterator();
                                while (iterator.hasNext()) {
                                    historicoDenteAux = (HistoricoDente) iterator.next();
                        %>
                        <tr>
                            <td align="center">
                                <%= historicoDenteAux.getProcedimento().getNome() %>
                            </td>
                            <td align="center">
                                <%= historicoDenteAux.getDente().getNome() %>&nbsp;<strong>|</strong>&nbsp;Posi&ccedil;&atilde;o:&nbsp;<%= historicoDenteAux.getDente().getPosicao() %>
                            </td>
                            <td align="center">
                                <%= historicoDenteAux.getStatusProcedimento().getNome() %>
                            </td>
                            <td align="center">
                                <%= decimalFormat.format(historicoDenteAux.getValorCobrado()) %>
                            </td>
                        </tr>
                        <%
                                } // while (iterator.hasNext())
                            } // if (planoTratamentoDentes != null)

                            Collection<HistoricoBoca> planoTratamentoBoca = (Collection<HistoricoBoca>)request.getAttribute("planoTratamentoBoca");
                            HistoricoBoca historicoBocaAux;
                            if (planoTratamentoBoca != null) {
                                Iterator iteratorBoca = planoTratamentoBoca.iterator();
                                while (iteratorBoca.hasNext()) {
                                    historicoBocaAux = (HistoricoBoca) iteratorBoca.next();
                        %>
                        <tr>
                            <td align="center">
                                <%= historicoBocaAux.getProcedimento().getNome() %>
                            </td>
                            <td align="center">
                                Boca Completa
                            </td>
                            <td align="center">
                                <%= historicoBocaAux.getStatusProcedimento().getNome() %>
                            </td>
                            <td align="center">
                                <%= decimalFormat.format(historicoBocaAux.getValorCobrado()) %>
                            </td>
                        </tr>
                        <%
                                } // while (iterator.hasNext())
                            } // if (planoTratamentoBoca != null)
                            if (planoTratamentoDentes.isEmpty() && planoTratamentoBoca.isEmpty()) {
                                out.println("<tr><td align='center' colspan='4'><p style='font-size:small; font-style:italic; color:red;'>Plano de tratamento vazio...</p></td></tr>");
                            }
                            else if (request.getAttribute("totalTratamento") != null) {
                                out.println("<tr><td style='border:none'>&nbsp;</td><td style='border:none'>&nbsp;</td><td style='border:none'>&nbsp;</td><td align='center' style='border:none'><font style='font-size:medium' color='#d42945'><strong>Total: R$" + decimalFormat.format((Double) request.getAttribute("totalTratamento")) + "</strong></font></td></tr>");
                            }
                        %>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <table width="100%" style="border:thin" cellpadding="1" cellspacing="1" align="center">
                        <thead>
                            <tr>
                                <th colspan="2">Resumo Financeiro</th>
                            </tr>
                        </thead>
                        <tr>
                            <th style="text-align:center">
                                <strong>Cr&eacute;dito (pagamentos)</strong>
                            </th>
                            <th style="text-align:center">
                                <strong>D&eacute;bito (procedimentos liberados, iniciados ou finalizados) </strong>
                            </th>
                        </tr>
                        <tr>
                            <td align="center">
                                <table width="100%" style="border:thin" cellpadding="1" cellspacing="1" align="center">
                                    <tr>
                                        <td align="center" style="border-left:none">
                                            <strong>Data</strong>
                                        </td>
                                        <td align="center">
                                            <strong>Forma de Pagamento</strong>
                                        </td>
                                        <td align="center" style="border-right:none">
                                            <strong>Valor (R$)</strong>
                                        </td>
                                    </tr>
                                    <%
                                        DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                                        Collection<Pagamento> pagamentos = (Collection<Pagamento>)request.getAttribute("pagamentos");
                                        Pagamento pagamentoAux;
                                        if (pagamentos != null) {
                                            Iterator iterator = pagamentos.iterator();
                                            while (iterator.hasNext()) {
                                                pagamentoAux = (Pagamento) iterator.next();
                                    %>
                                    <tr>
                                        <td align="center" style="border-left:none">
                                            <%= dateFormat.format(pagamentoAux.getDataHora()) %>
                                        </td>
                                        <td align="center">
                                            <%
                                                out.print(pagamentoAux.getFormaPagamento().getNome());
                                                if (pagamentoAux.getValorEmDinheiro() > Double.parseDouble("0")) {
                                                    out.print("&nbsp;<strong>|</strong>&nbsp;Dinheiro");
                                                }
                                                if (pagamentoAux.getValorEmCheque() > Double.parseDouble("0")) {
                                                    out.print("&nbsp;<strong>|</strong>&nbsp;Cheque(s)");
                                                }
                                                if (pagamentoAux.getValorEmCartao() > Double.parseDouble("0")) {
                                                    out.print("&nbsp;<strong>|</strong>&nbsp;Cart&atilde;o");
                                                }
                                            %>
                                        </td>
                                        <td align="center" style="border-right:none">
                                            <%= decimalFormat.format(pagamentoAux.getValorFinal()) %>
                                        </td>
                                    </tr>
                                    <%
                                            } // while (iterator.hasNext())
                                        } // if (pagamentos != null)
                                        if (pagamentos.isEmpty()) {
                                            out.println("<tr><td align='center' colspan='3' style='border:none'><p style='font-size:small; font-style:italic; color:red;'>Nenhum pagamento efetuado...</p></td></tr>");
                                        }
                                        else if (request.getAttribute("totalPagamentos") != null) {
                                            out.println("<tr><td style='border:none'>&nbsp;</td><td style='border:none'>&nbsp;</td><td align='center' style='border:none'><font style='font-size:medium' color='#d42945'><strong>Total: R$" + decimalFormat.format((Double) request.getAttribute("totalPagamentos")) + "</strong></font></td></tr>");
                                        }
                                    %>
                                </table>
                            </td>
                            <td align="center">
                                <table width="100%" style="border:thin" cellpadding="1" cellspacing="1" align="center">
                                    <tr>
                                            <td align="center" style="border-left:none">
                                                <strong>Data</strong>
                                            </td>
                                            <td align="center">
                                                <strong>Procedimento</strong>
                                            </td>
                                            <td align="center">
                                                <strong>Dente / Boca Completa</strong>
                                            </td>
                                            <td align="center">
                                                <strong>Status</strong>
                                            </td>
                                            <td align="center" style="border-right:none">
                                                <strong>Valor (R$)</strong>
                                            </td>
                                        </tr>
                                    <%
                                        Collection<HistoricoDente> debitosDente = (Collection<HistoricoDente>)request.getAttribute("debitosDente");
                                        HistoricoDente debitoDenteAux;
                                        if (debitosDente != null) {
                                            Iterator iterator = debitosDente.iterator();
                                            while (iterator.hasNext()) {
                                                debitoDenteAux = (HistoricoDente) iterator.next();
                                    %>
                                    <tr>
                                        <td align="center" style="border-left:none">
                                            <%= dateFormat.format(debitoDenteAux.getDataHora()) %>
                                        </td>
                                        <td align="center">
                                            <%= debitoDenteAux.getProcedimento().getNome() %>
                                        </td>
                                        <td align="center">
                                            Dente: <%= debitoDenteAux.getDente().getPosicao() %>
                                        </td>
                                        <td align="center">
                                            <%= debitoDenteAux.getStatusProcedimento().getNome() %>
                                        </td>
                                        <td align="center" style="border-right:none">
                                            <%= decimalFormat.format(debitoDenteAux.getValorCobrado()) %>
                                        </td>
                                    </tr>
                                    <%
                                            } // while (iterator.hasNext())
                                        } // if (debitosDente != null)

                                        Collection<HistoricoBoca> debitosBoca = (Collection<HistoricoBoca>)request.getAttribute("debitosBoca");
                                        HistoricoBoca debitoBocaAux;
                                        if (debitosBoca != null) {
                                            Iterator iterator = debitosBoca.iterator();
                                            while (iterator.hasNext()) {
                                                debitoBocaAux = (HistoricoBoca) iterator.next();
                                    %>
                                    <tr>
                                        <td align="center" style="border-left:none">
                                            <%= dateFormat.format(debitoBocaAux.getDataHora()) %>
                                        </td>
                                        <td align="center">
                                            <%= debitoBocaAux.getProcedimento().getNome() %>
                                        </td>
                                        <td align="center">
                                            Boca Completa
                                        </td>
                                        <td align="center">
                                            <%= debitoBocaAux.getStatusProcedimento().getNome() %>
                                        </td>
                                        <td align="center" style="border-right:none">
                                            <%= decimalFormat.format(debitoBocaAux.getValorCobrado()) %>
                                        </td>
                                    </tr>
                                    <%
                                            } // while (iterator.hasNext())
                                        } // if (debitosBoca != null)
                                        if (debitosDente.isEmpty() && debitosBoca.isEmpty()) {
                                            out.println("<tr><td align='center' style='border:none' colspan='5'><p style='font-size:small; font-style:italic; color:red;'>Nenhum d&eacute;bito efetuado...</p></td></tr>");
                                        }
                                        else if (request.getAttribute("totalDebitos") != null) {
                                            out.println("<tr><td style='border:none'>&nbsp;</td><td style='border:none'>&nbsp;</td><td style='border:none'>&nbsp;</td><td style='border:none'>&nbsp;</td><td align='center' style='border:none'><font style='font-size:medium' color='#d42945'><strong>Total: R$" + decimalFormat.format((Double) request.getAttribute("totalDebitos")) + "</strong></font></td></tr>");
                                        }
                                    %>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center" style="border-top:1px solid #e5eff8">
                                <%
                                    Double totalPagamentos = Double.parseDouble("0");
                                    Double totalDebitos = Double.parseDouble("0");
                                    Double saldo = Double.parseDouble("0");
                                    if (request.getAttribute("totalPagamentos") != null) {
                                        totalPagamentos = (Double) request.getAttribute("totalPagamentos");
                                    }
                                    if (request.getAttribute("totalDebitos") != null) {
                                        totalDebitos = (Double) request.getAttribute("totalDebitos");
                                    }
                                    if (request.getAttribute("saldoFicha") != null) {
                                        saldo = (Double) request.getAttribute("saldoFicha");
                                    }
                                    out.print("<font style='font-size:medium'><strong><u>Saldo do Paciente:</u></strong></font>");
                                    if (saldo < Double.parseDouble("0"))
                                        out.print("<font style='font-size:medium' color='#d42945'><strong> R$" + decimalFormat.format(saldo) + "</strong></font>");
                                    else
                                        out.print("<font style='font-size:medium' color='#00CC00'><strong> R$" + decimalFormat.format(saldo) + "</strong></font>");
                                %>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="border:none" colspan="4">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="paddingCelulaTabela" align="center" colspan="4">
                    <input name="voltar" id="voltar" class="botaodefault" type="button" value="voltar" title="Voltar" onclick="javascript:location.href='<%=request.getContextPath()%>/app/caixa/liberacaoProcedimentos.do'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                </td>
            </tr>
        </table>
        <%
            } // if (paciente != null)
        %>
    </body>
</html>