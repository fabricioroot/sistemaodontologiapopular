<%-- 
    Document   : editarPaciente
    Created on : 30/01/2010, 16:45:54
    Author     : Fabricio Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="annotations.Paciente"%>
<%@page import="annotations.Funcionario"%>
<%@page import="web.login.ValidaGrupos"%>
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
<%@ include file="paciente.js"%>
<%@ include file="../utilitario.js"%>
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
            // Captura objeto paciente no request
            // Este objeto vem da pagina consultar paciente quando eh clicado o botao editar paciente.
            // Passa pelo action correspondente (EditarPacienteAction)
            Paciente paciente = (Paciente)request.getAttribute("paciente");
            if (paciente != null) {
        %>
        <form name="formPaciente" id="formPaciente" method="POST" onsubmit="return validarDados()" action="<%=request.getContextPath()%>/app/paciente/actionAtualizarPaciente.do">
            <table cellpadding="0" cellspacing="0" align="center">
                <thead>
                    <tr>
                        <th>Editar Paciente (<strong><font color="#FF0000">*</font></strong> campos obrigat&oacute;rios)</th>
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
                                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Nome:
                                            <input name="id" id="id" value="<%= paciente.getId() %>" type="hidden">
                                            <input name="filaOrcamento" id="filaOrcamento" value="<%= paciente.isFilaOrcamento() %>" type="hidden">
                                            <input name="filaTratamento" id="filaTratamento" value="<%= paciente.isFilaTratamento() %>" type="hidden">
                                            <input name="impedimento" id="impedimento" value="<%= paciente.getImpedimento() %>" type="hidden">
                                            <input name="nome" id="nome" value="<%= paciente.getNome() %>" class="letrasIniciaisMaiusculas" type="text" size="40" maxlength="250" title="Nome do paciente">
                                        </td>
                                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Sexo:
                                            <input type="radio" name="sexo" id="sexo" value="F" <%if (paciente.getSexo() == 'F') out.print("checked");%>/> Feminino
                                            <input type="radio" name="sexo" id="sexo" value="M" <%if (paciente.getSexo() == 'M') out.print("checked");%>/> Masculino
                                        </td>
                                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Data de Nascimento:
                                            <%
                                                DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                                            %>
                                            <input name="dataNascimento" id="dataNascimento" value="<%=dateFormat.format(paciente.getDataNascimento())%>" type="text" size="10" maxlength="10" title="Data de nascimento do paciente" onKeyPress="mascaraData(dataNascimento)" onblur="validarData(dataNascimento, 'dataNascimento')">
                                            <br><font size="1" color="#FF0000">Formato: dd/mm/aaaa</font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="paddingCelulaTabela" align="left">CPF:
                                            <input name="cpf" id="cpf" value="<% if (paciente.getCpf() != null) out.print(paciente.getCpf());%>" type="text" size="14" maxlength="14" title="CPF do paciente" onkeypress="mascaraCpf(cpf)" onblur="validarCpf(cpf, 'cpf')">
                                            <br><font size="1" color="#FF0000">Formato: 000.000.000-00</font>
                                        </td>
                                        <td class="paddingCelulaTabela" align="left">RG:
                                            <input name="rg" id="rg" value="<% if (paciente.getRg() != null) out.print(paciente.getRg());%>" class="letrasMaiusculas" type="text" size="15" maxlength="15" title="RG do paciente" onblur="validarRg(rg)">
                                        </td>
                                        <td class="paddingCelulaTabela" align="left">Estado Civil:
                                            <select name="estadoCivil" id="estadoCivil">
                                                <option value="" <%if (paciente.getEstadoCivil().equals("")) out.print("selected"); %>>Selecione</option>
                                                <option value="Casado(a)" <%if (paciente.getEstadoCivil().equals("Casado(a)")) out.print("selected"); %>>Casado(a)</option>
                                                <option value="Separado(a)" <%if (paciente.getEstadoCivil().equals("Separado(a)")) out.print("selected"); %>>Separado(a)</option>
                                                <option value="Solteiro(a)" <%if (paciente.getEstadoCivil().equals("Solteiro(a)")) out.print("selected"); %>>Solteiro(a)</option>
                                                <option value="Viuvo(a)" <%if (paciente.getEstadoCivil().equals("Viuvo(a)")) out.print("selected"); %>>Vi&uacute;vo(a)</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="paddingCelulaTabela" align="left">Nome do Pai:
                                            <input name="nomePai" id="nomePai" value="<% if (paciente.getNomePai() != null) out.print(paciente.getNomePai());%>" class="letrasIniciaisMaiusculas" type="text" size="40" maxlength="250" title="Nome do pai do paciente">
                                        </td>
                                        <td class="paddingCelulaTabela" align="left" colspan="2">Nome da M&atilde;e:
                                            <input name="nomeMae" id="nomeMae" value="<% if (paciente.getNomeMae() != null) out.print(paciente.getNomeMae());%>" class="letrasIniciaisMaiusculas" type="text" size="40" maxlength="250" title="Nome da m&atilde;e do paciente">
                                        </td>
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
                                        <td class="paddingCelulaTabela" width="40%" align="left"><strong><font color="#FF0000">*</font></strong>Logradouro:
                                            <input name="enderecoId" id="enderecoId" value="<%=paciente.getEndereco().getId()%>" type="hidden">
                                            <input name="logradouro" id="logradouro" value="<%=paciente.getEndereco().getLogradouro()%>" class="letrasIniciaisMaiusculas" type="text" size="40" maxlength="250">
                                        </td>
                                        <td class="paddingCelulaTabela" width="29%" align="left">N&uacute;mero:
                                            <input name="numero" id="numero" value="<%=paciente.getEndereco().getNumero()%>" class="letrasMaiusculas" type="text" size="6" maxlength="6">
                                        </td>
                                        <td class="paddingCelulaTabela" width="31%" align="left"><strong><font color="#FF0000">*</font></strong>Bairro:
                                            <input name="bairro" id="bairro" value="<%=paciente.getEndereco().getBairro()%>" class="letrasIniciaisMaiusculas" type="text" size="25" maxlength="40">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="paddingCelulaTabela" colspan="3" align="left">Complemento:
                                            <input name="complemento" id="complemento" value="<%=paciente.getEndereco().getComplemento()%>" type="text" size="80" maxlength="195">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Cidade:
                                            <input name="cidade" id="cidade" value="<%=paciente.getEndereco().getCidade()%>" class="letrasIniciaisMaiusculas" type="text" size="30" maxlength="40">
                                        </td>
                                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Estado:
                                            <select name="estado" id="estado">
                                                <option value="" <%if (paciente.getEndereco().getEstado().equals("")) out.print("selected"); %>>Selecione</option>
                                                <option value="AC" <%if (paciente.getEndereco().getEstado().equals("AC")) out.print("selected"); %>>Acre</option>
                                                <option value="AL" <%if (paciente.getEndereco().getEstado().equals("AL")) out.print("selected"); %>>Alagoas</option>
                                                <option value="AP" <%if (paciente.getEndereco().getEstado().equals("AP")) out.print("selected"); %>>Amap&aacute;</option>
                                                <option value="AM" <%if (paciente.getEndereco().getEstado().equals("AM")) out.print("selected"); %>>Amazonas</option>
                                                <option value="BA" <%if (paciente.getEndereco().getEstado().equals("BA")) out.print("selected"); %>>Bahia</option>
                                                <option value="CE" <%if (paciente.getEndereco().getEstado().equals("CE")) out.print("selected"); %>>Cear&aacute;</option>
                                                <option value="DF" <%if (paciente.getEndereco().getEstado().equals("DF")) out.print("selected"); %>>Distrito Federal</option>
                                                <option value="ES" <%if (paciente.getEndereco().getEstado().equals("ES")) out.print("selected"); %>>Esp&iacute;rito Santo</option>
                                                <option value="GO" <%if (paciente.getEndereco().getEstado().equals("GO")) out.print("selected"); %>>Goi&aacute;s</option>
                                                <option value="MA" <%if (paciente.getEndereco().getEstado().equals("MA")) out.print("selected"); %>>Maranh&atilde;o</option>
                                                <option value="MT" <%if (paciente.getEndereco().getEstado().equals("MT")) out.print("selected"); %>>Mato Grosso</option>
                                                <option value="MS" <%if (paciente.getEndereco().getEstado().equals("MS")) out.print("selected"); %>>Mato Grosso do Sul</option>
                                                <option value="MG" <%if (paciente.getEndereco().getEstado().equals("MG")) out.print("selected"); %>>Minas Gerais</option>
                                                <option value="PA" <%if (paciente.getEndereco().getEstado().equals("PA")) out.print("selected"); %>>Par&aacute;</option>
                                                <option value="PB" <%if (paciente.getEndereco().getEstado().equals("PB")) out.print("selected"); %>>Para&iacute;ba</option>
                                                <option value="PR" <%if (paciente.getEndereco().getEstado().equals("PR")) out.print("selected"); %>>Paran&aacute;</option>
                                                <option value="PE" <%if (paciente.getEndereco().getEstado().equals("PE")) out.print("selected"); %>>Pernambuco</option>
                                                <option value="PI" <%if (paciente.getEndereco().getEstado().equals("PI")) out.print("selected"); %>>Piau&iacute;</option>
                                                <option value="RJ" <%if (paciente.getEndereco().getEstado().equals("RJ")) out.print("selected"); %>>Rio de Janeiro</option>
                                                <option value="RN" <%if (paciente.getEndereco().getEstado().equals("RN")) out.print("selected"); %>>Rio Grande do Norte</option>
                                                <option value="RS" <%if (paciente.getEndereco().getEstado().equals("RS")) out.print("selected"); %>>Rio Grande do Sul</option>
                                                <option value="RO" <%if (paciente.getEndereco().getEstado().equals("RO")) out.print("selected"); %>>Rond&ocirc;nia</option>
                                                <option value="RR" <%if (paciente.getEndereco().getEstado().equals("RR")) out.print("selected"); %>>Roraima</option>
                                                <option value="SC" <%if (paciente.getEndereco().getEstado().equals("SC")) out.print("selected"); %>>Santa Catarina</option>
                                                <option value="SP" <%if (paciente.getEndereco().getEstado().equals("SP")) out.print("selected"); %>>S&atilde;o Paulo</option>
                                                <option value="SE" <%if (paciente.getEndereco().getEstado().equals("SE")) out.print("selected"); %>>Sergipe</option>
                                                <option value="TO" <%if (paciente.getEndereco().getEstado().equals("TO")) out.print("selected"); %>>Tocantis</option>
                                            </select>
                                        </td>
                                        <td class="paddingCelulaTabela" align="left">CEP:
                                            <input name="cep" id="cep" value="<%=paciente.getEndereco().getCep()%>" type="text" size="10" maxlength="10" onkeypress="mascaraCep(cep)" onblur="validarCep(cep)">
                                            <br><font size="1" color="#FF0000">Formato: 00.000-000</font>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" align="center">
                            <table>
                                <thead>
                                    <tr><th colspan="3" align="center">Contatos</th></tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="paddingCelulaTabela" align="left">Telefone Fixo:
                                            <input name="telefoneFixo" id="telefoneFixo" value="<%=paciente.getTelefoneFixo()%>" type="text" size="13" maxlength="13" onkeypress="mascaraTelefone(telefoneFixo)" onblur="validarTelefone(telefoneFixo)">
                                            <br><font size="1" color="#FF0000">Formato: (00)0000-0000</font>
                                        </td>
                                        <td class="paddingCelulaTabela" align="left">Telefone Celular:
                                            <input name="telefoneCelular" id="telefoneCelular" value="<%=paciente.getTelefoneCelular()%>" type="text" size="13" maxlength="13" onkeypress="mascaraTelefone(telefoneCelular)" onblur="validarTelefone(telefoneCelular)">
                                            <br><font size="1" color="#FF0000">Formato: (00)0000-0000</font>
                                        </td>
                                        <td class="paddingCelulaTabela" align="left">Email:
                                            <input name="email" id="email" value="<%=paciente.getEmail()%>" class="letrasMinusculas" type="text" size="40" maxlength="250" onblur="validarEmail(email)">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
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
                                        <td class="paddingCelulaTabela" align="left">
                                            <table>
                                                <tr>
                                                    <td style="border:none">
                                                        <strong><font color="#FF0000">*</font></strong>Indica&ccedil;&atilde;o:
                                                        <select name="indicacao" id="indicacao" onchange="mostrarXsumir(this.value)">
                                                            <option value="" <%if (paciente.getIndicacao().trim().isEmpty()) out.print("selected"); %>>Selecione</option>
                                                            <option value="Amigo(a)" <%if (paciente.getIndicacao().equals("Amigo(a)")) out.print("selected");%>>Amigo(a)</option>
                                                            <option value="Cartaz" <%if (paciente.getIndicacao().equals("Cartaz")) out.print("selected");%>>Cartaz</option>
                                                            <option value="Internet" <%if (paciente.getIndicacao().equals("Internet")) out.print("selected");%>>Internet</option>
                                                            <option value="Jornal" <%if (paciente.getIndicacao().equals("Jornal")) out.print("selected");%>>Jornal</option>
                                                            <option value="Outdoor" <%if (paciente.getIndicacao().equals("Outdoor")) out.print("selected");%>>Outdoor</option>
                                                            <option value="Panfleto" <%if (paciente.getIndicacao().equals("Panfleto")) out.print("selected");%>>Panfleto</option>
                                                            <option value="Radio" <%if (paciente.getIndicacao().equals("Radio")) out.print("selected");%>>R&aacute;dio</option>
                                                            <option value="Revista" <%if (paciente.getIndicacao().equals("Revista")) out.print("selected");%>>Revista</option>
                                                            <option value="Televisao" <%if (paciente.getIndicacao().equals("Televisao")) out.print("selected");%>>Televis&atilde;o</option>
                                                            <%  String selected = "";
                                                                if ((!paciente.getIndicacao().trim().isEmpty()) && (!paciente.getIndicacao().equals("Amigo(a)")) && (!paciente.getIndicacao().equals("Cartaz"))
                                                                    && (!paciente.getIndicacao().equals("Internet")) && (!paciente.getIndicacao().equals("Jornal")) && (!paciente.getIndicacao().equals("Outdoor"))
                                                                    && (!paciente.getIndicacao().equals("Panfleto")) && (!paciente.getIndicacao().equals("Radio")) && (!paciente.getIndicacao().equals("Revista"))
                                                                    && (!paciente.getIndicacao().equals("Televisao"))) {
                                                                        selected = "selected";
                                                                }
                                                            %>
                                                            <option value="selected" <%=selected%>>Outra</option>
                                                        </select>
                                                    </td>
                                                    <td style="border:none" align="left">
                                                        <div id="infoIndicacaoOutra" style="display:<%if (!selected.isEmpty()) out.print("block"); else out.print("none");%>">
                                                            <strong><font color="#FF0000">*</font></strong>Qual?&nbsp;
                                                            <input name="indicacaoOutra" id="indicacaoOutra" value="<%= paciente.getIndicacao()%>" type="text" size="20" maxlength="20">
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Status:
                                            <input type="radio" name="status" id="status" value="A" <%if (paciente.getStatus() == 'A') out.print("checked"); %>/> Ativo
                                            <input type="radio" name="status" id="status" value="I" <%if (paciente.getStatus() == 'I') out.print("checked"); %>/> Inativo
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                    	<td class="paddingCelulaTabela" align="center">
                            <table>
                                <tr>
                                    <td class="paddingCelulaTabela" align="center">
                                        <input name="salvar" class="botaodefault" type="submit" value="salvar" title="Salvar" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                    </td>
                                    <td class="paddingCelulaTabela" align="center">
                                        <input name="desfazer" class="botaodefault" type="reset" value="desfazer" title="Desfazer" onclick="javascript:mostrarXsumir(<% out.print("'" + selected + "'"); %>)" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                    </td>
                                    <td class="paddingCelulaTabela" align="center">
                                        <input name="voltar" class="botaodefault" type="button" value="voltar" title="Voltar" onclick="javascript:history.back(1)" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        <%
            } // if (paciente != null)
            else {
        %>
            <jsp:forward page="../../mensagensDeRetorno/erro.jsp?codigoMensagem=12"></jsp:forward>
        <%
            System.out.println("Falha ao exibir os dados de paciente em editar.");
            }
        %>
    </body>
</html>
