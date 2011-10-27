// Script usado para controlar/validar dados de paginas relacionadas a funcionarios
// Criado em: 20/02/2010
// Autor: Fabricio P. Reis

// Funcao usada para validar os dados obrigatorios
// e colocar letras maiusculas e minusculas nos campos adequados
function validarDados() {
    var mensagem = "Preencha corretamente os seguintes campos:";

    if (trim(document.formFuncionario.nome.value) == "") {
        mensagem = mensagem + "\n- Nome";
    }
    else {
        // Linha abaixo comentada para manter acentos
        //document.formFuncionario.nome.value = primeirasLetrasMaiusculas(retirarAcentos(trim(document.formFuncionario.nome.value)).toLowerCase());
        document.formFuncionario.nome.value = primeirasLetrasMaiusculas(trim(document.formFuncionario.nome.value).toLowerCase());
    }

    if (!document.formFuncionario.sexo[0].checked && !document.formFuncionario.sexo[1].checked) {
        mensagem = mensagem + "\n- Sexo";
    }

    if (trim(document.formFuncionario.dataNascimento.value) == "") {
        mensagem = mensagem + "\n- Data de Nascimento";
    }

    if (trim(document.formFuncionario.cargo.value) == "") {
        mensagem = mensagem + "\n- Cargo";
    }

    if (trim(document.formFuncionario.cpf.value) == "") {
        mensagem = mensagem + "\n- CPF";
    }

    if (trim(document.formFuncionario.logradouro.value) == "") {
        mensagem = mensagem + "\n- Logradouro";
    }
    else {
        // Linha abaixo comentada para manter acentos
        //document.formFuncionario.logradouro.value = primeirasLetrasMaiusculas(retirarAcentos(trim(document.formFuncionario.logradouro.value)).toLowerCase());
        document.formFuncionario.logradouro.value = primeirasLetrasMaiusculas(trim(document.formFuncionario.logradouro.value).toLowerCase());
    }

    // Numero sem acentos e/ou cedilhas
    if (trim(document.formFuncionario.numero.value) != "") {
        document.formFuncionario.numero.value = retirarAcentos(trim(document.formFuncionario.numero.value)).toUpperCase();
    }

    /* Numero deixa de ser obrigatorio
    if (trim(document.formFuncionario.numero.value) == "") {
        mensagem = mensagem + "\n- Numero";
    }
    */

    if (trim(document.formFuncionario.bairro.value) == "") {
        mensagem = mensagem + "\n- Bairro";
    }
    else {
        // Linha abaixo comentada para manter acentos
        //document.formFuncionario.bairro.value = primeirasLetrasMaiusculas(retirarAcentos(trim(document.formFuncionario.bairro.value)).toLowerCase());
        document.formFuncionario.bairro.value = primeirasLetrasMaiusculas(trim(document.formFuncionario.bairro.value).toLowerCase());
    }
    
    // Complemento sem acentos e/ou cedilhas
    if (trim(document.formFuncionario.complemento.value) != "") {
        // Linha abaixo comentada para manter acentos
        //document.formFuncionario.complemento.value = retirarAcentos(trim(document.formFuncionario.complemento.value)).toUpperCase();
        document.formFuncionario.complemento.value = trim(document.formFuncionario.complemento.value).toUpperCase();
    }

    if (trim(document.formFuncionario.cidade.value) == "") {
        mensagem = mensagem + "\n- Cidade";
    }
    else {
        // Linha abaixo comentada para manter acentos
        //document.formFuncionario.cidade.value = primeirasLetrasMaiusculas(retirarAcentos(trim(document.formFuncionario.cidade.value)).toLowerCase());
        document.formFuncionario.cidade.value = primeirasLetrasMaiusculas(trim(document.formFuncionario.cidade.value).toLowerCase());
    }

    if (trim(document.formFuncionario.estado.value) == "") {
        mensagem = mensagem + "\n- Estado";
    }

    if (trim(document.formFuncionario.nomeDeUsuario.value) == "") {
        mensagem = mensagem + "\n- Nome de usuario";
    }
    else {
        // remove 1 espaco em branco que existir
        document.formFuncionario.nomeDeUsuario.value = document.formFuncionario.nomeDeUsuario.value.replace(" ", "");
    }

    if ((trim(document.formFuncionario.senha.value) == "") && (trim(document.formFuncionario.senha2.value) == "")) {
        mensagem = mensagem + "\n- Senha";
    }
    else {
        // remove 1 espaco em branco que existir
        document.formFuncionario.senha.value = document.formFuncionario.senha.value.replace(" ", "");
    }

    if (document.formFuncionario.senha.value != document.formFuncionario.senha2.value) {
        mensagem = mensagem + "\n- As senhas digitadas nao sao iguais!";
    }

    // Frase "Esqueci Minha Senha" sem acentos e/ou cedilhas
    if (trim(document.formFuncionario.fraseEsqueciMinhaSenha.value) != "") {
        // Linha abaixo comentada para manter acentos
        //document.formFuncionario.fraseEsqueciMinhaSenha.value = primeirasLetrasMaiusculas(retirarAcentos(trim(document.formFuncionario.fraseEsqueciMinhaSenha.value)).toLowerCase());
        document.formFuncionario.fraseEsqueciMinhaSenha.value = primeirasLetrasMaiusculas(trim(document.formFuncionario.fraseEsqueciMinhaSenha.value).toLowerCase());
    }

    if (!validarCheckBoxes(document.formFuncionario.grupoAcessoAdministrador.name)) {
        mensagem = mensagem + "\n- Grupo de acesso";
    }

    if (document.formFuncionario.cargo.value == "Dentista-Tratamento") {
        if (trim(document.formFuncionario.comissaoTratamento.value) == "") {
            mensagem = mensagem + "\n- Comissao(%)";
        }
        else {
            document.formFuncionario.comissaoTratamento.value = document.formFuncionario.comissaoTratamento.value.replace(",", ".");
        }
    }

    if (document.formFuncionario.cargo.value == "Dentista-Orcamento") {
        if (trim(document.formFuncionario.comissaoOrcamento.value) == "") {
            mensagem = mensagem + "\n- Comissao(R$)";
        }
        else {
            document.formFuncionario.comissaoOrcamento.value = document.formFuncionario.comissaoOrcamento.value.replace(",", ".");
        }
    }

    if (document.formFuncionario.cargo.value == "Dentista-Orcamento-Tratamento") {
        if (trim(document.formFuncionario.comissaoOrcamentoTratamento.value) == "") {
            mensagem = mensagem + "\n- Comissao(R$)";
        }
        else {
            document.formFuncionario.comissaoOrcamentoTratamento.value = document.formFuncionario.comissaoOrcamentoTratamento.value.replace(",", ".");
        }
        if (trim(document.formFuncionario.comissaoTratamentoOrcamento.value) == "") {
            mensagem = mensagem + "\n- Comissao(%)";
        }
        else {
            document.formFuncionario.comissaoTratamentoOrcamento.value = document.formFuncionario.comissaoTratamentoOrcamento.value.replace(",", ".");
        }
    }

    // Especialidade com primeiras letras maiusculas e sem acentos e/ou cedilhas
    if (trim(document.formFuncionario.especialidadeTratamento.value) != "") {
        // Linha abaixo comentada para manter acentos
        //document.formFuncionario.especialidadeTratamento.value = primeirasLetrasMaiusculas(retirarAcentos(trim(document.formFuncionario.especialidadeTratamento.value)).toLowerCase());
        document.formFuncionario.especialidadeTratamento.value = primeirasLetrasMaiusculas(trim(document.formFuncionario.especialidadeTratamento.value).toLowerCase());
    }

    // Especialidade com primeiras letras maiusculas e sem acentos e/ou cedilhas
    if (trim(document.formFuncionario.especialidadeOrcamento.value) != "") {
        // Linha abaixo comentada para manter acentos
        //document.formFuncionario.especialidadeOrcamento.value = primeirasLetrasMaiusculas(retirarAcentos(trim(document.formFuncionario.especialidadeOrcamento.value)).toLowerCase());
        document.formFuncionario.especialidadeOrcamento.value = primeirasLetrasMaiusculas(trim(document.formFuncionario.especialidadeOrcamento.value).toLowerCase());
    }

    // Especialidade com primeiras letras maiusculas e sem acentos e/ou cedilhas
    if (trim(document.formFuncionario.especialidadeOrcamentoTratamento.value) != "") {
        // Linha abaixo comentada para manter acentos
        //document.formFuncionario.especialidadeOrcamentoTratamento.value = primeirasLetrasMaiusculas(retirarAcentos(trim(document.formFuncionario.especialidadeOrcamentoTratamento.value)).toLowerCase());
        document.formFuncionario.especialidadeOrcamentoTratamento.value = primeirasLetrasMaiusculas(trim(document.formFuncionario.especialidadeOrcamentoTratamento.value).toLowerCase());
    }

    if (mensagem == "Preencha corretamente os seguintes campos:") {
        return true;
    }
    else {
        alert(mensagem);
        goFocus('nome');
        return false;
    }
}

