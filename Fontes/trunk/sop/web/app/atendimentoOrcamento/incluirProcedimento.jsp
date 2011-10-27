<%--
    Document   : incluirProcedimento
    Created on : 21/03/2010, 10:55:31
    Author     : Fabricio P. Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="annotations.Funcionario" %>
<%@page import="annotations.Dente" %>
<%@page import="annotations.HistoricoDente" %>
<%@page import="service.StatusProcedimentoService" %>
<%@page import="web.login.ValidaGrupos" %>
<%@page import="java.util.Collection" %>
<%@page import="java.util.Iterator" %>
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
    if(funcionarioLogado != null) {
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Administrador")){
            aux1 = true;
        }
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Administrador-TI")){
            aux2 = true;
        }
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Dentista-Orcamento")){
            aux3 = true;
        }
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Dentista-Tratamento")){
            aux4 = true;
        }
        if (aux1 && aux2 && aux3 && aux4) {
            response.sendRedirect(request.getContextPath() + "/mensagensDeRetorno/erro.jsp?codigoMensagem=11");
        }
    }
%>

<script type="text/javascript" language="javascript">
    <%@include file="atendimentoOrcamento.js"%>
    <%@include file="../utilitario.js"%>
</script>

<!-- Includes para DWR -->
<script type='text/javascript' src='/sop/dwr/engine.js'></script>
<script type='text/javascript' src='/sop/dwr/util.js'></script>
<script type='text/javascript' src='/sop/dwr/interface/Procedimento.js'></script>
<!-- Fim includes para DWR -->

