// Script usado para controlar/validar dados de paginas relacionadas a pacientes
// Criado em: 20/02/2010
// Autor: Fabricio P. Reis

// Funcao usada para validar os dados obrigatorios
// e colocar letras maiusculas e minusculas nos campos adequados
function validarDados() {
    var mensagem = "Preencha corretamente os seguintes campos:";

    if (trim(document.formPaciente.nome.value) == "") {
        mensagem = mensagem + "\n- Nome";
    }
    else {
        // Linha abaixo comentada para manter acentos
        //document.formPaciente.nome.value = primeirasLetrasMaiusculas(retirarAcentos(trim(document.formPaciente.nome.value)).toLowerCase());
        document.formPaciente.nome.value = primeirasLetrasMaiusculas(trim(document.formPaciente.nome.value).toLowerCase());
    }

    if (!document.formPaciente.sexo[0].checked && !document.formPaciente.sexo[1].checked) {
        mensagem = mensagem + "\n- Sexo";
    }

    if (trim(document.formPaciente.dataNascimento.value) == "") {
        mensagem = mensagem + "\n- Data de Nascimento";
    }

    // Nome do pai sem acentos e/ou cedilhas
    if (trim(document.formPaciente.nomePai.value) != "") {
        // Linha abaixo comentada para manter acentos
        //document.formPaciente.nomePai.value = primeirasLetrasMaiusculas(retirarAcentos(trim(document.formPaciente.nomePai.value)).toLowerCase());
        document.formPaciente.nomePai.value = primeirasLetrasMaiusculas(trim(document.formPaciente.nomePai.value).toLowerCase());
    }

    // Nome da mae sem acentos e/ou cedilhas
    if (trim(document.formPaciente.nomeMae.value) != "") {
        // Linha abaixo comentada para manter acentos
        //document.formPaciente.nomeMae.value = primeirasLetrasMaiusculas(retirarAcentos(trim(document.formPaciente.nomeMae.value)).toLowerCase());
        document.formPaciente.nomeMae.value = primeirasLetrasMaiusculas(trim(document.formPaciente.nomeMae.value).toLowerCase());
    }

    if (trim(document.formPaciente.logradouro.value) == "") {
        mensagem = mensagem + "\n- Logradouro";
    }
    else {
        // Linha abaixo comentada para manter acentos
        //document.formPaciente.logradouro.value = primeirasLetrasMaiusculas(retirarAcentos(trim(document.formPaciente.logradouro.value)).toLowerCase());
        document.formPaciente.logradouro.value = primeirasLetrasMaiusculas(trim(document.formPaciente.logradouro.value).toLowerCase());
    }

    // Numero sem acentos e/ou cedilhas
    if (trim(document.formPaciente.numero.value) != "") {
        document.formPaciente.numero.value = retirarAcentos(trim(document.formPaciente.numero.value)).toUpperCase();
    }

    /* Numero deixa de ser obrigatorio
    if (trim(document.formPaciente.numero.value) == "") {
        mensagem = mensagem + "\n- Numero";
    }
    */

    if (trim(document.formPaciente.bairro.value) == "") {
        mensagem = mensagem + "\n- Bairro";
    }
    else {
        // Linha abaixo comentada para manter acentos
        //document.formPaciente.bairro.value = primeirasLetrasMaiusculas(retirarAcentos(trim(document.formPaciente.bairro.value)).toLowerCase());
        document.formPaciente.bairro.value = primeirasLetrasMaiusculas(trim(document.formPaciente.bairro.value).toLowerCase());
    }
    
    // Complemento sem acentos e/ou cedilhas
    if (trim(document.formPaciente.complemento.value) != "") {
        // Linha abaixo comentada para manter acentos
        //document.formPaciente.complemento.value = retirarAcentos(trim(document.formPaciente.complemento.value)).toUpperCase();
        document.formPaciente.complemento.value = trim(document.formPaciente.complemento.value).toUpperCase();
    }

    if (trim(document.formPaciente.cidade.value) == "") {
        mensagem = mensagem + "\n- Cidade";
    }
    else {
        // Linha abaixo comentada para manter acentos
        //document.formPaciente.cidade.value = primeirasLetrasMaiusculas(retirarAcentos(trim(document.formPaciente.cidade.value)).toLowerCase());
        document.formPaciente.cidade.value = primeirasLetrasMaiusculas(trim(document.formPaciente.cidade.value).toLowerCase());
    }

    if (trim(document.formPaciente.estado.value) == "") {
        mensagem = mensagem + "\n- Estado";
    }

    if (trim(document.formPaciente.indicacao.value) == "") {
        mensagem = mensagem + "\n- Indicacao";
    }

    if (document.formPaciente.indicacao.value == "selected") {
        if (trim(document.formPaciente.indicacaoOutra.value) == "") {
            mensagem = mensagem + "\n- Indicacao - Outra";
        }
        else {
            // Linha abaixo comentada para manter acentos
            //document.formPaciente.indicacaoOutra.value = primeirasLetrasMaiusculas(retirarAcentos(trim(document.formPaciente.indicacaoOutra.value)).toLowerCase());
            document.formPaciente.indicacaoOutra.value = primeirasLetrasMaiusculas(trim(document.formPaciente.indicacaoOutra.value).toLowerCase());
        }
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
    document.formPaciente.indicacaoOutra.value = "";
    var abreDiv = document.getElementById('infoIndicacaoOutra');
    if (valor == 'selected') {
        abreDiv.style.display = 'block';
    }
    else {
        abreDiv.style.display = 'none';
    }
}

// TO DO Valida RG
// Verificar se tem letras e numeros ou soh numeros
// e retirar acentos e/ou cedilhas
function validarRg(rg) {
    if (trim(rg.value) != '') {
        document.formPaciente.rg.value = retirarAcentos(trim(document.formPaciente.rg.value)).toUpperCase();
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
            document.formPaciente.cep.value = "";
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
            document.formPaciente.email.value = "";
        }
    }
}