// Funcao usada para mostrar / sumir o div contendo Informacoes Adicionais
function mostrarXsumir(valor){
    // Dentista-Tratamento
    document.formFuncionario.croTratamento.value = "";
    document.formFuncionario.especialidadeTratamento.value = "";
    document.formFuncionario.comissaoTratamento.value = "";
    // Dentista-Orcamento
    document.formFuncionario.croOrcamento.value = "";
    document.formFuncionario.especialidadeOrcamento.value = "";
    document.formFuncionario.comissaoOrcamento.value = "";
    // Dentista-Orcamento-Tratamento
    document.formFuncionario.croOrcamentoTratamento.value = "";
    document.formFuncionario.especialidadeOrcamentoTratamento.value = "";
    document.formFuncionario.comissaoOrcamentoTratamento.value = "";
    document.formFuncionario.comissaoTratamentoOrcamento.value = "";
    if (valor == 'Dentista-Tratamento') {
        var abreDiv = document.getElementById('infoAddDentistaOrcamento');
        abreDiv.style.display = 'none';
        var abreDiv2 = document.getElementById('infoAddDentistaTratamento');
        abreDiv2.style.display = 'block';
        var abreDiv3 = document.getElementById('infoAddDentistaOrcamentoTratamento');
        abreDiv3.style.display = 'none';
        document.formFuncionario.grupoAcessoDentistaTratamento.disabled = false;
        document.formFuncionario.grupoAcessoDentistaTratamento.checked = true;
        document.formFuncionario.grupoAcessoDentistaOrcamento.checked = false;
        document.formFuncionario.grupoAcessoDentistaOrcamento.disabled = true;
    }
    else {
        if (valor == 'Dentista-Orcamento') {
            var abreDiv4 = document.getElementById('infoAddDentistaTratamento');
            abreDiv4.style.display = 'none';
            var abreDiv5 = document.getElementById('infoAddDentistaOrcamento');
            abreDiv5.style.display = 'block';
            var abreDiv6 = document.getElementById('infoAddDentistaOrcamentoTratamento');
            abreDiv6.style.display = 'none';
            document.formFuncionario.grupoAcessoDentistaOrcamento.disabled = false;
            document.formFuncionario.grupoAcessoDentistaOrcamento.checked = true;
            document.formFuncionario.grupoAcessoDentistaTratamento.checked = false;
            document.formFuncionario.grupoAcessoDentistaTratamento.disabled = true;
        }
        else {
            if (valor == 'Dentista-Orcamento-Tratamento') {
                var abreDiv7 = document.getElementById('infoAddDentistaTratamento');
                abreDiv7.style.display = 'none';
                var abreDiv8 = document.getElementById('infoAddDentistaOrcamento');
                abreDiv8.style.display = 'none';
                var abreDiv9 = document.getElementById('infoAddDentistaOrcamentoTratamento');
                abreDiv9.style.display = 'block';
                document.formFuncionario.grupoAcessoDentistaTratamento.checked = true;
                document.formFuncionario.grupoAcessoDentistaOrcamento.checked = true;
                document.formFuncionario.grupoAcessoDentistaTratamento.disabled = false;
                document.formFuncionario.grupoAcessoDentistaOrcamento.disabled = false;
             }
             else {
                var abreDiv10 = document.getElementById('infoAddDentistaTratamento');
                abreDiv10.style.display = 'none';
                var abreDiv11 = document.getElementById('infoAddDentistaOrcamento');
                abreDiv11.style.display = 'none';
                var abreDiv12 = document.getElementById('infoAddDentistaOrcamentoTratamento');
                abreDiv12.style.display = 'none';
                document.formFuncionario.grupoAcessoDentistaTratamento.checked = false;
                document.formFuncionario.grupoAcessoDentistaOrcamento.checked = false;
                document.formFuncionario.grupoAcessoDentistaTratamento.disabled = true;
                document.formFuncionario.grupoAcessoDentistaOrcamento.disabled = true;
            }
        }
    }
}