<link href="<%=request.getContextPath()%>/css/estiloOdontograma.css" rel="stylesheet" type="text/css">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Incluir Procedimento / Parte do Dente ou Dente Inteiro - SOP - Sistema de Odontologia Popular</title>
    </head>
    <body onload="goFocus('procedimentoId')">
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value="Incluir Procedimento / Parte do Dente ou Dente Inteiro"/>
        </jsp:include>
        <br> &nbsp;
        <br> &nbsp;

        <%
            // Captura objeto dente do request
            // Este objeto vem do action VisualizarHistoricoDenteAction acionado por botao da pagina atenderAtendimentoOrcamento
            Dente dente = (Dente)request.getAttribute("dente");
            if (dente != null) {
        %>

        <script type="text/javascript">
            Procedimento.carregarProcedimentosPDDI();
        </script>
        <table cellpadding="1" cellspacing="1" align="center" width="100%">
            <tr> <!-- TO DO - colocar idade do paciente  -->
                <th align="center" colspan="4">
                    <font style="color:black; font-size:medium;"><strong><u>Paciente:</u> <% out.print(dente.getBoca().getPaciente().getNome()); %></strong></font>
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
                    String nome = "";
                    String arco = "";
                    String parteSuperior = "";
                    String parteEsquerda = "";
                    String parteDireita = "";
                    String parteInferior = "";
                    char aux = dente.getPosicao().charAt(dente.getPosicao().length() - 1);
                    String posicaoDente = String.valueOf(aux);
                    switch (Integer.parseInt(posicaoDente)) {
                        case 1: {
                            nome = "Incisivo Central";
                        } break;
                        case 2: {
                            nome = "Incisivo Lateral";
                        } break;
                        case 3: {
                            nome = "Canino";
                        } break;
                        case 4: {
                            nome = "Primeiro Pr&eacute;-Molar";
                        } break;
                        case 5: {
                            nome = "Segundo Pr&eacute;-Molar";
                        } break;
                        case 6: {
                            nome = "Primeiro Molar";
                        } break;
                        case 7: {
                            nome = "Segundo Molar";
                        } break;
                        case 8: {
                            nome = "Terceiro Molar";
                        } break;
                        default: {
                            nome = "";
                        }
                    }

                    if (dente.getPosicao().startsWith("1")) {
                        arco = "Superior Direito";
                        parteSuperior = "Bucal";
                        parteEsquerda = "Distal";
                        parteDireita = "Mesial";
                        parteInferior = "Lingual";
                    } else
                        if (dente.getPosicao().startsWith("2")) {
                            arco = "Superior Esquerdo";
                            parteSuperior = "Bucal";
                            parteEsquerda = "Mesial";
                            parteDireita = "Distal";
                            parteInferior = "Lingual";
                        }
                    else
                        if (dente.getPosicao().startsWith("3")) {
                            arco = "Inferior Esquerdo";
                            parteSuperior = "Lingual";
                            parteEsquerda = "Mesial";
                            parteDireita = "Distal";
                            parteInferior = "Bucal";
                        }
                    else
                        if (dente.getPosicao().startsWith("4")) {
                            arco = "Inferior Direito";
                            parteSuperior = "Lingual";
                            parteEsquerda = "Distal";
                            parteDireita = "Mesial";
                            parteInferior = "Bucal";
                        }

                    // Verifica se ha registros de historicoDente para serem exibidos
                    if ((Collection<HistoricoDente>)request.getAttribute("historicoDenteCollectionOrdenadoDescData") != null) {
                %>
            <tr>
                <td align="center" colspan="4" style="border:none">
                    <table cellpadding="1" cellspacing="1" align="center" width="80%" style="border:none">
                        <%
                            HistoricoDente historicoDente = new HistoricoDente();
                            // Captura objeto 'historicoDenteCollectionOrdenadoDescData' do request
                            // Este objeto vem do action VisualizarHistoricoDenteAction acionado por botao da pagina visualizarOdontograma
                            Collection<HistoricoDente> historicoDenteCollectionOrdenadoDescData = (Collection<HistoricoDente>)request.getAttribute("historicoDenteCollectionOrdenadoDescData");
                            Iterator iterator = historicoDenteCollectionOrdenadoDescData.iterator();
                            int i = 1;
                            while (iterator.hasNext()) {
                                historicoDente = (HistoricoDente) iterator.next();
                        %>
                        <tr>
                            <td bgcolor="#EBE9E9" align="center" style="border:none" colspan="3">
                                <font style="color:black; font-size:small;"><strong>Hist&oacute;rico - Registro&nbsp;<%=i%></strong></font>
                            </td>
                        </tr>
                        <tr>
                            <%
                                // Determina cor de fundo
                                String corFundoBgColor = "";
                                String corFundoImagem = "";
                                String raiz = "";
                                String superior = "";
                                String esquerda = "";
                                String direita = "";
                                String inferior = "";
                                switch (historicoDente.getStatusProcedimento().getCodigo().intValue()) {
                                    // Orcado
                                    case 1: {
                                        corFundoBgColor = "#FFDD00";
                                        corFundoImagem = "a";
                                    } break;
                                    // Pago
                                    case 2: {
                                        corFundoBgColor = "#87FF00";
                                        corFundoImagem = "v";
                                    } break;
                                    // Executando
                                    case 3: {
                                        corFundoBgColor = "#00FFFF";
                                        corFundoImagem = "az";
                                    } break;
                                    // Finalizado
                                    case 4: {
                                        corFundoBgColor = "#CDC8B1";
                                        corFundoImagem = "c";
                                    } break;
                                    default: {
                                        corFundoBgColor = "";
                                        corFundoImagem = "b";
                                    }
                                }
                                if (historicoDente.getRaiz()) raiz = "r".concat(corFundoImagem); else raiz =  "rb";

                                if (dente.getPosicao().startsWith("1")) {
                                    if (historicoDente.getFaceDistal()) esquerda = "e".concat(corFundoImagem); else esquerda =  "eb";
                                    if (historicoDente.getFaceBucal()) superior = "c".concat(corFundoImagem); else superior =  "cb";
                                    if (historicoDente.getFaceMesial()) direita = "d".concat(corFundoImagem);  else direita =  "db";
                                    if (historicoDente.getFaceLingual()) inferior = "b".concat(corFundoImagem);  else inferior =  "bb";
                            %>
                            <td align="center" style="border:none">
                                <table border="0" width="70" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" class="<%=raiz%>" title="Raiz - <%=nome%> Superior Direito"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" class="<%=superior+"_"+esquerda+"_"+direita%>" title="Face Bucal - <%=nome%> Superior Direito"></td>
                                    </tr>
                                    <tr>
                                        <td class="<%=esquerda%>" title="Face Distal - <%=nome%> Superior Direito"></td>
                                        <td bgcolor="<% if (historicoDente.getFaceIncisal()) out.print(corFundoBgColor);%>" title="Face Incisal - <%=nome%> Superior Direito"></td>
                                        <td class="<%=direita%>" title="Face Mesial - <%=nome%> Superior Direito"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" class="<%=inferior+"_"+esquerda+"_"+direita%>" title="Face Lingual - <%=nome%> Superior Direito"></td>
                                    </tr>
                                </table>
                            </td>
                            <%  } else
                                    if (dente.getPosicao().startsWith("2")) {
                                        if (historicoDente.getFaceMesial()) esquerda = "e".concat(corFundoImagem); else esquerda =  "eb";
                                        if (historicoDente.getFaceBucal()) superior = "c".concat(corFundoImagem); else superior =  "cb";
                                        if (historicoDente.getFaceDistal()) direita = "d".concat(corFundoImagem);  else direita =  "db";
                                        if (historicoDente.getFaceLingual()) inferior = "b".concat(corFundoImagem);  else inferior =  "bb";
                            %>
                            <td align="center" style="border:none">
                                <table border="0" width="70" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" class="<%=raiz%>" title="Raiz - <%=nome%> Superior Esquerdo"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" class="<%=superior+"_"+esquerda+"_"+direita%>" title="Face Bucal - <%=nome%> Superior Esquerdo"></td>
                                    </tr>
                                    <tr>
                                        <td class="<%=esquerda%>" title="Face Mesial - <%=nome%> Superior Esquerdo"></td>
                                        <td bgcolor="<% if (historicoDente.getFaceIncisal()) out.print(corFundoBgColor);%>" title="Face Incisal - <%=nome%> Superior Esquerdo"></td>
                                        <td class="<%=direita%>" title="Face Distal - <%=nome%> Superior Esquerdo"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" class="<%=inferior+"_"+esquerda+"_"+direita%>" title="Face Lingual - <%=nome%> Superior Esquerdo"></td>
                                    </tr>
                                </table>
                            </td>
                            <%  } else
                                    if (dente.getPosicao().startsWith("3")) {
                                        if (historicoDente.getFaceMesial()) esquerda = "e".concat(corFundoImagem); else esquerda =  "eb";
                                        if (historicoDente.getFaceLingual()) superior = "c".concat(corFundoImagem); else superior =  "cb";
                                        if (historicoDente.getFaceDistal()) direita = "d".concat(corFundoImagem);  else direita =  "db";
                                        if (historicoDente.getFaceBucal()) inferior = "b".concat(corFundoImagem);  else inferior =  "bb";
                            %>
                            <td align="center" style="border:none">
                                <table border="0" width="70" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" class="<%=superior+"_"+esquerda+"_"+direita%>" title="Face Lingual - <%=nome%> Inferior Esquerdo"></td>
                                    </tr>
                                    <tr>
                                        <td class="<%=esquerda%>" title="Face Mesial - <%=nome%> Inferior Esquerdo"></td>
                                        <td bgcolor="<% if (historicoDente.getFaceIncisal()) out.print(corFundoBgColor);%>" title="Face Incisal - <%=nome%> Inferior Esquerdo"></td>
                                        <td class="<%=direita%>" title="Face Distal - <%=nome%> Inferior Esquerdo"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" class="<%=inferior+"_"+esquerda+"_"+direita%>" title="Face Bucal - <%=nome%> Inferior Esquerdo"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" class="<%=raiz%>" title="Raiz - <%=nome%> Inferior Esquerdo"></td>
                                    </tr>
                                </table>
                            </td>
                            <%  } else
                                    if (dente.getPosicao().startsWith("4")) {
										if (historicoDente.getFaceDistal()) esquerda = "e".concat(corFundoImagem); else esquerda =  "eb";
                                        if (historicoDente.getFaceLingual()) superior = "c".concat(corFundoImagem); else superior =  "cb";
                                        if (historicoDente.getFaceMesial()) direita = "d".concat(corFundoImagem);  else direita =  "db";
                                        if (historicoDente.getFaceBucal()) inferior = "b".concat(corFundoImagem);  else inferior =  "bb";
                            %>
                            <td align="center" style="border:none">
                                <table border="0" width="70" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" class="<%=superior+"_"+esquerda+"_"+direita%>" title="Face Lingual - <%=nome%> Inferior Direito"></td>
                                    </tr>
                                    <tr>
                                        <td class="<%=esquerda%>" title="Face Distal - <%=nome%> Inferior Direito"></td>
                                        <td bgcolor="<% if (historicoDente.getFaceIncisal()) out.print(corFundoBgColor);%>" title="Face Incisal - <%=nome%> Inferior Direito"></td>
                                        <td class="<%=direita%>" title="Face Mesial - <%=nome%> Inferior Direito"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" class="<%=inferior+"_"+esquerda+"_"+direita%>" title="Face Bucal - <%=nome%> Inferior Direito"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" class="<%=raiz%>" title="Raiz - <%=nome%> Inferior Direito"></td>
                                    </tr>
                                </table>
                            </td>
                                <%
                                    } // if (dente.getPosicao().startsWith("4"))

                                    boolean orcado = false;
                                    if (historicoDente.getStatusProcedimento().equals(StatusProcedimentoService.getStatusProcedimentoOrcado())) {
                                        orcado = true;
                                    }
                                %>
                            <td align="left" colspan="<% if(orcado) out.print("1"); else out.print("2"); %>" style="border:none">
                                <table border="0" cellpadding="1" cellspacing="1" style="border:none">
                                    <tr>
                                        <td style="border:none">
                                            <%  DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                                                DecimalFormat decimalFormat = new DecimalFormat("0.00");
                                            %>
                                            <strong>Data:</strong> <%= dateFormat.format(historicoDente.getDataHora())%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border:none">
                                            <strong>Procedimento:</strong> <%= historicoDente.getProcedimento().getNome()%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border:none">
                                            <strong>Valor Cobrado: R$<%= decimalFormat.format(historicoDente.getValorCobrado()) %></strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border:none">
                                            <strong>Dentista:</strong> <%= historicoDente.getDentista().getNome()%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border:none">
                                            <strong>Observa&ccedil;&atilde;o:</strong> <%= historicoDente.getObservacao()%>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <%
                                if (orcado) {
                                    String idHistoricoDente = historicoDente.getId().toString();
                                    pageContext.setAttribute("idHistoricoDente", idHistoricoDente);
                                    String idDente = historicoDente.getDente().getId().toString();
                                    pageContext.setAttribute("idDente", idDente);
                            %>
                            <td style="border:none" align="center" valign="middle">
                                <input name="excluirRegistroHistoricoDente" class="botaodefault" type="button" value="excluir" title="Excluir" onclick="javascript: if (confirm('Tem certeza que deseja excluir este registro?')) location.href='<%=request.getContextPath()%>/app/atendimentoOrcamento/excluirRegistroHistoricoDente.do?idHistoricoDente=${idHistoricoDente}&idDente=${idDente}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                            </td>
                            <%
                                } // if (orcado)
                            %>
                        </tr>
                        <%
                                i++;
                            } // while (iterator.hasNext())
                        %>
                        <tr>
                            <td colspan="3" style="border:none">
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <%
                } // if ((Collection<HistoricoDente>)request.getAttribute("historicoDenteCollectionOrdenadoDescData") != null)
            %>
            <tr>
                <td colspan="4" style="border:none">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <form name="formIncluirProcedimento" id="formIncluirProcedimento" method="POST" onsubmit="return validarDados()" action="<%=request.getContextPath()%>/app/atendimentoOrcamento/actionIncluirProcedimento.do">
                        <input name="denteId" id="denteId" value="<% if(dente.getId() != null) { out.print(dente.getId());}%>" type="hidden"/>
                        <input name="dentePosicao" id="dentePosicao" value="<%=dente.getPosicao()%>" type="hidden"/>
                        <table cellpadding="0" cellspacing="0" align="center" width="80%">
                            <thead>
                                <tr>
                                    <th colspan="3">Inclus&atilde;o de Procedimento (<strong><font color="#FF0000">*</font></strong> campos obrigat&oacute;rios)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td align="center" valign="middle" style="border-right:none; border-bottom:1px solid #e5eff8;">
                                        <img src="<%=request.getContextPath()%>/imagens/dentes/P<%=dente.getPosicao()%>.jpg" alt="Dente" width="40" height="158">
                                    </td>
                                    <td align="center" valign="middle" style="border-right:none; border-bottom:1px solid #e5eff8;">
                                        <p><u><strong><%= nome + " " + arco %></strong></u></p>
                                        <table width="100" border="0" cellpadding="0" cellspacing="0">
                                            <%
                                                if (dente.getPosicao().startsWith("1") || dente.getPosicao().startsWith("2")) {
                                            %>
                                            <tr>
                                                <td id="raiz" class="raiz" height="30" colspan="3" align="center" title="<%= "Raiz - " + nome + " " + arco%>">
                                                    <input name="raiz" id="checkRaiz" value="Raiz" type="checkbox" title="<%= "Raiz - " + nome + " " + arco%>" onclick="javascript:colorirFundo('raiz')"/>
                                                </td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                            <tr>
                                                <td id="faceSuperior" class="faceSuperior" height="30" colspan="3" align="center" title="<%= "Face " + parteSuperior + " - " + nome + " " + arco%>">
                                                    <input name="faceSuperior" id="checkFaceSuperior" value="<%=parteSuperior%>" type="checkbox" title="<%= "Face " + parteSuperior + " - " + nome + " " + arco%>" onclick="javascript:colorirFundo('faceSuperior')"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td id="faceEsquerda" class="faceEsquerda" width="31" height="40" align="center" title="<%= "Face " + parteEsquerda + " - " + nome + " " + arco%>">
                                                    <input name="faceEsquerda" id="checkFaceEsquerda" value="<%=parteEsquerda%>" type="checkbox" title="<%= "Face " + parteEsquerda + " - " + nome + " " + arco%>" onclick="javascript:colorirFundo('faceEsquerda')"/>
                                                </td>
                                                <td id="faceMeio" width="39" height="40" align="center" title="Face Incisal - <%=nome + " " + arco%>">
                                                    <input name="faceMeio" id="checkFaceMeio" value="Incisal" type="checkbox" title="Face Incisal - <%=nome + " " + arco%>" onclick="javascript:colorirFundo('faceMeio')"/>
                                                </td>
                                                <td id="faceDireita" class="faceDireita" width="31" height="40" align="center" title="<%= "Face " + parteDireita + " - " + nome + " " + arco%>">
                                                    <input name="faceDireita" id="checkFaceDireita" value="<%=parteDireita%>" type="checkbox" title="<%= "Face " + parteDireita + " - " + nome + " " + arco%>" onclick="javascript:colorirFundo('faceDireita')"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td id="faceInferior" class="faceInferior" height="30" colspan="3" align="center" title="<%= "Face " + parteInferior + " - " + nome + " " + arco%>">
                                                    <input name="faceInferior" id="checkFaceInferior" value="<%=parteInferior%>" type="checkbox" title="<%= "Face " + parteInferior + " - " + nome + " " + arco%>" onclick="javascript:colorirFundo('faceInferior')"/>
                                                </td>
                                            </tr>
                                            <%
                                                if (dente.getPosicao().startsWith("3") || dente.getPosicao().startsWith("4")) {
                                            %>
                                            <tr>
                                                <td id="raiz" class="raiz" height="30" colspan="3" align="center" title="<%= "Raiz - " + nome + " " + arco%>">
                                                    <input name="raiz" id="checkRaiz" value="Raiz" type="checkbox" title="<%= "Raiz - " + nome + " " + arco%>" onclick="javascript:colorirFundo('raiz')"/>
                                                </td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                        </table>
                                    </td>
                                    <td align="center" style="border-bottom:1px solid #e5eff8;">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Procedimento:
                                                    <input name="tipoProcedimento" id="tipoProcedimento" type="hidden">
                                                    <select name="procedimentoId" id="procedimentoId" onchange="Procedimento.marcarValoresPDDI(this.value)" onkeydown="return enter(event)">
                                                        <option value="" selected>Selecione</option>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="paddingCelulaTabela" align="left">Valor: R$
                                                    <input name="valor" id="valor" type="text" size="7" maxlength="7" onkeypress="return mascaraNumeroReal(valor, 1, 7)" onblur="validarValorReal3D(valor, 'valor')" readonly disabled>
                                                    <input name="valorProcedimento" id="valorProcedimento" type="hidden">
                                                    <input name="valorMinimo" id="valorMinimo" type="hidden">
                                                    <input name="valorMinimoProcedimento" id="valorMinimoProcedimento" type="hidden">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Valor Cobrado: R$
                                                    <input name="valorCobrado" id="valorCobrado" type="text" size="7" maxlength="7" onkeypress="return mascaraNumeroReal(valorCobrado, 1, 7)" onblur="validarValorReal3D(valorCobrado, 'valorCobrado')">
                                                    <br><font size="1" color="#FF0000">Formato: 0000.00</font>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="paddingCelulaTabela" align="left">Observa&ccedil;&atilde;o:
                                                    <textarea name="observacao" id="observacao" rows="3" cols="30"></textarea>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td class="paddingCelulaTabela" align="left" colspan="3" style="border-bottom:1px solid #e5eff8;">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td class="paddingCelulaTabela" align="center" style="border-left:none; border-right:none;">
                                                    <input name="incluirProcedimento" class="botaodefault" type="submit" value="incluir" title="Incluir procedimento" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                                </td>
                                                <td class="paddingCelulaTabela" align="center" style="border-left:none; border-right:none;">
                                                    <input name="limpar" class="botaodefault" type="reset" value="limpar" title="Limpar" onclick="javascript:descolorirFundos()" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                                </td>
                                                <td class="paddingCelulaTabela" align="center" style="border-left:none; border-right:none;">
                                                    <input name="verOdontograma" class="botaodefaultgra" type="button" value="ver odontograma" title="Odontograma" onclick="javascript:location.href='<%=request.getContextPath()%>/app/filaAtendimentoOrcamento/actionContinuarAtendimentoOrcamento.do?idPaciente=<%=(String)request.getSession(false).getAttribute("idPaciente")%>'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra.png)'">
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
                </td>
            </tr>
        </table>
        <%
            } // if (dente != null)
        %>
    </body>
</html>
