<%-- 
    Document   : visualizarHistoricoDente
    Created on : 21/03/2010, 10:55:31
    Author     : Fabricio P. Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="annotations.Funcionario" %>
<%@page import="annotations.Dente" %>
<%@page import="annotations.HistoricoDente" %>
<%@page import="web.login.ValidaGrupos" %>
<%@page import="java.util.Collection" %>
<%@page import="java.util.Iterator" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.text.DateFormat" %>
<%@page import="java.text.DecimalFormat" %>
<%@page import="javax.servlet.http.HttpSession" %>

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
    boolean aux6 = false;
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
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Caixa")){
            aux4 = true;
        }
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Dentista-Orcamento")){
            aux5 = true;
        }
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Dentista-Tratamento")){
            aux6 = true;
        }
        if (aux1 && aux2 && aux3 && aux4 && aux5 && aux6) {
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
        <title>Hist&oacute;rico - SOP - Sistema de Odontologia Popular</title>
    </head>
    <body onload="javascript:goFocus('voltar')">
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value="Hist&oacute;rico Dente"/>
        </jsp:include>
        <br> &nbsp;
        <br> &nbsp;

        <%
            // Captura objeto dente do request
            // Este objeto vem do action VisualizarHistoricoDenteAction acionado por botao da pagina visualizarOdontograma
            Dente dente = (Dente)request.getAttribute("dente");
            if (dente != null) {
        %>

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
            <tr>
                <td align="center" colspan="4">
                    <table cellpadding="1" cellspacing="1" align="center" width="80%" style="border:none">
                        <tr>
                            <td align="center" style="border:none" colspan="3">
                                <font style="color:black; font-size:small;"><u><strong><%= dente.getNome()%></strong></u></font>
                            </td>
                        </tr>
                        <tr>
                            <td style="border:none" colspan="3">
                                &nbsp;
                            </td>
                        </tr>
                        <%
                            // Captura objeto 'historicoDenteCollectionOrdenadoDescData' do request
                            // Este objeto vem do action VisualizarHistoricoDenteAction acionado por botao da pagina visualizarOdontograma
                            Collection<HistoricoDente> historicoDenteCollectionOrdenadoDescData = (Collection<HistoricoDente>)request.getAttribute("historicoDenteCollectionOrdenadoDescData");
                            if (!historicoDenteCollectionOrdenadoDescData.isEmpty()) {
                                HistoricoDente historicoDente;
                                Iterator iterator = historicoDenteCollectionOrdenadoDescData.iterator();
                                int i = 1;
                                while (iterator.hasNext()) {
                                    historicoDente = (HistoricoDente) iterator.next();
                        %>
                        <tr>
                            <td bgcolor="#EBE9E9" align="center" style="border:none" colspan="3">
                                <font style="color:black; font-size:small;"><strong>Registro&nbsp;<%=i%></strong></font>
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

                                char aux = dente.getPosicao().charAt(dente.getPosicao().length() - 1);
                                String posicaoDente = String.valueOf(aux);
                                String nome = "";
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
                            %>
                            <td colspan="2" align="left" style="border:none">
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
                        </tr>
                            <%
                                        i++;
                                    } // while (iterator.hasNext())
                                } // if (!historicoDenteCollectionOrdenadoDescData.isEmpty())
                                else {
                                    out.println("<tr><td align='center' colspan='3' style='border:none'><p style='font-size:medium; font-style:italic; color:red;'>Hist&oacute;rico vazio...</p></td></tr>");
                                }
                            %>
                        <tr>
                            <td colspan="3" style="border:none">
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="4" style="border:none">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="paddingCelulaTabela" align="center" colspan="4">
                    <input name="voltar" id="voltar" class="botaodefault" type="button" value="voltar" title="Voltar" onclick="javascript:history.back(1)" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                </td>
            </tr>
        </table>
        <%
            } // if (dente != null)
        %>
    </body>
</html>
