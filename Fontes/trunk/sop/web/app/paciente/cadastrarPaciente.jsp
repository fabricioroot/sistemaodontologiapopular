<%-- 
    Document   : cadastrarPaciente
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
    <%@include file="paciente.js"%>
    <%@include file="../utilitario.js"%>
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
            // Marca proxima pagina
            // Usado no Action correspondente
            request.getSession(false).setAttribute("proximaPagina", request.getRequestURI().replace(".jsp", ".do"));
        %>
        <form name="formPaciente" id="formPaciente" method="POST" onsubmit="return validarDados()" action="<%=request.getContextPath()%>/app/paciente/actionCadastrarPaciente.do">
            <table cellpadding="0" cellspacing="0" align="center">
                <thead>
                    <tr>
                        <th>Cadastro de Pacientes (<strong><font color="#FF0000">*</font></strong> campos obrigat&oacute;rios)</th>
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
                                            <input name="nome" id="nome" class="letrasIniciaisMaiusculas" type="text" size="40" maxlength="250" title="Nome do paciente">
                                        </td>
                                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Sexo:
                                            <input type="radio" name="sexo" id="sexo" value="F" checked/> Feminino
                                            <input type="radio" name="sexo" id="sexo" value="M"/> Masculino
                                        </td>
                                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Data de Nascimento:
                                            <input name="dataNascimento" id="dataNascimento" type="text" size="10" maxlength="10" title="Data de nascimento do paciente" onKeyPress="mascaraData(dataNascimento)" onblur="validarData(dataNascimento, 'dataNascimento')">
                                            <br><font size="1" color="#FF0000">Formato: dd/mm/aaaa</font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="paddingCelulaTabela" align="left">CPF:
                                            <input name="cpf" id="cpf" type="text" size="14" maxlength="14" title="CPF do paciente" onkeypress="mascaraCpf(cpf)" onblur="validarCpf(cpf, 'cpf')">
                                            <br><font size="1" color="#FF0000">Formato: 000.000.000-00</font>
                                        </td>
                                        <td class="paddingCelulaTabela" align="left">RG:
                                            <input name="rg" id="rg" class="letrasMaiusculas" type="text" size="15" maxlength="15" title="RG do paciente" onblur="validarRg(rg)">
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
                                    <tr>
                                        <td class="paddingCelulaTabela" align="left">Nome do Pai:
                                            <input name="nomePai" id="nomePai" class="letrasIniciaisMaiusculas" type="text" size="40" maxlength="250" title="Nome do pai do paciente">
                                        </td>
                                        <td class="paddingCelulaTabela" align="left" colspan="2">Nome da M&atilde;e:
                                            <input name="nomeMae" id="nomeMae" class="letrasIniciaisMaiusculas" type="text" size="40" maxlength="250" title="Nome da m&atilde;e do paciente">
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
                                            <input name="logradouro" id="logradouro" class="letrasIniciaisMaiusculas" type="text" size="40" maxlength="250">
                                        </td>
                                        <td class="paddingCelulaTabela" width="29%" align="left">N&uacute;mero:
                                            <input name="numero" id="numero" class="letrasMaiusculas" type="text" size="6" maxlength="6">
                                        </td>
                                        <td class="paddingCelulaTabela" width="31%" align="left"><strong><font color="#FF0000">*</font></strong>Bairro:
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
                                            <input name="telefoneFixo" id="telefoneFixo" type="text" size="13" maxlength="13" onkeypress="mascaraTelefone(telefoneFixo)" onblur="validarTelefone(telefoneFixo)">
                                            <br><font size="1" color="#FF0000">Formato: (00)0000-0000</font>
                                        </td>
                                        <td class="paddingCelulaTabela" align="left">Telefone Celular:
                                            <input name="telefoneCelular" id="telefoneCelular" type="text" size="13" maxlength="13" onkeypress="mascaraTelefone(telefoneCelular)" onblur="validarTelefone(telefoneCelular)">
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
                                                            <option value="" selected>Selecione</option>
                                                            <option value="Amigo(a)">Amigo(a)</option>
                                                            <option value="Cartaz">Cartaz</option>
                                                            <option value="Internet">Internet</option>
                                                            <option value="Jornal">Jornal</option>
                                                            <option value="Outdoor">Outdoor</option>
                                                            <option value="Panfleto">Panfleto</option>
                                                            <option value="Radio">R&aacute;dio</option>
                                                            <option value="Revista">Revista</option>
                                                            <option value="Televisao">Televis&atilde;o</option>
                                                            <option value="selected">Outra</option>
                                                        </select>
                                                    </td>
                                                    <td style="border:none" align="left">
                                                        <div id="infoIndicacaoOutra" style="display:none">
                                                            <strong><font color="#FF0000">*</font></strong>Qual?&nbsp;
                                                            <input name="indicacaoOutra" id="indicacaoOutra" type="text" size="20" maxlength="20">
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="paddingCelulaTabela" align="left"><strong><font color="#FF0000">*</font></strong>Status:
                                            <input type="radio" name="status" id="status" value="A" checked /> Ativo
                                            <input type="radio" name="status" id="status" value="I" /> Inativo
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
                                        <input name="cadastrar" class="botaodefault" type="submit" value="cadastrar" title="Cadastrar" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                    </td>
                                    <td class="paddingCelulaTabela" align="center">
                                        <input name="limpar" class="botaodefault" type="reset" value="limpar" title="Limpar" onclick="javascript:mostrarXsumir('')" onMouseOver="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med-over.png)'" onMouseOut="javascript:this.style.background='url(<%=request.getContextPath()%>/imagens/bgbt-med.png)'">
                                    </td>
                                    <td class="paddingCelulaTabela" align="center">
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