// TO DO Valida RG
// Verificar se tem letras e numeros ou soh numeros
// e retirar acentos e/ou cedilhas
function validarRg(rg) {
    if (trim(rg.value) != '') {
        document.formFuncionario.rg.value = retirarAcentos(trim(document.formFuncionario.rg.value)).toUpperCase();
    }
}

// Mascara para CEP
function mascaraCep(cep) {
        if (mascaraInteiro(cep) == false) {
        event.returnValue = false;
    }
    return formataCampo(cep, '00.000-000', event);
}

// Valida CEP
function validarCep(cep) {
    if (trim(cep.value) != '') {
        exp = /\d{2}\.\d{3}\-\d{3}/
        if (!exp.test(cep.value)) {
            alert('CEP Invalido!');
            document.formFuncionario.cep.value = "";
        }
    }
}

// Mascara para telefone
function mascaraTelefone(tel) {
    if (mascaraInteiro(tel) == false) {
        event.returnValue = false;
    }
    return formataCampo(tel, '(00)0000-0000', event);
}

// Valida telefone
function validarTelefone(telefone) {
    if (trim(telefone.value) != '') {
        campo = eval(telefone);
        exp = /\(\d{2}\)\d{4}\-\d{4}/
        if(!exp.test(campo.value)) {
            alert('Telefone Invalido!');
            campo.value = '';
        }
    }
}

