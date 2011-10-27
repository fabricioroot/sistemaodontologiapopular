// Script usado para controlar/validar dados de paginas relacionadas a formas de pagamentos
// Criado em: 20/02/2010
// Autor: Fabricio P. Reis

// Funcao usada para validar os dados obrigatorios
// e colocar letras maiusculas e minusculas nos campos adequados
function validarDados() {
    var mensagem = "Preencha corretamente os seguintes campos:";

    if (trim(document.formFormaPagamento.nome.value) == "") {
        mensagem = mensagem + "\n- Nome";
    }
    else {
        // Linha abaixo comentada para manter acentos
        //document.formFormaPagamento.nome.value = retirarAcentos(trim(document.formFormaPagamento.nome.value)).toUpperCase();
        document.formFormaPagamento.nome.value = trim(document.formFormaPagamento.nome.value).toUpperCase();
    }

    if (trim(document.formFormaPagamento.descricao.value) == "") {
        mensagem = mensagem + "\n- Descricao";
    }
    else {
        // Linha abaixo comentada para manter acentos
        //document.formFormaPagamento.descricao.value = primeirasLetrasMaiusculas(retirarAcentos(trim(document.formFormaPagamento.descricao.value)).toLowerCase());
        document.formFormaPagamento.descricao.value = primeirasLetrasMaiusculas(trim(document.formFormaPagamento.descricao.value).toLowerCase());
    }

    if (document.formFormaPagamento.tipo.value == "selected") {
        mensagem = mensagem + "\n- Tipo";
    }

    // Trecho de codigo para quando for usar desconto no pagamento a vista
    /*if (document.formFormaPagamento.tipo.value == 'A') {
        if (trim(document.formFormaPagamento.desconto.value) == "") {
            mensagem = mensagem + "\n- Desconto(%)";
        }
        if (trim(document.formFormaPagamento.pisoParaDesconto.value) == "") {
            mensagem = mensagem + "\n- Valor minimo para desconto(R$)";
        }
    }*/

    if (document.formFormaPagamento.tipo.value == 'P') {
        if (trim(document.formFormaPagamento.valorMinimoAPrazo.value) == "") {
            mensagem = mensagem + "\n- Valor minimo";
        }
        else {
            document.formFormaPagamento.valorMinimoAPrazo.value = document.formFormaPagamento.valorMinimoAPrazo.value.replace(",", ".");
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

// Funcao usada para mostrar / sumir o div contendo os detalhes
function mostrarXsumir(valor){
    document.formFormaPagamento.valorMinimoAPrazo.value = "";
    document.formFormaPagamento.desconto.value = "";
    document.formFormaPagamento.pisoParaDesconto.value = "";
    if (valor == 'A') {
        var abreDiv = document.getElementById('detalhesFormaPagamentoAPrazo');
        abreDiv.style.display = 'none';
        // Trecho de codigo para quando for usar desconto no pagamento a vista
        //var abreDiv2 = document.getElementById('detalhesFormaPagamentoAVista');
        //abreDiv2.style.display = 'block';
    }
    else {
        if (valor == 'P') {
            // Trecho de codigo para quando for usar desconto no pagamento a vista
            //var abreDiv3 = document.getElementById('detalhesFormaPagamentoAVista');
            //abreDiv3.style.display = 'none';
            var abreDiv4 = document.getElementById('detalhesFormaPagamentoAPrazo');
            abreDiv4.style.display = 'block';
         }
         else {
            // Trecho de codigo para quando for usar desconto no pagamento a vista
            //var abreDiv5 = document.getElementById('detalhesFormaPagamentoAVista');
            //abreDiv5.style.display = 'none';
            var abreDiv6 = document.getElementById('detalhesFormaPagamentoAPrazo');
            abreDiv6.style.display = 'none';
         }
    }
}

// Funcao usada para realizar a pesquisa de acordo com a opcao de campo (nome ou tipo) escolhida pelo usuario
// Esta funcao eh chamada pela funcao confirmarBuscarTodos(campo, op)
function submeter(op) {
    // Seta a opcao de pesquisa escolhida para o action correspondente funcionar corretamente
    document.formFormaPagamento.opcao.value = op;
    switch(op){
        // PESQUISAR PELO NOME
        case 0: {
            // Linha abaixo comentada para manter os acentos
            //document.formFormaPagamento.nome.value = retirarAcentos(document.formFormaPagamento.nome.value).toUpperCase();
            document.formFormaPagamento.nome.value = document.formFormaPagamento.nome.value.toUpperCase();
            document.formFormaPagamento.submit();
        }break;

        // PESQUISAR PELO TIPO
        case 1: {
            document.formFormaPagamento.submit();
        }break;
    }
}

// Funcao para exibir alert com opcoes de OK ou Cancelar quando o parametro 'campo' for vazio
// Esta funcao eh usada na pagina consultarFormaPagamento para garantir que o usuario queira mesmo buscar todos os registros
function confirmarBuscarTodos(campo, op) {
    submeter(op);

    /*if ((trim(campo.value) == '') || (campo.value == null)) {
        if (op == 1) {
            alert("Selecione um tipo para ser pesquisado!");
            return false;
        }
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
    }*/
}

// Funcao usada para manipular tecla <<enter>> no formulario de consulta
function consultarComEnter(event, campo, op) {
    var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
    if (keyCode == 13)
        return confirmarBuscarTodos(campo, op);
    else
        return event;
}