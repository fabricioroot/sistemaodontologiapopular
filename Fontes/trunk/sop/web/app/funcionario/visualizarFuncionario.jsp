<%-- 
    Document   : visualizarFuncionario
    Created on : 30/01/2010, 16:45:54
    Author     : Fabricio Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="annotations.Funcionario"%>
<%@page import="annotations.Dentista"%>
<%@page import="annotations.GrupoAcesso"%>
<%@page import="web.login.ValidaGrupos"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Iterator"%>
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
    if(funcionarioLogado != null) {
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Administrador")){
            aux1 = true;
        }
        if (!ValidaGrupos.validaGrupo(funcionarioLogado.getGrupoAcessoSet(), "Administrador-TI")){
            aux2 = true;
        }
        if (aux1 && aux2) {
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
        <title>Funcion&aacute;rios - SOP - Sistema de Odontologia Popular</title>
    </head>
    <body onload="javascript:goFocus('voltar')">
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value="Funcion&aacute;rios"/>
        </jsp:include>
        <br> &nbsp;
        <br> &nbsp;

        <%
            // Captura objeto funcionario ou dentista do request
            // Estes objetos vem da pagina consultar funcionario quando clicado o botao visualizar
            // passando pelo action correspondente (visualizarFuncionarioAction)
            Funcionario funcionario = (Funcionario)request.getAttribute("funcionario");
            Dentista dentista = (Dentista)request.getAttribute("dentista");
        %>

        <table cellpadding="0" cellspacing="0" align="center">
            <thead>
                <tr>
                    <th>Visualizar Funcion&aacute;rio</th>
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
                                        <strong>Nome:</strong>&nbsp;<%if(funcionario != null) out.print(funcionario.getNome()); else out.print(dentista.getNome()); %>
                                    </td>
                                    <td class="paddingCelulaTabela" align="left">
                                        <strong>Sexo:</strong> <%if(funcionario != null) { if (funcionario.getSexo() == 'F') { out.print("Feminino"); } else { out.print("Masculino"); }
                                                                     } else { if (dentista.getSexo() == 'F') { out.print("Feminino"); } else { out.print("Masculino"); } }
                                                               %>
                                    </td>
                                    <td class="paddingCelulaTabela" align="left">
                                        <strong>Cargo:</strong>&nbsp;<%if(funcionario != null) out.print(funcionario.getCargo()); else out.print(dentista.getCargo()); %>
                                    </td>
                                </tr>
                                <tr>
                                    <% if (funcionario != null) {
                                            if ((funcionario.getCpf() != null) || (funcionario.getRg() != null)) { %>
                                    <td class="paddingCelulaTabela" align="left">
                                        <%if(funcionario.getCpf() != null) out.print("<strong>CPF:</strong>&nbsp;" + funcionario.getCpf() + "&nbsp;&nbsp;&nbsp;&nbsp;");%>
                                        <%if(funcionario.getRg() != null) out.print("<strong>RG:</strong>&nbsp;" + funcionario.getRg());%>
                                    </td>
                                    <%      }
                                       } else if ((dentista.getCpf() != null) || (dentista.getRg() != null)) { %>
                                    <td class="paddingCelulaTabela" align="left">
                                        <%if(dentista.getCpf() != null) out.print("<strong>CPF:</strong>&nbsp;" + dentista.getCpf() + "&nbsp;&nbsp;&nbsp;&nbsp;");%>
                                        <%if(dentista.getRg() != null) out.print("<strong>RG:</strong>&nbsp;" + dentista.getRg());%>
                                    </td>
                                    <% }
                                        DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                                        String dataNascimentoAux = "";
                                        if (funcionario != null) {
                                            dataNascimentoAux = dateFormat.format(funcionario.getDataNascimento());
                                        }
                                        else {
                                            dataNascimentoAux = dateFormat.format(dentista.getDataNascimento());
                                        }
                                    %>

                                    <td class="paddingCelulaTabela" align="left">
                                        <strong>Data de Nascimento:</strong>&nbsp;<%=dataNascimentoAux%>
                                    </td>
                                    <% if (funcionario != null) {
                                           if (!funcionario.getEstadoCivil().equals("")) { %>
                                    <td class="paddingCelulaTabela" align="left">
                                        <%out.print("<strong>Estado Civil:</strong>&nbsp;" + funcionario.getEstadoCivil());%>
                                    </td>
                                    <%     }
                                       } else if(!dentista.getEstadoCivil().equals("")) { %>
                                    <td class="paddingCelulaTabela" align="left">
                                        <%out.print("<strong>Estado Civil:</strong>&nbsp;" + dentista.getEstadoCivil());%>
                                    </td>
                                    <% } %>
                                </tr>
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
                                    <td class="paddingCelulaTabela" width="42%" align="left">
                                        <strong>Logradouro:</strong>&nbsp;<%if(funcionario != null) out.print(funcionario.getEndereco().getLogradouro()); else out.print(dentista.getEndereco().getLogradouro()); %>
                                    </td>
                                    <td class="paddingCelulaTabela" width="23%" align="left">
                                        <strong>N&uacute;mero:</strong>&nbsp;<%if(funcionario != null) out.print(funcionario.getEndereco().getNumero()); else out.print(dentista.getEndereco().getNumero()); %>
                                    </td>
                                    <td class="paddingCelulaTabela" width="35%" align="left">
                                        <strong>Bairro:</strong>&nbsp;<%if(funcionario != null) out.print(funcionario.getEndereco().getBairro()); else out.print(dentista.getEndereco().getBairro()); %>
                                    </td>
                                </tr>
                                <tr>
                                    <% if (funcionario != null) {
                                           if (!funcionario.getEndereco().getComplemento().equals("")) { %>
                                    <td class="paddingCelulaTabela" align="left" colspan="3">
                                        <% out.print("<strong>Complemento:</strong>&nbsp;" + funcionario.getEndereco().getComplemento());%>
                                    </td>
                                    <%     }
                                        } else if (!dentista.getEndereco().getComplemento().equals("")) { %>
                                    <td class="paddingCelulaTabela" align="left" colspan="3">
                                        <%out.print("<strong>Complemento:</strong>&nbsp;" + dentista.getEndereco().getComplemento());%>
                                    </td>
                                    <% } %>
                                </tr>
                                <tr>
                                    <td class="paddingCelulaTabela" align="left">
                                        <strong>Cidade:</strong>&nbsp;<%if(funcionario != null) out.print(funcionario.getEndereco().getCidade()); else out.print(dentista.getEndereco().getCidade()); %>
                                    </td>
                                    <td class="paddingCelulaTabela" align="left">
                                        <strong>Estado:</strong>&nbsp;<%if(funcionario != null) out.print(funcionario.getEndereco().getEstado()); else out.print(dentista.getEndereco().getEstado()); %>
                                    </td>
                                    <% if(funcionario != null) {
                                           if (!funcionario.getEndereco().getCep().equals("")) { %>
                                    <td class="paddingCelulaTabela" align="left">
                                        <%out.print("<strong>CEP:</strong>&nbsp;" + funcionario.getEndereco().getCep());%>
                                    </td>
                                    <%     }
                                        } else if(!dentista.getEndereco().getCep().equals("")) { %>
                                    <td class="paddingCelulaTabela" align="left">
                                        <%out.print("<strong>CEP:</strong>&nbsp;" + dentista.getEndereco().getCep());%>
                                    </td>
                                    <% } %>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <%
                    if (funcionario != null) {
                        if ((!funcionario.getTelefoneFixo().equals("")) || (!funcionario.getTelefoneCelular().equals("")) || (!funcionario.getEmail().equals(""))) {
                %>
                <tr>
                    <td class="paddingCelulaTabela" align="center">
                        <table>
                            <thead>
                                <tr><th colspan="3" align="center">Contatos</th></tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <%  if (!funcionario.getTelefoneFixo().equals("")) { %>
                                    <td class="paddingCelulaTabela" align="left">
                                        <%out.print("<strong>Telefone Fixo:</strong>&nbsp;" + funcionario.getTelefoneFixo());%>
                                    </td>
                                    <%  }
                                        if (!funcionario.getTelefoneCelular().equals("")) { %>
                                    <td class="paddingCelulaTabela" align="left">
                                        <%out.print("<strong>Telefone Celular:</strong>&nbsp;" + funcionario.getTelefoneCelular());%>
                                    </td>
                                    <%  }
                                        if (!funcionario.getEmail().equals("")) { %>
                                    <td class="paddingCelulaTabela" align="left">
                                        <%out.print("<strong>Email:</strong>&nbsp;" + funcionario.getEmail());%>
                                    </td>
                                    <%  } %>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <%
                        } // if ((!funcionario.getTelefoneFixo().equals("")) || ...
                    } // if (funcionario != null)
                    else {
                        if (dentista != null) {
                            if ((!dentista.getTelefoneFixo().equals("")) || (!dentista.getTelefoneCelular().equals("")) || (!dentista.getEmail().equals(""))) {
                %>
                <tr>
                    <td class="paddingCelulaTabela" align="center">
                        <table>
                            <thead>
                                <tr><th colspan="3" align="center">Contatos</th></tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <%  if (!dentista.getTelefoneFixo().equals("")) { %>
                                    <td class="paddingCelulaTabela" align="left">
                                        <%out.print("<strong>Telefone Fixo:</strong>&nbsp;" + dentista.getTelefoneFixo());%>
                                    </td>
                                    <%  }
                                        if (!dentista.getTelefoneCelular().equals("")) { %>
                                    <td class="paddingCelulaTabela" align="left">
                                        <%out.print("<strong>Telefone Celular:</strong>&nbsp;" + dentista.getTelefoneCelular());%>
                                    </td>
                                    <%  }
                                        if (!dentista.getEmail().equals("")) { %>
                                    <td class="paddingCelulaTabela" align="left">
                                        <%out.print("<strong>Email:</strong>&nbsp;" + dentista.getEmail());%>
                                    </td>
                                    <%  } %>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <%
                            } // if ((!dentista.getTelefoneFixo().equals("")) || ...
                        } // if (dentista != null) {
                    } // else - // if (funcionario != null)
                %>
                <tr>
                    <td class="paddingCelulaTabela" align="center">
                        <table>
                            <thead>
                                <tr><th colspan="3">Sistema</th></tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="paddingCelulaTabela" align="left">
                                        <strong>Nome de usu&aacute;rio:</strong>&nbsp;<%if(funcionario != null) out.print(funcionario.getNomeDeUsuario()); else out.print(dentista.getNomeDeUsuario()); %>
                                    </td>
                                    <td class="paddingCelulaTabela" align="left">
                                        <strong>Status:</strong>&nbsp;<%if(funcionario != null) { if (funcionario.getStatus() == 'A') { out.print("<font color='#00CC00'><strong>Ativo</strong></font>"); } else { out.print("<font color='#d42945'><strong>Inativo</strong></font>"); }
                                                                            } else { if (dentista.getStatus() == 'A') { out.print("<font color='#00CC00'><strong>Ativo</strong></font>"); } else { out.print("<font color='#d42945'><strong>Inativo</strong></font>"); } }
                                                                      %>
                                    </td>
                                    <td class="paddingCelulaTabela" align="left">
                                        <strong>Grupos de acesso:</strong>&nbsp;
                                        <%  Set<GrupoAcesso> grupoAcessoSet;
                                            // Marca grupoAcessoSet para funcionario
                                            if(funcionario != null) {
                                                grupoAcessoSet = funcionario.getGrupoAcessoSet();
                                            }
                                            else { // ... ou para dentista
                                                grupoAcessoSet = dentista.getGrupoAcessoSet();
                                            }

                                            // Laco printando os nomes dos grupos de acesso
                                            if (grupoAcessoSet != null) {
                                                Iterator iterator = grupoAcessoSet.iterator();
                                                while (iterator.hasNext()) {
                                                    GrupoAcesso grupoAcesso = (GrupoAcesso) iterator.next();
                                                    if (iterator.hasNext()) {
                                                        out.print(grupoAcesso.getNome() + "&nbsp;<strong>|</strong>&nbsp;");
                                                    }
                                                    else {
                                                        out.print(grupoAcesso.getNome());
                                                    }
                                                }
                                            }
                                        %>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="paddingCelulaTabela" width="100%" align="left" colspan="3">
                                        <strong>Frase &ldquo;Esqueci Minha Senha&rdquo;:</strong>&nbsp;<%if(funcionario != null) out.print(funcionario.getFraseEsqueciMinhaSenha()); else out.print(dentista.getFraseEsqueciMinhaSenha()); %>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <% if (dentista != null) { %>
                <tr>
                    <td class="paddingCelulaTabela" align="center">
                        <table>
                            <thead>
                                <tr>
                                    <th colspan="3">Informa&ccedil;&otilde;es Adicionais</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <% if(dentista.getCro() != null) { %>
                                    <td class="paddingCelulaTabela" align="left">
                                        <strong>CRO:</strong>&nbsp;<%out.print(dentista.getCro());%>
                                    </td>
                                    <% }
                                       if(!dentista.getEspecialidade().equals("")) { %>
                                    <td class="paddingCelulaTabela" align="left">
                                        <strong>Especialidade:</strong>&nbsp;<%out.print(dentista.getEspecialidade());%>
                                    </td>
                                    <% } %>
                                    <td class="paddingCelulaTabela" align="left">
                                        <%  DecimalFormat decimalFormat = new DecimalFormat("0.00");
                                            if (dentista.getComissaoOrcamento() == Double.parseDouble("0.0")) {
                                                if(dentista.getCargo().equals("Dentista-Orcamento-Tratamento")) {
                                                    out.print("<strong>Comiss&atilde;o - Or&ccedil;amentos(R$):</strong>&nbsp;N&atilde;o tem");
                                                }
                                                if(dentista.getCargo().equals("Dentista-Orcamento")) {
                                                    out.print("<strong>Comiss&atilde;o - Or&ccedil;amentos(R$):</strong>&nbsp;N&atilde;o tem");
                                                }
                                            }
                                            if (dentista.getComissaoTratamento() == Double.parseDouble("0.0")) {
                                                if(dentista.getCargo().equals("Dentista-Orcamento-Tratamento")) {
                                                    out.print("<strong>&nbsp;|&nbsp;Comiss&atilde;o - Tratamentos(%):</strong>&nbsp;N&atilde;o tem");
                                                }
                                                if(dentista.getCargo().equals("Dentista-Tratamento")) {
                                                    out.print("<strong>Comiss&atilde;o - Tratamentos(%):</strong>&nbsp;N&atilde;o tem");
                                                }
                                            }
                                            if (dentista.getComissaoOrcamento() != Double.parseDouble("0.0")) {
                                                if(dentista.getCargo().equals("Dentista-Orcamento")) {
                                                    out.print("<strong>Comiss&atilde;o - Or&ccedil;amentos(R$):</strong>&nbsp;" + decimalFormat.format(dentista.getComissaoOrcamento()));
                                                }
                                                if(dentista.getCargo().equals("Dentista-Orcamento-Tratamento")) {
                                                    out.print("<strong>Comiss&atilde;o - Or&ccedil;amentos(R$):</strong>&nbsp;" + decimalFormat.format(dentista.getComissaoOrcamento()));
                                                }
                                            }
                                            if (dentista.getComissaoTratamento() != Double.parseDouble("0.0")) {
                                                if(dentista.getCargo().equals("Dentista-Tratamento")) {
                                                    out.print("<strong>Comiss&atilde;o - Tratamentos(%):</strong>&nbsp;" + decimalFormat.format(dentista.getComissaoTratamento()));
                                                }
                                                if(dentista.getCargo().equals("Dentista-Orcamento-Tratamento")) {
                                                    out.print("<strong>&nbsp;|&nbsp;Comiss&atilde;o - Tratamentos(%):</strong>&nbsp;" + decimalFormat.format(dentista.getComissaoTratamento()));
                                                }
                                            }
                                        %>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <% } %>
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
                                    String idFuncionario = "";
                                    if (funcionario != null) {
                                        idFuncionario = funcionario.getId().toString();
                                    } else
                                        if (dentista != null) {
                                            idFuncionario = dentista.getId().toString();
                                        }
                                    pageContext.setAttribute("idFuncionario", idFuncionario);
                                %>
                                <td class="paddingCelulaTabela" align="center" width="50%" style="border-bottom:none; border-left:none;">
                                    <input name="editar" class="botaodefault" type="button" value="editar" title="Editar" onclick="javascript:location.href='<%=request.getContextPath()%>/app/funcionario/actionEditarFuncionario.do?idFuncionario=${idFuncionario}'" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                </td>
                                <%
                                    String URLProximaPagina = (String)request.getSession(false).getAttribute("proximaPagina");
                                    String texto = "Voltar";
                                    Boolean botaoFinalizar = (Boolean)request.getAttribute("botaoFinalizar");
                                    if (botaoFinalizar != null) texto = "Finalizar";
                                %>
                                <td class="paddingCelulaTabela" align="center" width="50%" style="border-right:none; border-left:none; border-bottom:none;">
                                    <input name="voltar" id="voltar" class="botaodefault" type="button" value="<%=texto.toLowerCase()%>" title="<%=texto%>" onclick="javascript:<% if (botaoFinalizar != null) out.print("location.href='" + URLProximaPagina + "'"); else out.print("history.back(1)");  %>" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
    </body>
</html>
