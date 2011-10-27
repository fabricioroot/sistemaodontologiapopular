// Script usado para controlar/validar dados de paginas relacionadas a caixa
// Criado em: 20/02/2010
// Autor: Fabricio P. Reis

// Funcao usada para validar os dados obrigatorios
// e colocar letras maiusculas e minusculas nos campos adequados
function validarDados() {
    var mensagem = "Preencha corretamente os seguintes campos:";
    var divPagamentoAVista = document.getElementById('pagamentoAVista');
    var divPagamentoAPrazo = document.getElementById('pagamentoAPrazo');

    if (trim(document.formPagamento.formaPagamentoId.value) == "") {
        mensagem = mensagem + "\n- Forma de Pagamento";
    }

    if (divPagamentoAVista.style.display == 'block'){
        if (trim(document.formPagamento.subtotalAVista.value) == "" || parseFloat(trim(document.formPagamento.subtotalAVista.value)) <= parseFloat("0")) {
            mensagem = mensagem + "\n- Subtotal (R$)";
        }
        else {
            document.formPagamento.subtotalAVista.value = document.formPagamento.subtotalAVista.value.replace(",", ".");
        }
        if (trim(document.formPagamento.totalAVista.value) == "" || parseFloat(trim(document.formPagamento.totalAVista.value)) <= parseFloat("0")) {
            mensagem = mensagem + "\n- Total (R$)";
        }
        else {
            document.formPagamento.totalAVista.value = document.formPagamento.totalAVista.value.replace(",", ".");
        }
    }
    else
    if (divPagamentoAPrazo.style.display == 'block'){
        if (trim(document.formPagamento.subtotalAPrazo.value) == "" || parseFloat(trim(document.formPagamento.subtotalAPrazo.value)) <= parseFloat("0")) {
            mensagem = mensagem + "\n- Subtotal (R$)";
        }
        else {
            document.formPagamento.subtotalAPrazo.value = document.formPagamento.subtotalAPrazo.value.replace(",", ".");
        }
        if (trim(document.formPagamento.totalAPrazo.value) == "" || parseFloat(trim(document.formPagamento.totalAPrazo.value)) <= parseFloat("0")) {
            mensagem = mensagem + "\n- Total (R$)";
        }
        else {
            document.formPagamento.totalAPrazo.value = document.formPagamento.totalAPrazo.value.replace(",", ".");
        }
    }

    if (mensagem == "Preencha corretamente os seguintes campos:") {
        return true;
    }
    else {
        alert(mensagem);
        return false;
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
            document.formPaciente.nome.value = primeirasLetrasMaiusculas(document.formPaciente.nome.value.toLowerCase());
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
            document.formPaciente.logradouro.value = primeirasLetrasMaiusculas(document.formPaciente.logradouro.value.toLowerCase());
            document.formPaciente.submit();
        }break;

        // PESQUISAR PELO CODIGO
        case 3:{
            document.formPaciente.submit();
        }break;
    }
}

// Funcao para exibir alert com opcoes de OK ou Cancelar quando o paramentro 'campo' for vazio
// Esta funcao eh usada na pagina consultarPacienteParaPagamentos para garantir que o usuario queira mesmo buscar todos os registros
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
    if (keyCode == 13)
        return confirmarBuscarTodos(campo, op);
    else
        return event;
}

// Funcao para exibir alert com opcoes de OK ou Cancelar confirmando opcao do usuario
function confirmarAcao(acao) {
    if(confirm("Tem certeza que deseja " + acao + " ?")) {
        return validarDados();
    }
    else {
        return false;
    }
}

// Trecho de codigo para quando for usar desconto no pagamento a vista
// Funcao para recalcular o valor total do pagamento quando o tipo for 'a vista'
/*function recalcularTotalAVista() {
    var subTotalChequesECartao = parseFloat(trim(document.formPagamento.totalChequesAVista.value.toString())) + parseFloat(trim(document.formPagamento.totalCartaoAVista.value.toString()));
    var totalDinheiroAVista;

    // Verifica se o campo estah em branco
    if (trim(document.formPagamento.totalAVistaEmDinheiro.value.toString()) != '') {
        totalDinheiroAVista = parseFloat(trim(document.formPagamento.totalAVistaEmDinheiro.value.toString()));
    }
    else {
        document.formPagamento.totalAVistaEmDinheiro.value = parseFloat("0");
        totalDinheiroAVista = parseFloat("0");
    }

    // Verifica se foi inserido cheque ou cartao verificando a soma dos valores dos campos hidden 'totalChequesAVista' e 'totalCartaoAVista'
    if (subTotalChequesECartao > parseFloat("0")) {
        var subTotal = subTotalChequesECartao + totalDinheiroAVista;
        // Marca o subtotal com a soma de total de cheques  e total de dinheiro
        document.formPagamento.subtotalAVista.value = subTotal.toFixed(2);
        // Verifica se o valor a ser pago tem desconto..
        if (totalDinheiroAVista >= parseFloat(trim(document.formPagamento.pisoParaDesconto.value.toString()))) {
            // Aplica o desconto...
            document.formPagamento.totalAVistaComDesconto.value = (totalDinheiroAVista - (totalDinheiroAVista * (document.formPagamento.desconto.value / 100)) + subTotalChequesECartao).toFixed(2);
            document.formPagamento.descontoVisual.value = document.formPagamento.desconto.value;
        }
        else {
            document.formPagamento.totalAVistaComDesconto.value = subTotal.toFixed(2);
            document.formPagamento.descontoVisual.value = parseFloat("0");
        }
    }
    else {
        // Marca o subtotal com o total em dinheiro
        document.formPagamento.subtotalAVista.value = totalDinheiroAVista.toFixed(2);
        // Verifica se o valor a ser pago tem desconto..
        if (totalDinheiroAVista >= parseFloat(trim(document.formPagamento.pisoParaDesconto.value.toString()))) {
            // Aplica o desconto...
            document.formPagamento.totalAVistaComDesconto.value = (totalDinheiroAVista - (totalDinheiroAVista * (document.formPagamento.desconto.value / 100))).toFixed(2);
            document.formPagamento.descontoVisual.value = document.formPagamento.desconto.value;
        }
        else {
            document.formPagamento.totalAVistaComDesconto.value = totalDinheiroAVista.toFixed(2);
            document.formPagamento.descontoVisual.value = parseFloat("0");
        }
    }
}*/

