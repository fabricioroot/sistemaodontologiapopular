// Script usado para controlar/validar dados de paginas relacionadas a procedimentos
// Criado em: 20/02/2010
// Autor: Fabricio P. Reis

// Funcao usada para validar os dados obrigatorios
// e colocar letras maiusculas e minusculas nos campos adequados
function validarDados() {
    var mensagem = "Preencha corretamente os seguintes campos:";

    if (trim(document.formProcedimento.nome.value) == "") {
        mensagem = mensagem + "\n- Nome";
    }
    else {
        // Linha abaixo comentada para manter acentos
        //document.formProcedimento.nome.value = primeirasLetrasMaiusculas(retirarAcentos(trim(document.formProcedimento.nome.value)).toLowerCase());
        document.formProcedimento.nome.value = primeirasLetrasMaiusculas(trim(document.formProcedimento.nome.value).toLowerCase());
    }
    
    if (trim(document.formProcedimento.valor.value) == "") {
        mensagem = mensagem + "\n- Valor(R$)";
    }
    else {
        document.formProcedimento.valor.value = document.formProcedimento.valor.value.replace(",", ".");
    }

    if (trim(document.formProcedimento.valorMinimo.value) == "") {
        mensagem = mensagem + "\n- Valor Minimo(R$)";
    }
    else {
        document.formProcedimento.valorMinimo.value = document.formProcedimento.valorMinimo.value.replace(",", ".");
    }

    if (parseFloat(trim(document.formProcedimento.valor.value.toString())) < parseFloat(trim(document.formProcedimento.valorMinimo.value.toString()))) {
        alert("Valor minimo Invalido!");
        return false;
    }

    if (trim(document.formProcedimento.descricao.value) == "") {
        mensagem = mensagem + "\n- Descricao";
    }
    else {
        // Linha abaixo comentada para manter acentos
        //document.formProcedimento.descricao.value = primeirasLetrasMaiusculas(retirarAcentos(trim(document.formProcedimento.descricao.value)).toLowerCase());
        document.formProcedimento.descricao.value = primeirasLetrasMaiusculas(trim(document.formProcedimento.descricao.value).toLowerCase());
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

// Funcao para exibir alert com opcoes de OK ou Cancelar quando o parametro 'campo' for vazio
// Esta funcao eh usada na pagina consultarProcedimento para garantir que o usuario queira mesmo buscar todos os registros
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