// Script usado para controlar/validar dados de paginas relacionadas a cheques bancarios
// Criado em: 20/02/2010
// Autor: Fabricio P. Reis

// Funcao usada para validar os dados obrigatorios
// e colocar letras maiusculas e minusculas nos campos adequados
function validarDados() {
    var mensagem = "Preencha corretamente os seguintes campos:";

    if (trim(document.formChequeBancario.nomeTitular.value) == "") {
        mensagem = mensagem + "\n- Nome do Titular";
    }
    else {
        // Linha abaixo comentada para manter acentos
        //document.formChequeBancario.nomeTitular.value = primeirasLetrasMaiusculas(retirarAcentos(trim(document.formChequeBancario.nomeTitular.value)).toLowerCase());
        document.formChequeBancario.nomeTitular.value = primeirasLetrasMaiusculas(trim(document.formChequeBancario.nomeTitular.value).toLowerCase());
    }

    if (trim(document.formChequeBancario.cpfTitular.value) == "") {
        mensagem = mensagem + "\n- CPF do Titular";
    }

    if (trim(document.formChequeBancario.banco.value) == "") {
        mensagem = mensagem + "\n- Banco";
    }
    else {
        if (document.formChequeBancario.banco.value == "selected") {
            if (trim(document.formChequeBancario.outroBanco.value) == "") {
                mensagem = mensagem + "\n- Banco - Outro";
            }
            else {
                // Linha abaixo comentada para manter acentos
                //document.formChequeBancario.outroBanco.value = primeirasLetrasMaiusculas(retirarAcentos(trim(document.formChequeBancario.outroBanco.value).toLowerCase()));
                document.formChequeBancario.outroBanco.value = primeirasLetrasMaiusculas(trim(document.formChequeBancario.outroBanco.value).toLowerCase());
            }
        }
    }

    if (trim(document.formChequeBancario.numero.value) == "") {
        mensagem = mensagem + "\n- Numero";
    }
    else {
        document.formChequeBancario.numero.value = retirarAcentos(trim(document.formChequeBancario.numero.value)).toUpperCase();
    }

    if (trim(document.formChequeBancario.valor.value) == "" || parseFloat(trim(document.formChequeBancario.valor.value)) <= parseFloat("0")) {
        mensagem = mensagem + "\n- Valor (R$)";
    }

    if (trim(document.formChequeBancario.dataParaDepositar.value) == "") {
        mensagem = mensagem + "\n- Data para Depositar";
    }

    if (mensagem == "Preencha corretamente os seguintes campos:") {
        return true;
    }
    else {
        alert(mensagem);
        goFocus('nomeTitular');
        return false;
    }
}

// Funcao usada para validar os dados obrigatorios
// e colocar letras maiusculas e minusculas nos campos adequados na edicao de dados
function validarDadosEdicao() {
    var mensagem = "Preencha corretamente os seguintes campos:";

    if (trim(document.formChequeBancario.nomeTitular.value) == "") {
        mensagem = mensagem + "\n- Nome do Titular";
    }
    else {
        // Linha abaixo comentada para manter acentos
        //document.formChequeBancario.nomeTitular.value = primeirasLetrasMaiusculas(retirarAcentos(trim(document.formChequeBancario.nomeTitular.value).toLowerCase()));
        document.formChequeBancario.nomeTitular.value = primeirasLetrasMaiusculas(trim(document.formChequeBancario.nomeTitular.value).toLowerCase());
    }

    if (trim(document.formChequeBancario.cpfTitular.value) == "") {
        mensagem = mensagem + "\n- CPF do Titular";
    }

    if (trim(document.formChequeBancario.banco.value) == "") {
        mensagem = mensagem + "\n- Banco";
    }
    else {
        if (document.formChequeBancario.banco.value == "selected") {
            if (trim(document.formChequeBancario.outroBanco.value) == "") {
                mensagem = mensagem + "\n- Banco - Outro";
            }
            else {
                // Linha abaixo comentada para manter acentos
                //document.formChequeBancario.outroBanco.value = primeirasLetrasMaiusculas(retirarAcentos(trim(document.formChequeBancario.outroBanco.value).toLowerCase()));
                document.formChequeBancario.outroBanco.value = primeirasLetrasMaiusculas(trim(document.formChequeBancario.outroBanco.value).toLowerCase());
            }
        }
    }

    if (trim(document.formChequeBancario.numero.value) == "") {
        mensagem = mensagem + "\n- Numero";
    }

    if (trim(document.formChequeBancario.valor.value) == "" || parseFloat(trim(document.formChequeBancario.valor.value)) <= parseFloat("0")) {
        mensagem = mensagem + "\n- Valor";
    }

    if (trim(document.formChequeBancario.dataParaDepositar.value) == "") {
        mensagem = mensagem + "\n- Data para Depositar";
    }

    if (trim(document.formChequeBancario.codigoStatus.value) == "") {
        mensagem = mensagem + "\n- Status";
    }

    if (mensagem == "Preencha corretamente os seguintes campos:") {
        return true;
    }
    else {
        alert(mensagem);
        return false;
    }
}

// TO DO Valida RG
// Verificar se tem letras e numeros ou soh numeros
// e retirar acentos e/ou cedilhas
function validarRg(rg) {
    if (trim(rg.value) != '') {
        document.formChequeBancario.rgTitular.value = retirarAcentos(trim(document.formChequeBancario.rgTitular.value)).toUpperCase();
    }
}

// Funcao usada para realizar a pesquisa de acordo com a opcao de campo (numero, periodo,...) escolhida pelo usuario
// Esta funcao eh chamada pela funcao confirmarBuscarTodos(campo, op)
function submeter(op) {
    // Seta a opcao de pesquisa escolhida para o action correspondente funcionar corretamente
    document.formChequeBancario.opcao.value = op;
    switch(op){
        // PESQUISAR PELO NUMERO
        case 0: {
            document.formChequeBancario.submit();
        }break;

        // PESQUISAR PELO PERIODO
        case 1: {
            document.formChequeBancario.submit();
        }break;
    }
}

// Funcao para exibir alert com opcoes de OK ou Cancelar quando o parametro 'campo' for vazio
function confirmarBuscarTodos(campo, op) {
    if (trim(campo.value) == '') {
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
    if (keyCode == 13)
        return confirmarBuscarTodos(campo, op);
    else
        return event;
}

// Funcao usada para mostrar / sumir o div contendo Informacoes Adicionais
function mostrarXsumir(valor){
    document.formChequeBancario.outroBanco.value = "";
    var abreDiv = document.getElementById('infoOutroBanco');
    if (valor == 'selected') {
        abreDiv.style.display = 'block';
    }
    else {
        abreDiv.style.display = 'none';
    }
}