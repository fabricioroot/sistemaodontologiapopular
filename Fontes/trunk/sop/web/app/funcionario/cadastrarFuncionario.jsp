<%-- 
    Document   : cadastrarFuncionario
    Created on : 30/01/2010, 16:45:54
    Author     : Fabricio Reis
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="annotations.Funcionario"%>
<%@page import="web.login.ValidaGrupos"%>
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
    <%@include file="funcionario.js"%>
    <%@include file="../utilitario.js"%>
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
        <%
            // Marca proxima pagina
            // Usado no Action correspondente
            request.getSession(false).setAttribute("proximaPagina", request.getRequestURI().replace(".jsp", ".do"));
        %>
        <form name="formFuncionario" id="formFuncionario" method="POST" onsubmit="return validarDados()" action="<%=request.getContextPath()%>/app/funcionario/actionCadastrarFuncionario.do">
            <table cellpadding="0" cellspacing="0" align="center">
                <thead>
                    <tr>
                        <th>Cadastro de Funcion&aacute;rios (<strong><font color="#FF0000">*</font></strong> campos obrigat&oacute;rios)</th>
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
                                            <input name="nome" id="nome" class="letrasIniciaisMaiusculas" type="text" size="40" maxlength="250" title="Nome do funcion&aacute;rio">
                                        </td>
                                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Sexo:
                                            <input type="radio" name="sexo" id="sexo" value="F" checked/> Feminino
                                            <input type="radio" name="sexo" id="sexo" value="M"/> Masculino
                                        </td>
                                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Cargo:
                                            <select name="cargo" id="cargo" onchange="mostrarXsumir(this.value)">
                                                <option value="" selected>Selecione</option>
                                                <option value="Administrador">Administrador(a)</option>
                                                <option value="Auxiliar Administrativo">Auxiliar Administrativo</option>
                                                <option value="Caixa">Caixa</option>
                                                <option value="Dentista-Orcamento">Dentista-Or&ccedil;amento</option>
                                                <option value="Dentista-Tratamento">Dentista-Tratamento</option>
                                                <option value="Dentista-Orcamento-Tratamento">Dentista-Or&ccedil;amento-Tratamento</option>
                                                <option value="Secretaria">Secret&aacute;rio(a)</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="paddingCelulaTabela" align="left">
                                            <strong><font color="#FF0000">*</font></strong>CPF: <input name="cpf" id="cpf" type="text" size="14" maxlength="14" title="CPF do funcion&aacute;rio" onkeypress="mascaraCpf(cpf)" onblur="validarCpf(cpf, 'cpf')">
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;RG: <input name="rg" id="rg" class="letrasMaiusculas" type="text" size="15" maxlength="15" title="RG do funcion&aacute;rio" onblur="validarRg(rg)">
                                            <br><font size="1" color="#FF0000">Formato: 000.000.000-00</font>
                                        </td>
                                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Data de Nascimento:
                                            <input name="dataNascimento" id="dataNascimento" type="text" size="10" maxlength="10" title="Data de nascimento do funcion&aacute;rio" onKeyPress="mascaraData(dataNascimento)" onblur="validarData(dataNascimento, 'dataNascimento')">
                                            <br><font size="1" color="#FF0000">Formato: dd/mm/aaaa</font>
                                        </td>
                                        <td class="paddingCelulaTabela" align="left">Estado Civil:
                                            <select name="estadoCivil" id="estadoCivil">
                                                <option value="" selected>Selecione</option>
                                                <option value="Casado(a)">Casado(a)</option>
                                                <option value="Separado(a)">Separado(a)</option>
                                                <option value="Solteiro(a)">Solteiro(a)</option>
                                                <option value="Viuvo(a)">Vi&uacute;vo(a)</option>
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
                                            <input name="logradouro" id="logradouro" class="letrasIniciaisMaiusculas" type="text" size="40" maxlength="250">
                                        </td>
                                        <td class="paddingCelulaTabela" width="23%" align="left">N&uacute;mero:
                                            <input name="numero" id="numero" class="letrasMaiusculas" type="text" size="6" maxlength="6">
                                        </td>
                                        <td class="paddingCelulaTabela" width="35%" align="left"><strong><font color="#FF0000">*</font></strong>Bairro:
                                            <input name="bairro" id="bairro" class="letrasIniciaisMaiusculas" type="text" size="25" maxlength="40">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="paddingCelulaTabela" colspan="3" align="left">Complemento:
                                            <input name="complemento" id="complemento" type="text" size="80" maxlength="195">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Cidade:
                                            <input name="cidade" id="cidade" class="letrasIniciaisMaiusculas" type="text" size="30" maxlength="40">
                                        </td>
                                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Estado:
                                            <select name="estado" id="estado">
                                                <option value="" selected>Selecione</option>
                                                <option value="AC">Acre</option>
                                                <option value="AL">Alagoas</option>
                                                <option value="AP">Amap&aacute;</option>
                                                <option value="AM">Amazonas</option>
                                                <option value="BA">Bahia</option>
                                                <option value="CE">Cear&aacute;</option>
                                                <option value="DF">Distrito Federal</option>
                                                <option value="ES">Esp&iacute;rito Santo</option>
                                                <option value="GO">Goi&aacute;s</option>
                                                <option value="MA">Maranh&atilde;o</option>
                                                <option value="MT">Mato Grosso</option>
                                                <option value="MS">Mato Grosso do Sul</option>
                                                <option value="MG">Minas Gerais</option>
                                                <option value="PA">Par&aacute;</option>
                                                <option value="PB">Para&iacute;ba</option>
                                                <option value="PR">Paran&aacute;</option>
                                                <option value="PE">Pernambuco</option>
                                                <option value="PI">Piau&iacute;</option>
                                                <option value="RJ">Rio de Janeiro</option>
                                                <option value="RN">Rio Grande do Norte</option>
                                                <option value="RS">Rio Grande do Sul</option>
                                                <option value="RO">Rond&ocirc;nia</option>
                                                <option value="RR">Roraima</option>
                                                <option value="SC">Santa Catarina</option>
                                                <option value="SP">S&atilde;o Paulo</option>
                                                <option value="SE">Sergipe</option>
                                                <option value="TO">Tocantis</option>
                                            </select>
                                        </td>
                                        <td class="paddingCelulaTabela" align="left">CEP:
                                            <input name="cep" id="cep" type="text" size="10" maxlength="10" onkeypress="mascaraCep(cep)" onblur="validarCep(cep)">
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
                                            <input name="telefoneFixo" id="telefoneFixo" type="text" size="13" maxlength="13" onkeypress="mascaraTelefone(this)" onblur="validarTelefone(telefoneFixo)">
                                            <br><font size="1" color="#FF0000">Formato: (00)0000-0000</font>
                                        </td>
                                        <td class="paddingCelulaTabela" align="left">Telefone Celular:
                                            <input name="telefoneCelular" id="telefoneCelular" type="text" size="13" maxlength="13" onkeypress="mascaraTelefone(this)" onblur="validarTelefone(telefoneCelular)">
                                            <br><font size="1" color="#FF0000">Formato: (00)0000-0000</font>
                                        </td>
                                        <td class="paddingCelulaTabela" align="left">Email:
                                            <input name="email" id="email" class="letrasMinusculas" type="text" size="40" maxlength="250" onblur="validarEmail(email)">
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
                                            <input name="nomeDeUsuario" id="nomeDeUsuario" class="letrasMinusculas" type="text" size="15" maxlength="15" onblur="validarNomeDeUsuario(nomeDeUsuario)">
                                        </td>
                                        <td class="paddingCelulaTabela" width="40%" align="left">
                                            <strong><font color="#FF0000">*</font></strong>Senha: <input name="senha" id="senha" type="password" size="10" maxlength="10" onblur="validarSenha(senha)">&nbsp;&nbsp;&nbsp;
                                            <strong><font color="#FF0000">*</font></strong>Redigite a senha: <input name="senha2" id="senha2" type="password" size="10" maxlength="10">
                                            <br><font size="1" color="#FF0000">M&iacute;nimo de 4 e m&aacute;ximo de 10 d&iacute;gitos</font>
                                        </td>
                                        <td class="paddingCelulaTabela" width="30%" align="left"><strong><font color="#FF0000">*</font></strong>Status:
                                            <input type="radio" name="status" id="status" value="A" checked/> Ativo
                                            <input type="radio" name="status" id="status" value="I"/> Inativo
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="paddingCelulaTabela" width="100%" align="left" colspan="3">Frase &ldquo;Esqueci Minha Senha&rdquo;:
                                            <input name="fraseEsqueciMinhaSenha" id="fraseEsqueciMinhaSenha" class="letrasIniciaisMaiusculas" type="text" size="80" maxlength="195">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="paddingCelulaTabela" align="left" colspan="3"><strong><font color="#FF0000">*</font></strong>Grupos de acesso:
                                            <input type="checkbox" name="grupoAcesso" id="grupoAcessoAdministrador" value="1"/>Administrador&nbsp;
                                            <input type="checkbox" name="grupoAcesso" id="grupoAcessoAdministradorTI" value="2"/>Adm. de TI&nbsp;
                                            <input type="checkbox" name="grupoAcesso" id="grupoAcessoCaixa" value="3"/>Caixa&nbsp;
                                            <input type="checkbox" name="grupoAcesso" id="grupoAcessoDentistaOrcamento" value="4" onclick="marcarCheckBox()"/>Dentista-Or&ccedil;amento&nbsp;
                                            <input type="checkbox" name="grupoAcesso" id="grupoAcessoDentistaTratamento" value="5" onclick="marcarCheckBox()"/>Dentista-Tratamento&nbsp;
                                            <input type="checkbox" name="grupoAcesso" id="grupoAcessoFinanceiro" value="6"/>Financeiro&nbsp;
                                            <input type="checkbox" name="grupoAcesso" id="grupoAcessoRelatorio" value="7"/>Relat&oacute;rio&nbsp;
                                            <input type="checkbox" name="grupoAcesso" id="grupoAcessoSecretaria" value="8"/>Secretaria
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
                    <tr>
                        <td class="paddingCelulaTabela" align="center">
                            <table>
                                <tr>
                                    <td class="paddingCelulaTabela" align="center" style="border-top: 1px solid #e5eff8;">
                                        <input name="cadastrar" class="botaodefault" type="submit" value="cadastrar" title="Cadastrar" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                    </td>
                                    <td class="paddingCelulaTabela" align="center" style="border-top: 1px solid #e5eff8;">
                                        <input name="limpar" class="botaodefault" type="reset" value="limpar" title="Limpar" onclick="javascript:mostrarXsumir('')" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                    </td>
                                    <td class="paddingCelulaTabela" align="center" style="border-top: 1px solid #e5eff8;">
                                        <input name="cancelar" class="botaodefault" type="button" value="cancelar" title="Cancelar" onclick="javascript:window.location.href='<%=request.getContextPath()%>/main.do';" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
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
