<%--
    Document   : atenderAtendimentoOrcamento
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
<%@page import="web.login.ValidaGrupos" %>
<%@page import="java.util.Collection" %>
<%@page import="java.util.Iterator" %>
<%@page import="java.text.DecimalFormat" %>
<%@page import="java.text.DateFormat" %>
<%@page import="java.text.SimpleDateFormat"%>
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
</script>

<link href="<%=request.getContextPath()%>/css/estiloOdontograma.css" rel="stylesheet" type="text/css">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Atendimento Or&ccedil;amento - SOP - Sistema de Odontologia Popular</title>
    </head>
    <body>
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value="Atendimento Or&ccedil;amento"/>
        </jsp:include>
        <br> &nbsp;
        <br> &nbsp;

        <%
            // Captura objeto paciente do request
            // Este objeto vem de AtenderAtendimentoOrcamentoAction
            Paciente paciente = (Paciente)request.getAttribute("paciente");
            if (paciente != null) {
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
                    <input name="incluirProcedimentoBoca" class="botaodefaultgra" type="button" value="+ Boca Completa" title="Incluir procedimento de boca completa / ver hist&oacute;rico" onclick="javascript:location.href='<%=request.getContextPath()%>/app/atendimentoOrcamento/incluirProcedimentoBoca.do?idPaciente=${idPaciente}&idBoca=${idBoca}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-gra.png)'">
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
                                String esquerda = "";
                                String direita = "";
                                String meio = "";
                                String superior = "";
                                String inferior = "";
                                String raiz = "";
                                String denteId = "";

                                Dente dente = null;
                                String nome = "";
                                for (int i = 8; i >= 1; i--) {
                                    dente = (Dente)request.getSession(false).getAttribute("dente1" + String.valueOf(i));
                                    switch (i) {
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

                                    if (dente.getId() !=  null) {
                                        // Face Distal
                                        switch (dente.getFaceDistal().intValue()) {
                                            // Orcado
                                            case 1: {
                                                esquerda = "ea";
                                            } break;
                                            // Pago
                                            case 2: {
                                                esquerda = "ev";
                                            } break;
                                            // Executando
                                            case 3: {
                                                esquerda = "eaz";
                                            } break;
                                            // Finalizado
                                            case 4: {
                                                esquerda = "ec";
                                            } break;
                                            default: {
                                                esquerda = "eb";
                                            }
                                        }

                                        // Face Mesial
                                        switch (dente.getFaceMesial().intValue()) {
                                            // Orcado
                                            case 1: {
                                                direita = "da";
                                            } break;
                                            // Pago
                                            case 2: {
                                                direita = "dv";
                                            } break;
                                            // Executando
                                            case 3: {
                                                direita = "daz";
                                            } break;
                                            // Finalizado
                                            case 4: {
                                                direita = "dc";
                                            } break;
                                            default: {
                                                direita = "db";
                                            }
                                        }

                                        // Face Incisal
                                        switch (dente.getFaceIncisal().intValue()) {
                                            // Orcado
                                            case 1: {
                                                meio = "#FFDD00";
                                            } break;
                                            // Pago
                                            case 2: {
                                                meio = "#87FF00";
                                            } break;
                                            // Executando
                                            case 3: {
                                                meio = "#00FFFF";
                                            } break;
                                            // Finalizado
                                            case 4: {
                                                meio = "#CDC8B1";
                                            } break;
                                            default: {
                                                meio = "";
                                            }
                                        }

                                        // Face Bucal
                                        switch (dente.getFaceBucal().intValue()) {
                                            // Orcado
                                            case 1: {
                                                superior = "ca";
                                            } break;
                                            // Pago
                                            case 2: {
                                                superior = "cv";
                                            } break;
                                            // Executando
                                            case 3: {
                                                superior = "caz";
                                            } break;
                                            // Finalizado
                                            case 4: {
                                                superior = "cc";
                                            } break;
                                            default: {
                                                superior = "cb";
                                            }
                                        }

                                        // Face Lingual
                                        switch (dente.getFaceLingual().intValue()) {
                                            // Orcado
                                            case 1: {
                                                inferior = "ba";
                                            } break;
                                            // Pago
                                            case 2: {
                                                inferior = "bv";
                                            } break;
                                            // Executando
                                            case 3: {
                                                inferior = "baz";
                                            } break;
                                            // Finalizado
                                            case 4: {
                                                inferior = "bc";
                                            } break;
                                            default: {
                                                inferior = "bb";
                                            }
                                        }

                                        // Raiz
                                        switch (dente.getRaiz().intValue()) {
                                            // Orcado
                                            case 1: {
                                                raiz = "ra";
                                            } break;
                                            // Pago
                                            case 2: {
                                                raiz = "rv";
                                            } break;
                                            // Executando
                                            case 3: {
                                                raiz = "raz";
                                            } break;
                                            // Finalizado
                                            case 4: {
                                                raiz = "rc";
                                            } break;
                                            default: {
                                                raiz = "rb";
                                            }
                                        }
                                        // Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico
                                        // "botao mais"
                                        String idDente = "idDente1" + String.valueOf(i);
                                        pageContext.setAttribute(idDente, dente.getId());
                                        denteId = dente.getId().toString();
                                    }  // if (dente != null)
                                    else {
                                            pageContext.setAttribute("idDente1" + String.valueOf(i), "S1"+String.valueOf(i)+"P");
                                            denteId = "S1"+String.valueOf(i)+"P";
                                            esquerda = "eb";
                                            direita = "db";
                                            meio = "";
                                            superior = "cb";
                                            inferior = "bb";
                                            raiz = "rb";
                                    }
                            %>
                            <td align="center">
                            <%
                                if (dente != null) {
                            %>
                            <input name="incluirProcedimento" class="botaodefaultpeq" type="button" value="+" title="Incluir procedimento / ver hist&oacute;rico" onclick="javascript:location.href='<%=request.getContextPath()%>/app/atendimentoOrcamento/incluirProcedimento.do?idBoca=${idBoca}&idDente=<%=denteId%>'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                            <%
                                }
                            %>
                            <br>
                            <br>
                                <table border="0" width="70" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" class="<%=raiz%>" title="Raiz - <%=nome%> Superior Direito"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" class="<%=superior+"_"+esquerda+"_"+direita%>" title="Face Bucal - <%=nome%> Superior Direito"></td>
                                    </tr>
                                    <tr>
                                        <td class="<%=esquerda%>" title="Face Distal - <%=nome%> Superior Direito"></td>
                                        <td bgcolor="<%=meio%>" title="Face Incisal - <%=nome%> Superior Direito"></td>
                                        <td class="<%=direita%>" title="Face Mesial - <%=nome%> Superior Direito"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" class="<%=inferior+"_"+esquerda+"_"+direita%>" title="Face Lingual - <%=nome%> Superior Direito"></td>
                                    </tr>
                                </table>
                            </td>
                            <%
                                } // for (int i = 8; i >= 1; i--) {
                            %>
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
                            <%  
                                dente = null;
                                for (int i = 1; i <= 8; i++) {
                                dente = (Dente)request.getSession(false).getAttribute("dente2" + String.valueOf(i));
                                switch (i) {
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

                                if (dente.getId() !=  null) {
                                    // Face Mesial
                                    switch (dente.getFaceMesial().intValue()) {
                                        // Orcado
                                        case 1: {
                                            esquerda = "ea";
                                        } break;
                                        // Pago
                                        case 2: {
                                            esquerda = "ev";
                                        } break;
                                        // Executando
                                        case 3: {
                                            esquerda = "eaz";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            esquerda = "ec";
                                        } break;
                                        default: {
                                            esquerda = "eb";
                                        }
                                    }

                                    // Face Distal
                                    switch (dente.getFaceDistal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            direita = "da";
                                        } break;
                                        // Pago
                                        case 2: {
                                            direita = "dv";
                                        } break;
                                        // Executando
                                        case 3: {
                                            direita = "daz";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            direita = "dc";
                                        } break;
                                        default: {
                                            direita = "db";
                                        }
                                    }

                                    // Face Incisal
                                    switch (dente.getFaceIncisal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            meio = "#FFDD00";
                                        } break;
                                        // Pago
                                        case 2: {
                                            meio = "#87FF00";
                                        } break;
                                        // Executando
                                        case 3: {
                                            meio = "#00FFFF";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            meio = "#CDC8B1";
                                        } break;
                                        default: {
                                            meio = "";
                                        }
                                    }

                                    // Face Bucal
                                    switch (dente.getFaceBucal().intValue()) {
                                        // Orcado
                                        case 1: {
                                            superior = "ca";
                                        } break;
                                        // Pago
                                        case 2: {
                                            superior = "cv";
                                        } break;
                                        // Executando
                                        case 3: {
                                            superior = "caz";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            superior = "cc";
                                        } break;
                                        default: {
                                            superior = "cb";
                                        }
                                    }

                                    // Face Lingual
                                    switch (dente.getFaceLingual().intValue()) {
                                        // Orcado
                                        case 1: {
                                            inferior = "ba";
                                        } break;
                                        // Pago
                                        case 2: {
                                            inferior = "bv";
                                        } break;
                                        // Executando
                                        case 3: {
                                            inferior = "baz";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            inferior = "bc";
                                        } break;
                                        default: {
                                            inferior = "bb";
                                        }
                                    }

                                    // Raiz
                                    switch (dente.getRaiz().intValue()) {
                                        // Orcado
                                        case 1: {
                                            raiz = "ra";
                                        } break;
                                        // Pago
                                        case 2: {
                                            raiz = "rv";
                                        } break;
                                        // Executando
                                        case 3: {
                                            raiz = "raz";
                                        } break;
                                        // Finalizado
                                        case 4: {
                                            raiz = "rc";
                                        } break;
                                        default: {
                                            raiz = "rb";
                                        }
                                    }
                                    // Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico "botao mais"
                                    String idDente = "idDente2" + String.valueOf(i);
                                    pageContext.setAttribute(idDente, dente.getId());
                                    denteId = dente.getId().toString();
                                }  // if (dente != null)
                                else {
                                    pageContext.setAttribute("idDente2" + String.valueOf(i), "S2"+String.valueOf(i)+"P");
                                    denteId = "S2"+String.valueOf(i)+"P";
                                    esquerda = "eb";
                                    direita = "db";
                                    meio = "";
                                    superior = "cb";
                                    inferior = "bb";
                                    raiz = "rb";
                                }
                            %>
                            <td align="center">
                                <%
                                    if (dente != null) {
                                %>
                                <input name="incluirProcedimento" class="botaodefaultpeq" type="button" value="+" title="Incluir procedimento / ver hist&oacute;rico" onclick="javascript:location.href='<%=request.getContextPath()%>/app/atendimentoOrcamento/incluirProcedimento.do?idBoca=${idBoca}&idDente=<%=denteId%>'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
                                    }
                                %>
                                <br>
                                <br>
                                <table border="0" width="70" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" class="<%=raiz%>" title="Raiz - <%=nome%> Superior Direito"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" class="<%=superior+"_"+esquerda+"_"+direita%>" title="Face Bucal - <%=nome%> Superior Direito"></td>
                                    </tr>
                                    <tr>
                                        <td class="<%=esquerda%>" title="Face Mesial - <%=nome%> Superior Direito"></td>
                                        <td bgcolor="<%=meio%>" title="Face Incisal - <%=nome%> Superior Direito"></td>
                                        <td class="<%=direita%>" title="Face Distal - <%=nome%> Superior Direito"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" class="<%=inferior+"_"+esquerda+"_"+direita%>" title="Face Lingual - <%=nome%> Superior Direito"></td>
                                    </tr>
                                </table>
                            </td>
                            <%
                                } // for (int i = 1; i <= 8; i++) {
                            %>
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
                        <%
                                dente = null;
                                for (int i = 1; i <= 8; i++) {
                                    dente = (Dente)request.getSession(false).getAttribute("dente3" + String.valueOf(i));
                                    switch (i) {
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

                                    if (dente.getId() !=  null) {
                                        // Face Mesial
                                        switch (dente.getFaceMesial().intValue()) {
                                            // Orcado
                                            case 1: {
                                                esquerda = "ea";
                                            } break;
                                            // Pago
                                            case 2: {
                                                esquerda = "ev";
                                            } break;
                                            // Executando
                                            case 3: {
                                                esquerda = "eaz";
                                            } break;
                                            // Finalizado
                                            case 4: {
                                                esquerda = "ec";
                                            } break;
                                            default: {
                                                esquerda = "eb";
                                            }
                                        }

                                        // Face Distal
                                        switch (dente.getFaceDistal().intValue()) {
                                            // Orcado
                                            case 1: {
                                                direita = "da";
                                            } break;
                                            // Pago
                                            case 2: {
                                                direita = "dv";
                                            } break;
                                            // Executando
                                            case 3: {
                                                direita = "daz";
                                            } break;
                                            // Finalizado
                                            case 4: {
                                                direita = "dc";
                                            } break;
                                            default: {
                                                direita = "db";
                                            }
                                        }

                                        // Face Incisal
                                        switch (dente.getFaceIncisal().intValue()) {
                                            // Orcado
                                            case 1: {
                                                meio = "#FFDD00";
                                            } break;
                                            // Pago
                                            case 2: {
                                                meio = "#87FF00";
                                            } break;
                                            // Executando
                                            case 3: {
                                                meio = "#00FFFF";
                                            } break;
                                            // Finalizado
                                            case 4: {
                                                meio = "#CDC8B1";
                                            } break;
                                            default: {
                                                meio = "";
                                            }
                                        }

                                        // Face Lingual
                                        switch (dente.getFaceLingual().intValue()) {
                                            // Orcado
                                            case 1: {
                                                superior = "ca";
                                            } break;
                                            // Pago
                                            case 2: {
                                                superior = "cv";
                                            } break;
                                            // Executando
                                            case 3: {
                                                superior = "caz";
                                            } break;
                                            // Finalizado
                                            case 4: {
                                                superior = "cc";
                                            } break;
                                            default: {
                                                superior = "cb";
                                            }
                                        }

                                        // Face Bucal
                                        switch (dente.getFaceBucal().intValue()) {
                                            // Orcado
                                            case 1: {
                                                inferior = "ba";
                                            } break;
                                            // Pago
                                            case 2: {
                                                inferior = "bv";
                                            } break;
                                            // Executando
                                            case 3: {
                                                inferior = "baz";
                                            } break;
                                            // Finalizado
                                            case 4: {
                                                inferior = "bc";
                                            } break;
                                            default: {
                                                inferior = "bb";
                                            }
                                        }

                                        // Raiz
                                        switch (dente.getRaiz().intValue()) {
                                            // Orcado
                                            case 1: {
                                                raiz = "ra";
                                            } break;
                                            // Pago
                                            case 2: {
                                                raiz = "rv";
                                            } break;
                                            // Executando
                                            case 3: {
                                                raiz = "raz";
                                            } break;
                                            // Finalizado
                                            case 4: {
                                                raiz = "rc";
                                            } break;
                                            default: {
                                                raiz = "rb";
                                            }
                                        }
                                        // Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico "botao mais"
                                        String idDente = "idDente3" + String.valueOf(i);
                                        pageContext.setAttribute(idDente, dente.getId());
                                        denteId = dente.getId().toString();
                                    }  // if (dente != null)
                                    else {
                                        pageContext.setAttribute("idDente3" + String.valueOf(i), "S3"+String.valueOf(i)+"P");
                                        denteId = "S3"+String.valueOf(i)+"P";
                                        esquerda = "eb";
                                        direita = "db";
                                        meio = "";
                                        superior = "cb";
                                        inferior = "bb";
                                        raiz = "rb";
                                    }
                            %>
                            <td align="center">
                                <%
                                    if (dente != null) {
                                %>
                                <input name="incluirProcedimento" class="botaodefaultpeq" type="button" value="+" title="Incluir procedimento / ver hist&oacute;rico" onclick="javascript:location.href='<%=request.getContextPath()%>/app/atendimentoOrcamento/incluirProcedimento.do?idBoca=${idBoca}&idDente=<%=denteId%>'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
                                    }
                                %>
                                <br>
                                <br>
                                <table border="0" width="70" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" class="<%=superior+"_"+esquerda+"_"+direita%>" title="Face Lingual - <%=nome%> Superior Direito"></td>
                                    </tr>
                                    <tr>
                                        <td class="<%=esquerda%>" title="Face Mesial - <%=nome%> Superior Direito"></td>
                                        <td bgcolor="<%=meio%>" title="Face Incisal - <%=nome%> Superior Direito"></td>
                                        <td class="<%=direita%>" title="Face Distal - <%=nome%> Superior Direito"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" class="<%=inferior+"_"+esquerda+"_"+direita%>" title="Face Bucal - <%=nome%> Superior Direito"></td>
                                    </tr>
									<tr>
                                        <td colspan="3" align="center" class="<%=raiz%>" title="Raiz - <%=nome%> Superior Direito"></td>
                                    </tr>
                                </table>
                            </td>
                            <%
                                } // for (int i = 1; i <= 8; i++) {
                            %>
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
                        <%
                                dente = null;
                                for (int i = 8; i >= 1; i--) {
                                    dente = (Dente)request.getSession(false).getAttribute("dente4" + String.valueOf(i));
                                    switch (i) {
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

                                    if (dente.getId() !=  null) {
                                        // Face Distal
                                        switch (dente.getFaceDistal().intValue()) {
                                            // Orcado
                                            case 1: {
                                                esquerda = "ea";
                                            } break;
                                            // Pago
                                            case 2: {
                                                esquerda = "ev";
                                            } break;
                                            // Executando
                                            case 3: {
                                                esquerda = "eaz";
                                            } break;
                                            // Finalizado
                                            case 4: {
                                                esquerda = "ec";
                                            } break;
                                            default: {
                                                esquerda = "eb";
                                            }
                                        }

                                        // Face Mesial
                                        switch (dente.getFaceMesial().intValue()) {
                                            // Orcado
                                            case 1: {
                                                direita = "da";
                                            } break;
                                            // Pago
                                            case 2: {
                                                direita = "dv";
                                            } break;
                                            // Executando
                                            case 3: {
                                                direita = "daz";
                                            } break;
                                            // Finalizado
                                            case 4: {
                                                direita = "dc";
                                            } break;
                                            default: {
                                                direita = "db";
                                            }
                                        }

                                        // Face Incisal
                                        switch (dente.getFaceIncisal().intValue()) {
                                            // Orcado
                                            case 1: {
                                                meio = "#FFDD00";
                                            } break;
                                            // Pago
                                            case 2: {
                                                meio = "#87FF00";
                                            } break;
                                            // Executando
                                            case 3: {
                                                meio = "#00FFFF";
                                            } break;
                                            // Finalizado
                                            case 4: {
                                                meio = "#CDC8B1";
                                            } break;
                                            default: {
                                                meio = "";
                                            }
                                        }

                                        // Face Lingual
                                        switch (dente.getFaceLingual().intValue()) {
                                            // Orcado
                                            case 1: {
                                                superior = "ca";
                                            } break;
                                            // Pago
                                            case 2: {
                                                superior = "cv";
                                            } break;
                                            // Executando
                                            case 3: {
                                                superior = "caz";
                                            } break;
                                            // Finalizado
                                            case 4: {
                                                superior = "cc";
                                            } break;
                                            default: {
                                                superior = "cb";
                                            }
                                        }

                                        // Face Bucal
                                        switch (dente.getFaceBucal().intValue()) {
                                            // Orcado
                                            case 1: {
                                                inferior = "ba";
                                            } break;
                                            // Pago
                                            case 2: {
                                                inferior = "bv";
                                            } break;
                                            // Executando
                                            case 3: {
                                                inferior = "baz";
                                            } break;
                                            // Finalizado
                                            case 4: {
                                                inferior = "bc";
                                            } break;
                                            default: {
                                                inferior = "bb";
                                            }
                                        }

                                        // Raiz
                                        switch (dente.getRaiz().intValue()) {
                                            // Orcado
                                            case 1: {
                                                raiz = "ra";
                                            } break;
                                            // Pago
                                            case 2: {
                                                raiz = "rv";
                                            } break;
                                            // Executando
                                            case 3: {
                                                raiz = "raz";
                                            } break;
                                            // Finalizado
                                            case 4: {
                                                raiz = "rc";
                                            } break;
                                            default: {
                                                raiz = "rb";
                                            }
                                        }
                                        // Coloca o id do dente no contexto da pagina para passar para action que ira mostrar o historico "botao mais"
                                        String idDente = "idDente4" + String.valueOf(i);
                                        pageContext.setAttribute(idDente, dente.getId());
                                        denteId = dente.getId().toString();
                                    }  // if (dente != null)
                                    else {
                                        pageContext.setAttribute("idDente4" + String.valueOf(i), "S4"+String.valueOf(i)+"P");
                                        denteId = "S4"+String.valueOf(i)+"P";
                                        esquerda = "eb";
                                        direita = "db";
                                        meio = "";
                                        superior = "cb";
                                        inferior = "bb";
                                        raiz = "rb";
                                    }
                            %>
                            <td align="center">
                                <%
                                    if (dente != null) {
                                %>
                                <input name="incluirProcedimento" class="botaodefaultpeq" type="button" value="+" title="Incluir procedimento / ver hist&oacute;rico" onclick="javascript:location.href='<%=request.getContextPath()%>/app/atendimentoOrcamento/incluirProcedimento.do?idBoca=${idBoca}&idDente=<%=denteId%>'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-peq.png)'">
                                <%
                                    }
                                %>
                                <br>
                                <br>
                                <table border="0" width="70" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center" class="<%=superior+"_"+esquerda+"_"+direita%>" title="Face Lingual - <%=nome%> Superior Direito"></td>
                                    </tr>
                                    <tr>
                                        <td class="<%=esquerda%>" title="Face Distal - <%=nome%> Superior Direito"></td>
                                        <td bgcolor="<%=meio%>" title="Face Incisal - <%=nome%> Superior Direito"></td>
                                        <td class="<%=direita%>" title="Face Mesial - <%=nome%> Superior Direito"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" class="<%=inferior+"_"+esquerda+"_"+direita%>" title="Face Bucal - <%=nome%> Superior Direito"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" class="<%=raiz%>" title="Raiz - <%=nome%> Superior Direito"></td>
                                    </tr>
                                </table>
                            </td>
                            <%
                                } // for (int i = 8; i >= 1; i--) {
                            %>
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
                <td style="border:none">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td style="border:none">
                    &nbsp;
                </td>
                <%
                    // Coloca o id do dente no contexto da pagina
                    pageContext.setAttribute("idPaciente", paciente.getId());
                %>
                <td class="paddingCelulaTabela" align="center" style="border:none">
                    <input name="imprimirOrcamento" class="botaodefaultextrag" type="button" value="imprimir orcamento" title="Imprimir or&ccedil;amento" onclick="javascript:location.href='<%=request.getContextPath()%>/app/atendimentoOrcamento/imprimirOrcamento.do?idPaciente=${idPaciente}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-extrag-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-extrag.png)'">
                </td>
                <td class="paddingCelulaTabela" align="center" style="border:none">
                    <input name="encerrarAtendimento" class="botaodefaultextrag" type="button" value="encerrar atendimento" title="Encerrar atendimento" onclick="javascript: if (confirmarAcao('encerrar')) location.href='<%=request.getContextPath()%>/app/atendimentoOrcamento/encerrarAtendimentoOrcamento.do?idPaciente=${idPaciente}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-extrag-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-extrag.png)'">
                </td>
                <td style="border:none">
                    &nbsp;
                </td>
            </tr>
        </table>
        <%
            } // if (paciente != null)
        %>
    </body>
</html>