function recalcularTotalAVista() {
    var subTotalChequesECartao = parseFloat(trim(document.formPagamento.totalChequesAVista.value.toString())) + parseFloat(trim(document.formPagamento.totalCartaoAVista.value.toString()));
    var totalDinheiroAVista;

    // Verifica se o campo estah em branco
    if (trim(document.formPagamento.totalAVistaEmDinheiro.value.toString()) != '') {
        totalDinheiroAVista = parseFloat(trim(document.formPagamento.totalAVistaEmDinheiro.value.toString()));
    }
    else {
        document.formPagamento.totalAVistaEmDinheiro.value = parseFloat("0");
        totalDinheiroAVista = parseFloat("0");
    }

    // Verifica se foi inserido cheque ou cartao verificando a soma dos valores dos campos hidden 'totalChequesAVista' e 'totalCartaoAVista'
    if (subTotalChequesECartao > parseFloat("0")) {
        var subTotal = subTotalChequesECartao + totalDinheiroAVista;
        // Marca o subtotal e o total com a soma do subtotal de cheques mais cartao  e total de dinheiro
        document.formPagamento.subtotalAVista.value = subTotal.toFixed(2);
        document.formPagamento.totalAVista.value = subTotal.toFixed(2);
    }
    else {
        // Marca o subtotal e o total com o total em dinheiro
        document.formPagamento.subtotalAVista.value = totalDinheiroAVista.toFixed(2);
        document.formPagamento.totalAVista.value = totalDinheiroAVista.toFixed(2);
    }
}

// Trecho de codigo para quando for usar desconto no pagamento a vista
// Funcao para calcular o valor total do pagamento quando o tipo for 'a vista'
/*function calcularTotalAVista() {
    var subTotalChequesECartao = parseFloat(trim(document.formPagamento.totalChequesAVista.value.toString())) + parseFloat(trim(document.formPagamento.totalCartaoAVista.value.toString()));
    var totalDinheiroAVista;

    // Verifica se o campo estah em branco
    if (trim(document.formPagamento.totalAVistaEmDinheiro.value.toString()) != '') {
        totalDinheiroAVista = parseFloat(trim(document.formPagamento.totalAVistaEmDinheiro.value.toString()));
    }
    else {
        document.formPagamento.totalAVistaEmDinheiro.value = parseFloat("0");
        totalDinheiroAVista = parseFloat("0");
    }

    // Verifica se foi inserido cheque ou cartao verificando a soma dos valores dos campos hidden 'totalChequesAVista' e 'totalCartaoAVista'
    if (subTotalChequesECartao > parseFloat("0")) {
        // Marca o totalAVistaEmDinheiro igual a zero e o subtotal com o total de cheques
        document.formPagamento.totalAVistaEmDinheiro.value = parseFloat("0");
        document.formPagamento.subtotalAVista.value = subTotalChequesECartao.toFixed(2);

        // Veririca se o valor a ser pago tem desconto...
        if (totalDinheiroAVista >= parseFloat(trim(document.formPagamento.pisoParaDesconto.value.toString()))) {
            // Aplica o desconto...
            document.formPagamento.totalAVistaComDesconto.value = (totalDinheiroAVista - (totalDinheiroAVista * (document.formPagamento.desconto.value / 100)) + subTotalChequesECartao).toFixed(2);
            document.formPagamento.descontoVisual.value = document.formPagamento.desconto.value;
        }
        else {
            document.formPagamento.totalAVistaComDesconto.value = subTotalChequesECartao.toFixed(2);
            document.formPagamento.descontoVisual.value = parseFloat("0");
        }
    }
    else {
        // Marca o subtotal com total em dinheiro
        document.formPagamento.subtotalAVista.value = document.formPagamento.totalAVistaEmDinheiro.value;
        // Veririca se o valor a ser pago tem desconto...
        if (parseFloat(trim(document.formPagamento.totalAVistaEmDinheiro.value.toString())) >= parseFloat(trim(document.formPagamento.pisoParaDesconto.value.toString()))) {
            // Aplica o desconto...
            document.formPagamento.totalAVistaComDesconto.value = (document.formPagamento.totalAVistaEmDinheiro.value - (document.formPagamento.totalAVistaEmDinheiro.value * (document.formPagamento.desconto.value / 100))).toFixed(2);
            document.formPagamento.descontoVisual.value = document.formPagamento.desconto.value;
        }
        else {
            document.formPagamento.totalAVistaComDesconto.value = document.formPagamento.totalAVistaEmDinheiro.value;
            document.formPagamento.descontoVisual.value = parseFloat("0");
        }
    }
}*/