// Valida email
function validarEmail(email) {
    if (trim(email.value) != '') {
        exp = /^[\w-]+(\.[\w-]+)*@(([\w-]{2,63}\.)+[A-Za-z]{2,6}|\[\d{1,3}(\.\d{1,3}){3}\])$/
        if(!exp.test(email.value)) {
            alert('E-mail Invalido!');
            document.formFuncionario.email.value = "";
        }
    }
}

// Valida nome de usuario
// Nome de usuario somente letras minusculas e sem acentos e/ou cedilhas
function validarNomeDeUsuario(nomeDeUsuario) {
    if (trim(nomeDeUsuario.value) != '') {
        document.formFuncionario.nomeDeUsuario.value = retirarAcentos(trim(document.formFuncionario.nomeDeUsuario.value)).toLowerCase();
    }
}

// Valida CRO
// Retira acentos e/ou cedilhas
function validarCro(entrada) {
    var saida = entrada;
    if (trim(entrada.value) != '') {
        saida = retirarAcentos(trim(entrada.value)).toUpperCase();
        return saida;
    }
    else {
        return '';
    }
}

// Valida senha
// TO DO: Nao permitir 'espaco'
function validarSenha(senha) {
    if (trim(senha.value) != '') {
        var senhaAux = new String(trim(senha.value));
        if (senhaAux.length < 4) {
            alert('Digite uma senha com no minimo 4 digitos!');
            document.formFuncionario.senha.value = "";
            document.formFuncionario.senha2.value = "";
        }
    }
}

// Funcao para exibir alert com opcoes de OK ou Cancelar quando o paramentro 'campo' for vazio
// Esta funcao eh usada na pagina consultarFuncionario para garantir que o usuario queira mesmo buscar todos os registros
function confirmarBuscarTodos(campo) {
    if (trim(campo.value) == '') {
        if(confirm("Tem certeza que deseja pesquisar todos os registros?\nEsta operacao pode ser demorada devido a quantidade de registros.")) {
            return true;
        }
        else {
            return false;
        }
    }
    else {
        return true;
    }
}

// Valida checkBoxes verificando se ha pelo menos um marcado
function validarCheckBoxes(campo) {
    var inputs = document.getElementsByTagName('input');
    var retorno = false;
    for( var x = 0; x < inputs.length; x++ ) {
        if(inputs[x].type == 'checkbox' && inputs[x].name == campo) {
            if(inputs[x].checked == true) {
                retorno = true;
            }
        }
    }
    return retorno;
}

// Funcao usada para marcar checkbox Dentista-Orcamento e/ou Dentista-Tratamento
function marcarCheckBox(){
    if (document.formFuncionario.cargo.value == "Dentista-Orcamento-Tratamento") {
        document.formFuncionario.grupoAcessoDentistaTratamento.checked = true;
        document.formFuncionario.grupoAcessoDentistaOrcamento.checked = true;
    }
    else {
        if (document.formFuncionario.cargo.value == "Dentista-Orcamento") {
            document.formFuncionario.grupoAcessoDentistaTratamento.checked = false;
            document.formFuncionario.grupoAcessoDentistaOrcamento.checked = true;
        }
        else {
            if (document.formFuncionario.cargo.value == "Dentista-Tratamento") {
                document.formFuncionario.grupoAcessoDentistaTratamento.checked = true;
                document.formFuncionario.grupoAcessoDentistaOrcamento.checked = false;
            }
        }
    }
}