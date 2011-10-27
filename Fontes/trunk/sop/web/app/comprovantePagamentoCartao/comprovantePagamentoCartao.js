// Script usado para controlar/validar dados de paginas relacionadas a comprovantes de pagamentos com cartao
// Criado em: 20/02/2010
// Autor: Fabricio P. Reis

// Funcao usada para validar os dados obrigatorios
// e colocar letras maiusculas e minusculas nos campos adequados
function validarDados() {
    var mensagem = "Preencha corretamente os seguintes campos:";

    if (trim(document.formComprovantePagamentoCartao.bandeira.value) == "selected") {
        mensagem = mensagem + "\n- Bandeira";
    }

    if (document.formComprovantePagamentoCartao.tipo[0].checked) {
        if (trim(document.formComprovantePagamentoCartao.parcelas.value) == "0") {
            mensagem = mensagem + "\n- Parcelas";
        }
    }

    if (trim(document.formComprovantePagamentoCartao.codigoAutorizacao.value) == "") {
        mensagem = mensagem + "\n- Codigo de Autorizacao";
    }
    else {
        document.formComprovantePagamentoCartao.codigoAutorizacao.value = retirarAcentos(trim(document.formComprovantePagamentoCartao.codigoAutorizacao.value));
    }

    if (trim(document.formComprovantePagamentoCartao.valor.value) == "" || parseFloat(trim(document.formComprovantePagamentoCartao.valor.value)) <= parseFloat("0")) {
        mensagem = mensagem + "\n- Valor (R$)";
    }
    else {
        document.formComprovantePagamentoCartao.valor.value = document.formComprovantePagamentoCartao.valor.value.replace(",", ".");
    }

    if (mensagem == "Preencha corretamente os seguintes campos:") {
        return true;
    }
    else {
        alert(mensagem);
        goFocus('bandeira');
        return false;
    }
}

// Funcao usada para validar os dados obrigatorios
// e colocar letras maiusculas e minusculas nos campos adequados
function validarDadosEdicao() {
    var mensagem = "Preencha corretamente os seguintes campos:";

    if (trim(document.formComprovantePagamentoCartao.bandeira.value) == "selected") {
        mensagem = mensagem + "\n- Bandeira";
    }

    if (document.formComprovantePagamentoCartao.tipo[0].checked) {
        if (trim(document.formComprovantePagamentoCartao.parcelas.value) == "0") {
            mensagem = mensagem + "\n- Parcelas";
        }
    }

    if (trim(document.formComprovantePagamentoCartao.codigoAutorizacao.value) == "") {
        mensagem = mensagem + "\n- Codigo de Autorizacao";
    }

    if (trim(document.formComprovantePagamentoCartao.valor.value) == "" || parseFloat(trim(document.formComprovantePagamentoCartao.valor.value)) <= parseFloat("0")) {
        mensagem = mensagem + "\n- Valor";
    }
    else {
        document.formComprovantePagamentoCartao.valor.value = document.formComprovantePagamentoCartao.valor.value.replace(",", ".");
    }

    if (trim(document.formComprovantePagamentoCartao.status.value) == "S") {
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

// Funcao usada para realizar a pesquisa de acordo com a opcao de campo (codigoAutorizacao, periodo,...) escolhida pelo usuario
// Esta funcao eh chamada pela funcao confirmarBuscarTodos(campo, op)
function submeter(op) {
    // Seta a opcao de pesquisa escolhida para o action correspondente funcionar corretamente
    document.formComprovantePagamentoCartao.opcao.value = op;
    switch(op){
        // PESQUISAR PELO CODIGO DE AUTORIZACAO
        case 0: {
            document.formComprovantePagamentoCartao.submit();
        }break;

        // PESQUISAR PELO PERIODO
        case 1: {
            document.formComprovantePagamentoCartao.submit();
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
    //document.formComprovantePagamentoCartao.parcelas.value = "";
    var abreDiv = document.getElementById('infoParcelas');
    if (valor == 'C') {
        abreDiv.style.display = 'block';
    }
    else {
        abreDiv.style.display = 'none';
    }
}