function calcularTotalAVista() {
    var subTotalChequesECartao = parseFloat(trim(document.formPagamento.totalChequesAVista.value.toString())) + parseFloat(trim(document.formPagamento.totalCartaoAVista.value.toString()));

    // Verifica se foi inserido cheque ou cartao verificando a soma dos valores dos campos hidden 'totalChequesAVista' e 'totalCartaoAVista'
    if (subTotalChequesECartao > parseFloat("0")) {
        // Marca o totalAVistaEmDinheiro igual a zero e o subtotal com o total de cheques
        document.formPagamento.totalAVistaEmDinheiro.value = parseFloat("0");
        document.formPagamento.subtotalAVista.value = subTotalChequesECartao.toFixed(2);
        // ...E o total com o subtotal
        document.formPagamento.totalAVista.value = document.formPagamento.subtotalAVista.value;
    }
    else {
        // Marca o subtotal com total em dinheiro
        document.formPagamento.subtotalAVista.value = document.formPagamento.totalAVistaEmDinheiro.value;
        // ...E o total com o subtotal
        document.formPagamento.totalAVista.value = document.formPagamento.subtotalAVista.value;
    }
}

// Funcao para recalcular o valor total do pagamento quando o tipo for 'a prazo'
function recalcularTotalAPrazo() {
    var subTotalChequesECartao = parseFloat(trim(document.formPagamento.totalChequesAPrazo.value.toString())) + parseFloat(trim(document.formPagamento.totalCartaoAPrazo.value.toString()));
    var totalDinheiroAPrazo;

    // Verifica se o campo estah em branco
    if (trim(document.formPagamento.totalAPrazoEmDinheiro.value.toString()) != '') {
        totalDinheiroAPrazo = parseFloat(trim(document.formPagamento.totalAPrazoEmDinheiro.value.toString()));
    }
    else {
        document.formPagamento.totalAPrazoEmDinheiro.value = parseFloat("0");
        totalDinheiroAPrazo = parseFloat("0");
    }

    // Verifica se foi inserido cheque ou cartao verificando a soma dos valores dos campos hidden 'totalChequesAVista' e 'totalCartaoAVista'
    if (subTotalChequesECartao > parseFloat("0")) {
        var subTotal = subTotalChequesECartao + totalDinheiroAPrazo;
        // Marca o subtotal e o total com a soma do subtotal de cheques mais cartao  e total de dinheiro
        document.formPagamento.subtotalAPrazo.value = subTotal.toFixed(2);
        document.formPagamento.totalAPrazo.value = subTotal.toFixed(2);
    }
    else {
        // Marca o subtotal e o total com o total em dinheiro
        document.formPagamento.subtotalAPrazo.value = totalDinheiroAPrazo.toFixed(2);
        document.formPagamento.totalAPrazo.value = totalDinheiroAPrazo.toFixed(2);
    }
}

// Funcao para calcular o valor total do pagamento quando o tipo for 'a prazo'
function calcularTotalAPrazo() {
    var subTotalChequesECartao = parseFloat(trim(document.formPagamento.totalChequesAPrazo.value.toString())) + parseFloat(trim(document.formPagamento.totalCartaoAPrazo.value.toString()));

    // Verifica se foi inserido cheque ou cartao verificando a soma dos valores dos campos hidden 'totalChequesAVista' e 'totalCartaoAVista'
    if (subTotalChequesECartao > parseFloat("0")) {
        // Marca o totalAPrazoEmDinheiro igual a zero
        document.formPagamento.totalAPrazoEmDinheiro.value = parseFloat("0");
        // ...O subtotal com o subtotal de cheques mais cartao
        document.formPagamento.subtotalAPrazo.value = subTotalChequesECartao.toFixed(2);
        // ...E o total com o subtotal
        document.formPagamento.totalAPrazo.value = document.formPagamento.subtotalAPrazo.value;
    }
    else {
        // Marca o subtotal com total em dinheiro
        document.formPagamento.subtotalAPrazo.value = document.formPagamento.totalAPrazoEmDinheiro.value;
        // ...E o total com o subtotal
        document.formPagamento.totalAPrazo.value = document.formPagamento.subtotalAPrazo.value;
    }
}