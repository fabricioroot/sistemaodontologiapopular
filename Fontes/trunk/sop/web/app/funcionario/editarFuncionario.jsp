<%-- 
    Document   : editarFuncionario
    Created on : 30/01/2010, 16:45:54
    Author     : Fabricio Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="annotations.Funcionario"%>
<%@page import="annotations.Dentista"%>
<%@page import="web.login.ValidaGrupos"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.ArrayList"%>
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
<%@ include file="funcionario.js"%>
<%@ include file="../utilitario.js"%>
</script>

<link href="<%=request.getContextPath()%>/css/estiloGeral.css" rel="stylesheet" type="text/css">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Funcion&aacute;rios - SOP - Sistema de Odontologia Popular</title>
    </head>
    <body onload="goFocus('nome')">
        <jsp:include page="/app/cabecalho.jsp" flush="true">
            <jsp:param name="titulo" value="Funcion&aacute;rios"/>
        </jsp:include>
        <br> &nbsp;
        <br> &nbsp;
        <form name="formFuncionario" id="formFuncionario" method="POST" onsubmit="return validarDados()" action="<%=request.getContextPath()%>/app/funcionario/actionAtualizarFuncionario.do">
            <table cellpadding="0" cellspacing="0" align="center">
                <thead>
                    <tr>
                        <th>Editar Funcion&aacute;rio (<strong><font color="#FF0000">*</font></strong> campos obrigat&oacute;rios)</th>
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
        <%
            // Captura objeto funcionario ou dentista no request
            // Estes objetos vem da pagina consultar funcionario quando eh clicado o botao editar funcionario.
            // Passa pelo action correspondente (EditarFuncionarioAction)
            Funcionario funcionario = (Funcionario)request.getAttribute("funcionario");
            Dentista dentista = (Dentista)request.getAttribute("dentista");
            
            // Captura objeto nomesGrupoAcesso no request
            // Este objeto eh colocado no request por EditarFuncionarioAction
            // e eh usado para controlar os checkboxes com os grupos de acesso do usuario
            ArrayList<String> nomesGrupoAcesso = new ArrayList<String>();
            nomesGrupoAcesso = (ArrayList<String>)request.getAttribute("nomesGrupoAcesso");

            // Coloca objeto na sessao para ser usado em AtualizarFuncionarioAction
            request.getSession(false).setAttribute("funcionarioAux", funcionario);

            if (funcionario != null) {
        %>
                                    <tr>
                                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Nome:
                                            <input name="id" id="id" value="<%= funcionario.getId() %>" type="hidden">
                                            <input name="nome" id="nome" value="<%= funcionario.getNome() %>" class="letrasIniciaisMaiusculas" type="text" size="40" maxlength="250" title="Nome do funcion&aacute;rio">
                                        </td>
                                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Sexo:
                                            <input type="radio" name="sexo" id="sexo" value="F" <%if (funcionario.getSexo() == 'F') out.print("checked");%>/> Feminino
                                            <input type="radio" name="sexo" id="sexo" value="M" <%if (funcionario.getSexo() == 'M') out.print("checked");%>/> Masculino
                                        </td>
                                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Cargo:
                                            <select name="cargo" id="cargo" onchange="mostrarXsumir(this.value)">
                                                <option value="" <%if (funcionario.getCargo().equals("")) out.print("selected");%>>Selecione</option>
                                                <option value="Administrador" <%if (funcionario.getCargo().equals("Administrador")) out.print("selected");%>>Administrador(a)</option>
                                                <option value="Auxiliar Administrativo" <%if (funcionario.getCargo().equals("Auxiliar Administrativo")) out.print("selected");%>>Auxiliar Administrativo</option>
                                                <option value="Caixa" <%if (funcionario.getCargo().equals("Caixa")) out.print("selected");%>>Caixa</option>
                                                <option value="Dentista-Orcamento" <%if (funcionario.getCargo().equals("Dentista-Orcamento")) out.print("selected");%>>Dentista-Or&ccedil;amento</option>
                                                <option value="Dentista-Tratamento" <%if (funcionario.getCargo().equals("Dentista-Tratamento")) out.print("selected");%>>Dentista-Tratamento</option>
                                                <option value="Dentista-Orcamento-Tratamento" <%if (funcionario.getCargo().equals("Dentista-Orcamento-Tratamento")) out.print("selected");%>>Dentista-Or&ccedil;amento-Tratamento</option>
                                                <option value="Secretaria" <%if (funcionario.getCargo().equals("Secretaria")) out.print("selected");%>>Secret&aacute;rio(a)</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="paddingCelulaTabela" align="left">
                                            <strong><font color="#FF0000">*</font></strong>CPF: <input name="cpf" id="cpf" value="<% if (funcionario.getCpf() != null) { out.print(funcionario.getCpf()); } %>" type="text" size="14" maxlength="14" title="CPF do funcion&aacute;rio" onkeypress="mascaraCpf(cpf)" onblur="validarCpf(cpf, 'cpf')">
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;RG: <input name="rg" id="rg" value="<% if (funcionario.getRg() != null) { out.print(funcionario.getRg()); } %>" class="letrasMaiusculas" type="text" size="15" title="RG do funcion&aacute;rio" maxlength="15" onblur="validarRg(rg)">
                                            <br><font size="1" color="#FF0000">Formato: 000.000.000-00</font>
                                        </td>
                                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Data de Nascimento:
                                            <%
                                                DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                                            %>
                                            <input name="dataNascimento" id="dataNascimento" value="<%=dateFormat.format(funcionario.getDataNascimento())%>" type="text" size="10" maxlength="10" title="Data de nascimento do funcion&aacute;rio" onKeyPress="mascaraData(dataNascimento)" onblur="validarData(dataNascimento, 'dataNascimento')">
                                            <br><font size="1" color="#FF0000">Formato: dd/mm/aaaa</font>
                                        </td>
                                        <td class="paddingCelulaTabela" align="left">Estado Civil:
                                            <select name="estadoCivil" id="estadoCivil">
                                                <option value="" <%if (funcionario.getEstadoCivil().equals("")) out.print("selected"); %>>Selecione</option>
                                                <option value="Casado(a)" <%if (funcionario.getEstadoCivil().equals("Casado(a)")) out.print("selected"); %>>Casado(a)</option>
                                                <option value="Separado(a)" <%if (funcionario.getEstadoCivil().equals("Separado(a)")) out.print("selected"); %>>Separado(a)</option>
                                                <option value="Solteiro(a)" <%if (funcionario.getEstadoCivil().equals("Solteiro(a)")) out.print("selected"); %>>Solteiro(a)</option>
                                                <option value="Viuvo(a)" <%if (funcionario.getEstadoCivil().equals("Viuvo(a)")) out.print("selected"); %>>Vi&uacute;vo(a)</option>
                                            </select>
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
                                        <td class="paddingCelulaTabela" width="42%" align="left"><strong><font color="#FF0000">*</font></strong>Logradouro:
                                            <input name="enderecoId" id="enderecoId" value="<%=funcionario.getEndereco().getId()%>" type="hidden">
                                            <input name="logradouro" id="logradouro" value="<%=funcionario.getEndereco().getLogradouro()%>" class="letrasIniciaisMaiusculas" type="text" size="40" maxlength="250">
                                        </td>
                                        <td class="paddingCelulaTabela" width="23%" align="left">N&uacute;mero:
                                            <input name="numero" id="numero" value="<%=funcionario.getEndereco().getNumero()%>" class="letrasMaiusculas" type="text" size="6" maxlength="6">
                                        </td>
                                        <td class="paddingCelulaTabela" width="35%" align="left"><strong><font color="#FF0000">*</font></strong>Bairro:
                                            <input name="bairro" id="bairro" value="<%=funcionario.getEndereco().getBairro()%>" class="letrasIniciaisMaiusculas" type="text" size="25" maxlength="40">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="paddingCelulaTabela" colspan="3" align="left">Complemento:
                                            <input name="complemento" id="complemento" value="<%=funcionario.getEndereco().getComplemento()%>" type="text" size="80" maxlength="195">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Cidade:
                                            <input name="cidade" id="cidade" value="<%=funcionario.getEndereco().getCidade()%>" class="letrasIniciaisMaiusculas" type="text" size="30" maxlength="40">
                                        </td>
                                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Estado:
                                            <select name="estado" id="estado">
                                                <option value="" <%if (funcionario.getEndereco().getEstado().equals("")) out.print("selected"); %>>Selecione</option>
                                                <option value="AC" <%if (funcionario.getEndereco().getEstado().equals("AC")) out.print("selected"); %>>Acre</option>
                                                <option value="AL" <%if (funcionario.getEndereco().getEstado().equals("AL")) out.print("selected"); %>>Alagoas</option>
                                                <option value="AP" <%if (funcionario.getEndereco().getEstado().equals("AP")) out.print("selected"); %>>Amap&aacute;</option>
                                                <option value="AM" <%if (funcionario.getEndereco().getEstado().equals("AM")) out.print("selected"); %>>Amazonas</option>
                                                <option value="BA" <%if (funcionario.getEndereco().getEstado().equals("BA")) out.print("selected"); %>>Bahia</option>
                                                <option value="CE" <%if (funcionario.getEndereco().getEstado().equals("CE")) out.print("selected"); %>>Cear&aacute;</option>
                                                <option value="DF" <%if (funcionario.getEndereco().getEstado().equals("DF")) out.print("selected"); %>>Distrito Federal</option>
                                                <option value="ES" <%if (funcionario.getEndereco().getEstado().equals("ES")) out.print("selected"); %>>Esp&iacute;rito Santo</option>
                                                <option value="GO" <%if (funcionario.getEndereco().getEstado().equals("GO")) out.print("selected"); %>>Goi&aacute;s</option>
                                                <option value="MA" <%if (funcionario.getEndereco().getEstado().equals("MA")) out.print("selected"); %>>Maranh&atilde;o</option>
                                                <option value="MT" <%if (funcionario.getEndereco().getEstado().equals("MT")) out.print("selected"); %>>Mato Grosso</option>
                                                <option value="MS" <%if (funcionario.getEndereco().getEstado().equals("MS")) out.print("selected"); %>>Mato Grosso do Sul</option>
                                                <option value="MG" <%if (funcionario.getEndereco().getEstado().equals("MG")) out.print("selected"); %>>Minas Gerais</option>
                                                <option value="PA" <%if (funcionario.getEndereco().getEstado().equals("PA")) out.print("selected"); %>>Par&aacute;</option>
                                                <option value="PB" <%if (funcionario.getEndereco().getEstado().equals("PB")) out.print("selected"); %>>Para&iacute;ba</option>
                                                <option value="PR" <%if (funcionario.getEndereco().getEstado().equals("PR")) out.print("selected"); %>>Paran&aacute;</option>
                                                <option value="PE" <%if (funcionario.getEndereco().getEstado().equals("PE")) out.print("selected"); %>>Pernambuco</option>
                                                <option value="PI" <%if (funcionario.getEndereco().getEstado().equals("PI")) out.print("selected"); %>>Piau&iacute;</option>
                                                <option value="RJ" <%if (funcionario.getEndereco().getEstado().equals("RJ")) out.print("selected"); %>>Rio de Janeiro</option>
                                                <option value="RN" <%if (funcionario.getEndereco().getEstado().equals("RN")) out.print("selected"); %>>Rio Grande do Norte</option>
                                                <option value="RS" <%if (funcionario.getEndereco().getEstado().equals("RS")) out.print("selected"); %>>Rio Grande do Sul</option>
                                                <option value="RO" <%if (funcionario.getEndereco().getEstado().equals("RO")) out.print("selected"); %>>Rond&ocirc;nia</option>
                                                <option value="RR" <%if (funcionario.getEndereco().getEstado().equals("RR")) out.print("selected"); %>>Roraima</option>
                                                <option value="SC" <%if (funcionario.getEndereco().getEstado().equals("SC")) out.print("selected"); %>>Santa Catarina</option>
                                                <option value="SP" <%if (funcionario.getEndereco().getEstado().equals("SP")) out.print("selected"); %>>S&atilde;o Paulo</option>
                                                <option value="SE" <%if (funcionario.getEndereco().getEstado().equals("SE")) out.print("selected"); %>>Sergipe</option>
                                                <option value="TO" <%if (funcionario.getEndereco().getEstado().equals("TO")) out.print("selected"); %>>Tocantis</option>
                                            </select>
                                        </td>
                                        <td class="paddingCelulaTabela" align="left">CEP:
                                            <input name="cep" id="cep" value="<%=funcionario.getEndereco().getCep()%>" type="text" size="10" maxlength="10" onkeypress="mascaraCep(cep)" onblur="validarCep(cep)">
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
                                            <input name="telefoneFixo" id="telefoneFixo" value="<%=funcionario.getTelefoneFixo()%>" type="text" size="13" maxlength="13" onkeypress="mascaraTelefone(telefoneFixo)" onblur="validarTelefone(telefoneFixo)">
                                            <br><font size="1" color="#FF0000">Formato: (00)0000-0000</font>
                                        </td>
                                        <td class="paddingCelulaTabela" align="left">Telefone Celular:
                                            <input name="telefoneCelular" id="telefoneCelular" value="<%=funcionario.getTelefoneCelular()%>" type="text" size="13" maxlength="13" onkeypress="mascaraTelefone(telefoneCelular)" onblur="validarTelefone(telefoneCelular)">
                                            <br><font size="1" color="#FF0000">Formato: (00)0000-0000</font>
                                        </td>
                                        <td class="paddingCelulaTabela" align="left">Email:
                                            <input name="email" id="email" value="<%=funcionario.getEmail()%>" class="letrasMinusculas" type="text" size="40" maxlength="250" onblur="validarEmail(email)">
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
                                    <tr><th colspan="3">Sistema</th></tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="paddingCelulaTabela" width="30%" align="left"><strong><font color="#FF0000">*</font></strong>Nome de usu&aacute;rio:
                                            <input name="nomeDeUsuario" id="NomeDeUsuario" value="<%=funcionario.getNomeDeUsuario()%>" class="letrasMinusculas" type="text" size="15" maxlength="15" onblur="validarNomeDeUsuario(nomeDeUsuario)">
                                        </td>
                                        <td class="paddingCelulaTabela" width="40%" align="left">
                                            <strong><font color="#FF0000">*</font></strong>Senha: <input name="senha" id="senha" value="<%=funcionario.getSenha()%>" type="password" size="10" maxlength="10" onblur="validarSenha(senha)">&nbsp;&nbsp;&nbsp;
                                            <strong><font color="#FF0000">*</font></strong>Redigite a senha: <input name="senha2" id="senha2" value="<%=funcionario.getSenha()%>" type="password" size="10" maxlength="10">
                                            <br><font size="1" color="#FF0000">M&iacute;nimo de 4 e m&aacute;ximo de 10 d&iacute;gitos</font>
                                        </td>
                                        <td class="paddingCelulaTabela" width="30%" align="left"><strong><font color="#FF0000">*</font></strong>Status:
                                            <input type="radio" name="status" id="status" value="A" <%if (funcionario.getStatus() == 'A') out.print("checked"); %>/> Ativo
                                            <input type="radio" name="status" id="status" value="I" <%if (funcionario.getStatus() == 'I') out.print("checked"); %>/> Inativo
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="paddingCelulaTabela" width="100%" align="left" colspan="3">Frase &ldquo;Esqueci Minha Senha&rdquo;:
                                            <input name="fraseEsqueciMinhaSenha" id="fraseEsqueciMinhaSenha" value="<%=funcionario.getFraseEsqueciMinhaSenha()%>" class="letrasIniciaisMaiusculas" type="text" size="80" maxlength="195">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="paddingCelulaTabela" align="left" colspan="3"><strong><font color="#FF0000">*</font></strong>Grupo de acesso:
                                            <input type="checkbox" name="grupoAcesso" id="grupoAcessoAdministrador" value="1" <%if (nomesGrupoAcesso.contains("Administrador")) out.print("checked"); %>/>Administrador&nbsp;
                                            <input type="checkbox" name="grupoAcesso" id="grupoAcessoAdministradorTI" value="2" <%if (nomesGrupoAcesso.contains("Administrador-TI")) out.print("checked"); %>/>Adm. de TI&nbsp;
                                            <input type="checkbox" name="grupoAcesso" id="grupoAcessoCaixa" value="3" <%if (nomesGrupoAcesso.contains("Caixa")) out.print("checked"); %>/>Caixa&nbsp;
                                            <input type="checkbox" name="grupoAcesso" id="grupoAcessoDentistaOrcamento" value="4" onclick="marcarCheckBox()" <%if (nomesGrupoAcesso.contains("Dentista-Orcamento") || nomesGrupoAcesso.contains("Dentista-Orcamento-Tratamento")) out.print("checked"); else out.print("disabled"); %>/>Dentista-Or&ccedil;amento&nbsp;
                                            <input type="checkbox" name="grupoAcesso" id="grupoAcessoDentistaTratamento" value="5" onclick="marcarCheckBox()" <%if (nomesGrupoAcesso.contains("Dentista-Tratamento") || nomesGrupoAcesso.contains("Dentista-Orcamento-Tratamento")) out.print("checked"); else out.print("disabled"); %>/>Dentista-Tratamento&nbsp;
                                            <input type="checkbox" name="grupoAcesso" id="grupoAcessoFinanceiro" value="6" <%if (nomesGrupoAcesso.contains("Financeiro")) out.print("checked"); %>/>Financeiro&nbsp;
                                            <input type="checkbox" name="grupoAcesso" id="grupoAcessoRelatorio" value="7" <%if (nomesGrupoAcesso.contains("Relatorio")) out.print("checked"); %>/>Relat&oacute;rio&nbsp;
                                            <input type="checkbox" name="grupoAcesso" id="grupoAcessoSecretaria" value="8" <%if (nomesGrupoAcesso.contains("Secretaria")) out.print("checked"); %>/>Secretaria
                                            <br><font size="1" color="#FF0000">Marque no m&iacute;nimo um grupo de acesso</font>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" align="center" style="border:none">
                            <div id="infoAddDentistaTratamento" style="display:none">
                                <table>
                                    <thead>
                                        <tr>
                                            <th colspan="3">Informa&ccedil;&otilde;es Adicionais</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="paddingCelulaTabela" width="25%" align="left">CRO:
                                                <input name="croTratamento" id="croTratamento" class="letrasMaiusculas" type="text" size="12" maxlength="12" onblur="croTratamento.value=validarCro(croTratamento)">
                                            </td>
                                            <td class="paddingCelulaTabela" width="40%" align="left">Especialidade:
                                                <input name="especialidadeTratamento" id="especialidadeTratamento" class="letrasIniciaisMaiusculas" type="text" size="27" maxlength="50">
                                            </td>
                                            <td class="paddingCelulaTabela" width="35%" align="left"><strong><font color="#FF0000">*</font></strong>Comiss&atilde;o - Tratamentos(%):
                                                <input name="comissaoTratamento" id="comissaoTratamento" type="text" size="6" maxlength="6" onkeypress="return mascaraNumeroReal(comissaoTratamento, 1, 6)" onblur="validarValorReal3D(comissaoTratamento, 'comissaoTratamento')">
                                                <br><font size="1" color="#FF0000">Formato: 000.00</font>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" align="center" style="border:none">
                            <div id="infoAddDentistaOrcamento" style="display:none">
                                <table>
                                    <thead>
                                        <tr>
                                            <th colspan="3">Informa&ccedil;&otilde;es Adicionais</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="paddingCelulaTabela" width="25%" align="left">CRO:
                                                <input name="croOrcamento" id="croOrcamento" class="letrasMaiusculas" type="text" size="12" maxlength="12" onblur="croOrcamento.value=validarCro(croOrcamento)">
                                            </td>
                                            <td class="paddingCelulaTabela" width="40%" align="left">Especialidade:
                                                <input name="especialidadeOrcamento" id="especialidadeOrcamento" class="letrasIniciaisMaiusculas" type="text" size="27" maxlength="50">
                                            </td>
                                            <td class="paddingCelulaTabela" width="35%" align="left"><strong><font color="#FF0000">*</font></strong>Comiss&atilde;o - Or&ccedil;amentos(R$):
                                                <input name="comissaoOrcamento" id="comissaoOrcamento" type="text" size="6" maxlength="6" onkeypress="return mascaraNumeroReal(comissaoOrcamento, 1, 6)" onblur="validarValorReal3D(comissaoOrcamento, 'comissaoOrcamento')">
                                                <br><font size="1" color="#FF0000">Formato: 000.00</font>
                                                <input name="tipoComissao" id="tipoComissao" type="hidden" value='M'>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" align="center" style="border:none">
                            <div id="infoAddDentistaOrcamentoTratamento" style="display:none">
                                <table>
                                    <thead>
                                        <tr>
                                            <th colspan="4">Informa&ccedil;&otilde;es Adicionais</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="paddingCelulaTabela" width="16%" align="left">CRO:
                                                <input name="croOrcamentoTratamento" id="croOrcamentoTratamento" class="letrasMaiusculas" type="text" size="12" maxlength="12" onblur="croOrcamentoTratamento.value=validarCro(croOrcamentoTratamento)">
                                            </td>
                                            <td class="paddingCelulaTabela" width="30%" align="left">Especialidade:
                                                <input name="especialidadeOrcamentoTratamento" id="especialidadeOrcamentoTratamento" class="letrasIniciaisMaiusculas" type="text" size="27" maxlength="50">
                                            </td>
                                            <td class="paddingCelulaTabela" width="27%" align="left"><strong><font color="#FF0000">*</font></strong>Comiss&atilde;o - Or&ccedil;amentos(R$):
                                                <input name="comissaoOrcamentoTratamento" id="comissaoOrcamentoTratamento" type="text" size="6" maxlength="6" onkeypress="return mascaraNumeroReal(comissaoOrcamentoTratamento, 1, 6)" onblur="validarValorReal3D(comissaoOrcamentoTratamento, 'comissaoOrcamentoTratamento')">
                                                <br><font size="1" color="#FF0000">Formato: 000.00</font>
                                            </td>
                                            <td class="paddingCelulaTabela" width="27%" align="left"><strong><font color="#FF0000">*</font></strong>Comiss&atilde;o - Tratamentos(%):
                                                <input name="comissaoTratamentoOrcamento" id="comissaoTratamentoOrcamento" type="text" size="6" maxlength="6" onkeypress="return mascaraNumeroReal(comissaoTratamentoOrcamento, 1, 6)" onblur="validarValorReal3D(comissaoTratamentoOrcamento, 'comissaoTratamentoOrcamento')">
                                                <br><font size="1" color="#FF0000">Formato: 000.00</font>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                   <%-- <tr>
                    	<td class="paddingCelulaTabela" align="center">
                            <table>
                                <tr>                            
                                    <td class="paddingCelulaTabela" align="center">
                                        <input name="Cadastrar" class="botaodefault" type="submit" value="cadastrar" title="Cadastrar" onMouseOver="javascript:this.style.backgroundColor='#00EE76'" onMouseOut="javascript:this.style.backgroundColor=''">
                                    </td>
                                    <td class="paddingCelulaTabela" align="center">
                                        <input name="Limpar" class="botaodefault" type="reset" value="limpar" title="Limpar" onMouseOver="javascript:this.style.backgroundColor='#00EE76'" onMouseOut="javascript:this.style.backgroundColor=''">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form> --%>
        <%
            } // if (funcionario != null)
            else if (dentista != null) {
        %>
       <%-- <form name="formFuncionario" id="formFuncionario" method="POST" onsubmit="return validarDados()" action="actionEditarFuncionario.do">
            <table cellpadding="0" cellspacing="0" align="center">
                <thead>
                    <tr>
                        <th>Editar Funcion&aacute;rio (<strong><font color="#FF0000">*</font></strong> campos obrigat&oacute;rios)</th>
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
                                <tbody> --%>
                                    <tr>
                                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Nome:
                                            <input name="id" id="id" value="<%= dentista.getId() %>" type="hidden">
                                            <input name="nome" id="nome" value="<%= dentista.getNome() %>" class="letrasIniciaisMaiusculas" type="text" size="40" maxlength="250" title="Nome do funcion&aacute;rio">
                                        </td>
                                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Sexo:
                                            <input type="radio" name="sexo" id="sexo" value="F" <%if (dentista.getSexo() == 'F') out.print("checked");%>/> Feminino
                                            <input type="radio" name="sexo" id="sexo" value="M" <%if (dentista.getSexo() == 'M') out.print("checked");%>/> Masculino
                                        </td>
                                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Cargo:
                                            <select name="cargo" id="cargo" onchange="mostrarXsumir(this.value)">
                                                <option value="" <%if (dentista.getCargo().equals("")) out.print("selected");%>>Selecione</option>
                                                <option value="Administrador" <%if (dentista.getCargo().equals("Administrador")) out.print("selected");%>>Administrador(a)</option>
                                                <option value="Auxiliar Administrativo" <%if (dentista.getCargo().equals("Auxiliar Administrativo")) out.print("selected");%>>Auxiliar Administrativo</option>
                                                <option value="Caixa" <%if (dentista.getCargo().equals("Caixa")) out.print("selected");%>>Caixa</option>
                                                <option value="Dentista-Orcamento" <%if (dentista.getCargo().equals("Dentista-Orcamento")) out.print("selected");%>>Dentista-Or&ccedil;amento</option>
                                                <option value="Dentista-Tratamento" <%if (dentista.getCargo().equals("Dentista-Tratamento")) out.print("selected");%>>Dentista-Tratamento</option>
                                                <option value="Dentista-Orcamento-Tratamento" <%if (dentista.getCargo().equals("Dentista-Orcamento-Tratamento")) out.print("selected");%>>Dentista-Or&ccedil;amento-Tratamento</option>
                                                <option value="Secretaria" <%if (dentista.getCargo().equals("Secretaria")) out.print("selected");%>>Secret&aacute;rio(a)</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="paddingCelulaTabela" align="left">
                                            <strong><font color="#FF0000">*</font></strong>CPF: <input name="cpf" id="cpf" value="<% if (dentista.getCpf() != null) { out.print(dentista.getCpf()); } %>" type="text" size="14" title="CPF do funcion&aacute;rio" maxlength="14" onkeypress="mascaraCpf(cpf)" onblur="validarCpf(cpf, 'cpf')">
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;RG: <input name="rg" id="rg" value="<% if (dentista.getRg() != null) { out.print(dentista.getRg()); } %>" class="letrasMaiusculas" type="text" size="15" title="RG do funcion&aacute;rio" maxlength="15" onblur="validarRg(rg)">
                                            <br><font size="1" color="#FF0000">Formato: 000.000.000-00</font>
                                        </td>
                                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Data de Nascimento:
                                            <%
                                                DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                                            %>
                                            <input name="dataNascimento" id="dataNascimento" value="<%=dateFormat.format(dentista.getDataNascimento())%>" type="text" size="10" title="Data de nascimento do funcion&aacute;rio" maxlength="10" onKeyPress="mascaraData(dataNascimento)" onblur="validarData(dataNascimento, 'dataNascimento')">
                                            <br><font size="1" color="#FF0000">Formato: dd/mm/aaaa</font>
                                        </td>
                                        <td class="paddingCelulaTabela" align="left">Estado Civil:
                                            <select name="estadoCivil" id="estadoCivil">
                                                <option value="" <%if (dentista.getEstadoCivil().equals("")) out.print("selected"); %>>Selecione</option>
                                                <option value="Casado(a)" <%if (dentista.getEstadoCivil().equals("Casado(a)")) out.print("selected"); %>>Casado(a)</option>
                                                <option value="Separado(a)" <%if (dentista.getEstadoCivil().equals("Separado(a)")) out.print("selected"); %>>Separado(a)</option>
                                                <option value="Solteiro(a)" <%if (dentista.getEstadoCivil().equals("Solteiro(a)")) out.print("selected"); %>>Solteiro(a)</option>
                                                <option value="Viuvo(a)" <%if (dentista.getEstadoCivil().equals("Viuvo(a)")) out.print("selected"); %>>Vi&uacute;vo(a)</option>
                                            </select>
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
                                            <input name="enderecoId" id="enderecoId" value="<%=dentista.getEndereco().getId()%>" type="hidden">
                                            <input name="logradouro" id="logradouro" value="<%=dentista.getEndereco().getLogradouro()%>" class="letrasIniciaisMaiusculas" type="text" size="40" maxlength="250">
                                        </td>
                                        <td class="paddingCelulaTabela" width="29%" align="left">N&uacute;mero:
                                            <input name="numero" id="numero" value="<%=dentista.getEndereco().getNumero()%>" class="letrasMaiusculas" type="text" size="6" maxlength="6">
                                        </td>
                                        <td class="paddingCelulaTabela" width="31%" align="left"><strong><font color="#FF0000">*</font></strong>Bairro:
                                            <input name="bairro" id="bairro" value="<%=dentista.getEndereco().getBairro()%>" class="letrasIniciaisMaiusculas" type="text" size="25" maxlength="40">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="paddingCelulaTabela" colspan="3" align="left">Complemento:
                                            <input name="complemento" id="complemento" value="<%=dentista.getEndereco().getComplemento()%>" type="text" size="80" maxlength="195">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Cidade:
                                            <input name="cidade" id="cidade" value="<%=dentista.getEndereco().getCidade()%>" class="letrasIniciaisMaiusculas" type="text" size="30" maxlength="40">
                                        </td>
                                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Estado:
                                            <select name="estado" id="estado">
                                                <option value="" <%if (dentista.getEndereco().getEstado().equals("")) out.print("selected"); %>>Selecione</option>
                                                <option value="AC" <%if (dentista.getEndereco().getEstado().equals("AC")) out.print("selected"); %>>Acre</option>
                                                <option value="AL" <%if (dentista.getEndereco().getEstado().equals("AL")) out.print("selected"); %>>Alagoas</option>
                                                <option value="AP" <%if (dentista.getEndereco().getEstado().equals("AP")) out.print("selected"); %>>Amap&aacute;</option>
                                                <option value="AM" <%if (dentista.getEndereco().getEstado().equals("AM")) out.print("selected"); %>>Amazonas</option>
                                                <option value="BA" <%if (dentista.getEndereco().getEstado().equals("BA")) out.print("selected"); %>>Bahia</option>
                                                <option value="CE" <%if (dentista.getEndereco().getEstado().equals("CE")) out.print("selected"); %>>Cear&aacute;</option>
                                                <option value="DF" <%if (dentista.getEndereco().getEstado().equals("DF")) out.print("selected"); %>>Distrito Federal</option>
                                                <option value="ES" <%if (dentista.getEndereco().getEstado().equals("ES")) out.print("selected"); %>>Esp&iacute;rito Santo</option>
                                                <option value="GO" <%if (dentista.getEndereco().getEstado().equals("GO")) out.print("selected"); %>>Goi&aacute;s</option>
                                                <option value="MA" <%if (dentista.getEndereco().getEstado().equals("MA")) out.print("selected"); %>>Maranh&atilde;o</option>
                                                <option value="MT" <%if (dentista.getEndereco().getEstado().equals("MT")) out.print("selected"); %>>Mato Grosso</option>
                                                <option value="MS" <%if (dentista.getEndereco().getEstado().equals("MS")) out.print("selected"); %>>Mato Grosso do Sul</option>
                                                <option value="MG" <%if (dentista.getEndereco().getEstado().equals("MG")) out.print("selected"); %>>Minas Gerais</option>
                                                <option value="PA" <%if (dentista.getEndereco().getEstado().equals("PA")) out.print("selected"); %>>Par&aacute;</option>
                                                <option value="PB" <%if (dentista.getEndereco().getEstado().equals("PB")) out.print("selected"); %>>Para&iacute;ba</option>
                                                <option value="PR" <%if (dentista.getEndereco().getEstado().equals("PR")) out.print("selected"); %>>Paran&aacute;</option>
                                                <option value="PE" <%if (dentista.getEndereco().getEstado().equals("PE")) out.print("selected"); %>>Pernambuco</option>
                                                <option value="PI" <%if (dentista.getEndereco().getEstado().equals("PI")) out.print("selected"); %>>Piau&iacute;</option>
                                                <option value="RJ" <%if (dentista.getEndereco().getEstado().equals("RJ")) out.print("selected"); %>>Rio de Janeiro</option>
                                                <option value="RN" <%if (dentista.getEndereco().getEstado().equals("RN")) out.print("selected"); %>>Rio Grande do Norte</option>
                                                <option value="RS" <%if (dentista.getEndereco().getEstado().equals("RS")) out.print("selected"); %>>Rio Grande do Sul</option>
                                                <option value="RO" <%if (dentista.getEndereco().getEstado().equals("RO")) out.print("selected"); %>>Rond&ocirc;nia</option>
                                                <option value="RR" <%if (dentista.getEndereco().getEstado().equals("RR")) out.print("selected"); %>>Roraima</option>
                                                <option value="SC" <%if (dentista.getEndereco().getEstado().equals("SC")) out.print("selected"); %>>Santa Catarina</option>
                                                <option value="SP" <%if (dentista.getEndereco().getEstado().equals("SP")) out.print("selected"); %>>S&atilde;o Paulo</option>
                                                <option value="SE" <%if (dentista.getEndereco().getEstado().equals("SE")) out.print("selected"); %>>Sergipe</option>
                                                <option value="TO" <%if (dentista.getEndereco().getEstado().equals("TO")) out.print("selected"); %>>Tocantis</option>
                                            </select>
                                        </td>
                                        <td class="paddingCelulaTabela" align="left">CEP:
                                            <input name="cep" id="cep" value="<%=dentista.getEndereco().getCep()%>" type="text" size="10" maxlength="10" onkeypress="mascaraCep(cep)" onblur="validarCep(cep)">
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
                                            <input name="telefoneFixo" id="telefoneFixo" value="<%=dentista.getTelefoneFixo()%>" type="text" size="13" maxlength="13" onkeypress="mascaraTelefone(telefoneFixo)" onblur="validarTelefone(telefoneFixo)">
                                            <br><font size="1" color="#FF0000">Formato: (00)0000-0000</font>
                                        </td>
                                        <td class="paddingCelulaTabela" align="left">Telefone Celular:
                                            <input name="telefoneCelular" id="telefoneCelular" value="<%=dentista.getTelefoneCelular()%>" type="text" size="13" maxlength="13" onkeypress="mascaraTelefone(telefoneCelular)" onblur="validarTelefone(telefoneCelular)">
                                            <br><font size="1" color="#FF0000">Formato: (00)0000-0000</font>
                                        </td>
                                        <td class="paddingCelulaTabela" align="left">Email:
                                            <input name="email" id="email" value="<%=dentista.getEmail()%>" class="letrasMinusculas" type="text" size="40" maxlength="250" onblur="validarEmail(email)">
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
                                    <tr><th colspan="3">Sistema</th></tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="paddingCelulaTabela" width="30%" align="left"><strong><font color="#FF0000">*</font></strong>Nome de usu&aacute;rio:
                                            <input name="nomeDeUsuario" id="NomeDeUsuario" value="<%=dentista.getNomeDeUsuario()%>" class="letrasMinusculas" type="text" size="15" maxlength="15" onblur="validarNomeDeUsuario(nomeDeUsuario)">
                                        </td>
                                        <td class="paddingCelulaTabela" width="40%" align="left">
                                            <strong><font color="#FF0000">*</font></strong>Senha: <input name="senha" id="senha" value="<%=dentista.getSenha()%>" type="password" size="10" maxlength="10" onblur="validarSenha(senha)">&nbsp;&nbsp;&nbsp;
                                            <strong><font color="#FF0000">*</font></strong>Redigite a senha: <input name="senha2" id="senha2" value="<%=dentista.getSenha()%>" type="password" size="10" maxlength="10">
                                            <br><font size="1" color="#FF0000">M&iacute;nimo de 4 e m&aacute;ximo de 10 d&iacute;gitos</font>
                                        </td>
                                        <td class="paddingCelulaTabela" width="30%" align="left"><strong><font color="#FF0000">*</font></strong>Status:
                                            <input type="radio" name="status" id="status" value="A" <%if (dentista.getStatus() == 'A') out.print("checked"); %>/> Ativo
                                            <input type="radio" name="status" id="status" value="I" <%if (dentista.getStatus() == 'I') out.print("checked"); %>/> Inativo
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="paddingCelulaTabela" width="100%" align="left" colspan="3">Frase &ldquo;Esqueci Minha Senha&rdquo;:
                                            <input name="fraseEsqueciMinhaSenha" id="fraseEsqueciMinhaSenha" value="<%=dentista.getFraseEsqueciMinhaSenha()%>" class="letrasIniciaisMaiusculas" type="text" size="80" maxlength="195">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="paddingCelulaTabela" align="left" colspan="3"><strong><font color="#FF0000">*</font></strong>Grupo de acesso:
                                            <input type="checkbox" name="grupoAcesso" id="grupoAcessoAdministrador" value="1" <%if (nomesGrupoAcesso.contains("Administrador")) out.print("checked"); %>/>Administrador&nbsp;
                                            <input type="checkbox" name="grupoAcesso" id="grupoAcessoAdministradorTI" value="2" <%if (nomesGrupoAcesso.contains("Administrador-TI")) out.print("checked"); %>/>Adm. de TI&nbsp;
                                            <input type="checkbox" name="grupoAcesso" id="grupoAcessoCaixa" value="3" <%if (nomesGrupoAcesso.contains("Caixa")) out.print("checked"); %>/>Caixa&nbsp;
                                            <input type="checkbox" name="grupoAcesso" id="grupoAcessoDentistaOrcamento" value="4" onclick="marcarCheckBox()" <%if (nomesGrupoAcesso.contains("Dentista-Orcamento") || nomesGrupoAcesso.contains("Dentista-Orcamento-Tratamento")) out.print("checked"); %>/>Dentista-Or&ccedil;amento&nbsp;
                                            <input type="checkbox" name="grupoAcesso" id="grupoAcessoDentistaTratamento" value="5" onclick="marcarCheckBox()" <%if (nomesGrupoAcesso.contains("Dentista-Tratamento") || nomesGrupoAcesso.contains("Dentista-Orcamento-Tratamento")) out.print("checked"); %>/>Dentista-Tratamento&nbsp;
                                            <input type="checkbox" name="grupoAcesso" id="grupoAcessoFinanceiro" value="6" <%if (nomesGrupoAcesso.contains("Financeiro")) out.print("checked"); %>/>Financeiro&nbsp;
                                            <input type="checkbox" name="grupoAcesso" id="grupoAcessoRelatorio" value="7" <%if (nomesGrupoAcesso.contains("Relatorio")) out.print("checked"); %>/>Relat&oacute;rio&nbsp;
                                            <input type="checkbox" name="grupoAcesso" id="grupoAcessoSecretaria" value="8" <%if (nomesGrupoAcesso.contains("Secretaria")) out.print("checked"); %>/>Secretaria
                                            <br><font size="1" color="#FF0000">Marque no m&iacute;nimo um grupo de acesso</font>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" align="center" style="border:none">
                            <div id="infoAddDentistaTratamento" style="display:<%if (dentista.getCargo().equals("Dentista-Tratamento")) out.print("block"); else out.print("none");%>">
                                <table>
                                    <thead>
                                        <tr>
                                            <th colspan="3">Informa&ccedil;&otilde;es Adicionais</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="paddingCelulaTabela" width="25%" align="left">CRO:
                                                <input name="croTratamento" id="croTratamento" class="letrasMaiusculas" value="<% if (dentista.getCro() != null) { out.print(dentista.getCro()); } %>" type="text" size="12" maxlength="12" onblur="croTratamento.value=validarCro(croTratamento)">
                                            </td>
                                            <td class="paddingCelulaTabela" width="40%" align="left">Especialidade:
                                                <input name="especialidadeTratamento" id="especialidadeTratamento" value="<%=dentista.getEspecialidade()%>" class="letrasIniciaisMaiusculas" type="text" size="27" maxlength="50">
                                            </td>
                                            <td class="paddingCelulaTabela" width="35%" align="left"><strong><font color="#FF0000">*</font></strong>Comiss&atilde;o - Tratamentos(%):
                                                <input name="comissaoTratamento" id="comissaoTratamento" value="<%=dentista.getComissaoTratamento()%>" type="text" size="6" maxlength="6" onkeypress="return mascaraNumeroReal(comissaoTratamento, 1, 6)" onblur="validarValorReal3D(comissaoTratamento, 'comissaoTratamento')">
                                                <br><font size="1" color="#FF0000">Formato: 000.00</font>
                                                <input name="tipoComissao" id="tipoComissao" type="hidden" value='P'>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" align="center" style="border:none">
                            <div id="infoAddDentistaOrcamento" style="display:<%if (dentista.getCargo().equals("Dentista-Orcamento")) out.print("block"); else out.print("none");%>">
                                <table>
                                    <thead>
                                        <tr>
                                            <th colspan="3">Informa&ccedil;&otilde;es Adicionais</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="paddingCelulaTabela" width="25%" align="left">CRO:
                                                <input name="croOrcamento" id="croOrcamento" class="letrasMaiusculas" value="<% if (dentista.getCro() != null) { out.print(dentista.getCro()); } %>" type="text" size="12" maxlength="12" onblur="croOrcamento.value=validarCro(croOrcamento)">
                                            </td>
                                            <td class="paddingCelulaTabela" width="40%" align="left">Especialidade:
                                                <input name="especialidadeOrcamento" id="especialidadeOrcamento" value="<%=dentista.getEspecialidade()%>" class="letrasIniciaisMaiusculas" type="text" size="27" maxlength="50">
                                            </td>
                                            <td class="paddingCelulaTabela" width="35%" align="left"><strong><font color="#FF0000">*</font></strong>Comiss&atilde;o - Or&ccedil;amentos(R$):
                                                <input name="comissaoOrcamento" id="comissaoOrcamento" value="<%=dentista.getComissaoOrcamento()%>" type="text" size="6" maxlength="6" onkeypress="return mascaraNumeroReal(comissaoOrcamento, 1, 6)" onblur="validarValorReal3D(comissaoOrcamento, 'comissaoOrcamento')">
                                                <br><font size="1" color="#FF0000">Formato: 000.00</font>
                                                <input name="tipoComissao" id="tipoComissao" type="hidden" value='M'>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="paddingCelulaTabela" align="center" style="border:none">
                            <div id="infoAddDentistaOrcamentoTratamento" style="display:<%if (dentista.getCargo().equals("Dentista-Orcamento-Tratamento")) out.print("block"); else out.print("none");%>">
                                <table>
                                    <thead>
                                        <tr>
                                            <th colspan="4">Informa&ccedil;&otilde;es Adicionais</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="paddingCelulaTabela" width="16%" align="left">CRO:
                                                <input name="croOrcamentoTratamento" id="croOrcamentoTratamento" class="letrasMaiusculas" value="<% if (dentista.getCro() != null) { out.print(dentista.getCro()); } %>" type="text" size="12" maxlength="12" onblur="croOrcamentoTratamento.value=validarCro(croOrcamentoTratamento)">
                                            </td>
                                            <td class="paddingCelulaTabela" width="30%" align="left">Especialidade:
                                                <input name="especialidadeOrcamentoTratamento" id="especialidadeOrcamentoTratamento" value="<%=dentista.getEspecialidade()%>" class="letrasIniciaisMaiusculas" type="text" size="27" maxlength="50">
                                            </td>
                                            <td class="paddingCelulaTabela" width="27%" align="left"><strong><font color="#FF0000">*</font></strong>Comiss&atilde;o - Or&ccedil;amentos(R$):
                                                <input name="comissaoOrcamentoTratamento" id="comissaoOrcamentoTratamento" value="<%=dentista.getComissaoOrcamento()%>" type="text" size="6" maxlength="6" onkeypress="return mascaraNumeroReal(comissaoOrcamentoTratamento, 1, 6)" onblur="validarValorReal3D(comissaoOrcamentoTratamento, 'comissaoOrcamentoTratamento')">
                                                <br><font size="1" color="#FF0000">Formato: 000.00</font>
                                            </td>
                                            <td class="paddingCelulaTabela" width="27%" align="left"><strong><font color="#FF0000">*</font></strong>Comiss&atilde;o - Tratamentos(%):
                                                <input name="comissaoTratamentoOrcamento" id="comissaoTratamentoOrcamento" value="<%=dentista.getComissaoTratamento()%>" type="text" size="6" maxlength="6" onkeypress="return mascaraNumeroReal(comissaoTratamentoOrcamento, 1, 6)" onblur="validarValorReal3D(comissaoTratamentoOrcamento, 'comissaoTratamentoOrcamento')">
                                                <br><font size="1" color="#FF0000">Formato: 000.00</font>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
    <%
        } // else if (dentista != null)
        else {
    %>
            <jsp:forward page="../../mensagensDeRetorno/erro.jsp?codigoMensagem=12"></jsp:forward>
    <%  
        System.out.println("Falha ao exibir os dados de funcionario/dentista em editar.");
        }
    %>
                    <tr>
                    	<td class="paddingCelulaTabela" align="center">
                            <table>
                                <tr>
                                    <td class="paddingCelulaTabela" align="center" style="border-top: 1px solid #e5eff8;">
                                        <input name="salvar" class="botaodefault" type="submit" value="salvar" title="Salvar" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                    </td>
                                    <td class="paddingCelulaTabela" align="center" style="border-top: 1px solid #e5eff8;">
                                        <input name="desfazer" class="botaodefault" type="reset" value="desfazer" title="Desfazer" onclick="javascript:mostrarXsumir(<%if(funcionario != null) out.print("'" + funcionario.getCargo() + "'"); else out.print("'" + dentista.getCargo() + "'");%>)" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                    </td>
                                    <td class="paddingCelulaTabela" align="center" style="border-top: 1px solid #e5eff8;">
                                        <input name="voltar" class="botaodefault" type="button" value="voltar" title="Voltar" onclick="javascript:history.back(1)" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
    </body>
</html>