// Funcao usada para realizar a pesquisa de acordo com a opcao de campo (nome, logradouro, cpf,...) escolhida pelo usuario
// Esta funcao eh chamada pela funcao confirmarBuscarTodos(campo, op)
function submeter(op) {
    // Seta a opcao de pesquisa escolhida para o action correspondente funcionar corretamente
    document.formPaciente.opcao.value = op;
    switch(op){
        // PESQUISAR PELO NOME
        case 0: {
            // Linha abaixo comentada para manter acentos
            //document.formPaciente.nome.value = primeirasLetrasMaiusculas(retirarAcentos(document.formPaciente.nome.value).toLowerCase());
            document.formPaciente.nome.value = primeirasLetrasMaiusculas(document.formPaciente.nome.value).toLowerCase();
            document.formPaciente.submit();
        }break;

        // PESQUISAR PELO CPF
        case 1: {
            document.formPaciente.submit();
        }break;

        // PESQUISAR PELO LOGRADOURO
        case 2:{
            // Linha abaixo comentada para manter acentos
            //document.formPaciente.logradouro.value = primeirasLetrasMaiusculas(retirarAcentos(document.formPaciente.logradouro.value).toLowerCase());
            document.formPaciente.logradouro.value = primeirasLetrasMaiusculas(document.formPaciente.logradouro.value).toLowerCase();
            document.formPaciente.submit();
        }break;

        // PESQUISAR PELO CODIGO
        case 3:{
            document.formPaciente.submit();
        }break;
    }
}

// Funcao para exibir alert com opcoes de OK ou Cancelar quando o paramentro 'campo' for vazio
// Esta funcao eh usada na pagina consultarPaciente para garantir que o usuario queira mesmo buscar todos os registros
function confirmarBuscarTodos(campo, op) {
    if ((trim(campo.value) == '') || (campo.value == null)) {
        if(confirm("Tem certeza que deseja pesquisar todos os registros?\nEsta operacao pode ser demorada devido a quantidade de registros.")) {
            submeter(op);
            return true;
        }
        else {
            return false;
        }
    }
    else {
        submeter(op);
        return true;
    }
}

// Funcao usada para manipular tecla <<enter>> no formulario de consulta
function consultarComEnter(event, campo, op) {
    var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
    if (keyCode == 13) {
        return confirmarBuscarTodos(campo, op);
    }
    else {
        return event;
    }
}

// Funcao para exibir alert com opcoes de OK ou Cancelar confirmando opcao do usuario
function confirmarAcao(acao) {
    if(confirm("Tem certeza que deseja incluir este paciente na fila de " + acao + "?")) {
        return true;
    }
    else {
        return false;
    }
}